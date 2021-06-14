//
//  LoginVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/23.
//

import UIKit

class LoginVC: UIViewController {
    
    lazy private var loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)  //正常状态是登陆
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = mainColor
        btn.layer.cornerRadius = 22
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(loginBtn)
        setUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI(){
        //水平垂直居中
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //宽高
        loginBtn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc private func login(){
        #if targetEnvironment(simulator)
            presentCodeLoginVC()
        #else
            //locallogin()
        presentCodeLoginVC()
        #endif
        
    }
}
