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
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = mainColor
        headerView.heightAnchor.constraint(equalToConstant: view.bounds.height/4).isActive = true
        return headerView
    }
    
    override var titlesInSwitcher: [String] {
        return ["笔记", "收藏", "赞过"]
    }
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
