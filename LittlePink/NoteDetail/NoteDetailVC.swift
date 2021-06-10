//
//  NoteDetailVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/2.
//

import UIKit
import ImageSlideshow

class NoteDetailVC: UIViewController {
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var tableHeaderView: UIView!
    
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        imageSlideShow.setImageInputs([
            ImageSource(image: UIImage(named: "1")!),
            ImageSource(image: UIImage(named: "2")!),
            ImageSource(image: UIImage(named: "3")!),
        ])
        let imageSize = UIImage(named: "1")!.size
        imageSlideShowHeight.constant = (imageSize.height / imageSize.width) * screenRect.width
        setUI()

    }
    
    override func viewDidLayoutSubviews() {
        //为了解决图片导致的高度适配问题
        //计算出tableHeaderView里面所有view的总高度,将总高度赋值给tableHeaderView
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView .frame = frame
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
