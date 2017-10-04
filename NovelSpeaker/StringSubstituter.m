//
//  StringSubstituter.m
//  novelspeaker
//
//  Created by 飯村卓司 on 2014/09/21.
//  Copyright (c) 2014年 IIMURA Takuji. All rights reserved.
//

#import "StringSubstituter.h"

/*
 変換用の設定 (変換元(from)と変換先(to))を、ConvertSeting (このファイル内だけの inetrface) に入れて保存して、
 変換元(from) の 1文字目 が同じものを NSMutableArray に 変換元(from) の文字列長の長いものの順に入れます。
 その NSMutableArray　を
 変換元(from) の 1文字目 を key とした m_1stKeyMap(NSMutableDictionary) に入れて保管します。
 
 文字列の変換時は、文字列を1文字づつ読み込んで、m_1stKeyMap と見比べながら
 変換された文字列を作ります。

 これで、今までのような全ての変換文字列毎に全体を置換した文字列を生成する、
 といったほぼ全ての文字列のメモリコピーが変換対象回だけ発声していたのを
 だいたい1回位で済むようにしようとしてみます。
 ただ、1文字毎にチェックが入るので n の数が少ないと逆に重くなるはずです。
 */

@interface ConvertSetting : NSObject
@property (nonatomic) NSString* from;
@property (nonatomic) NSString* to;
@end
@implementation ConvertSetting
@end

@implementation StringSubstituter

- (id)init
{
    self = [super init];
    if (self == nil) {
        return nil;
    }
    
    m_1stKeyMap = [NSMutableDictionary new];
    
    return self;
}

/// 変換設定を追加します。
/// from が同じものを登録された場合、設定が上書きされます。
- (BOOL) AddSetting_From:(NSString*)from to:(NSString*)to
{
    if (from == nil || to == nil
        || [from length] <= 0) {
        return false;
    }
    
    // 1文字目で m_1stKeyMap から設定を読み出します。
    unichar c = [from characterAtIndex:0];
    NSString* key = [NSString stringWithFormat:@"%C", c];
    NSMutableArray* convArray = [m_1stKeyMap objectForKey:key];
    if (convArray == nil) {
        convArray = [NSMutableArray new];
    }

    // 同じ from が既にあったのなら、to を書き換えておしまいです。
    for (ConvertSetting* convSettingInArray in convArray) {
        if ([convSettingInArray.from compare:from] == NSOrderedSame) {
            convSettingInArray.to = to;
            return true;
        }
    }

    ConvertSetting* convSetting = [ConvertSetting new];
    convSetting.from = from;
    convSetting.to = to;
    
    // とりあえず追加して from の長さで sort しておきます。
    [convArray addObject:convSetting];
    convArray = [[convArray sortedArrayUsingComparator:^NSComparisonResult(ConvertSetting* a, ConvertSetting* b){
        if (a == nil){
            return NSOrderedAscending;
        }
        if (b == nil){
            return NSOrderedDescending;
        }
        NSUInteger aLength = [a.from length];
        NSUInteger bLength = [b.from length];
        if (aLength == bLength){
            return [a.from compare:b.from];
        }
        if (aLength > bLength) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }] mutableCopy];
    
    // 設定を上書きして終了です
    [m_1stKeyMap setObject:convArray forKey:key];
    
    return true;
}

/// 変換設定を削除します。
- (BOOL) DelSetting:(NSString*)from
{
    if (from == nil || [from length] <= 0) {
        return false;
    }
    
    // 1文字目で m_1stKeyMap から設定を読み出します。
    unichar c = [from characterAtIndex:0];
    NSString* key = [NSString stringWithFormat:@"%C", c];
    NSMutableArray* convArray = [m_1stKeyMap objectForKey:key];
    if (convArray == nil) {
        convArray = [NSMutableArray new];
    }
    
    // 同じ from の設定を検索します。
    NSUInteger length = [convArray count];
    for (NSUInteger i = 0; i < length; i++) {
        ConvertSetting* convSetting = convArray[i];
        if ([convSetting.from compare:from] == NSOrderedSame) {
            // 発見したので削除します
            [convArray removeObject:convSetting];
            break;
        }
    }
    // この1文字目の設定が消えたなら削除はしておきます。
    if ([convArray count] <= 0) {
        [m_1stKeyMap removeObjectForKey:key];
    }
    return true;
}

/// 変換設定を全て削除します。
- (void) ClearSetting
{
    [m_1stKeyMap removeAllObjects];
}

/// 変換を行います。
- (SpeechBlock*) Convert:(NSString*)text speechConfig:(SpeechConfig*)config;
{
    SpeechBlock* result = [SpeechBlock new];
    result.speechConfig = [SpeechConfig new];
    result.speechConfig.voiceIdentifier = config.voiceIdentifier;
    result.speechConfig.beforeDelay = config.beforeDelay;
    result.speechConfig.pitch = config.pitch;
    result.speechConfig.rate = config.rate;
    
    // 今まで読んできた中で書き換えの必要のない部分文字列
    NSMutableString* noConvString = [NSMutableString new];

    NSUInteger textLength = [text length];
    NSUInteger n = 0;
    while (n < textLength) {
        NSString* targetChar = [NSString stringWithFormat:@"%C", [text characterAtIndex:n]];
        NSMutableArray* convArray = [m_1stKeyMap objectForKey:targetChar];
        if (convArray == nil) {
            // 設定に無い文字なのであればそれを追加して次へ
            [noConvString appendString:targetChar];
            n++;
            continue;
        }
        BOOL hit = false;
        for (ConvertSetting* convSetting in convArray) {
            NSUInteger fromLength = [convSetting.from length];
            if (n + fromLength > textLength) {
                // 対象のfrom文字列が長すぎるので次へ
                continue;
            }
            if([text compare:convSetting.from options:NSLiteralSearch range:NSMakeRange(n, fromLength)] == NSOrderedSame)
            {
                // そこから続くのは目的の文字列であった。
                if ([noConvString length] > 0) {
                    [result AddDisplayText:noConvString speechText:noConvString];
                    noConvString = [NSMutableString new];
                }
                [result AddDisplayText:convSetting.from speechText:convSetting.to];
                n += fromLength;
                hit = true;
                break;
            }
        }
        if (hit != true) {
            // 検索したけれどマッチする from はなかった
            [noConvString appendString:targetChar];
            n++;
            continue;
        }
    }
    if ([noConvString length] > 0) {
        [result AddDisplayText:noConvString speechText:noConvString];
    }
    
    return result;
}


/// 与えられた文章の文字列から、小説家になろうにおけるルビ表記を発見して、自身の読み替え辞書に登録するための辞書を取り出します
/// 例として、『|北の鬼(ノースオーガ)』という文字列を発見した場合には
/// key → value
/// "|北の鬼(ノースオーガ)" → "ノースオーガ"
/// "北の鬼" → "ノースオーガ"
/// の二種類を出力します。
+ (NSDictionary*)FindNarouRubyNotation:(NSString*)text {
    // 小説家になろうでのルビの扱い https://syosetu.com/man/ruby/
    // 平仮名 \p{Hiragana}
    // カタカナ \p{Katakana}
    // 漢字 \p{Han}
    // 数字 \p{}
    NSArray* patternArray = @[
      @"\\|([^|]+)《(.+?)》", // | のある場合
      @"([\\p{Han}]+)《(.+?)》", // 《 》 の前が漢字
      @"([\\p{Han}]+)[(（]([\\p{Hiragana}\\p{Katakana}]+)[)）]", // () の前が漢字かつ、() の中がカタカナまたは平仮名
    ];

    NSLog(@"phase 1.");
    NSMutableArray* regexpArray = [NSMutableArray new];
    for (int i = 0; i < patternArray.count; i++) {
        NSString* pattern = patternArray[i];
        NSError *err = nil;
        NSRegularExpression* regexp = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&err];
        if (err != nil) {
            continue;
        }
        [regexpArray addObject:regexp];
    }
    
    NSLog(@"phase 2.");
    // 先にマッチしたものの範囲のリスト
    NSMutableArray* hitRanges = [NSMutableArray new];
    // 抽出された読み替え辞書のストア
    NSMutableDictionary* result = [NSMutableDictionary new];
    for (NSRegularExpression* regexp in regexpArray) {
        NSArray* hitArray = [regexp matchesInString:text options:0 range:NSMakeRange(0, text.length)];
        NSLog(@"phase 2.1. count: %lu", (unsigned long)[hitArray count]);
        for (NSTextCheckingResult* match in hitArray) {
            NSLog(@"phase 2.1.1. match: %p", match);
            if ([match numberOfRanges] != 3) {
                continue;
            }
            
            NSRange thisRange = [match rangeAtIndex:0];
            if (thisRange.length == 0) {
                continue;
            }
            NSUInteger thisStart = thisRange.location;
            NSUInteger thisEnd = thisRange.location + thisRange.length;
            BOOL alreadyHit = false;
            for (NSValue* rangeValue in hitRanges) {
                NSLog(@"phase 2.1.1.1. rangeValue: %p", rangeValue);
                NSLog(@"   rangeValue: [%lu, %lu]", rangeValue.rangeValue.location, rangeValue.rangeValue.length);
                NSRange prevRange = rangeValue.rangeValue;
                NSUInteger prevStart = prevRange.location;
                NSUInteger prevEnd = prevRange.location + prevRange.length;
                if (prevStart <= thisStart && prevEnd >= thisStart) {
                    alreadyHit = true;
                    break;
                }
                if (prevStart <= thisEnd && prevEnd >= thisEnd) {
                    alreadyHit = true;
                    break;
                }
            }
            NSLog(@"phase 2.1.2. alreadyHit?: %@", alreadyHit ? @"true" : @"false");
            if (alreadyHit) {
                continue;
            }
            [hitRanges addObject:[NSValue valueWithRange:thisRange]];

            NSRange fromStringRange = [match rangeAtIndex:1];
            NSRange toStringRange = [match rangeAtIndex:2];
            NSString* fromString = [text substringWithRange:fromStringRange];
            NSString* toString = [text substringWithRange:toStringRange];
            [result setObject:toString forKey:fromString];
            NSString* allString = [text substringWithRange:thisRange];
            NSLog(@"phase 2.1.3: from/to: %@/%@", fromString, toString);
            [result setObject:toString forKey:allString];
            NSLog(@"phase 2.1.4: from/to: %@/%@", allString, toString);
        }
    }
    NSLog(@"phase 3: done.");

    return result;
}


@end