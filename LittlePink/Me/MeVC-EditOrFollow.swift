//
// Created by 马俊 on 2021/8/3.
//

import LeanCloud

extension MeVC{
    @objc func editOrFollow(){
        if isMySelf{//编辑资料

        }else{
            //用户登录看别人，或者用户未登录看所有
            if let _ = LCApplication.default.currentUser{
                print("关注和取消关注功能")
            }else{
                showLoginHUD()
            }
        }
    }
}
