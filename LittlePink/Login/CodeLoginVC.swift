//
//  CodeLoginVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/20.
//

import UIKit
import LeanCloud

private var totalTime = 4

class CodeLoginVC: UIViewController {
    
    private var timeRemain = totalTime
    
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var authCodeTF: UITextField!
    @IBOutlet weak var getAuthCodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    lazy var timer = Timer()
    
    private var phoneNumStr : String {phoneNumTF.unwrappedText }
    private var authCodeStr: String { authCodeTF.unwrappedText }
    
    
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
    
    @IBAction func TFEditingChanged(_ sender: UITextField) {
        if sender == phoneNumTF{
            getAuthCodeBtn.isHidden = !phoneNumStr.isPhoneNum && getAuthCodeBtn.isEnabled
        }
        
        if phoneNumStr.isPhoneNum && authCodeStr.isAuthCode{
            loginBtn.setToEnable()
        }else{
            loginBtn.setToDisable()
        }
    }
    
    
    @IBAction func getAuthCode(_ sender: Any) {
        getAuthCodeBtn.isEnabled = false
        setAuthCodeBtnDisableText()
        authCodeTF.becomeFirstResponder()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeAuthCodeBtnText), userInfo: nil, repeats: true) //selector.userinfo可以传值,这里不用传,所以给nil
        
        let variables: LCDictionary = [
            "name": LCString("小粉书"),
            "ttl": LCNumber(5),
        ]
        
        LCSMSClient.requestShortMessage(
            mobilePhoneNumber: phoneNumStr,
            templateName: "Register_Notice", // 控制台配置好的模板名称
            signatureName: "LeanCloud",  // 控制台配置好的短信签名
            variables: variables
        )
        { result in
            
            if case let .failure(error: error) = result{
                print(error.reason)
            }
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        view.endEditing(true)
        
        showLoadHUD()
        LCUser.signUpOrLogIn(mobilePhoneNumber: phoneNumStr, verificationCode: authCodeStr) { result in
            self.hideLoadHUD()
            switch result {
            case let .success(object: user): //登录成功  user是lc对象
                //判断是否首次登录
                let randomNickName = "小红薯\(String.randomString(6))"
                self.configAfterLogin(user,randomNickName)
                
            case let .failure(error:  error):
                DispatchQueue.main.async {
                    self.showTextHUD("登录失败", true, error.reason)
                }
            }
        }
    }
    
    
}

extension CodeLoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //range.location --当前输入的字符或粘贴的文本的第一个字符的索引
        //string--当前输入字符或粘贴的文本
        let limit = textField == phoneNumTF ? 11 : 6
        let isExceed = range.location >= limit || (textField.unwrappedText.count + string.count) > limit  //直接输入和粘贴输入,textField.unwrappedText不包含当前输入的字符
        if isExceed{
            showTextHUD("请输入正确的手机号码")
        }
        return !isExceed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == phoneNumTF{
            authCodeTF.becomeFirstResponder()
        }else{
            if loginBtn.isEnabled{
                login(loginBtn)
            }
        }
        
        return true
    }
}

extension CodeLoginVC{
    @objc private func changeAuthCodeBtnText(){
        timeRemain -= 1
        setAuthCodeBtnDisableText()
        
        if timeRemain <= 0{
            timer.invalidate()
            
            //重置
            timeRemain = totalTime
            getAuthCodeBtn.isEnabled = true
            getAuthCodeBtn.setTitle("发送验证码", for: .normal)
            
            getAuthCodeBtn.isHidden = !phoneNumStr.isPhoneNum
        }
    }
}

extension CodeLoginVC{
    private func  setAuthCodeBtnDisableText(){
        getAuthCodeBtn.setTitle("重新发送(\(timeRemain))s", for: .disabled)
    }
}
