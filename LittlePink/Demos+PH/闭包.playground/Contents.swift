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


class SomeVC{
    func getData(finished:@escaping (String) -> ()){
        print("外层执行")
        DispatchQueue.global().async {
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                finished("数据")
            }
        }
        print("外层结束")
    }
}

let someVC = SomeVC()
someVC.getData { data in
    print("\(data)");
}
