//
//  MigrationViewController.swift
//  NovelSpeaker
//
//  Created by 飯村卓司 on 2019/05/31.
//  Copyright © 2019 IIMURA Takuji. All rights reserved.
//

import UIKit

class MigrationViewController: UIViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 戻るボタンを見えなくします
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        DispatchQueue.global(qos: .utility).async {
            self.CheckAndDoCoreDataMigration()
            self.CheckAndDoCoreDataToRealmMigration()
            self.goToMainStoryBoard()
        }
    }
    
    func CheckAndDoCoreDataMigration() {
        if let globalData = GlobalDataSingleton.getInstance() {
            if globalData.isAliveOLDSaveDataFile() {
                globalData.moveOLDSaveDataFileToNewLocation()
            }
            if globalData.isAliveCoreDataSaveFile() && globalData.isRequiredCoreDataMigration() {
                DispatchQueue.main.async {
                    self.progressLabel.text = NSLocalizedString("MigrationViewController_DoingCoreDataMigration", comment: "旧データベースの更新を行っています。")
                }
                globalData.doCoreDataMigration()
            }
        }
    }

    func CheckAndDoCoreDataToRealmMigration() {
        if RealmUtil.IsUseCloudRealm() {
            // iCloud を使う場合で、
            if RealmUtil.CheckIsCloudRealmCreated() {
                // iCloud の データがあるならそれを使う
                return
            }
            if RealmUtil.CheckIsLocalRealmCreated() {
                // local のがあるならそこからコピーする
                guard let localRealm = try? RealmUtil.GetLocalRealm(), let cloudRealm = try? RealmUtil.GetCloudRealm() else { return }
                // TODO: ここで localRealm から cloudRealm に上書きコピーをして良いのかの確認プロセスが無い
                RealmToRealmCopyTool.DoCopy(from: localRealm, to: cloudRealm) { (text) in
                    DispatchQueue.main.async {
                        self.progressLabel.text = text
                    }
                }
                return
            }
            if GlobalDataSingleton.getInstance()?.isAliveCoreDataSaveFile() ?? false {
                // CoreData のがあるならそこからコピーする
                CoreDataToRealmTool.ConvertFromCoreaData { (text) in
                    DispatchQueue.main.async {
                        self.progressLabel.text = text
                    }
                }
                return
            }else{
                // CoreData のものはなかったので CoreData からの移行は完了したと印をつけておく
                CoreDataToRealmTool.RegisterConvertFromCoreDataFinished()
            }
            // それでもないなら default値 を入れておく
            NovelSpeakerUtility.InsertDefaultSettingsIfNeeded()
        }else{
            // Local Ream を使う場合で、
            if RealmUtil.CheckIsLocalRealmCreated() {
                // realm file はあって
                if CoreDataToRealmTool.IsConvertFromCoreDataFinished() {
                    // CoreData からの移行もできてるならそれを使う
                    return
                }
                // CoreData からの移行が完了していないらしいので Local Realm file は消しておきます
                RealmUtil.RemoveLocalRealmFile()
            }
        }
        // ここに来るのは
        // ・LocalRealm を使用する
        // ・LocalRealm file は無い(か消した)
        // という状態。
        if !(GlobalDataSingleton.getInstance()?.isAliveCoreDataSaveFile() ?? true) {
            // CoreData のファイルが無いなら CoreData からの移行は完了したとマークしておく
            CoreDataToRealmTool.RegisterConvertFromCoreDataFinished()
            // 標準の設定を入れて終了
            print("NovelSpeakerUtility.InsertDefaultSettingsIfNeeded() call.")
            NovelSpeakerUtility.InsertDefaultSettingsIfNeeded()
            return
        }
        // そうでもないなら CoreData からの移行を行う
        print("CoreDataToRealmTool.ConvertFromCoreaData() call.")
        CoreDataToRealmTool.ConvertFromCoreaData { (text) in
            DispatchQueue.main.async {
                self.progressLabel.text = text
            }
        }
        NovelSpeakerUtility.InsertDefaultSettingsIfNeeded()
    }
    
    func goToMainStoryBoard() {
        DispatchQueue.main.async {
            NovelSpeakerUtility.InsertDefaultSettingsIfNeeded()

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let firstViewController = storyboard.instantiateInitialViewController() else { return }
            NiftyUtilitySwift.RegisterToplevelViewController(viewController: firstViewController)
            self.present(firstViewController, animated: true, completion: nil)
        }
    }
}