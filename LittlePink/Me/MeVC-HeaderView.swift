//
//  MeVC-HeaderView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/2.
//

import LeanCloud

extension MeVC{
    func setHeaderView() -> UIView {
        
        meHeaderView.translatesAutoresizingMaskIntoConstraints = false
        meHeaderView.heightAnchor.constraint(equalToConstant: meHeaderView.rootStackView.frame.height + 26).isActive = true
        
        meHeaderView.user = user
        
        if isFromNote{
            meHeaderView.backOrSlideBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        
        meHeaderView.backOrSlideBtn.addTarget(self, action: #selector(backOrSlide), for: .touchUpInside)
        
        if isMySelf{
            //登录并且看自己
            //简介添加手势
            meHeaderView.introLabel.addGestureRecognizer(UIPassableTapGestureRecognizer(target: self, action: #selector(editorIntro)))
        }else{
            if user.getExactStringVal(kIntroCol).isEmpty{
                meHeaderView.introLabel.isHidden = true
            }
            //1.登录看别人 2.未登录看别人
            if let user = LCApplication.default.currentUser{
                meHeaderView.editOrFollowBtn.setTitle(isAttention(user,attentionTo: meHeaderView.user) ? "取消关注" : "关注" , for: .normal)
                meHeaderView.editOrFollowBtn.backgroundColor = mainColor
            }else{
                meHeaderView.editOrFollowBtn.setTitle("关注", for: .normal)
                meHeaderView.editOrFollowBtn.backgroundColor = mainColor
                meHeaderView.settingOrChatBtn.setImage(fontIcon("ellipsis.bubble", fontSize: 13), for: .normal)
            }


            
        }
        meHeaderView.editOrFollowBtn.addTarget(self, action: #selector(editOrFollow), for: .touchUpInside)
        meHeaderView.settingOrChatBtn.addTarget(self, action: #selector(settingOrChat), for: .touchUpInside)
        
        return meHeaderView
    }
}

extension MeVC{
    func isAttention(_ follower:LCUser,attentionTo user: LCUser)  -> Bool {
        let query = LCQuery(className: kFollower)
        query.whereKey(kFollower, .equalTo(follower))
        query.whereKey(kUserCol, .equalTo(user))
        
        let count = query.count()
        
        return (count.intValue > 0)
    }
}
