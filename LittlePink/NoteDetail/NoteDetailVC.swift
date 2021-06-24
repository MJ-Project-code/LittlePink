//
//  NoteDetailVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/2.
//

import UIKit
import ImageSlideshow
import LeanCloud
import FaveButton

class NoteDetailVC: UIViewController {
    
    let note: LCObject
    var isLikeFromWaterfallCell = false
    
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var imageSlideShowHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var channelBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    //整个tableview
    @IBOutlet weak var tableView: UITableView!
    //下方bar
    @IBOutlet weak var likeBtn: FaveButton!
    @IBOutlet weak var likeCountLbael: UILabel!
    @IBOutlet weak var favBtn: FaveButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var commentCountBtn: UIButton!
    
    var likeCount = 0{
        didSet{
            likeCountLbael.text = likeCount == 0 ? "点赞" : likeCount.formattedStr
        }
    }
    var currentLikeCount = 0
    
    var favCount = 0{
        didSet{
            favCountLabel.text = favCount == 0 ? "收藏" : favCount.formattedStr
        }
    }
    
    var commentCount = 0{
        didSet{
            commentCountLabel.text = "\(commentCount)"
            commentCountBtn.setTitle(commentCount == 0 ? "评论" : commentCount.formattedStr, for: .normal)
        }
    }
    
    //计算属性
    var author:LCUser?{ note.get(kAuthorCol) as? LCUser}
    var isLike:Bool{ likeBtn.isSelected }
    //依赖注入note
    init?(coder: NSCoder ,note :LCObject ) {
        self.note = note
        super.init(coder: coder)
    }
    
    //从sb走 storyboard.instance只用id创建走这里
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
//        imageSlideShow.setImageInputs([
//            ImageSource(image: UIImage(named: "1")!),
//            ImageSource(image: UIImage(named: "2")!),
//            ImageSource(image: UIImage(named: "3")!),
//        ])
//        let imageSize = UIImage(named: "1")!.size
//        imageSlideShowHeight.constant = (imageSize.height / imageSize.width) * screenRect.width
        setUI()

    }
    
    override func viewDidLayoutSubviews() {
        //为了解决图片导致的高度适配问题
        //计算出tableHeaderView里面所有view的总高度,将总高度赋值给tableHeaderView
        let height = tableHeaderView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = tableHeaderView.frame
        
        if frame.height != height{
            frame.size.height = height
            tableHeaderView .frame = frame
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func like(_ sender: Any) { like() }
    
    @IBAction func fav(_ sender: Any) { fav() }
    
}
