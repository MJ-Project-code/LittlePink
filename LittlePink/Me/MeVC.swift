//
//  MeVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/16.
//

import UIKit
import LeanCloud
import SegementSlide

class MeVC: SegementSlideDefaultViewController {
    
    var user:LCUser
    lazy var meHeaderView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)

    //判断来源
    var isFromNote = false
    //本人已登录,查看自己的页面,可以修改资料和简介,显示'编辑资料'和 '设置' 按钮
    //本人已登录,查看他人页面||本人未登录,查看别人或自己页面,点击个人简介不可修改,显示 '关注','聊天' 按钮
    var isMySelf = false
    
    init?(coder: NSCoder , user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()

    }
    
    override var bouncesType: BouncesType { .child }
    
    override func segementSlideHeaderView() -> UIView? { setHeaderView() }
    
    override var titlesInSwitcher: [String] { ["笔记", "收藏", "赞过"] }
    override var switcherConfig: SegementSlideDefaultSwitcherConfig{
        var config = super.switcherConfig
        config.type = .tab
        config.selectedTitleColor = .label
        config.indicatorColor = mainColor
        return config
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        let isMyDraft = (index == 0) && isMySelf && (UserDefaults.standard.integer(forKey: kDraftNoteCount) > 0)
        
        let vc = storyboard?.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        vc.user = user
        vc.isMyDraft = isMyDraft
        vc.isMyNote = index == 0
        vc.isMyFav = index == 1
        vc.isMyselfLike = (isMySelf && index == 2)
        vc.isFromMeVC = true
        vc.fromMeVCUser = user
        return vc
    }
    
}
