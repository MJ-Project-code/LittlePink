//
//  NoteEditVC-CollectionView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/8.
//

import YPImagePicker
import SKPhotoBrowser
import AVKit


extension NoteEditVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
         
        cell.contentView.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside) //touchUpInside 点击后执行 action的内容
            return photoFooter
        default:
            fatalError("collectionView的footerc出问题")
        }
    }
    
}

extension NoteEditVC:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isVideo{
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            present(playerVC, animated: true) {
                playerVC.player?.play()
            }
        }else{
            var images:[SKPhoto] = []
            for photo in photos{
                images.append(SKPhoto.photoWithImage(photo))
            }
            
            
            // 2. create PhotoBrowser Instance, and present from your viewController.
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true)
        }
    }
}

extension NoteEditVC:SKPhotoBrowserDelegate{
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        photoCollectionview.reloadData()
        reload()
    }
}


//监听
extension NoteEditVC{
    @objc public func addPhoto(){
        if photoCount<kMaxPhotoCount{
            var config = YPImagePickerConfiguration()
            
            //左右划不会在相册和相机切换
            config.albumName = Bundle.main.appName  //存图片时,我的相册里的名称
            
            config.screens = [.library]
            

            
            
            
//            config.library.preSelectItemOnMultipleSelection = true
            
            config.library.defaultMultipleSelection = true
            config.library.maxNumberOfItems = kMaxPhotoCount - photoCount
            config.library.spacingBetweenItems = kSpacingBetweenItems

            config.gallery.hidesRemoveButton = false
            
            //视频配置
            config.video.recordingTimeLimit = 60.0
            config.video.libraryTimeLimit = 60.0
            config.video.minimumTimeLimit = 3.0
            config.video.trimmerMaxDuration = 60.0
            config.video.trimmerMinDuration = 3.0
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, _ in
                for item in items {
                    if case let .photo(photo) =  item {
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionview.reloadData()
                
//                let noteeditvv = NoteEditVC();
//                picker.pushViewController(noteeditvv, animated: true)
                picker.dismiss(animated:  true)
            }
            present(picker, animated: true)
        }else{
            showTextHUD("最多只能选择\(kMaxPhotoCount)张照片")
        }
    }
}
