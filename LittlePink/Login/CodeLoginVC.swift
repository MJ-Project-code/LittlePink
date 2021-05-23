//
//  CodeLoginVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/20.
//

import UIKit

class CodeLoginVC: UIViewController {

    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCode: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    private var phoneNumStr : String {phoneNumTF.unwrappedText}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        
        loginBtn.setToDisable()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneNumTF.becomeFirstResponder()
    }


    @IBAction func dismiss(_ sender: Any) {dismiss(animated: true)}
    
    @IBAction func TFEditingChanged(_ sender: Any) {
        getAuthCode.isHidden = !phoneNumStr.isPhoneNum
    }
    
    
    @IBAction func getAuthCode(_ sender: Any) {
    }
    
    @IBAction func login(_ sender: Any) {
    }
    

}

extension CodeLoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //range.location --当前输入的字符或粘贴的文本的第一个字符的索引
        //string--当前输入字符或粘贴的文本
        let limit = textField == phoneNumTF ? 11 : 6
        print(textField.unwrappedText)
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit  //直接输入和粘贴输入,textField.unwrappedText不包含当前输入的字符
        if isExceed{
            showTextHUD("请输入正确的手机号码")
        }
        return !isExceed
    }
}
