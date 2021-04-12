//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/15.
//

import Foundation

extension NoteEditVC{
    func config(){
        photoCollectionview.dragInteractionEnabled = true
        hideKeyboardWhenTappedAround()
        titleCountLabel.text = "\(kmaxNoteTitleCount)"
        
        let lineFragmentPadding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -lineFragmentPadding, bottom: 0, right: -lineFragmentPadding)//UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) 文本上下边距
//        textView.textContainer.lineFragmentPadding = 0 //左右缩进

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let typingAttributes:[NSAttributedString.Key:Any] = [
            .paragraphStyle:paragraphStyle,
            .font:UIFont.systemFont(ofSize: 14),
            .foregroundColor:UIColor.secondaryLabel
        ]
        textView.typingAttributes  = typingAttributes
        //光标颜色
        textView.tintColorDidChange()
        
        //可能会加载多个view
        //软键盘的view  
        textView.inputAccessoryView = Bundle.loadView(fromNib: "TextViewIAView", with: TextViewIAView.self)
            textView.inputAccessoryView = textViewIAView
            
            textViewIAView.doneBtn.addTarget(self, action: #selector(resignTextView), for: .touchUpInside)
            textViewIAView.maxTextCountLabel.text = "/\(kmaxNoteTextCount)"
        
        //提前请求位置权限
        locationManager.requestWhenInUseAuthorization()
        
        print(NSHomeDirectory())
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
}
//监听
extension NoteEditVC{
    @objc private func resignTextView(){
        textView.resignFirstResponder()
    }
}
