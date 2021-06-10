//
//  NoteEditVC-Note.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/1.
//
import LeanCloud

extension NoteEditVC{
    func createNote(){
        do {
            let noteGroup = DispatchGroup()
            
            let note = LCObject(className: kNoteTable)
            //单个文件
            if let videoURL = self.videoURL{  //视频
                let video = LCFile(payload: .fileURL(fileURL: videoURL))
                video.save(to: note, as: kVideoCol, group: noteGroup)
            }
            
            if let coverPhotoData =  photos[0].jpeg(.high){ //封面图
                let coverPhoto =  LCFile(payload: .data(data: coverPhotoData))
                coverPhoto.save(to: note, as: kCoverPhotoCol, group: noteGroup)
            }
            let photoGroup = DispatchGroup()
            //多个图片存储
            var photoPaths : [Int:String] = [:]
            for (index,eachPhoto) in photos.enumerated(){
                if let photoData = eachPhoto.pngData(){
                    let photo = LCFile(payload: .data(data: photoData))
                    photoGroup.enter()
                    photo.save { (res) in
                        if case .success = res , let path = photo.url?.stringValue{
                            photoPaths[index] = path
                        }
                        photoGroup.leave()
                    }
                }
            }
            noteGroup.enter()
            photoGroup.notify(queue: .main) {
                let photoPathsArr =  photoPaths.sorted(by: <).map{$0.value}
                do{
                    try note.set(kPhotosCol, value: photoPathsArr)
                    note.save(){ _ in
                        print("")
                        noteGroup.leave()
                    }
                }catch{
                    print("字段赋值失败\(error)")
                }
            }
            
            try note.set(kTitleCol, value: titleTextField.exactText)
            try note.set(kTextCol,value: textView.exactText)
            try note.set(kChannelCol, value: channel.isEmpty ? "推荐" : channel )
            try note.set(kSubChannelCol,value: subChannel)
            try note.set(kPoiNameCol, value: poiName)
            
            noteGroup.enter()
            note.save { res in
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
                self.showTextHUD("发布笔记成功", false)
            }
            
            if draftNote != nil{
                //发布的是草稿
                //草稿是从我的页面进入的,有navigation
                navigationController?.popViewController(animated: true)
            }else{
                //发布的是全新笔记
                //全新笔记直接点+号进入
                dismiss(animated: true)
            }
            
            
        } catch  {
            print("存笔记金云端失败\(error)")
        }
    }
    
    func postDraftNote(_ draftNote: DraftNote){
        createNote()
        
        backgroundContext.perform {

            //数据
            backgroundContext.delete(draftNote)
            appDelegate.saveBackgroundContext()
            
            
            DispatchQueue.main.async {
                self.postDraftNoteFinished?()
            }
        }
    }
}
