//
//  MeHeaderView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/21.
//

import UIKit

class MeHeaderView: UIView {
    @IBOutlet weak var editOrFollowBtn: UIButton!
    @IBOutlet weak var settingOrChatBtn: UIButton!
    @IBOutlet weak var rootStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        editOrFollowBtn.makeCapsule()
        settingOrChatBtn.makeCapsule()
    }
}
