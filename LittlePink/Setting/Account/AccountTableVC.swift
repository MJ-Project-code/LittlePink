//
//  AccountTableVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/19.
//

import UIKit
import LeanCloud

class AccountTableVC: UITableViewController {
    
    var user:LCUser!
    var phoneNumStr : String? { user.mobilePhoneNumber?.value }
    var isSetPassword: Bool? { user.get(kIsSetPasswordCol)?.boolValue }
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var appleIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let phoneNumStr = phoneNumStr{
            phoneNumLabel.text = phoneNumStr
        }
        if let _ = isSetPassword{
            passwordLabel.setToLight("已设置")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passwordTableVC = segue.destination as? PasswordTableVC{
            passwordTableVC.user = user
            if isSetPassword == nil {
                passwordTableVC.setPasswordfinished = {
                    self.passwordLabel.setToLight("已设置")
                }
            }
        }
    }
    
}
