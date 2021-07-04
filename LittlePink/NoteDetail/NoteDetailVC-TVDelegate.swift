//
//  NoteDetailVC-TVDelegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/4.
//

extension NoteDetailVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let commentView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kCommentViewID) as! CommentView
        return commentView
    }
}
