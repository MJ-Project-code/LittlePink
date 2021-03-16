//
//  TextViewIAView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/15.
//

import UIKit

class TextViewIAView: UIView {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textCountStack: UIStackView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0{
        didSet{
            if currentTextCount <= kmaxNoteTextCount{
                doneBtn.isHidden = false
                textCountStack.isHidden = true
            }else{
                doneBtn.isHidden = true
                textCountStack.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }

}
