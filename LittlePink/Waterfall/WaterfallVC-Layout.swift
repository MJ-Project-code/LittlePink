//
//  WaterfallVC-Layout.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/8.
//

import CHTCollectionViewWaterfallLayout

extension WaterfallVC:CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellW = (screenRect.width - kWaterfallPadding * 3)/2
        
        var cellH:CGFloat = 0
        
        if isMyDraft , indexPath.item == 0{
            cellH = 100
        }else if isDraft{
            let draftNote = draftNotes[indexPath.item]
            let imageH = UIImage(draftNote.coverPhoto)?.size.height
            let imageW = UIImage(draftNote.coverPhoto)?.size.width
            let imageRatio = imageH! / imageW!
            cellH = cellW * imageRatio + kDraftNoteWaterfallCellButtomViewH
        }else{
            let offset = isMyDraft ? 1: 0
            let note = notes[indexPath.item - offset]
            let coverPhotoRatioCol = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol))
            cellH = cellW * coverPhotoRatioCol + kWaterfallCellButtomViewH
        }
        
        return CGSize(width: cellW, height: cellH)
    }
}
