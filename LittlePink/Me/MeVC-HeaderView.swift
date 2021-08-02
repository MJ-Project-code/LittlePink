//
//  MeVC-HeaderView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/2.
//

import LeanCloud

extension MeVC{
    func setHeaderView() -> UIView {
        let headerView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: headerView.rootStackView.frame.height + 16).isActive = true
        
        headerView.user = user
        
        if isFromNote{
            headerView.backOrSlideBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        
        headerView.backOrSlideBtn.addTarget(self, action: #selector(backOrSlide), for: .touchUpInside)
        
        if isMySelf{
            //登录并且看自己
            
        }else{
            if user.getExactStringVal(kIntroCol).isEmpty{
                headerView.introLabel.isHidden = true
            }
            //1.登录看别人 2.未登录看别人
            if let user = LCApplication.default.currentUser{
                headerView.editOrFollowBtn.setTitle(isAttention(user,attentionTo: headerView.user) ? "取消关注" : "关注" , for: .normal)
                headerView.editOrFollowBtn.backgroundColor = mainColor
            }else{
                headerView.editOrFollowBtn.setTitle("关注", for: .normal)
                headerView.editOrFollowBtn.backgroundColor = mainColor
                headerView.settingOrChatBtn.setImage(fontIcon("ellipsis.bubble", fontSize: 13), for: .normal)
            }
            
        }
        
        return headerView
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
