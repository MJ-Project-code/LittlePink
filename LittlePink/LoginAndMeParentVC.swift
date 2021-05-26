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
            let meVC = storyboard!.instantiateViewController(identifier: kMeVCID)
            addChild(meVC)
        }else{
            let loginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
            addChild(loginVC)
        }
        
        loginAndMeParentVC = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
