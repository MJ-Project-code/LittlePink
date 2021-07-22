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

class WaterfallVC: UICollectionViewController , SegementSlideContentScrollViewDelegate{
    var channel = ""
    @objc var scrollView: UIScrollView { collectionView }
    
    //当用户在 我的 页面点击,会传一个isMyDraft数据
    //"我的"页面用到的变量
    var isMyDraft = false
    var draftNotes:[DraftNote] = []
    
    //首页进入,笔记详情页
    var notes: [LCObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        getNotes()
        getDraftNotes()
        
    }

    @IBAction func dismissDraftNotesVC(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

//delegate 调瀑布流布局
//动态设定cell的size
extension WaterfallVC:CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellW = (screenRect.width - kWaterfallPadding * 3)/2
        
        var cellH:CGFloat = 0
        
        if isMyDraft{
            let draftNote = draftNotes[indexPath.item]
            let imageH = UIImage(draftNote.coverPhoto)?.size.height
            let imageW = UIImage(draftNote.coverPhoto)?.size.width
            let imageRatio = imageH! / imageW!
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellButtomViewH
        }else{
            let note = notes[indexPath.item]
            let coverPhotoRatioCol = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol))
            cellH = cellW * coverPhotoRatioCol + kWaterfallCellButtomViewH
        }
        
        return CGSize(width: cellW, height: cellH)
    }
}

extension WaterfallVC:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
