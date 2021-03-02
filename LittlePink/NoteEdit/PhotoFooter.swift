//
//  PhotoFooter.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/1.
//

import UIKit

class PhotoFooter: UICollectionReusableView {
   
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addPhotoBtn.layer.borderWidth = 1
        addPhotoBtn.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
