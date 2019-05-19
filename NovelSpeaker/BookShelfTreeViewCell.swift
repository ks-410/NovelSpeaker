//
//  BookShelfTreeViewCell.swift
//  NovelSpeaker
//
//  Created by 飯村卓司 on 2019/05/18.
//  Copyright © 2019 IIMURA Takuji. All rights reserved.
//

import UIKit
import RealmSwift

class BookShelfTreeViewCell: UITableViewCell {
    public static let id = "BookShelfTreeViewCell"
    final let depthWidth:Float = 32.0
    
    @IBOutlet weak var treeDepthImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var downloadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var readProgressView: UIProgressView!
    @IBOutlet weak var treeDepthImageViewWidthConstraint: NSLayoutConstraint!
    
    var storyObserveToken: NotificationToken? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        unregistStoryObserver()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func activateDownloadIndicator() {
        if self.downloadingActivityIndicator.isHidden {
            self.downloadingActivityIndicator.isHidden = false
        }
    }
    func deactivateDownloadIndicator() {
        if !self.downloadingActivityIndicator.isHidden {
            self.downloadingActivityIndicator.isHidden = true
        }
    }
    func activateNewImageView() {
        if self.newImageView.isHidden {
            self.newImageView.isHidden = false
        }
    }
    func deactivateNewImageView() {
        if !self.newImageView.isHidden {
            self.newImageView.isHidden = true
        }
    }
    func applyDepth(treeLevel:Int) {
        let depthWidth = CGFloat(self.depthWidth * Float(treeLevel))
        self.treeDepthImageView.removeConstraint(self.treeDepthImageViewWidthConstraint)
        self.treeDepthImageViewWidthConstraint = self.treeDepthImageView.widthAnchor.constraint(equalToConstant: depthWidth)
        self.treeDepthImageViewWidthConstraint.isActive = true
    }
    func applyCurrentReadingPointToIndicator(novelID:String) {
        guard let novel = RealmNovel.SearchNovelFrom(novelID: novelID), let story = novel.readingChapter else {
            self.readProgressView.progress = 0.0
            return
        }
        let chapterNumber = Float(story.chapterNumber)
        let readLocation = Float(story.readLocation)
        let contentCount = Float(story.content?.count ?? story.readLocation)
        let lastChapterNumber = Float(novel.lastChapterNumber ?? 1)
        let progress = ((chapterNumber - 1.0) + readLocation / contentCount) / lastChapterNumber
        self.readProgressView.progress = progress
    }
    func applyCurrentDownloadIndicatorVisibleStatus(novelIDArray:[String]) {
        // TODO: あとでダウンロード回りが決まったら作る
        self.downloadingActivityIndicator.isHidden = true
    }
    func registerStoryObserver(novelIDArray:[String]) {
        if novelIDArray.count == 1 {
            guard let realm = try? RealmUtil.GetRealm() else {
                return
            }
            let novelID = novelIDArray[0]
            self.storyObserveToken = realm.objects(RealmStory.self).filter("isDeleted = false AND novelID = %@", novelID).observe({ (change) in
                switch (change) {
                case .initial(_):
                    break
                case .update(_, _, _, let modifications):
                    if modifications.count > 0 {
                        DispatchQueue.main.async {
                            self.applyCurrentReadingPointToIndicator(novelID: novelID)
                        }
                    }
                case .error(_):
                    break
                }
            })
        }
    }
    func unregistStoryObserver() {
        self.storyObserveToken = nil
    }

    func cellSetup(title:String, treeLevel: Int, watchNovelIDArray: [String]) {
        applyDepth(treeLevel: treeLevel)
        titleLabel.text = title
        if watchNovelIDArray.count == 1 {
            let novelID = watchNovelIDArray[0]
            self.readProgressView.isHidden = false
            applyCurrentReadingPointToIndicator(novelID: novelID)
        }else{
            self.readProgressView.isHidden = true
        }
        applyCurrentDownloadIndicatorVisibleStatus(novelIDArray: watchNovelIDArray)
        registerStoryObserver(novelIDArray: watchNovelIDArray)
    }
    
    public var height : CGFloat {
        get {
            return CGFloat(self.titleLabel.bounds.height) + CGFloat(12) + CGFloat(10.5)
        }
    }
    
}