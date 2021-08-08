//
// Created by 马俊 on 2021/8/3.
//

import LeanCloud

extension MeVC{
    @objc func settingOrChat(){
        if isMySelf{//设置

        }else{
            if let _ = LCApplication.default.currentUser{
                print("私信功能")
            }else{
                showLoginHUD()
            }
        }
    }
}