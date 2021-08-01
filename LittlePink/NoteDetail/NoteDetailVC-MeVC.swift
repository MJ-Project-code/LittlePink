//
//  NoteDetailVC-MeVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/1.
//

import LeanCloud

extension NoteDetailVC{
    func noteToMeVC(_ user: LCUser?){
        guard let user = user else { return }
        let meVC = storyboard!.instantiateViewController(identifier: kMeVCID){ coder in
            MeVC(coder: coder, user: user)
        }
        meVC.isFromNote = true
        meVC.modalPresentationStyle = .fullScreen
        present(meVC, animated: true)
    }
    
    @objc func goToMeVC(_ tap:UIPassableTapGestureRecognizer){
        let user  = tap.passObj
        noteToMeVC(user)
    }
}
