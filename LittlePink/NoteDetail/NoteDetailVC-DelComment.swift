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
            //数据
            comment.delete { _ in }
            try? self.note.increase(kCommentCountCol , by: -1)
            self.note.save { _ in }
            
            self.comments.remove(at: section)
            
            //UI
            self.tableView.reloadData()
//                        self.tableView.performBatchUpdates {
//                            //self.tableView.deleteSections(IndexSet(integer: section), with: .automatic)
//                        }
            self.commentCount -= 1
        }
    }
}
