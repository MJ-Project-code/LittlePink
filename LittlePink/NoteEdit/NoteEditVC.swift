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
import LeanCloud

class NoteEditVC: UIViewController, UITextViewDelegate {
    
    var draftNote:DraftNote?
    var updateDraftNoteFinished:(()->())?
    
    var photos : [UIImage] = []
    
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
        guard isValidateNote() else {return }
        
        if let draftNote = draftNote{
            updateDraftNote(draftNote)
        }else{
            createDraftNote()
        }
        
    }
    
    @IBAction func postNote(_ sender: Any) {
        guard isValidateNote() else {return }
        
        do {
            let noteGroup = DispatchGroup()
            
            let note = LCObject(className: kNoteTable)
            //单个文件
            if let videoURL = self.videoURL{  //视频
                let video = LCFile(payload: .fileURL(fileURL: videoURL))
                video.save(to: note, as: kVideoCol, group: noteGroup)
            }
            
            if let coverPhotoData =  photos[0].jpeg(.high){ //封面图
                let coverPhoto =  LCFile(payload: .data(data: coverPhotoData))
                coverPhoto.save(to: note, as: kCoverPhotoCol, group: noteGroup)
            }
            let photoGroup = DispatchGroup()
            //多个图片存储
            var photoPaths : [Int:String] = [:]
            for (index,eachPhoto) in photos.enumerated(){
                if let photoData = eachPhoto.pngData(){
                    let photo = LCFile(payload: .data(data: photoData))
                    photoGroup.enter()
                    photo.save { (res) in
                        if case .success = res , let path = photo.url?.stringValue{
                            photoPaths[index] = path
                        }
                        photoGroup.leave()
                    }
                }
            }
            noteGroup.enter()
            photoGroup.notify(queue: .main) {
                let photoPathsArr =  photoPaths.sorted(by: <).map{$0.value}
                do{
                    try note.set(kPhotosCol, value: photoPathsArr)
                    note.save(){ _ in
                        print("")
                        noteGroup.leave()
                    }
                }catch{
                    print("字段赋值失败\(error)")
                }
            }
            
            try note.set(kTitleCol, value: titleTextField.exactText)
            try note.set(kTextCol,value: textView.exactText)
            try note.set(kChannelCol, value: channel.isEmpty ? "推荐" : channel )
            try note.set(kSubChannelCol,value: subChannel)
            try note.set(kPoiNameCol, value: poiName)
            
            noteGroup.enter()
            note.save { res in
                noteGroup.leave()
            }
            
            noteGroup.notify(queue: .main) {
                
            }
            
        } catch  {
            print("存笔记金云端失败\(error)")
        }
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

