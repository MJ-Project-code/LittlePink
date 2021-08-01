//
//  SocialLoginVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/12.
//

import UIKit
import AuthenticationServices
import LeanCloud

class SocialLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInWithAlipay(_ sender: Any) {
        signInWithAlipay()
    }
    
    @IBAction func signWithApple(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email,.fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

}
