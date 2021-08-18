//
//  SettingTableVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/17.
//

import UIKit
import Kingfisher

class SettingTableVC: UITableViewController {
    
    @IBOutlet weak var cacheSizeLabel: UILabel!
    
    var cacheSizeStr = "无缓存"{
        didSet{
            DispatchQueue.main.async {
                self.cacheSizeLabel.text = self.cacheSizeStr
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageCache.default.calculateDiskStorageSize { res in
            if case let .success(size) = res{
                var cacheSizeStr: String{
                    guard size > 0 else { return "无缓存" }
                    guard size >= 1024 else { return "\(size) B" }
                    guard size >= 1048576 else { return "\(size / 1024) KB" }
                    guard size >= 1073741824 else { return "\(size / 1048576) MB" }
                    return "\(size / 1073741824) GB"
                }
                self.cacheSizeStr = cacheSizeStr
            }
        }
    }
    
    
}
