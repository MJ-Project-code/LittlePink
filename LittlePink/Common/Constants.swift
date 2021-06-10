//
//  Constants.swift
//  LittlePink
//
//  Created by 马俊 on 2021/1/28.
//

import UIKit

// StoryboardID
let kFollowVCID = "FollowVCID"
let kNearByVCID = "NearByVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"
let kChannelTableVCID = "ChannelTableVCID"
let kLoginVCID = "LoginVCID"
let kMeVCID = "MeVCID"
let kDraftNotesNavID = "DraftNotesNavID"

//cell相关id
let kWaterfallCellID = "WaterfallCellID"
let kPhotoCellID = "PhotoCellID"
let kPhotoFooterID = "PhotoFooterID"
let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"
let kLoginNaviID = "LoginNaviID"

//资源相关
let mainColor = UIColor(named: "main")!
let blueColor = UIColor(named: "blue")!
let mainLightColor = UIColor(named: "main-light")

//userdefaults的key
let kNameFromAppID = "nameFromAppID"
let kEmailFromAppleID = "emailFromAppleID"

//coredata
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let persistentContainer = appDelegate.persistentContainer
let context = persistentContainer.viewContext
let backgroundContext = persistentContainer.newBackgroundContext()

//ui布局
let screenRect =  UIScreen.main.bounds

//瀑布流
let kWaterfallPadding:CGFloat = 4;
let kDraftNoteWaterfallCellButtomViewH: CGFloat = 86.5

//Mark: -业务逻辑相关
let kChannels = ["推荐","旅行","娱乐","才艺","美妆","白富美","美食","萌宠"]

let kMaxCameraZoomFactor:CGFloat = 5
let kMaxPhotoCount = 9
let kSpacingBetweenItems:CGFloat = 2


//label剩余可输入字符
let kmaxNoteTitleCount = 20
let kmaxNoteTextCount = 1000


//话题
let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]

//高德
let kAMapapiKey = "5668d352b14b4dd1f85d102996274d40"
let kNoPOIPH = "未知地点"
//let kPOITypes = "汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施"
let kPOITypes = "医疗保健服务"
let kPOIsInitArr = [["不显示位置",""]]
let kPOIsOffset = 20

//极光
let kJappKey = "d2734727c0faa17b5cbae05b"

//支付宝
let kAliPayAppID = "2021002142686715"
let kAliPayPID = "2088"
let kAliPayPrivateKey = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCAgYk5k/Lcet0NtyFP8VUUZsVNUUg5W0/f9X0YGgJ3CXigKIMv/jrinOsEDf9cXrNkvB6pfBXRx6UMGI+O96NUvDkPOh7EQlif0udPm1esAZJYzlFEG6jLP0/GjhkZjJwLzDTOFKoB10PovMlSc2QiKPbnnOv870u0dzwcglKErzIj+aHBFQp4DkKeInag58eW+RXr+I4WURo/MJ3a8Pr5G2zeEz5/qjYOCGze3+Dqd7ZMhW8+9dj4ZSWiLiXiG/I0CPMZ4XEaT/s8Nhy5CW0tdGY2fP67r5vZ3hgnke23Oz849lyhcYl1redCqRjurvHCV+ip3ux7dHkWjEJBcBlXAgMBAAECggEAcdtTjBJLsZGiXc6N01jNuv+7fF+yEC+ZO6M0LLCO0o0vtSdv5Ivp/HJvv+3u/RZi97O9rwjkBDRRRcBVIaTDsAX8wEMMk3L9Ns4UZ/II4buawNg8JI4lJb94nUG1d2+fqsxJVPX2Ex95abIq5cSbSbDl4hyk8jvK5aBnQBMvraKN5Z3vIKiz2NtII5kT8EvPnqijYpOXRrDC0EVvAl48uWyzxP20+vDlbJ2t3kbIgbm9njnw8PsLAIvvNRoi0bS22iW1CqAPaDVlTtObGKhSLmPbbHb5RJGj4hcmpIit9ZXRK3/9t6F6SFvbMJpTNE/wzy94n3zoM4P5ofHyqzsiwQKBgQDYee26I69+gjppai3NQ3EaGzYdSyFUChoPKUDvF7E9U6j1d+U7H1armPNZQekHW0PlI3zAbCRrgjEL6Bj4lPGHro6iG4lB+bqcLbzOOzAMRklr/bgECd9CCAz/McKKWEsYSkqIcK1BmmxOX3XXSzESB6BUukUsKbt73w0NDsySEQKBgQCX9+N7V2vbnHTnzQpqoYcCFfY6ObuX2z3+ZIao8+qX/O24wZW1Leq72v2g7GYSLLWR+U5zd++Fn6aUcew6hQblg33LSF8tH9/hu0+9soldRp4iryAuLqqZ1hIz/MUoWpMLUZlZyXI5lOH7TpdhbFCyWWoHQainfvb2b7pxAIeM5wKBgQDPB4UAsOJEth1Q9ZgKKAbB9eZCC7k7G1Iiz8xnHRyHzzvWTqzvZyBHikapRWyseW8sdEz55jLKkr9/aKCBFEkN/zYv+O/DJid++AsKnPZttsa/Pe5ABoT7LKHpadho4Noox9wSMtiv1hTgu1EC7slmOd7vSRmgi+TfKcnchBvHUQKBgGYsja7c/TCfhd5f9nPw/FPDrlRBgsY76veCYSNxM7ZSoQZKabxyDdOWDlbG+m2Xz9BAXaW26rzdtWMzIU/LJvLjMI2fsBYnyx/7D0cMpdyn4SSSuEE0sRFTY9O+TFSwaRMAHunGTl02o6WSlqcy6yKuiWItnBZZf/P69NCLOZfbAoGACBcKHaRy/ZH2OAGcGs+yB0FHxGXSZOG1THgC+jBExb9s+wrw4wiQcWJcpq1HWvvf4mC0v3uWsl9CkZX9yc9wRcYbzykX5HIg6U8SKoTCxHN1Ltt41VksBd1fxiCy6AlqxFLunGzgSbvbQgfKBdrqsValYjPPj+eON8YqR3d58Aw="

let kAppScheme = "LittlePink"



//正则表达式
let kPhoneRegEx = "^1\\d{10}$"  //^1\d{10}$
let kAuthCodeRegEx = "^\\d{6}$"


//leanCloud
let kLCAppID = "i2v2REDMUWNJeJh97TmprWYm-gzGzoHsz"
let kLCAppKey = "lFb6RCiANNg3d4FWsOWThXuP"
let kLCServerURL = "https://i2v2redm.lc-cn-n1-shared.com"

//表
let kNoteTable = "Note"

//User表
let knickNameCol = "nickName"
let kAvatarCol = "avatar"
let kGenderCol = "gender"
let kIntroCol = "intro"

//Note表
let kCoverPhotoCol = "coverPhoto"
let kPhotosCol = "photos"
let kVideoCol = "video"
let kTitleCol = "title"
let kTextCol = "text"
let kChannelCol = "channel"
let kSubChannelCol = "subChannel"
let kPoiNameCol = "PoiName"
let kIsVideoCol = "isVideo"


func largeIcon(_ iconName: String, with color:UIColor = .label) -> UIImage {
    let config = UIImage.SymbolConfiguration(scale: .large)
    let icon = UIImage(systemName: iconName,withConfiguration: config)!
    
    return icon.withTintColor(color)
}
