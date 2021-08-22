//
//  SettingTableVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/18.
//

import UIKit
import Kingfisher
import LeanCloud

extension SettingTableVC{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 1 , row == 1{//清楚缓存
            ImageCache.default.clearCache {
                self.showTextHUD("清除缓存成功")
                self.cacheSizeLabel.text = "无缓存"
            }
        }else if section == 3 {
            let appID = ""
            let path = "https://itunes.apple.com/app/id\(appID)"
            //let path = "https://www.baidu.com"
            
            guard let url = URL(string: path) , UIApplication.shared.canOpenURL(url) else { return  }
            UIApplication.shared.open(url)
        }else if section == 4{
            dismiss(animated: true)
            LCUser.logOut()
            
            let loginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child: loginVC)
        }
    }
}
