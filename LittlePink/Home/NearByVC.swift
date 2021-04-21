//
//  NearByVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/1/28.
//

import UIKit
import XLPagerTabStrip

class NearByVC: UIViewController ,IndicatorInfoProvider{
    
    lazy private var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 44, width: 300, height: 300))
        return imageView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
//        let serialQueue = DispatchQueue(label: "serialQueue")
//        serialQueue.sync {
//            for i in 1...3{
//                print("i:\(i)")
//            }
//        }
//
//        for j in 10...13{
//            print("j:\(j)")
//        }
        
        let concurrentQueue =  DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
//        concurrentQueue.async {
//            for i in 1...3{
//                print("i:\(i)")
//            }
//            print(Thread.current)
//        }
//        concurrentQueue.async {
//            for j in 10...13{
//                print("j:\(j)")
//            }
//            print(Thread.current)
//        }
        DispatchQueue.global().async {
            print(Thread.current)
        }
        DispatchQueue.main.async {
            print(Thread.current)
        }
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3399106330,3358396864&fm=26&gp=0.jpg")!)
            let image  =  UIImage(data)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
        }

    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
         IndicatorInfo(title: "附近")
    }


}
