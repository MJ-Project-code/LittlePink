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
            dismissAndShowMeVC()
        }else{//首次登录(注册动作)
            let group = DispatchGroup()
            
            let randomAvatar = UIImage(named: "avatarPH\(Int.random(in: 1...4))")!
            if let avatarData = randomAvatar.pngData(){
                let avatarFile = LCFile(payload: .data(data: avatarData))
                avatarFile.mimeType = "image/jpeg"
                
                avatarFile.save(to: user, as: kAvatarCol ,group: group)
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
            group.enter()
            user.save { _ in group.leave() }
            
            group.enter()
            let userInfo = LCObject(className: kUserInfoTable)
            try? userInfo.set(kUserObjectIdCol, value: user.objectId)
            userInfo.save{ _ in group.leave() }
            
            group.notify(queue: .main) {
                self.dismissAndShowMeVC()
            }
            
        }

    }
    func  dismissAndShowMeVC(){
        self.hideLoadHUD()
        DispatchQueue.main.async {
            let mainSB = UIStoryboard(name:"Main", bundle: nil)
            let meVC =  mainSB.instantiateViewController(identifier: kMeVCID)
            loginAndMeParentVC.removeChildren()
            loginAndMeParentVC.add(child: meVC)
            
            self.dismiss(animated: true)
        }
    }
}
