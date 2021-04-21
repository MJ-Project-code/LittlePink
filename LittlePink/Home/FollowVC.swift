//
//  FollowVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/1/28.
//

import UIKit
import XLPagerTabStrip

class FollowVC: UIViewController, IndicatorInfoProvider{
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
         IndicatorInfo(title: "关注")
    }

}


class ColorBtn: UIButton{
    var color:UIColor
    init(frame:CGRect, color:UIColor){
        self.color = color
        super.init(frame: frame)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
