//
//  EditPorfileTableVC-Delegate.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/12.
//

import PhotosUI

extension EditPorfileTableVC{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            var config = PHPickerConfiguration()
            config.filter = .images
            config.selectionLimit = 1
            let vc = PHPickerViewController(configuration: config)
            vc.delegate = self
            present(vc, animated: true)
        case 1:
            showTextHUD("修改简介")
        case 2:
            textfield.becomeFirstResponder()
        default:
            break
        }
    }
}
