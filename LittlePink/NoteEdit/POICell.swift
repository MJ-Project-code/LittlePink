//
//  POICell.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/22.
//

import UIKit

class POICell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var poi = ["",""]{
        didSet{
            nameLabel.text = poi[0]
            addressLabel.text = poi[1]
        }
    }

}
