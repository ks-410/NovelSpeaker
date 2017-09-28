//
//  CustomUITextView.swift
//  novelspeaker
//
//  Created by 飯村卓司 on 2017/05/10.
//  Copyright © 2017年 IIMURA Takuji. All rights reserved.
//

import Foundation
import UIKit

public class CustomUITextView: UITextView {
    // UITextView で長押しして出て来るメニューの項目を減らします
    // from http://qiita.com/watt1006/items/2425bfa1720d522d05fd
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let globalData = GlobalDataSingleton.getInstance();
        if globalData == nil || globalData?.getMenuItemIsAddSpeechModSettingOnly() != true {
            return super.canPerformAction(action, withSender: sender);
        }
        if action == #selector(copy(_:))
            || action == #selector(cut(_:))
            || action == #selector(paste(_:))
            || action == #selector(select(_:))
            || action == #selector(selectAll(_:))
            || action == #selector(copy(_:))
        {
            return false;
        }
        return super.canPerformAction(action, withSender: sender);
    }
}
