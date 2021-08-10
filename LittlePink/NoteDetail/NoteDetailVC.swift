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
import GrowingTextView

class NoteDetailVC: UIViewController {
    
    var note: LCObject
    var isLikeFromWaterfallCell = false
    var delNoteFinished: (() -> ())?
    
    var comments: [LCObject] = []
    
    var isReply = false
    var commentSection = 0 //在用户准备回复的时候,赋值
    
    var replies: [ExpandableReplies] = []
    var replyToUser: LCUser?
    
    var isFromMeVC = false
    var fromMeVCUser: LCUser?
    
    @IBOutlet weak var authorAvatarBtn: UIButton!
    @IBOutlet weak var authorNickNameBtn: UIButton!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var shareOrMoreBtn: UIButton!
    
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
    
    @IBOutlet weak var textViewBarVIew: UIView!
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var textViewBarButtomConstraint: NSLayoutConstraint!
    
    lazy var overlayView: UIView = {
        let overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        overlayView.addGestureRecognizer(tap)
        return overlayView
    }() //黑色透明遮罩,点击评论的时候,笔记会变黑
    
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
    
    var currentFavCount = 0;
    
    var commentCount = 0{
        didSet{
            commentCountLabel.text = "\(commentCount)"
            commentCountBtn.setTitle(commentCount == 0 ? "评论" : commentCount.formattedStr, for: .normal)
        }
    }
    
    //计算属性
    var author:LCUser?{ note.get(kAuthorCol) as? LCUser}
    var isLike:Bool{ likeBtn.isSelected }
    var isFav:Bool{ favBtn.isSelected }
    var isReadMyNote: Bool{
        if let user = LCApplication.default.currentUser , let author = author , user == author{
            return true
        }else{
            return false
        }
    }
    
    
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
        setUI()
        getCommentsAndReplies()
        getFav()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustTableHeaderViewHeight()
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func goToAuthorMeVC(_ sender: Any) { noteToMeVC(author) }
    @IBAction func shareOrMore(_ sender: Any) { shareOrMore() }
    //点赞
    @IBAction func like(_ sender: Any) { like() }
    
    //收藏
    @IBAction func fav(_ sender: Any) { fav() }
    
    
    @IBAction func comment(_ sender: Any) { comment() }
    
    @IBAction func postCommentOrReply(_ sender: Any) {
        
        if !textView.isBlank{
            
            if !isReply{
                postComment()
            }else{
                //还需要判断是回复还是子回复
                postReply()
            }
            hideAndResetTextView()
        }
        
    }
    
    
}

extension NoteDetailVC{
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
    }
}
