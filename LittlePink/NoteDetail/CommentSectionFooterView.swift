//
//  CommentSectionFooterView.swift
//  LittlePink
//
//  Created by 马俊 on 2021/7/11.
//

import UIKit

class CommentSectionFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String? ){
        super.init(reuseIdentifier: reuseIdentifier)
        
        //footer本身有颜色,需要改
        tintColor = .systemBackground
        
        let separatorLine = UIView(frame: CGRect(x: 62, y: 0, width: screenRect.height - 62, height: 1))
        separatorLine.backgroundColor = .quaternaryLabel
        
        addSubview(separatorLine)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
