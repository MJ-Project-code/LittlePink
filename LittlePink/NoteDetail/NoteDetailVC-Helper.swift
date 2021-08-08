//
//  NoteDetailVC-Helper.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/25.
//
import LeanCloud

extension NoteDetailVC{
    func comment(){
        if let _ = LCApplication.default.currentUser{
            //reset
            //UI
            showTextView()
        }else{
            showLoginHUD()        }
    }
    
    func showTextView(_ isReply: Bool = false,_ textViewPH: String = kNoteCommentPH , _ replyToUser:LCUser? = nil){
        //reset
        self.isReply = isReply
        textView.placeholder = textViewPH
        self.replyToUser = replyToUser
        //UI
        textView.becomeFirstResponder()
        textViewBarVIew.isHidden = false
    }
    
    func hideAndResetTextView(){
        textView.resignFirstResponder()
        textView.text = ""
    }
    
    func prepareForReply(_ nickName: String, _ section: Int, _ replyToUser: LCUser? = nil){
        //参数1:全局变量isReply--因公用textview,故在点击发送时需要判断是发评论还是回复
        //参数2:textView的placeholder
        //参数3:全局变量replyToUser(flag),若有则表明自己是子回复
        showTextView(true,"回复 \(nickName)",replyToUser)
        commentSection = section
    }
}

extension NoteDetailVC{
    func showDelAlert(for name: String,confirmHandler: ((UIAlertAction) -> ())?){
        let alert = UIAlertController(title: "提示", message: "你确定删除\(name)吗?", preferredStyle: .alert)
        let alert1 = UIAlertAction(title: "取消", style: .cancel)
        let alert2 = UIAlertAction(title: "确认", style: .default, handler: confirmHandler)
        alert.addAction(alert1)
        alert.addAction(alert2)
        present(alert, animated: true)
    }
    
    
    
    func updateCommentCount(by offset: Int){
        //云端数据
        try? note.increase(kCommentCountCol , by: -1)
        note.save { _ in }
        
        //UI
        self.commentCount += offset
    }
    
    
}
