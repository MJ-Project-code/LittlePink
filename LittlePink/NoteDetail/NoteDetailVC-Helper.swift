//
//  NoteDetailVC-Helper.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/25.
//
import LeanCloud

extension NoteDetailVC{
    func showDelAlert(for name: String,confirmHandler: ((UIAlertAction) -> ())?){
        let alert = UIAlertController(title: "提示", message: "你确定删除\(name)吗?", preferredStyle: .alert)
        let alert1 = UIAlertAction(title: "取消", style: .cancel)
        let alert2 = UIAlertAction(title: "确认", style: .default, handler: confirmHandler)
        alert.addAction(alert1)
        alert.addAction(alert2)
        present(alert, animated: true)
    }
    
    func comment(){
        if let _ = LCApplication.default.currentUser{
            //reset
            //UI
            showTextView()
        }else{
            showTextHUD("请先登录")
        }
    }
    
    func showTextView(_ isReply: Bool = false,_ textViewPH: String = kNoteCommentPH){
        //reset
        self.isReply = isReply
        textView.placeholder = textViewPH
        //UI
        textView.becomeFirstResponder()
        textViewBarVIew.isHidden = false
    }
    
    func hideAndResetTextView(){
        textView.resignFirstResponder()
        textView.text = ""
    }
}
