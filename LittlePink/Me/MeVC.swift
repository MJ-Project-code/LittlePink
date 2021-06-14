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
    
    @IBAction func LogoutTest(_ sender: Any) {
        LCUser.logOut()
        
        let LoginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
        
        loginAndMeParentVC.removeChildren()
        loginAndMeParentVC.add(child: LoginVC)
    }
    
    @IBAction func showDraftNotes(_ sender: Any) {
        let navi = storyboard!.instantiateViewController(identifier: kDraftNotesNavID)
        navi.modalPresentationStyle = .fullScreen
        present(navi, animated: true)
    }
}
