//
//  Extensions.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/2.
//

import UIKit

extension UIView{
    @IBInspectable
    var radius:CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
        }
    }
}

extension Bundle{
    var appName:String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return  appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
