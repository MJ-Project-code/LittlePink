//
//  MeHeaderView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/21.
//

import LeanCloud
import Kingfisher

class MeHeaderView: UIView {
    @IBOutlet weak var rootStackView: UIStackView!

    @IBOutlet weak var backOrSlideBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var likedAndFavedLabel: UILabel!
    @IBOutlet weak var editOrFollowBtn: UIButton!
    @IBOutlet weak var settingOrChatBtn: UIButton!
    @IBOutlet weak var showLikedAndFavedBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        editOrFollowBtn.makeCapsule()
        settingOrChatBtn.makeCapsule()
        showLikedAndFavedBtn.addTarget(self, action: #selector(showLikedAndFaved), for: .touchUpInside)
    }
    
    var user: LCUser!{
        didSet{
            avatarImageView.kf.setImage(with: user.getImageURL(from: kAvatarCol, .avatar))
            nickNameLabel.text = user.getExactStringVal(knickNameCol)
            let gender =  user.getExactBoolValDefaultF(kGenderCol)
            genderLabel.text = gender ? "♂" : "♀"
            genderLabel.textColor = gender ? blueColor : mainColor
            
            idLabel.text = "\(user.getExactIntVal(kIdCok))"
            let intro = user.getExactStringVal(kIntroCol)
            introLabel.text = intro.isEmpty ? "请你填写个人简介" : intro
            
            guard let userObjectId =  user.objectId?.stringValue else { return }
            let query = LCQuery(className: kUserInfoTable)
            query.whereKey(kUserObjectIdCol, .equalTo(userObjectId))
            query.getFirst{ res in
                if case let .success(object: userInfo) = res{
                    let likeCount = userInfo.getExactIntVal(kLikeCountCol)
                    let favCount = userInfo.getExactIntVal(kFavCountCol)
                    DispatchQueue.main.async {
                        self.likedAndFavedLabel.text = "\(likeCount + favCount)"
                    }
                }
            }
        }
    }
    
    @IBAction func logouttest(_ sender: Any) {
        LCUser.logOut()
    }
}

extension MeHeaderView{
    @objc func showLikedAndFaved(_ sender: UIButton){
//        let alert = UIAlertController(title: "提示", message: nil, preferredStyle: .alert)
//        let action = UIAlertAction(title: "晓得了", style: .cancel, handler: nil)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
    }
}
