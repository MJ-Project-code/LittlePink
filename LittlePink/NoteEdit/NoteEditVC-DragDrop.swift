//
//  NoteEditVC-DragDrop.swift
//  LittlePink
//
//  Created by 马俊 on 2021/3/5.
//

import Foundation

extension NoteEditVC:UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //if indexPath.section=0 返回空数组 表示第一段不可拖拽
        
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photo))
        dragItem.localObject = photo
        
        return [dragItem]
    }
    
    
}


extension NoteEditVC:UICollectionViewDropDelegate{
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        //Proposal 提案,怎么拖放过去 是move 还是copy
        print("xxx")
        
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        //coordinator类似上下文
        
        if coordinator.proposal.operation == .move ,
           let item = coordinator.items.first ,
           let sourceIndexPath = item.sourceIndexPath,
           let destinationIndexPath = coordinator.destinationIndexPath{
            
            //coordinator.items.first?.dragItem.localObject
            //first? 只支持拖一个图所以是first
            collectionView.performBatchUpdates {
                photos.remove(at: sourceIndexPath.item)
                photos.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            }
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            
        }
    }
    
    
}
