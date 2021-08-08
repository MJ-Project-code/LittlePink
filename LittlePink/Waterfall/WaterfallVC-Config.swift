//
//  WaterfallVC-Config.swift
//  LittlePink
//
//  Created by 马俊 on 2021/4/8.
//

import CHTCollectionViewWaterfallLayout

extension WaterfallVC{
    func config(){
        let layout = collectionView.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        
        layout.columnCount = 2
        layout.minimumColumnSpacing = kWaterfallPadding
        layout.minimumInteritemSpacing = kWaterfallPadding
        layout.sectionInset = UIEdgeInsets(top: 0, left: kWaterfallPadding, bottom: kWaterfallPadding, right: kWaterfallPadding)
        
        if isDraft{
            navigationItem.title = "本地草稿"
        }
        
        //注册 '我的草稿cell'
        collectionView.register(UINib(nibName: "MyDraftNoteWaterfallCell", bundle: nil), forCellWithReuseIdentifier: kMyDraftNoteWaterfallCellID)
    }
}
