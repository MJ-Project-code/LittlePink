//
//  NearByVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/1/28.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController ,IndicatorInfoProvider{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
         IndicatorInfo(title: "附近")
    }


}
