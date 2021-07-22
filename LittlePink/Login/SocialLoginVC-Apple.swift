//
//  SocialLoginVC-apple.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/18.
//
import AuthenticationServices
import LeanCloud

extension SocialLoginVC: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential{
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userID = appleIDCredential.user
            let status = appleIDCredential.realUserStatus
            
            

            
            var name = ""
            
            if appleIDCredential.fullName?.familyName != nil || appleIDCredential.fullName?.givenName != nil{
                let familyName = appleIDCredential.fullName?.familyName ?? ""
                let givenName = appleIDCredential.fullName?.givenName ?? ""
                 name = "\(familyName)\(givenName)"
                UserDefaults.standard.setValue(name, forKey: kNameFromAppID)
            }else{
                name = UserDefaults.standard.string(forKey: kNameFromAppID) ?? ""
            }
            var email = ""
            if let unwrappedEmail = appleIDCredential.email{
                email = unwrappedEmail
                UserDefaults.standard.setValue(email, forKey: kEmailFromAppleID)
            }else{
                email = UserDefaults.standard.string(forKey: kEmailFromAppleID) ?? ""
            }
            guard let identityToken = appleIDCredential.identityToken,
                  let authorizationCode = appleIDCredential.authorizationCode else{ return }
            
            let appleData: [String: Any] = [
                "uid": userID,
                "identity_token": String(decoding: identityToken, as: UTF8.self),
                "code": String(decoding: authorizationCode, as: UTF8.self)
            ]
            let user = LCUser()
            user.logIn(authData: appleData, platform: .apple) { (result) in
                switch result {
                case .success:
                    self.configAfterLogin(user , name , email)
                case .failure(error: let error):
                    DispatchQueue.main.async {
                        self.showTextHUD("登录失败", in: self.parent!.view, error.reason)
                    }
                }
            }
            
        case let passwordCredential as ASPasswordCredential: print(passwordCredential)
            let _ = passwordCredential.user
            let _ = passwordCredential.password
        default: break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("苹果登录失败\(error)")
    }
    
    
}

extension SocialLoginVC: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
    
    
}

extension SocialLoginVC{
    func checkSignInWithAppleState(with userID: String){
        let appleProvider = ASAuthorizationAppleIDProvider()
        appleProvider.getCredentialState(forUserID: userID) { (credentialState, error) in
            switch credentialState{
                
            case .authorized:
                print("用户已登录")
            case .revoked:
                print("用户已从设置退出登录或登了其他AppID")
            case .notFound:
                print("无此登录")
             default:
                break
            }
        }
    }
}
