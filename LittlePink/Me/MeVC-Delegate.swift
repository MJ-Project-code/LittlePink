//
//  MeVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/17.
//

import LeanCloud

extension MeVC: EditProfileDelegate{
    func updateUser(_ avatar: UIImage?, _ nickName: String, _ gender: Bool, _ birth: Date?, _ intro: String) {
        if let avatar = avatar , let data = avatar.jpeg(.meduim) {
            let avatarFile = LCFile(payload: .data(data: data))
            avatarFile.save(to: user, as: kAvatarCol)
            meHeaderView.avatarImageView.image = avatar
        }
        
        try? user.set(knickNameCol, value: nickName)
        meHeaderView.nickNameLabel.text = nickName
        
        try? user.set(kGenderCol, value: gender)
        meHeaderView.genderLabel.text = gender ? "♀" : "♂" 
        meHeaderView.genderLabel.textColor = gender ? blueColor : mainColor
        
        try? user.set(kBirthCol, value: birth)
        
        try? user.set(kIntroCol, value: intro)
        meHeaderView.introLabel.text = intro.isEmpty ? "请填写" : intro
        
        user.save{ _ in }

    }
}
