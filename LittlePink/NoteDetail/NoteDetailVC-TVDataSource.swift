//
//  NoteDetail-TVDatasource.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/4.
//
import LeanCloud

extension NoteDetailVC: UITableViewDataSource{
    //多段tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let replyCount = replies[section].replies.count
        
        if replyCount > 1 && !replies[section].isExpanded{
            return 1
        }else{
            return replyCount
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReplyCellID, for: indexPath) as! ReplyCell
        
        let reply = replies[indexPath.section].replies[indexPath.row]
        
        cell.reply = reply
        
        if let replyAuthor =  reply.get(kUserCol) as? LCUser, let noteAuthor = author, replyAuthor == noteAuthor{
            cell.authorLabel.isHidden = false
        }else{
            cell.authorLabel.isHidden = true
        }
        
        let replyCount = replies[indexPath.section].replies.count
        
        if replyCount > 1 ,!replies[indexPath.section].isExpanded {
            cell.showAllReplyBtn.isHidden = false
            cell.showAllReplyBtn.setTitle("展示 \(replyCount - 1) 条回复", for: .normal)
            cell.showAllReplyBtn.tag = indexPath.section
            cell.showAllReplyBtn.addTarget(self, action: #selector(showAllReply), for: .touchUpInside)
        }else{
            cell.showAllReplyBtn.isHidden = true
        }
        
        return cell
    }
    
    
}

extension NoteDetailVC{
    @objc private func showAllReply(sender: UIButton){
        let section = sender.tag
        
        replies[section].isExpanded = true
        
        tableView.performBatchUpdates {
            tableView.reloadSections(IndexSet(integer: section), with: .automatic)
        }
    }
}
