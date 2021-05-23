//
//  Extensions.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/2.
//

import UIKit
import DateToolsSwift
import AVFoundation

extension String{
    var isBlank:Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isPhoneNum: Bool{
        Int(self) != nil  && NSRegularExpression(kPhoneRegEx).matches(self)
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
    var exactText : String{
        unwrappedText.isBlank ? "" : unwrappedText
    }
}

extension UITextView{
    var unwrappedText:String{ text ?? ""}
    var exactText : String{
        unwrappedText.isBlank ? "" : unwrappedText
    }
}

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
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
