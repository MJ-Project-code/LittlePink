//
//  PasswordTableVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/22.
//

import UIKit
import LeanCloud

class PasswordTableVC: UITableViewController {
    
    var user:LCUser!
    var setPasswordfinished:(() -> ())?

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    private var passwordStr: String{ passwordTF.unwrappedText }
    private var confirmPasswordStr: String{ confirmPasswordTF.unwrappedText }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.becomeFirstResponder()
    }

    @IBAction func done(_ sender: UIButton) {
        if passwordStr.isPassword && confirmPasswordStr.isPassword{
            if passwordStr == confirmPasswordStr{
                //云端数据
                user.password = LCString(passwordStr)
                try? user.set(kIsSetPasswordCol, value: true)
                user.save{ _ in }
                
                //UI
                dismiss(animated: true)
                setPasswordfinished?()
            }else{
                showTextHUD("密码不一致")
            }
            
        }else{
            showTextHUD("密码必须为6-16位的数字或字母")
        }
    }
    
    @IBAction func TFEditChanged(_ sender:Any){
        if passwordTF.isBlank || confirmPasswordTF.isBlank{
            doneBtn.isEnabled = false
        }else{
            doneBtn.isEnabled = true
        }
    }
}

extension PasswordTableVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case passwordTF:
            confirmPasswordTF.becomeFirstResponder()
        default:
            if doneBtn.isEnabled{
                done(doneBtn)
            }
        }
        return true
    }
}
