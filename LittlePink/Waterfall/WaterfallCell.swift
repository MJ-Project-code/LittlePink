//
//  WaterfallCell.swift
//  LittlePink
//
//  Created by 马俊 on 2021/1/29.
//

import UIKit
import LeanCloud
import Kingfisher

class WaterfallCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    var likeCount = 0{
        didSet{
            likeBtn.setTitle(likeCount.formattedStr, for: .normal)
        }
    }
    var currentLikeCount = 0
    var isLike: Bool{ likeBtn.isSelected }
    
    var note: LCObject?{
        didSet{
            guard let note = note , let author = note.get(kAuthorCol) as? LCUser else { return }
            
            //加载远程图片
            let coverPhotoURL = note.getImageURL(from: kCoverPhotoCol, .coverPhoto)
            imageView.kf.setImage(with: coverPhotoURL)
            
            //头像url
            let avatarURL = author.getImageURL(from: kAuthorCol, .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
            
            //笔记标题
            titleLabel.text = note.getExactStringVal(kTitleCol)
            
            
            likeCount = note.getExactIntVal(kLikeCountCol)
            currentLikeCount = likeCount
            
            
            //点赞功能+判断是否点赞
            if let user = LCApplication.default.currentUser{
                let query = LCQuery(className: kUserLikeTable)
                query.whereKey(kUserCol, .equalTo(user))
                query.whereKey(kNoteCol, .equalTo(note))
                query.getFirst { res in
                    if case  .success = res{
                        DispatchQueue.main.async {
                            self.likeBtn.isSelected = true
                        }
                    }
                }
            }
            
        }
    }
    //从SB或者xib唤醒后,会加载这些函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let icon = UIImage(systemName: "heart.fill")?.withTintColor(mainColor ,renderingMode: .alwaysOriginal)
        likeBtn.setImage(icon, for: .selected)
    }
    
    @IBAction func like(_ sender: Any) {
        
        if let _ = LCApplication.default.currentUser{
            //likeBtn.isSelected = !likeBtn.isSelected
            
            //UI
            likeBtn.isSelected.toggle()
            isLike ? ( likeCount += 1 ) : ( likeCount -= 1 )
            
            //数据
            //防暴力点击
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(likeBtnTappedWhenLogin), object: nil)
            perform(#selector(likeBtnTappedWhenLogin), with: nil, afterDelay: 3)
            
            
            
        }else{
            showGlobalTextHUD("请登录")
        }
    }
}

