//
//  SpeechViewController.swift
//  NovelSpeaker
//
//  Created by 飯村卓司 on 2019/05/19.
//  Copyright © 2019 IIMURA Takuji. All rights reserved.
//

import UIKit
import RealmSwift

class SpeechViewController: UIViewController, UITextViewDelegate, StorySpeakerDeletgate {
    
    public var targetStoryID : String? = nil

    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var previousChapterButton : UIButton!
    @IBOutlet weak var nextChapterButton : UIButton!
    @IBOutlet weak var chapterSlider : UISlider!
    @IBOutlet weak var chapterPositionLabel : UILabel!
    @IBOutlet weak var chapterPositionLabelWidthConstraint : NSLayoutConstraint!
    
    var startStopButtonItem:UIBarButtonItem? = nil
    var defaultDisplaySettingObserverToken : NotificationToken? = nil
    
    let storySpeaker = StorySpeaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storySpeaker.AddDelegate(delegate: self)
        // Do any additional setup after loading the view.
        initWidgets()
        if let storyID = targetStoryID, let story = RealmStory.SearchStoryFrom(storyID: storyID) {
            if let novel = RealmNovel.SearchNovelFrom(novelID: story.novelID){
                loadNovel(novel: novel)
            }
            self.storySpeaker.SetStory(story: story)
        }else{
            textView.text = NSLocalizedString("SpeechViewController_ContentReadFailed", comment: "文書の読み込みに失敗しました。")
        }
    }

    // 表示される直前に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let globalState = RealmGlobalState.GetInstance(), globalState.isDarkThemeEnabled {
            applyDarkTheme()
        }else{
            applyBrightTheme()
        }
    }
    
    // 非表示になる直前に呼ばれる
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        applyBrightTheme()
    }
    
    func initWidgets() {
        guard let globalState = RealmGlobalState.GetInstance() else {
            return
        }
        if let displaySetting = globalState.defaultDisplaySetting {
            textView.font = displaySetting.font
        }
        observeGlobalState()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        textView.delegate = self
    }
    
    func loadNovel(novel:RealmNovel) {
        startStopButtonItem = UIBarButtonItem(title: NSLocalizedString("SpeechViewController_Speak", comment: "Speak"), style: .plain, target: self, action: #selector(startStopButtonClicked(_:)))
        var barButtonArray:[UIBarButtonItem] = [
            startStopButtonItem!,
            UIBarButtonItem(title: NSLocalizedString("SpeechViewController_Edit", comment: "編集"), style: .plain, target: self, action: #selector(detailButtonClicked(_:)))
        ]
        if novel.type == .URL {
            barButtonArray.append(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonClicked(_:))))
            barButtonArray.append(UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(urlRefreshButtonClicked(_:))))
            barButtonArray.append(UIBarButtonItem(image: UIImage(named: "earth"), style: .plain, target: self, action: #selector(safariButtonClicked(_:))))
        }
        navigationItem.rightBarButtonItems = barButtonArray
        navigationItem.title = novel.title
    }
    
    func setStoryWithoutSetToStorySpeaker(story:RealmStory) {
        DispatchQueue.main.async {
            guard let novel = RealmNovel.SearchNovelFrom(novelID: story.novelID), let lastChapterNumber = novel.lastChapterNumber else {
                return
            }
            
            if story.chapterNumber <= 1 {
                self.previousChapterButton.isEnabled = false
            }else{
                self.previousChapterButton.isEnabled = true
            }
            if story.chapterNumber < lastChapterNumber {
                self.nextChapterButton.isEnabled = true
            }else{
                self.nextChapterButton.isEnabled = false
            }
            self.chapterSlider.minimumValue = 1.0
            self.chapterSlider.maximumValue = Float(lastChapterNumber) + Float(0.01)
            self.chapterSlider.value = Float(story.chapterNumber)
            
            self.chapterPositionLabel.text = "\(story.chapterNumber)/\(lastChapterNumber)"
            if let constraint = self.chapterPositionLabelWidthConstraint {
                self.chapterPositionLabel.removeConstraint(constraint)
            }
            self.chapterPositionLabel.sizeToFit()
            self.chapterPositionLabelWidthConstraint = self.chapterPositionLabel.widthAnchor.constraint(equalToConstant: self.chapterPositionLabel.frame.width)
            self.chapterPositionLabelWidthConstraint.isActive = true
            
            self.textView.text = story.content
            let storyID = story.id
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 3000)) {
                guard let story = RealmStory.SearchStoryFrom(storyID: storyID) else { return }
                self.textView.selectedRange = NSRange(location: story.readLocation, length: 1)
                self.textViewScrollTo(readLocation: story.readLocation)
            }
        }
    }
    
    func observeGlobalState() {
        guard let displaySetting = RealmGlobalState.GetInstance()?.defaultDisplaySetting else {
            return
        }
        self.defaultDisplaySettingObserverToken = displaySetting.observe({ (change) in
            print("defaultDisplaySetting update?")
            switch change {
            case .change(_):
                if let displaySetting = RealmGlobalState.GetInstance()?.defaultDisplaySetting {
                    DispatchQueue.main.async {
                        self.textView.font = displaySetting.font
                    }
                }
                break
            default:
                break
            }
        })
    }
    func removeObserveGlobalState() {
        self.defaultDisplaySettingObserverToken = nil
    }
    
    func textViewScrollTo(readLocation:Int) {
        guard let text = self.textView.text else {
            return
        }
        let textLength = text.count
        var location = readLocation
        
        if textLength <= 0 {
            location = 0
        }else if location >= textLength {
            location = textLength - 1
        }
        var range = NSRange(location: location, length: 1)

        let maxLineCount = 5
        let minAppendLength = 15
        let maxAppendLength = 120
        var appendLength = location
        var lineCount = 0
        var index = text.index(text.startIndex, offsetBy: location)
        while index < text.endIndex {
            if text[index].unicodeScalars.contains(where: { (s) -> Bool in
                return CharacterSet.newlines.contains(s)
            }) {
                lineCount += 1
                if lineCount > maxLineCount && appendLength > minAppendLength {
                    break
                }
            }
            appendLength += 1
            if appendLength > maxAppendLength {
                break
            }
            index = text.index(index, offsetBy: 1)
        }
        range.location = appendLength;
        self.textView.scrollRangeToVisible(range)
        print("scrollRangeToVisible:(\(range.location), \(range.length), textLength: \(textLength)), readLocation: \(readLocation), appendLength: \(appendLength)")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 読み上げ中は無視して良いはず
        if storySpeaker.isSeeking {
            return
        }
        print("update readLocation: \(self.textView.selectedRange.location)")
        storySpeaker.readLocation = self.textView.selectedRange.location
    }
    
    func pushEditStory() {
        
    }
    
    func applyDarkTheme() {
        let backgroundColor = UIColor.black
        let foregroundColor = UIColor.white
        
        self.view.backgroundColor = backgroundColor;
        self.textView.textColor = foregroundColor;
        self.textView.backgroundColor = backgroundColor;
        self.textView.indicatorStyle = UIScrollView.IndicatorStyle.white
        self.nextChapterButton.backgroundColor = backgroundColor
        self.previousChapterButton.backgroundColor = backgroundColor
        self.chapterSlider.backgroundColor = backgroundColor
        self.chapterPositionLabel.backgroundColor = backgroundColor
        self.chapterPositionLabel.textColor = foregroundColor
        self.tabBarController?.tabBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        // ステータスバーの色を指定する
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    func applyBrightTheme() {
        let backgroundColor = UIColor.white
        let foregroundColor = UIColor.black
        
        self.view.backgroundColor = backgroundColor;
        self.textView.textColor = foregroundColor;
        self.textView.backgroundColor = backgroundColor;
        self.textView.indicatorStyle = UIScrollView.IndicatorStyle.black
        self.nextChapterButton.backgroundColor = backgroundColor
        self.previousChapterButton.backgroundColor = backgroundColor
        self.chapterSlider.backgroundColor = backgroundColor
        self.chapterPositionLabel.backgroundColor = backgroundColor
        self.chapterPositionLabel.textColor = foregroundColor
        self.tabBarController?.tabBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        // ステータスバーの色を指定する
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @objc func detailButtonClicked(_ sender: UIBarButtonItem) {
    }
    @objc func shareButtonClicked(_ sender: UIBarButtonItem) {
    }
    @objc func urlRefreshButtonClicked(_ sender: UIBarButtonItem) {
    }
    @objc func safariButtonClicked(_ sender: UIBarButtonItem) {
    }
    @objc func startStopButtonClicked(_ sender: UIBarButtonItem) {
    }
    @objc func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        self.storySpeaker.LoadNextChapter()
    }
    @objc func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        self.storySpeaker.LoadPreviousChapter()
    }
    
    // MARK: StorySpeakerDelegate
    func storySpeakerStartSpeechEvent(storyID:String){
    }
    func storySpeakerStopSpeechEvent(storyID:String){
    }
    func storySpeakerUpdateReadingPoint(storyID:String, location:Int){
        DispatchQueue.main.async {
            let contentLength = self.textView.text.count
            if contentLength <= location {
                self.textView.selectedRange = NSRange(location: location, length: 1)
            }
            self.textViewScrollTo(readLocation: location)
        }
    }
    func storySpeakerStoryChanged(story:RealmStory){
        setStoryWithoutSetToStorySpeaker(story: story)
    }


    @IBAction func chapterSliderValueChanged(_ sender: Any) {
        guard let storyID = self.targetStoryID, let story = RealmStory.SearchStoryFrom(storyID: RealmStory.CreateUniqueID(novelID: RealmStory.StoryIDToNovelID(storyID: storyID), chapterNumber: Int(self.chapterSlider.value + 0.5))) else {
            return
        }
        self.chapterSlider.value = Float(story.chapterNumber)
        self.storySpeaker.SetStory(story: story)
    }
    @IBAction func previousChapterButtonClicked(_ sender: Any) {
        self.storySpeaker.LoadPreviousChapter()
    }
    @IBAction func nextChapterButtonClicked(_ sender: Any) {
        self.storySpeaker.LoadNextChapter()
    }

}
