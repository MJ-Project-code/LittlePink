//
//  EditPorfileTableVC-UI.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/16.
//

import Kingfisher

extension EditPorfileTableVC{
    func setUI(){
        avatarImageView.kf.setImage(with: user.getImageURL(from: kAvatarCol, .avatar))
        nickName = user.getExactStringVal(knickNameCol)
        
        gender = user.getExactBoolValDefaultF(kGenderCol)
        
        birth = user.get(kBirthCol)?.dateValue
        
        intro = user.getExactStringVal(kIntroCol)
    }
}
