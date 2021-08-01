//
//  MeVC-BackOrDrawer.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/1.
//

import Foundation

extension MeVC{
    @objc func backOrSlide(_ sender:UIButton){
        if isFromNote{
            dismiss(animated: true)
        }else{
            //左侧抽屉菜单
        }
    }
}
