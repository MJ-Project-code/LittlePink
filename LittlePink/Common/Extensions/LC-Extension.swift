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

extension LCObject{
    func getExactStringVal(_ col: String) -> String { get(col)?.stringValue ?? "" }
    func getExactIntVal(_ col:String) -> Int { get(col)?.intValue ?? 0 }
    func getExactDoubleVal(_ col: String) -> Double { get(col)?.doubleValue ?? 1 }
    func getExactBoolVal(_ col: String) -> Bool { get(col)?.boolValue ?? false }
    
    enum imageType {
        case avatar
        case coverPhoto
    }
    
    func getImageURL(from col:String,_ type: imageType) -> URL{
        if let file =  get(col) as? LCFile,
           let path = file.url?.stringValue,
           let url = URL(string: path){
            return url
        }else{
            switch type {
            case .avatar:
                return Bundle.main.url(forResource: "avatarPH", withExtension: "jpeg")!
            case .coverPhoto:
                return Bundle.main.url(forResource: "logo", withExtension: "png")!
            }
        }
    }
}

