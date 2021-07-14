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
            // 云端数据
            //reply表
            let reply = LCObject(className: kReplyTable)
            
            try reply.set(kTextCol, value: textView.unwrappedText)
            try reply.set(kUserCol, value: user)
            try reply.set(kCommentCol, value: comments[commentSection])
            
            reply.save { _ in }
            
            //note表数据
            try note.increase(kCommentCountCol)
            note.save{ _ in }
            
            //内存数据
            replies[commentSection].replies.append(reply)

            //UI
            if replies[commentSection].isExpanded{
                tableView.performBatchUpdates {
                    //row:先利用commentSection找到当前section中一共就几个回复,减去1之后就得出插入的新row的索引
                    tableView.insertRows(
                        at: [IndexPath(row: replies[commentSection].replies.count - 1, section: commentSection)],
                        with: .automatic
                    )
                }
            }else{
                let cell = tableView.cellForRow(at: IndexPath(row: 0, section: commentSection)) as! ReplyCell
                cell.showAllReplyBtn.setTitle("展示 \(replies[commentSection].replies.count - 1) 条回复", for: .normal)
            }
            
            
        }catch{
            print("给reply表赋值失败")
        }
        
        
        
        
    }
}
