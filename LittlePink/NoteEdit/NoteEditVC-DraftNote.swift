//
//  NoteEditVC-DraftNote.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/14.
//

extension NoteEditVC{
    func createDraftNote(){
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            if self.isVideo{
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            
            self.handlePhotos(draftNote)

            
            draftNote.isVideo = self.isVideo

            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUD("保存草稿成功",false)
            }
        }
        dismiss(animated: true ) //dismiss会把父视图一起dismiss
        
    }
    
    func updateDraftNote(_ draftNote:DraftNote){
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote)
            }
            
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        
        navigationController?.popViewController(animated: true)
        
    }
}

extension NoteEditVC{
    private func handlePhotos(_ draftNote:DraftNote){
        //封面图片
        draftNote.coverPhoto = photos[0].jpeg(.high)

        var photos:[Data] = []
        for photo in self.photos{
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote:DraftNote){
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
    }
}

