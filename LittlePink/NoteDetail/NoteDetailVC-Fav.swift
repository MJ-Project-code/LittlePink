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
            //UI
            isFav ? (favCount += 1) : (favCount -= 1)
            
            //数据
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(favBtnTappedWhenLogin), object: nil)
            perform(#selector(favBtnTappedWhenLogin), with: nil, afterDelay: 1)
            
        }else{
            showLoginHUD()
        }
    }
    
    @objc func favBtnTappedWhenLogin(){
        if favCount != currentFavCount{
            let user = LCApplication.default.currentUser!
            let authorObjectId = author?.objectId?.stringValue ?? ""
            
            let offset = isLike ? 1 : -1
            currentFavCount += offset
            
            if isFav{
                let userFav =  LCObject(className: kUserFavTable)
                try? userFav.set(kUserCol, value: user)
                try? userFav.set(kNoteCol, value: note)
                userFav.save{ _ in }
                
                try? note.increase(kFavCountCol)
                
                try? author?.increase(kFavCountCol)

                LCObject.userInfo(where: authorObjectId, increase: kFavCountCol)
                
            }else{
                let query = LCQuery(className: kUserFavTable)
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
                LCObject.userInfo(where: authorObjectId, decrease: kFavCountCol, to: favCount)
            }
        }
    }
}
 
