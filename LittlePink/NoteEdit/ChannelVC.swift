//
//  ChannelVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/16.
//

import UIKit
import XLPagerTabStrip

class ChannelVC: ButtonBarPagerTabStripViewController {
    
     var PVdelegate: ChannelVCDelegate?

    override func viewDidLoad() {
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarBackgroundColor = mainColor
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        
        super.viewDidLoad()

        containerView.bounces = false
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .secondaryLabel
            newCell?.label.textColor = .label
        }
    }
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs:[UIViewController] = []
        for i in kChannels.indices{
            let vc = storyboard?.instantiateViewController(identifier: kChannelTableVCID) as! ChannelTableVC
            vc.channel = kChannels[i]
            vc.subChannels = kAllSubChannels[i]
            vcs.append(vc)
        }
        return vcs

    }
}
