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
    
    
    //    @IBAction func LogoutTest(_ sender: Any) {
    //        LCUser.logOut()
    //
    //        let LoginVC = storyboard!.instantiateViewController(identifier: kLoginVCID)
    //
    //        loginAndMeParentVC.removeChildren()
    //        loginAndMeParentVC.add(child: LoginVC)
    //    }
    //
    //    @IBAction func showDraftNotes(_ sender: Any) {
    //        let navi = storyboard!.instantiateViewController(identifier: kDraftNotesNavID)
    //        navi.modalPresentationStyle = .fullScreen
    //        present(navi, animated: true)
    //    }
    
}
