//
//  TabBarC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/1.
//

import UIKit
import YPImagePicker

class TabBarC: UITabBarController ,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self

        // Do any additional setup after loading the view.
    }
    

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if  viewController is PostVC{
            
            //todo(判断是否登录)
            
            var config = YPImagePickerConfiguration()
            
            //左右划不会在相册和相机切换
            config.isScrollToChangeModesEnabled = false
            config.onlySquareImagesFromCamera = false
            config.albumName = Bundle.main.appName
            
            config.startOnScreen = .photo
            config.screens = [.library,.video, .photo]
            
            config.preferredStatusBarStyle = UIStatusBarStyle.default
            config.maxCameraZoomFactor = 1.0
            
            
            
//            config.library.preSelectItemOnMultipleSelection = true
            
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount
            config.library.spacingBetweenItems = 1.0

            
            //视频配置
            config.video.recordingTimeLimit = 60.0
            config.video.libraryTimeLimit = 60.0
            config.video.minimumTimeLimit = 3.0
            config.video.trimmerMaxDuration = 60.0
            config.video.trimmerMinDuration = 3.0
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled{
                    
                }
                picker.dismiss(animated:  true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}
