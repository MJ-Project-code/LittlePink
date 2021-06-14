//
//  WaterfallVC-LoadData.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/8.
//

import CoreData
import LeanCloud

extension WaterfallVC{
    func getDraftNotes(){
       //let draftNotes =  try! context.fetch()
        let request = DraftNote.fetchRequest() as NSFetchRequest<DraftNote>
        //分页(上拉加载)
        //request.fetchOffset = 0  //偏移量 从n+1开始取
        //request.fetchLimit = 20  //每一页的数量
        
        //筛选
        //request.predicate  = NSPredicate(format: "title = %@","iOS")
        
        //排序
        let sortDescriptors1 = NSSortDescriptor(key: "updatedAt", ascending: false)
        //let sortDescriptors2 = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptors1]
        
//        request.returnsObjectsAsFaults = true
        
        request.propertiesToFetch = ["coverPhoto","title","updatedAt","isVideo"]
        
        
        backgroundContext.perform {
            if let draftNotes =  try?  backgroundContext.fetch(request){
                self.draftNotes = draftNotes
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            self.hideLoadHUD()
        }
        
        
    }
    
    func getNotes(){
        let query = LCQuery(className: kNoteTable)
        
        query.whereKey(kChannelCol, .equalTo(channel))
        query.whereKey(kAuthorCol, .included)
        query.whereKey(kUpdatedAtCol, .descending)
        query.limit = kNotesOffset
        
        query.find { result in
            if case let  .success(objects: notes) =  result{
                self.notes = notes
                self.collectionView.reloadData()
            }
        }
    }
}
