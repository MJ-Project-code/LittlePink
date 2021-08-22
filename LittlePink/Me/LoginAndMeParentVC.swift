//
//  LoginAndMeparentVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/26.
//

import LeanCloud

var loginAndMeParentVC = UIViewController()
class LoginAndMeParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user  = LCApplication.default.currentUser {
            let meVC =  storyboard!.instantiateViewController(identifier: kMeVCID){ coder in
                MeVC(coder: coder, user: user)
            }
            add(child: meVC)
        }else{
            let loginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
            add(child: loginVC)
        }
        loginAndMeParentVC = self
    }

}
