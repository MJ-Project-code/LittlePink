import UIKit

class Author{
    var name:String
    unowned var video:Video?
    init(name:String) {
        self.name = name
    }
    deinit {
        print("author销毁")
    }
}

class Video{
    unowned var author:Author
    init(author:Author) {
        self.author = author
    }
    deinit {
        print("video销毁")
    }
}

var author:Author? = Author(name: "mj")
var video:Video? = Video(author: author!)
author?.video = video

author = nil
video = nil


class vc:UIViewController,UITableViewDelegate{
    var tableView: UITableView!
    override func viewDidLoad() {
        tableView.delegate = self
    }
}

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self]  in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}


var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil
