//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/13.
//
import PopupDialog

extension NoteEditVC{
    func setUI(){
        addPopup()//右上角加按钮并展示popup弹框
        setDraftNoteEditUI()
        setNoteEditUI()//编辑笔记时
    }
}

//编辑草稿笔记
extension NoteEditVC{
    //编辑草稿笔记时的UI处理
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
    //编辑笔记时的UI处理
    private func setNoteEditUI(){
        if let note = note{
            titleTextField.text = note.getExactStringVal(kTitleCol)
            textView.text = note.getExactStringVal(kTextCol)
            channel = note.getExactStringVal(kChannelCol)
            subChannel = note.getExactStringVal(kSubChannelCol)
            poiName = note.getExactStringVal(kPoiNameCol)
            
            
            if !subChannel.isEmpty{ updateChannelUI() }
            if !poiName.isEmpty{ updatePOINameUI() }
        }
    }
}


//编辑草稿笔记/笔记时的统一处理
extension NoteEditVC{
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

extension NoteEditVC{
    private func addPopup(){
        let icon =  largeIcon("info.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(shwoPopup))
        
        let pv = PopupDialogDefaultView.appearance()
        pv.titleColor = .label
        pv.messageFont = .systemFont(ofSize: 13)
        pv.messageColor = .secondaryLabel
        pv.messageTextAlignment = .natural
        
        let cb = CancelButton.appearance()
        cb.titleColor = .label
        cb.separatorColor = mainColor
        
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = .secondarySystemBackground
        pcv.cornerRadius = 10
    }
}

extension NoteEditVC{
    @objc private func shwoPopup(){
        let title = "发布小贴士"
        let message =
        """
        小粉书提示
        ..
        """
        let popup = PopupDialog(title: title, message: message,  transitionStyle: .zoomIn)
        
        let btn = CancelButton(title: "知道了", action: nil )
        
        popup.addButton(btn)
        
        present(popup, animated: true)
    }
}


