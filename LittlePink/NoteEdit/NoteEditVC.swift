//
//  NoteEditVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/2/9.
//

import UIKit

class NoteEditVC: UIViewController {

    let photos = [
        UIImage(named: "1"), UIImage(named: "2")
    ]
    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension NoteEditVC:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCellID, for: indexPath) as! PhotoCell
        
        cell.imageView.image = photos[indexPath.item]
         
        cell.contentView.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside) //touchUpInside 点击后执行 action的内容
            return photoFooter
        default:
            fatalError("collectionView的footerc出问题")
        }
    }
    
}

extension NoteEditVC:UICollectionViewDelegate{
    
}

//监听
extension NoteEditVC{
    @objc private func addPhoto(){
        print("xxxxx")
    }
}
