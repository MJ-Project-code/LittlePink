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
    
    var isFromNote = false
    
    init?(coder: NSCoder , user: LCUser) {
        self.user = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        setUI()
        defaultSelectedIndex = 0
        reloadData()
    }
    
    override var bouncesType: BouncesType { .child }
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = Bundle.loadView(fromNib: "MeHeaderView", with: MeHeaderView.self)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: headerView.rootStackView.frame.height + 16).isActive = true
        
        headerView.user = user

        if isFromNote{
            headerView.backOrSlideBtn.setImage(largeIcon("chevron.left"), for: .normal)
        }
        
        headerView.backOrSlideBtn.addTarget(self, action: #selector(backOrSlide), for: .touchUpInside)
        
        return headerView
    }
    
    override var titlesInSwitcher: [String] { ["笔记", "收藏", "赞过"] }
    override var switcherConfig: SegementSlideDefaultSwitcherConfig{
        var config = super.switcherConfig
        config.type = .tab
        config.selectedTitleColor = .label
        config.indicatorColor = mainColor
        return config
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        let vc = storyboard?.instantiateViewController(identifier: kWaterfallVCID) as! WaterfallVC
        return vc
    }
    
}
