//
//  SpeechModSettingsTableViewController.h
//  NovelSpeaker
//
//  Created by 飯村卓司 on 2014/08/16.
//  Copyright (c) 2014年 IIMURA Takuji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateSpeechModSettingViewController.h"
#import "Speaker.h"

@interface SpeechModSettingsTableViewController : UITableViewController<CreateNewSpeechModSettingDelegate>
{
    Speaker* m_Speaker;
}
@end