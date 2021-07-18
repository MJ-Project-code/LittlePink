//
//  NoteDetailVC-DelReply.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/15.
//

import LeanCloud

extension NoteDetailVC{
    func delReply(_ reply: LCObject, _ indexPath: IndexPath ){
        showDelAlert(for: "回复"){ _ in
            //云端数据
            reply.delete { _ in }
            self.updateCommentCount(by: -1)
            
            self.replies[indexPath.section].replies.remove(at: indexPath.row)
            
            //UI
            self.tableView.reloadData()
            
        }
        
        
    }
}
