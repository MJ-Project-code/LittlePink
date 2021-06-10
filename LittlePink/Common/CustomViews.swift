//
//  CustomViews.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/7.
//

import Foundation

@IBDesignable
class BigButton: UIButton{
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        //designtime 并非runtime 所以用didiset
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    //代码创建走这里
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    //IB创建会走这里
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override  func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        sharedInit()
    }
    
    //两种方法都需要实现的部分
    private func  sharedInit(){
        backgroundColor = .secondarySystemBackground
        tintColor = .placeholderText
        setTitleColor(.placeholderText, for: .normal)
        
        
        contentHorizontalAlignment = .leading  //居左
        contentEdgeInsets  = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
}
