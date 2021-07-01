//
//  NoteDetailVC-DelNote.swift
//  LittlePink
//
//  Created by 马俊 on 2021/6/25.
//
import LeanCloud

extension NoteDetailVC{
    func delNote(){
        
        showDelAlert(for: "笔记") { _ in
            self.delLcNote()
            
            //UI
            self.dismiss(animated: true) {
                self.delNoteFinished?()
            }
        }
    }
    
    private func delLcNote(){
        
        note.delete { res in
            if case .success = res{
                self.showTextHUD("笔记已删除")
            }
        }
        
    }
}
