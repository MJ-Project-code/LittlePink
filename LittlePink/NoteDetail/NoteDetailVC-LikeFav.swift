//
//  NoteDetailVC-LikeFav.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/21.
//
import LeanCloud

extension NoteDetailVC{
    func like(){
        if let user = LCApplication.default.currentUser{
            
        }else{
            showTextHUD("请先登录")
        }
    }
    
    func fav(){
        if let user = LCApplication.default.currentUser{
            
        }else{
            showTextHUD("请先登录")
        }
    }
}
