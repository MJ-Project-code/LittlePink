//
//  Protocols.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/18.
//

import Foundation

protocol ChannelVCDelegate{
    /// 用户从选择话题页面返回编辑笔记页面传值
    /// - Parameter channel: 传回来的channel
    /// - parameter subChannel: subchannel
    func updateChannel(channel:String, subChannel:String)
    
    
}

protocol POIVCDelegate {
    func updatePOIName(_ poiName:String)
}

protocol IntroVCDelegate{
    func updateIntro(_ intro: String)
}
