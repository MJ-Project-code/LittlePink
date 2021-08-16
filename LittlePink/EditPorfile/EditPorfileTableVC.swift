//
//  EditPorfileTableVC.swift
//  LittlePink
//
//  Created by 马俊 on 2021/8/12.
//

import UIKit

class EditPorfileTableVC: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
    var avatar:UIImage?{
        didSet{
            DispatchQueue.main.async {
                self.avatarImageView.image = self.avatar
            }
        }
    }
    
    lazy var textfield:UITextField = {
        let textfield = UITextField(frame: .zero)
        //textfield.inputView =
        return textfield
    }()
    
    lazy var genderPickerView:UIStackView =  {
        let cancelBtn = UIButton()
        setToolBarBtn(cancelBtn, title: "取消", color: .secondaryLabel)
        let doneBtn = UIButton()
        setToolBarBtn(doneBtn, title: "完成", color: mainColor)
        let ToolBarView = UIStackView(arrangedSubviews: [cancelBtn,doneBtn])
        ToolBarView.distribution = .equalSpacing
        
        let pickView = UIPickerView()
        pickView.translatesAutoresizingMaskIntoConstraints = false
        pickView.dataSource = self
        pickView.delegate = self

        
        let genderPickerView = UIStackView(arrangedSubviews: [ToolBarView,pickView])
        genderPickerView.frame.size.height = 150
        genderPickerView.axis = .vertical
        genderPickerView.spacing = 8
        genderPickerView.backgroundColor = .secondarySystemBackground


        return genderPickerView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.inputView = genderPickerView
        tableView.addSubview(textfield)
    }
    
    @IBAction func back(_ sender: Any) {
    }
    
    private func setToolBarBtn(_ btn:UIButton , title: String , color: UIColor){
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitleColor(color, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
    }
}

extension EditPorfileTableVC:UIPickerViewDataSource , UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        ["男","女"][row]
    }
}
