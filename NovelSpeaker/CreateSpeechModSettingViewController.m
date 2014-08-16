//
//  CreateSpeechModSettingViewController.m
//  NovelSpeaker
//
//  Created by 飯村卓司 on 2014/08/16.
//  Copyright (c) 2014年 IIMURA Takuji. All rights reserved.
//

#import "CreateSpeechModSettingViewController.h"
#import "GlobalDataSingleton.h"

@interface CreateSpeechModSettingViewController ()

@end

@implementation CreateSpeechModSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    m_Speaker = [Speaker new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertView:(NSString*)message
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (IBAction)testSpeechButtonClicked:(id)sender {
    NSString* sampleText = [[NSString alloc] initWithFormat:@"%@を%@に読み替えます。", self.beforeTextField.text, self.afterTextField.text];
    [m_Speaker Speech:sampleText];
}

- (IBAction)assignButtonClicked:(id)sender {
    if ([self.beforeTextField.text length] <= 0
        || [self.afterTextField.text length] <= 0) {
        [self showAlertView:@"変換元か変換先の文字列が設定されていません。"];
        return;
    }
    
    SpeechModSettingCacheData* speechMod = [SpeechModSettingCacheData new];
    speechMod.beforeString = self.beforeTextField.text;
    speechMod.afterString = self.afterTextField.text;
    if ([[GlobalDataSingleton GetInstance] UpdateSpeechModSetting:speechMod] == false) {
        [self showAlertView:@"設定に失敗しました。"];
        return;
    }
    [self.createNewSpeechModSettingDelegate NewSpeechModSettingAdded];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end