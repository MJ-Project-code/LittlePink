//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/7.
//

import ImageSlideshow

extension NoteDetailVC{
    func config(){
        
        //imageSlideShow    
        imageSlideShow.zoomEnabled = true
        imageSlideShow.circular = false
        imageSlideShow.contentScaleMode = .scaleAspectFill
        imageSlideShow.activityIndicator = DefaultActivityIndicator()
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = mainColor  //选中颜色
        pageControl.pageIndicatorTintColor = .systemGray
        imageSlideShow.pageIndicator = pageControl
        
        //textView
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}
