//
//  WaterfallVC.swift
//  Pods
//
//  Created by 马俊 on 2021/1/29.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip
import LeanCloud
import SegementSlide
import MJRefresh

class WaterfallVC: UICollectionViewController , SegementSlideContentScrollViewDelegate{
    var channel = ""
    lazy var header = MJRefreshNormalHeader()
    
    @objc var scrollView: UIScrollView { collectionView }
    
    //当用户在 我的 页面点击,会传一个isDraft数据
    //"我的"页面用到的变量
    var isDraft = false
    var draftNotes:[DraftNote] = []
    
    var isMyDraft = false
    
    //首页进入,笔记详情页
    var notes: [LCObject] = []
    var user: LCUser?
    var isMyNote = false
    var isMyFav = false
    var isMyselfLike = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        if let _ = user {//个人页面瀑布流
            if isMyNote{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyNotes))
            }else if isMyFav{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyFavNotes))
            }else{
                header.setRefreshingTarget(self, refreshingAction: #selector(getMyLikeNotes))
            }
            header.beginRefreshing()
        }else if isDraft{
            getDraftNotes()
        }else{
            header.setRefreshingTarget(self, refreshingAction: #selector(getNotes))
            header.beginRefreshing()
        }
        
    }
    
    @IBAction func dismissDraftNotesVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

//delegate 调瀑布流布局
//动态设定cell的size


extension WaterfallVC:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
