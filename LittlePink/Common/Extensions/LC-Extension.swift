//
//  LC-Extension.swift
//  LittlePink
//
//  Created by 马俊 on 2021/5/25.
//

import LeanCloud

extension LCFile{
    func save(to table: LCObject , as record: String, group: DispatchGroup? = nil ){
        group?.enter()
        self.save { result in
            switch result {
            case .success:
                if let _ = self.objectId?.value {
                    //print("文件保存完成。objectId: \(value)")
                    
                    do {
                        try table.set(record, value: self)
                        group?.enter()
                        table.save { (result) in
                            switch result {
                            case .success:
                                break
                            case .failure(error: let error):
                                print("保存表的数据失败")
                            }
                            group?.leave()
                        }
                        
                    } catch {
                        print("User表失败\(error)")
                    }
                }
            case .failure(error: let error):
                // 保存失败，可能是文件无法被读取，或者上传过程中出现问题
                print("保存文件进云端失败\(error)")
            }
            group?.leave()
        }
    }
}
