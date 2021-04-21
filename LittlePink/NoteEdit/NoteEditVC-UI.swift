//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/13.
//


extension NoteEditVC{
    func setUI(){
        setDraftNoteEditUI()
    }
}

//编辑草稿笔记
extension NoteEditVC{
    private func setDraftNoteEditUI(){
        
        if let draftNote = draftNote{  //编辑草稿而不是新建草稿
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            
            if !subChannel.isEmpty{ updateChannelUI() }
            if !poiName.isEmpty{ updatePOINameUI() }
        }
    }
    
    
    func updateChannelUI(){
        channelIcon.tintColor = blueColor
        channelLabel.text = subChannel
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
    }
    
    func updatePOINameUI(){
        if poiName == ""{
            poiNameIcon.tintColor = .label
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
        }else{
            poiNameIcon.tintColor = blueColor
            poiNameLabel.text = poiName
            poiNameLabel.textColor = blueColor
        }
    }
}
