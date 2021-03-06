//
//  NoteEditVC-Helper.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/13.
//

import Foundation

extension NoteEditVC{
    func isValidateNote() -> Bool {
        
        guard !photos.isEmpty else {
            showTextHUD("至少需要一张图片")
            return false
        }
        
        guard textViewIAView.currentTextCount <= kmaxNoteTextCount else{
            showTextHUD("标题最多输入\(kmaxNoteTitleCount)字")
            return false
        }
        
        return true
    }
    
    func handleTFEditChanged(){
        guard titleTextField.markedTextRange == nil else { return } //有拼音就不校验
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

