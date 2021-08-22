//
//  PasswordLoginVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/20.
//

import UIKit

class PasswordLoginVC: UIViewController {

    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    private var phoneNumStr: String { phoneNumberTF.unwrappedText }
    private var passwordStr: String { passwordTF.unwrappedText }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        loginBtn.setToDisable()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumberTF.becomeFirstResponder()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func backToCodeLoginVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TFEditChanged(_ sender: Any) {
        if phoneNumStr.isPhoneNum && passwordStr.isPassword{
            loginBtn.setToEnable()
        }else{
            loginBtn.setToDisable()
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
    }
    
}

extension PasswordLoginVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case phoneNumberTF:
            passwordTF.becomeFirstResponder()
        default:
            <#code#>
        }
    }
}
