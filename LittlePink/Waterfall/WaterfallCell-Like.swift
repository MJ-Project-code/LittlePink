//
//  WaterfallCell-Like.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/24.
//

import LeanCloud
extension WaterfallCell{
    @objc func likeBtnTappedWhenLogin(){
        
        if likeCount != currentLikeCount{
            guard let note = note else { return }
            let user = LCApplication.default.currentUser!
            
            let offset = isLike ? 1 : -1
            currentLikeCount += offset
            if isLike{
                let userLike =  LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: note)
                userLike.save{ _ in }
                
                try? note.increase(kLikeCountCol)
                note.save{ _ in }
                
            }else{
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst { res in
                    if case let .success(object: userLike) = res{
                        userLike.delete { _ in }
                    }
                }
                
                try? note.set(kLikeCountCol, value: likeCount)
                note.save{ _ in }


            }
        }
    }
}

