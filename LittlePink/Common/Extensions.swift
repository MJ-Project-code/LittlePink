//
//  Extensions.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/2.
//

import Foundation

extension Bundle{
    var appName:String{
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String{
            return  appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
