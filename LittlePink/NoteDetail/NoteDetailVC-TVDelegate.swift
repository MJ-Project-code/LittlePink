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
        
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(commentTapped))
        commentView.tag = section
        commentView.addGestureRecognizer(commentTap)
        
        return commentView
    }
}

extension NoteDetailVC{
    @objc private func commentTapped(_ tap: UITapGestureRecognizer){
        if let user = LCApplication.default.currentUser{
            
            guard let section = tap.view?.tag else{ return }
            let comment = comments[section]
            let commentText = comment.getExactStringVal(kTextCol)
            
            if  let commentAuthor = comment.get(kUserCol) as? LCUser , commentAuthor == user{
                
                let alert = UIAlertController(title: nil, message: "你的评论: \(commentText)", preferredStyle: .actionSheet)
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    //回复
                }
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    UIPasteboard.general.string = commentText
                }
                let deletelAction = UIAlertAction(title: "删除", style: .default) { _ in
                    self.delComment(comment,section)
                }
                replyAction.setTitleColor(mainColor)

                let cancelAction = UIAlertAction(title: "取消", style: .cancel)
                alert.addAction(replyAction)
                alert.addAction(copyAction)
                alert.addAction(deletelAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true)

            }else{
                //回复操作
            }
            
        }else{
            showTextHUD("请你登录")
        }
    }
}
