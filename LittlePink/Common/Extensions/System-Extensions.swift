//
//  Extensions.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/2.
//

import UIKit
import DateToolsSwift
import AVFoundation

extension Int{
    var formattedStr: String{
        let num = Double(self)
        let tenThousand = num / 10_000
        let hundredMillion = num / 100_000_000
        
        if  tenThousand < 1{
            return "\(self)"
        }else if hundredMillion >= 1{
            return "\(round(hundredMillion*10) / 10)亿"
        }else{
            return "\(round(tenThousand*10) / 10)万"
        }
        
    }
}

extension String{
    var isBlank:Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isPhoneNum: Bool{
        Int(self) != nil  && NSRegularExpression(kPhoneRegEx).matches(self)
    }
    
    var isAuthCode: Bool{
        Int(self) != nil  && NSRegularExpression(kAuthCodeRegEx).matches(self)
    }
    
    static func randomString(_ length: Int) -> String{
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return  String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func spliceAttrStr(_ datastr: String) -> NSMutableAttributedString{
        
        let attrText = self.toAttrStr()
        let attrDate = " \(datastr)".toAttrStr(12, .secondaryLabel)
        
        attrText.append(attrDate)
        return attrText
    }
    
    func toAttrStr(_ fontSize: CGFloat = 14, _ color: UIColor = .label ) -> NSMutableAttributedString{
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: color
        ]
        return NSMutableAttributedString(string: self, attributes: attr)
        
    }
}

extension NSRegularExpression{
    convenience init(_ pattern: String){
        do{
            try self.init(pattern: pattern)
        }catch  {
            fatalError()
        }
    }
    func matches(_ string: String) -> Bool{
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

extension Optional where Wrapped == String{
    var unwrappedText:String{ self ?? ""}
}

//刚刚//5分钟前//今天21:30//昨天21:30//09-15//2019-09-15
extension Date{
    var formattedDate:String{
        let currentYear = Date().year
        
        if year == currentYear{ //今年
            
            if isToday{
                if minutesAgo > 10 {
                    return "今天 \(format(with: "HH:mm"))"
                }else{
                    return  timeAgoSinceNow
                }
                
                
            }else if isYesterday{
                return "昨天 \(format(with: "HH:mm"))"
            }else{
                return format(with: "MM-dd")
            }
            
        }else if year < currentYear{
            return format(with: "yyyy-MM-dd")
        }else{
            return "未来?"
        }
    }
}

//封面图
extension URL{
    var thumbnail:UIImage{
        let asset = AVAsset(url: self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //视频尺寸确定的话可以用下面这句话提高性能
        //assetImgGenerate.maximumSize = CGSize(width: , height: )
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do{
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }catch{
            return UIImage(named: "1")!;
        }
    }
}

extension UIButton{
    
    func setToEnable(){
        isEnabled = true
        backgroundColor = mainColor
    }
    
    func setToDisable(){
        isEnabled = false
        backgroundColor = mainLightColor
    }
    
    func makeCapsule(_ color:UIColor = .label){
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
        layer.cornerRadius = frame.height / 2
    }
}

extension UIImage{
    
    convenience init?(_ data:Data?){  //init?可失败构造器
        if let unwrappedData = data{
            self.init(data:unwrappedData)
        } else{
            return nil;
        }
    }
    
    enum JPEGQuality: CGFloat{
        case lowest = 0
        case low = 0.25
        case meduim = 0.5
        case high = 0.75
        case highest = 1
    }
    
    func jpeg(_ jpegQuality:JPEGQuality) -> Data?{
        jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UITextField{
    var unwrappedText:String{ text ?? ""}
    var exactText : String{ unwrappedText.isBlank ? "" : unwrappedText }
    var isBlank: Bool { unwrappedText.isBlank }
}

extension UITextView{
    var unwrappedText:String{ text ?? ""}
    var exactText : String{ unwrappedText.isBlank ? "" : unwrappedText }
    var isBlank: Bool { unwrappedText.isBlank }
}

extension UIView{
    @IBInspectable
    var radius:CGFloat{
        get{
            layer.cornerRadius
        }
        set{
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
}

extension UIAlertAction{
    
    //KVC
    func setTitleColor(_ color: UIColor){
        setValue(color, forKey: "titleTextColor")
    }
    
    var titleTextColor: UIColor?{
        get{
            value(forKey: "titleTextColor") as? UIColor
        } set{
            setValue(newValue, forKey: "titleTextColor")
        }
    }
}



extension UIViewController{
    //显示加载或提示框
    
    //显示加载框(需要手动隐藏)
    func showLoadHUD(_ title:String? = nil){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
    }
    
    func hideLoadHUD(_ title:String? = nil){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    //提示框(自动隐藏)
    func showTextHUD(_ title:String,_ inCurrentView:Bool = true ,_ subTitle:String? = nil  ){
        var viewToShow = view!
        if !inCurrentView{
            viewToShow = UIApplication.shared.windows.last!
        }
        let hud = MBProgressHUD.showAdded(to: viewToShow, animated: true)
        hud.mode = .text //
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func showTextHUD(_ title:String, in view: UIView, _ subTitle:String? = nil ){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text //
        hud.label.text = title
        hud.detailsLabel.text = subTitle
        hud.hide(animated: true, afterDelay: 2)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    //添加子视图控制器
    func add(child vc:UIViewController){
        addChild(vc)
        vc.view.frame = view.bounds  //若vc是代码创建责需要加这句
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func remove(child vc:UIViewController){
        vc.willMove(toParent: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    func removeChildren(){
        if !children.isEmpty{
            for vc in children{
                remove(child:vc)
            }
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
    
    static func loadView<T>(fromNib name:String,with type:T.Type) -> T{
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T{
            return view
        }
        fatalError("加载\(type)类型失败")
    }
}

extension FileManager{
    func save(_ data:Data?, to dirName: String, as fileName:String) -> URL?{
        guard let data = data else {
            print("data为nil")
            return nil
        }
        
        
        let dirURL =  URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(dirName, isDirectory: true)
        
        if fileExists(atPath: dirURL.path){
            guard let _ = try? createDirectory(at: dirURL, withIntermediateDirectories: true) else{
                print("创建文件夹失败")
                return nil
            }
        }
        
        let fileURL = dirURL.appendingPathComponent(fileName)
        
        if !fileExists(atPath: fileURL.path){
            guard let _  = try? data.write(to: fileURL) else{ return nil }
        }
        return fileURL
    }
}
