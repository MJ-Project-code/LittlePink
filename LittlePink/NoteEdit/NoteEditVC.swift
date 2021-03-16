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
    
    //var dragingIndexpath = IndexPath(item: 0, section: 0)

     var photos = [
        UIImage(named: "1")!, UIImage(named: "2")!
    ]
    //var videoURL:URL = Bundle.main.url(forResource: "testVideo", withExtension:".mp4")!
    var videoURL:URL?
    @IBOutlet weak var photoCollectionview: UICollectionView!

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var photoCount:Int{return photos.count}
    var isVideo:Bool{ videoURL != nil}
    var textViewIAView:TextViewIAView{textView.inputAccessoryView as! TextViewIAView}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
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
        guard titleTextField.markedTextRange == nil else { return }
        if titleTextField.unwrappedText.count > kmaxNoteTitleCount{
            titleTextField.text = String(titleTextField.unwrappedText.prefix(kmaxNoteTitleCount))
            showTextHUD("标题最多输入\(kmaxNoteTitleCount)字")
            
            DispatchQueue.main.async {
                let end =  self.titleTextField.endOfDocument
                self.titleTextField.selectedTextRange = self.titleTextField.textRange(from: end, to: end)
            }
        }
        titleCountLabel.text = "\(kmaxNoteTitleCount - titleTextField.unwrappedText.count)"
    }
    
    

}
    //todo


extension NoteEditVC{
    func textViewDidChange(_ textView: UITextView) {
        guard textView.markedTextRange == nil else{ return }
        textViewIAView.currentTextCount = textView.text.count
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
