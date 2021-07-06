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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
