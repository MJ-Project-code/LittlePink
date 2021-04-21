//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/9.
//

import UIKit
import YPImagePicker
import SKPhotoBrowser
import AVKit

class NoteEditVC: UIViewController, UITextViewDelegate {
    
    var draftNote:DraftNote?
    var updateDraftNoteFinished:(()->())?
    
     var photos = [
        UIImage(named: "1")!, UIImage(named: "2")!
    ]
    //var videoURL:URL? = Bundle.main.url(forResource: "TV", withExtension:".mp4")!
    var videoURL:URL?
    
    var channel = ""
    var subChannel = ""
    var poiName = ""
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var photoCollectionview: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelPlaceholderLabel: UILabel!
    @IBOutlet weak var poiNameLabel: UILabel!
    @IBOutlet weak var poiNameIcon: UIImageView!
    
    
    var photoCount:Int{return photos.count}
    var isVideo:Bool{ videoURL != nil}
    var textViewIAView:TextViewIAView{textView.inputAccessoryView as! TextViewIAView}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        setUI()
    }
    

    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    @IBAction func TFEndOnExit(_ sender: Any) {
        
    }
    @IBAction func TFEditChanged(_ sender: Any) {
        
        handleTFEditChanged()
        
        
    }
    //待做 存草稿之前判断当前用户输入字数是否符合要求
    @IBAction func saveDraftNote(_ sender: Any) {
        validateNote()
        
        if let draftNote = draftNote{
            updateDraftNote(draftNote)
        }else{
            createDraftNote()
        }
        
    }
    
    @IBAction func postNote(_ sender: Any) {
        validateNote()
    }
    
    //跳转 storyboard
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let channelVC = segue.destination as? ChannelVC{
            view.endEditing(true)
            channelVC.PVdelegate = self
        }else if let poiVC = segue.destination as? POIVC{
            poiVC.delegate = self
            poiVC.poiName = poiName
        }
    }
    

}




extension NoteEditVC{
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else{ return }
        textViewIAView.currentTextCount = textView.text.count
    }
}

extension NoteEditVC:ChannelVCDelegate{
    func updateChannel(channel: String, subChannel: String) {
        //数据部分
        self.channel = channel
        self.subChannel = subChannel
        //UI
        updateChannelUI()
    }
}

extension NoteEditVC:POIVCDelegate{
    func updatePOIName(_ poiName: String) {
        
        if poiName == kPOIsInitArr[0][0]{
            self.poiName = ""

        }else{
            self.poiName = poiName
        }
        //UI
        updatePOINameUI()
        
    }
}

//extension NoteEditVC:UITextFieldDelegate{
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//        let  isExceed = range.location >= kmaxNoteTitleCount || (textField.unwrappedText.count + string.count)  > kmaxNoteTitleCount
////        if range.location >= kmaxNoteTitleCount || (textField.unwrappedText.count + string.count)  > kmaxNoteTitleCount{
////            return false
////        }
//        if isExceed{
//            showTextHUD("标题最多输入\(kmaxNoteTitleCount)字")
//        }
//        return !isExceed
//    }
//}

