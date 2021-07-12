//
//  NoteDetail-TVDatasource.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/4.
//

extension NoteDetailVC: UITableViewDataSource{
    //多段tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        replies[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReplyCellID, for: indexPath) as! ReplyCell
        
        cell.reply = replies[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
}
