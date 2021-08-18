//
//  SettingTableVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/18.
//

import UIKit
import Kingfisher

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
        }
    }
}
