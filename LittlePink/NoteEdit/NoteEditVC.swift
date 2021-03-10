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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoCollectionview.dragInteractionEnabled = true
        hideKeyboardWhenTappedAround()
    }
    

    @IBAction func TFEditBegin(_ sender: Any) {
        titleCountLabel.isHidden = false
    }
    
    @IBAction func TFEditEnd(_ sender: Any) {
        titleCountLabel.isHidden = true
    }
    @IBAction func TFEndOnExit(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}


//extension NoteEditVC:UITextFieldDelegate{
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
