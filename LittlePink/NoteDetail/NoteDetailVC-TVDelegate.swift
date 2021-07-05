//
//  NoteDetailVC-TVDelegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/4.
//
import LeanCloud

extension NoteDetailVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentViewID) as! CommentView
        let comment = comments[section]
        commentView.comment = comment
        
        if let commentAuthor = comment.get(kUserCol) as? LCUser,
           let noteAuthor = author ,
           commentAuthor == noteAuthor{
            commentView.authorLabel.isHidden = false
        }
        
        
        return commentView
    }
}
