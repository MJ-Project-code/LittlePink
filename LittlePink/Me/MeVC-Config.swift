//
//  MeVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/2.
//

import LeanCloud

extension MeVC{
    func config(){
        navigationItem.backButtonDisplayMode = .minimal
        
        //本人已登录,查看自己的页面,可以修改资料和简介,显示'编辑资料'和 '设置' 按钮
        //本人已登录,查看他人页面||本人未登录,查看别人或自己页面,点击个人简介不可修改,显示 '关注','聊天' 按钮
        if let user = LCApplication.default.currentUser , user == self.user{
            isMySelf = true
        }
    }
}
