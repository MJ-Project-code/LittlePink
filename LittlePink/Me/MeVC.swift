//
//  MeVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/16.
//

import UIKit
import LeanCloud

class MeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         
        navigationItem.backButtonDisplayMode = .minimal
    }
    @IBAction func logoutTest(_ sender: Any) {
        LCUser.logOut()
        
        let LoginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
        
        loginAndMeParentVC.removeChildren()
        loginAndMeParentVC.add(child: LoginVC)
    }
    
}
