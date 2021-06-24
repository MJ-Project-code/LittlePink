//
//  NoteDetailVC-Fav.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/24.
//

import LeanCloud

extension NoteDetailVC{
    func fav(){
        if let user = LCApplication.default.currentUser{
            
        }else{
            showTextHUD("请先登录")
        }
    }
}
 
