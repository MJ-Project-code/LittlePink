//
//  ReplyCell.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/12.
//

import LeanCloud
import Kingfisher

class ReplyCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var replyTextLabel: UILabel!
    @IBOutlet weak var showAllReplyBtn: UIButton!
    
    var reply: LCObject?{
        didSet{
            guard let reply = reply else { return }
            
            if let user = reply.get(kUserCol) as? LCUser{
                avatarImageView.kf.setImage(with: user.getImageURL(from: kAvatarCol, .avatar))
                nickNameLabel.text = user.getExactStringVal(knickNameCol)
            }
            
            let createdAt = reply.createdAt?.value
            let dateText = createdAt == nil ? "刚刚" : createdAt!.formattedDate
            let replyText = reply.getExactStringVal(kTextCol).spliceAttrStr(dateText)
            
            if let replyToUser = reply.get(kReplyToUserCol) as? LCUser{
                
                let replyTotext =  "回复 ".toAttrStr()
                
                let nickName = replyToUser.getExactStringVal(knickNameCol).toAttrStr(14, .secondaryLabel)
                
                let colon =  ": ".toAttrStr()
                
                replyTotext.append(nickName)
                replyTotext.append(colon)
                
                replyText.insert(replyTotext, at: 0)
            }
            
            replyTextLabel.attributedText = replyText
            
        }
    }

}
