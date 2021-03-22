//
//  ChannelTableVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/17.
//

import UIKit
import XLPagerTabStrip

class ChannelTableVC: UITableViewController {
    
    var channel = ""
    var subChannels:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.tableFooterView = UIView()
        
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subChannels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSubChannelCellID, for: indexPath)
        cell.textLabel?.text = "# \(subChannels[indexPath.row])"
        cell.textLabel?.font = .systemFont(ofSize: 15)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelVC  =  parent as! ChannelVC
        channelVC.PVdelegate?.updateChannel(channel: channel, subChannel: subChannels[indexPath.row])
        dismiss(animated: true)
    }
   

}

extension ChannelTableVC:IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
