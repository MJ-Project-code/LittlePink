//
//  WaterfallVC.swift
//  Pods
//
//  Created by 马俊 on 2021/1/29.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip
class WaterfallVC: UICollectionViewController {
    var channel = ""
        
    var draftNotes:[DraftNote] = []
    //当用户在 我的 页面点击,会传一个isMyDraft数据
    var isMyDraft = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
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
            cellH = UIImage(named: "\(indexPath.item + 1)")!.size.height
        }
        
        return CGSize(width: cellW, height: cellH)
    }
}

extension WaterfallVC:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
