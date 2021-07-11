//
//  NoteDetailVC-postComment.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/7.
//

import LeanCloud

extension NoteDetailVC{
    func postComment(){
        let user = LCApplication.default.currentUser!

        do {
            //存入云端的数据
            let comment = LCObject(className: kCommentTable)
            try comment.set(kTextCol, value: textView.unwrappedText)
            try comment.set(kUserCol, value: user)
            try comment.set(kNoteCol, value: note)
            
            comment.save { _ in }
            
            try? note.increase(kCommentCountCol)
            
            //内存数据
            comments.insert(comment, at: 0)
            
            //UI
            tableView.performBatchUpdates {
                tableView.insertSections(IndexSet(integer: 0), with: .automatic)
            }
            commentCount += 1
            
            
        } catch  {
            print("comment赋值失败\(error)")
        }
    }
}
