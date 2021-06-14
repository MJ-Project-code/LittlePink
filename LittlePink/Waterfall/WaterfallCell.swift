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
    
    var note: LCObject?{
        didSet{
            guard let note = note , let author = note.get(kAuthorCol) as? LCUser else { return }
            
            let coverPhotoURL = note.getImageURL(from: kCoverPhotoCol, .coverPhoto)
            imageView.kf.setImage(with: coverPhotoURL)
            
            let avatarURL = author.getImageURL(from: kAuthorCol, .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
            
            titleLabel.text = note.getExactStringVal(kTitleCol)
            likeBtn.setTitle("\(note.getExactIntVal(kLikeCountCol))", for: .normal)
            
            //待做:点赞功能+判断是否点赞
        }
    }
}
