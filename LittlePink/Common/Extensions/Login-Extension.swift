//
//  Login-Extension.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/25.
//

import LeanCloud

extension UIViewController{
    func configAfterLogin(_ user: LCUser,_ nickName: String,_ email: String = ""){
        if let _ = user.get(knickNameCol){
            
        }else{//首次登录(注册动作)
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")!
            if let avatarData = randomAvatar.pngData(){
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                
                avatarFile.save(to: user, as: kAvatarCol)
            }
            
            do {
                if email != ""{
                    user.email = LCString(email)
                }
                try user.set(knickNameCol, value: nickName)
            } catch {
                print("字段赋值失败\(error)")
                return
            }
            
            user.save { result in
                if case .success = result{
                    
                }
            }
        }
        
    }
}
