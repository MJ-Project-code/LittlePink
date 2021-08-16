//
//  EditPorfileTableVC-PHPickerVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/13.
//

import PhotosUI

extension EditPorfileTableVC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        //let itemProviders = results.map{ $0.itemProvider }
        let itemProviders = results.map(\.itemProvider)
        if let itemProvider  = itemProviders.first , itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self](image, error) in
                guard let self = self, let image = image as? UIImage else{ return }
                self.avatar = image
            }
        }
    }
}
