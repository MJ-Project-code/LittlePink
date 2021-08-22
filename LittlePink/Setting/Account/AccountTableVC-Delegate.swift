//
//  AccountTableVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/22.
//

import Foundation

extension AccountTableVC{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0{
            if row == 0{
                showTextHUD("绑定,解绑,换绑手机号")
            }else if row == 1{
                if let _ = phoneNum{
                    performSegue(withIdentifier: "showPasswordTableVC", sender: nil)
                }else{
                    showTextHUD("请绑定手机号")
                }
            }
        }
    }
}
