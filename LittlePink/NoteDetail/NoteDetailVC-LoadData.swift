//
//  NoteDetailVC-LoadData.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/5.
//

import LeanCloud

extension NoteDetailVC{
    func getCommens(){
        showLoadHUD()
        
        
        let query = LCQuery(className: kCommentTable)
        query.whereKey(kNoteCol, .equalTo(note))
        query.whereKey(kUserCol, .included)
        //query.whereKey("\(kUserCol).\(knickNameCol)", .selected)
        query.whereKey(kCreatedAtCol, .descending)
        query.limit = kCommentsOffset

        query.find { res in
            self.hideLoadHUD()
            if case let .success(objects: comments) = res{
                self.comments = comments
                self.getReplies()

            }
        }
    }
    
    func getReplies(){
        
        var repliesDic : [Int:[LCObject]] = [:]
        
        let group = DispatchGroup()
        for (index, comment) in comments.enumerated(){
            group.enter()
            let query = LCQuery(className: kReplyTable)
            query.whereKey(kCommentCol, .equalTo(comment))
            query.whereKey(kUserCol, .included)
            query.whereKey(kCreatedAtCol, .descending)
            
            query.find{ res in
                if case let .success(objects: replies) = res{
                    repliesDic[index] = replies
                }else{
                    repliesDic[index] = []
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.replies =  repliesDic.sorted { $0.key < $1.key }.map{ $0.value }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
