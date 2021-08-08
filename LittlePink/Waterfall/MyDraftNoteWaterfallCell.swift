//
//  MyDraftNoteWaterfallCell.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/6.
//

import UIKit

class MyDraftNoteWaterfallCell: UICollectionViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.text = "\(UserDefaults.standard.integer(forKey: kDraftNoteCount))"
        if let coverPhotoData = UserDefaults.standard.data(forKey: kDraftNoteCoverphoto){
            ImageView.image = UIImage(coverPhotoData)
        }else{
            ImageView.image =   UIImage(named: "201704131205597084")
        }
        
    }
    
}
