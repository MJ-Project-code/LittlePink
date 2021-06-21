//
//  WaterfallVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/12.
//

import Foundation

extension WaterfallVC{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMyDraft{
            let draftNote =  draftNotes[indexPath.item]
            
            if let photosData = draftNote.photos,
               let photosDataArr =  try? JSONDecoder().decode([Data].self, from: photosData){
                
                let photos = photosDataArr.map {UIImage($0)!}  //相当于for循环,data转uiimage
                
                let videoURL =  FileManager.default.save(draftNote.video, to: "video", as: "\(UUID().uuidString).mp4")
                
                let vc = storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                vc.draftNote = draftNote
                vc.photos = photos
                vc.videoURL = videoURL
                vc.updateDraftNoteFinished = {
                    self.getDraftNotes()
                }
                vc.postDraftNoteFinished = {
                    self.getDraftNotes()
                }
                navigationController?.pushViewController(vc, animated: true)
                
                
            }else{
                showTextHUD("加载草稿失败")
            }
            
        }else{
            //依赖注入
            let detailVC = storyboard!.instantiateViewController(identifier: kNoteDetailVCID){ coder  in
                NoteDetailVC(coder: coder,note: self.notes[indexPath.item])
            }
            detailVC.modalPresentationStyle = .fullScreen
            present(detailVC, animated: true)
        }
    }
}
