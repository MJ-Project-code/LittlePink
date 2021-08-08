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
            //UI
            isLike ? (likeCount += 1) : (likeCount -= 1)
            
            
            //数据
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
            perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 1)
          

            
        }else{
            showLoginHUD()        }
    }
    
    @objc func likeBtnTappedWhenLogin(){
        if likeCount != currentLikeCount{
            let user = LCApplication.default.currentUser!
            let authorObjectId = author?.objectId?.stringValue ?? ""
            
            let offset = isLike ? 1 : -1
            currentLikeCount += offset
            
            if isLike{
                let userLike =  LCObject(className: kUserLikeTable)
                try? userLike.set(kUserCol, value: user)
                try? userLike.set(kNoteCol, value: note)
                userLike.save{ _ in }
                
                try? note.increase(kLikeCountCol)
                
                try? author?.increase(kLikeCountCol)
                LCObject.userInfo(where: authorObjectId, increase: kLikeCountCol)

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
                
                try? author?.set(kLikeCountCol, value: likeCount)
                author?.save{ _ in }
                LCObject.userInfo(where: authorObjectId, decrease: kLikeCountCol, to: likeCount)
            }
        }
       
    }
}
