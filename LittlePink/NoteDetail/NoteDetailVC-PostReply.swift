//
//  NoteDetailVC-postReply.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/7.
//

import LeanCloud

extension NoteDetailVC{
    func postReply(){
        let user = LCApplication.default.currentUser!
        do{
            let reply = LCObject(className: kReplyTable)
            
            try reply.set(kTextCol, value: textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: comments[commentSection])
            
            reply.save { _ in }
            
            //UI
        }catch{
            print("给reply表赋值失败")
        }
        
        
        
        
    }
}
