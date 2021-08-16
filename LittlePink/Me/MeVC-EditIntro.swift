//
// Created by 马俊 on 2021/8/3.
//

import Foundation

extension MeVC{
    @objc func editorIntro(){
        let vc = storyboard?.instantiateViewController(identifier: kIntroVCID) as! IntroVC
        vc.intro = user.getExactStringVal(kIntroCol)
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension MeVC:IntroVCDelegate{
    func updateIntro(_ intro: String) {
        //UI
        meHeaderView.introLabel.text = intro.isEmpty ? "请填写简介" : intro
        //云端
        try? user.set(kIntroCol, value: intro)
        user.save{ _ in }
    }
}
