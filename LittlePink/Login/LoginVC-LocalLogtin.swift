//
//  LoginVC-LocalLogtin.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/23.
//


extension LoginVC{
    
    @objc func locallogin(){
        
        showLoadHUD()
        let config = JVAuthConfig()
        config.appKey = kJappKey
        config.authBlock = { _ -> Void in
            if  JVERIFICATIONService.isSetupClient(){
                ///预取号(可验证当前网络是否可以一键登录)
                JVERIFICATIONService.preLogin(5000) { (result) in
                    self.hideLoadHUD()
                    if let result = result , let code = result["code"] as? Int , code == 7000 {
                        //预取号成功
                        self.presentLocalLoginUI()
                        self.presentLocalLoginVC()
                    }else{
                        //print("预取号失败, 错误码:\(result!["code"]),错误描述:\(result!["content"])")
                    }
                }
                
            }else{
                self.hideLoadHUD()
                print("初始化一键登录失败")
            }
        }
        JVERIFICATIONService.setup(with: config)
    }
    
    private func presentLocalLoginUI(){
        let config = JVUIConfig()
        config.prefersStatusBarHidden = true
        config.navTransparent = true
        config.navText = NSAttributedString(string: "")
        
        let constraintX = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)!
       let logoConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1/7, constant: 0)

        config.logoConstraints = [constraintX,logoConstraintY!]
        
        let numberConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)
        config.numberConstraints = [constraintX,numberConstraintY!]
        
        let sloganConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.number, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 35)
        config.sloganConstraints = [constraintX,sloganConstraintY!]
        
        config.logBtnText = "同意协议并一键登录"
        config.logBtnImgs = [
            UIImage(named:"localLoginBtn-nor")!,
            UIImage(named:"localLoginBtn-nor")!,
            UIImage(named:"localLoginBtn-hig")!,
        ]
        let logBtnConstraintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.slogan, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 50)
        config.logBtnConstraints = [constraintX,logBtnConstraintY!]
        
        config.privacyState = true
        config.checkViewHidden = true
        
        config.appPrivacyOne = ["用户协议","https://www.zhihu.com"]
        config.appPrivacyTwo = ["隐私政策"]
        config.privacyComponents = ["登录注册代表你已同意","以及","和",""]
        config.appPrivacyColor = [UIColor.secondaryLabel,blueColor]
        config.privacyTextAlignment = .center
        
        let privacyConstaintW = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.none, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 260)
        let privacyConstaintY = JVLayoutConstraint(attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, to: JVLayoutItem.super, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -70)
        config.privacyConstraints = [constraintX,privacyConstaintW!,privacyConstaintY!]
        
        config.agreementNavBackgroundColor = mainColor
        config.agreementNavReturnImage = UIImage(systemName: "chevron.left")
        
        JVERIFICATIONService.customUI(with: config) { customView in
            guard let customView = customView else { return }
            
            let otherLoginBtn = UIButton()
            otherLoginBtn.setTitle("其他方式登录", for: .normal)
            otherLoginBtn.setTitleColor(.secondaryLabel, for: .normal)
            otherLoginBtn.titleLabel?.font = .systemFont(ofSize: 15)
            otherLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            otherLoginBtn.addTarget(self, action: #selector(self.otherLogin), for: .touchUpInside)
            
            customView.addSubview(otherLoginBtn)
            
            NSLayoutConstraint.activate([
                otherLoginBtn.centerXAnchor.constraint(equalTo: customView.centerXAnchor),
                otherLoginBtn.centerYAnchor.constraint(equalTo: customView.centerYAnchor, constant: 170),
                otherLoginBtn.widthAnchor.constraint(equalToConstant: 279)
            ])
        }
    }
    
    @objc private func otherLogin(){
        
    }
    
    //弹出一键登录授权页+用户点击登录
    private func presentLocalLoginVC(){
        JVERIFICATIONService.getAuthorizationWith(self, hide: true, animated: true, timeout: 5*1000, completion: { (result) in
            if let result = result , let _ = result["loginToken"]{
                //  一键登录成功
                JVERIFICATIONService.clearPreLoginCache()
            }else{
                print("一键登录失败")
            }
        }) { (type, content) in
            if let content = content {
                print("一键登录 actionBlock :type = \(type), content = \(content)")
            }
        }
    }
    
}
