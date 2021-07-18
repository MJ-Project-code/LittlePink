//
//  NoteDetailVC-DelComment.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/6.
//
import LeanCloud

extension NoteDetailVC{
    func delComment(_ comment: LCObject, _ section: Int){
        showDelAlert(for: "评论") { _ in
            //云端数据
            comment.delete { _ in }
            self.updateCommentCount(by: -1)

            
            self.comments.remove(at: section)
            
            //UI
            self.tableView.reloadData()
//                        self.tableView.performBatchUpdates {
//                            //self.tableView.deleteSections(IndexSet(integer: section), with: .automatic)
//                        }
        }
    }
}


