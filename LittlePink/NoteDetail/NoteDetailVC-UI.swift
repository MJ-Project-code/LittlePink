//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/7.
//

import Kingfisher
import LeanCloud
import ImageSlideshow

extension NoteDetailVC{
    func setUI(){
        followBtn.layer.borderWidth = 1
        followBtn.layer.borderColor = mainColor.cgColor
        
        showNote()
        showLike()
    }
    
    private func showNote(){
        let authorAvatarURL = author?.getImageURL(from: kAvatarCol, .avatar)
        authorAvatarBtn.kf.setImage(with: authorAvatarURL, for: .normal)
        authorNickNameBtn.setTitle(author?.getExactStringVal(knickNameCol), for: .normal)
        
        //note图片
        let coverPhotoHeight = CGFloat(note.getExactDoubleVal(kCoverPhotoRatioCol)) * screenRect.width
        imageSlideShowHeight.constant = coverPhotoHeight
        
        let coverPhoto = KingfisherSource(url: note.getImageURL(from: kCoverPhotoRatioCol, .coverPhoto))
        if let photoPaths =  note.get(kPhotosCol)?.arrayValue as? [String]{
            var photoArr = photoPaths.compactMap{ KingfisherSource(urlString: $0) }
            photoArr[0] = coverPhoto
            imageSlideShow.setImageInputs(photoArr)
        }else{
            imageSlideShow.setImageInputs([coverPhoto])
        }
        
        
        
        //note标题
        let noteTitle = note.getExactStringVal(kTitleCol)
        if noteTitle.isEmpty{
            titleLabel.isHidden = true
        }else{
            titleLabel.text = noteTitle
        }
        
        let noteText = note.getExactStringVal(kTextCol)
        if noteText.isEmpty{
            textLabel.isHidden = true
        }else{
            textLabel.text = noteText
        }
        //note话题
        let noteChannel = note.getExactStringVal(kChannelCol)
        let noteSubChannel = note.getExactStringVal(kSubChannelCol)
        channelBtn.setTitle(noteSubChannel.isEmpty ? noteChannel : noteSubChannel, for: .normal)
        
        //note发表或编辑时间
        if let updatedAt = note.updatedAt?.value{
            dateLabel.text = "\(note.getExactBoolVal(kHasEidtCol) ? "编辑于 " : "")\(updatedAt.formattedDate)"
            
        }
        //当前用户头像
        if let user = LCApplication.default.currentUser{
            let avatarURL = user.getImageURL(from: kAvatarCol, .avatar)
            avatarImageView.kf.setImage(with: avatarURL)
        }
        
        //底部bar的点赞数,收藏数,评论数
        likeCount = note.getExactIntVal(kLikeCountCol)
        currentLikeCount = likeCount
        favCount = note.getExactIntVal(kFavCountCol)
        commentCount = note.getExactIntVal(kCommentCountCol)
    }
    
    private func showLike(){
        //ImageSlideshow包的用法,从首页进入详情页不显示点赞动画
        self.likeBtn.setSelected(selected: isLikeFromWaterfallCell, animated: false)
    }
}
