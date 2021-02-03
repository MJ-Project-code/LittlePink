import UIKit

let  label:UILabel = {
    let label = UILabel()
    label.text = "xxx"
    return label
}()

let learn = { (lan:String) -> String in
    "学习\(lan)"
}

learn("ios")
