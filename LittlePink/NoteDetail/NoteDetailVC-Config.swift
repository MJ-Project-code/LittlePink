//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/7.
//

import Foundation

extension NoteDetailVC{
    func config(){
        imageSlideShow.zoomEnabled = true
        imageSlideShow.circular = false
        imageSlideShow.contentScaleMode = .scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = mainColor  //选中颜色
        pageControl.pageIndicatorTintColor = .systemGray
        imageSlideShow.pageIndicator = pageControl
    }
}
