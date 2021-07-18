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
        }else{
            commentView.authorLabel.isHidden = true
        }
        
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(commentTapped))
        commentView.tag = section
        commentView.addGestureRecognizer(commentTap)
        
        return commentView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separatorLine = tableView.dequeueReusableCell(withIdentifier: kCommentSectionFooterViewID)
        return separatorLine
    }
    //用户按下评论的回复后,对这个回复进行回复,删除,再回复
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //点击cell,轻闪一下
        //tableView.deselectRow(at: indexPath, animated: true)
        
        if let user = LCApplication.default.currentUser{
            let reply = replies[indexPath.section].replies[indexPath.row]
            guard let replyAuthor = reply.get(kUserCol) as? LCUser else { return }
            let commentAuthorNickName = replyAuthor.getExactStringVal(knickNameCol)
                        
            if user == replyAuthor  {
                let replyText = reply.getExactStringVal(kTextCol)
                
                let alert = UIAlertController(title: nil, message: "你的回复: \(replyText)", preferredStyle: .actionSheet)
                let subReplyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    self.prepareForReply(commentAuthorNickName, indexPath.section , replyAuthor)
                }
                let copyAction = UIAlertAction(title: "复制", style: .default) { _ in
                    UIPasteboard.general.string = replyText
                }
                let deletelAction = UIAlertAction(title: "删除", style: .default) { _ in
                    self.delReply(reply, indexPath)
                }
                subReplyAction.setTitleColor(mainColor)

                let cancelAction = UIAlertAction(title: "取消", style: .cancel)
                alert.addAction(subReplyAction)
                alert.addAction(copyAction)
                alert.addAction(deletelAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true)
            }else{
                self.prepareForReply(commentAuthorNickName, indexPath.section , replyAuthor)
            }
            
            
        }else{
            showTextHUD("请你登录")
        }
    }
    
}

extension NoteDetailVC{
    @objc private func commentTapped(_ tap: UITapGestureRecognizer){
        if let user = LCApplication.default.currentUser{
            
            guard let section = tap.view?.tag else{ return }
            let comment = comments[section]
            guard let commentAuthor = comment.get(kUserCol) as? LCUser else { return }
            let commentAuthorNickName = commentAuthor.getExactStringVal(knickNameCol)
            
            let commentText = comment.getExactStringVal(kTextCol)
            
            if  commentAuthor == user{
                
                let alert = UIAlertController(title: nil, message: "你的评论: \(commentText)", preferredStyle: .actionSheet)
                let replyAction = UIAlertAction(title: "回复", style: .default) { _ in
                    self.prepareForReply(commentAuthorNickName,section)
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
                prepareForReply(commentAuthorNickName,section)
            }
            
        }else{
            showTextHUD("请你登录")
        }
    }
}
