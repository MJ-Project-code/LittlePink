//
//  WaterfallVC-LoadData.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/8.
//

import CoreData

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
        
        
        let draftNotes =  try! context.fetch(request)
        
        
        
        self.draftNotes = draftNotes
    }
}
