//
//  TabBarC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/1.
//

import UIKit
import YPImagePicker
import LeanCloud

class TabBarC: UITabBarController ,UITabBarControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if  viewController is PostVC{
            
            if let _ = LCApplication.default.currentUser{
                var config = YPImagePickerConfiguration()
                
                //左右划不会在相册和相机切换
                config.isScrollToChangeModesEnabled = false
                config.onlySquareImagesFromCamera = false
                config.albumName = Bundle.main.appName
                
                config.startOnScreen = .photo
                config.screens = [.library,.video, .photo]
                
                config.preferredStatusBarStyle = UIStatusBarStyle.default
                config.maxCameraZoomFactor = kMaxCameraZoomFactor
                config.showsVideoTrimmer = false
                
                
                
                //            config.library.preSelectItemOnMultipleSelection = true
                
                config.library.defaultMultipleSelection = true
                config.library.maxNumberOfItems = kMaxPhotoCount
                config.library.spacingBetweenItems = kSpacingBetweenItems
                
                
                //视频配置
                config.video.recordingTimeLimit = 60.0
                config.video.libraryTimeLimit = 60.0
                config.video.minimumTimeLimit = 3.0
                config.video.trimmerMaxDuration = 60.0
                config.video.trimmerMinDuration = 3.0
                
                let picker = YPImagePicker(configuration: config)
                
                picker.didFinishPicking { [unowned picker] items, cancelled in
                    if cancelled{
                        picker.dismiss(animated: true)
                    }else{
                        var photos:[UIImage] = []
                        var videoURL:URL?
                        
                        for item in items {
                            switch item {
                            case let .photo(photo):
                                photos.append(photo.image)
                            case .video:
                                let url = URL(fileURLWithPath: "recordedVideoRAW.mov", relativeTo: FileManager.default.temporaryDirectory)
                                photos.append(url.thumbnail)
                                videoURL = url
                            }
                        }
                        
                        let vc = self.storyboard!.instantiateViewController(identifier: kNoteEditVCID) as! NoteEditVC
                        vc.photos = photos
                        vc.videoURL = videoURL
                        picker.pushViewController(vc, animated: true)
                    }
                }
                present(picker, animated: true)
            }else{
                let alert = UIAlertController(title: "提示", message: "请你登录", preferredStyle: .alert)
                let action1 = UIAlertAction(title: "再看看", style: .cancel, handler: nil)
                let action2 = UIAlertAction(title: "去登录", style: .default) {_ in
                    tabBarController.selectedIndex = 4
                }
                alert.addAction(action1)
                alert.addAction(action2)
                
                present(alert, animated: true, completion: nil)
            }
            
            
            
            
            return false
        }
        return true
    }
    
}
