//
//  NoteEditVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/7.
//

import ImageSlideshow
import GrowingTextView

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
        textView.delegate = self
        
        //selector函数是在第一个参数self里定义的
        //监听到键盘frame改变,做出#selector响应
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        tableView.register(UINib(nibName: "CommentView", bundle: nil), forHeaderFooterViewReuseIdentifier:kCommentViewID )
    }
    
    func adjustTableHeaderViewHeight(){
        //为了解决图片导致的高度适配问题
        //计算出tableHeaderView里面所有view的总高度,将总高度赋值给tableHeaderView
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView.frame = frame
        }
    }
}
extension NoteDetailVC: GrowingTextViewDelegate{
    func textViewDidChangeHeight(_ textView: GrowingTextView, height: CGFloat) {
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}


extension NoteDetailVC{
    @objc private func KeyboardWillChangeFrame(_ notification: Notification){
        //设置监听了以后,可以获取到很多信息,它们都存在userinfo里,取enduserinfo来获取结束时的信息
        if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let keyboardH = screenRect.height - endFrame.origin.y  //键盘y坐标
            
            if keyboardH > 0{
                view.insertSubview(overlayView, belowSubview: textViewBarVIew)
            }else{
                overlayView.removeFromSuperview()
                textViewBarVIew.isHidden = true
            } 
            textViewBarButtomConstraint.constant = keyboardH
            view.layoutIfNeeded()
            
        }
    }
}
