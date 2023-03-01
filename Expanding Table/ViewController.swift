//
//  ViewController.swift
//  Expanding Table
//
//  Created by Muhammed Faruk Söğüt on 26.02.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tableSection: [TableSectionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        
        configureHeader()
        configureTable()
    }
    
    private func configureHeader(){
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseID)
    }
    

    private func configureTable(){
        tableSection.append(TableSectionModel(title: "Renk", sectionType: .color, itemType: [.colorItems(.red),.colorItems(.blue),.colorItems(.systemGreen)], opened: false))
        
        tableSection.append(TableSectionModel(title: "Mesaj", sectionType: .message, itemType: [.label("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s")], opened: false))
                        
        
        tableSection.append(TableSectionModel(title: "Resim", sectionType: .image, itemType: [.imageView("imageName")], opened: false))
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableSection[section].opened {
            return tableSection[section].itemType.count
        }else {
            return 0
        }
                
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let section = tableSection[section]
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseID) as! HeaderView
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        headerView.backgroundView = view
        headerView.sectionModel = section
        headerView.delegate = self
        headerView.title.text = section.title
        
        let bottom = UIImage(named: "arrowBottom")
        let up = UIImage(named: "arrowUp")
        
        if section.opened {
            headerView.imageView.image = up
        }else {
            headerView.imageView.image = bottom
        }
        
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = tableSection[indexPath.section]
        let item = section.itemType[indexPath.row]
        
        switch item {
        case .imageView(let name):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageTableViewCell
            cell.istanbulImage.image = UIImage(named: name)
            return cell
        case .label(let message):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageTableViewCell
            cell.label.text = message
            return cell
            
        case .colorItems(let color):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as! ColorTableViewCell
            cell.backgroundColor = color
            return cell
        }
                        
    }
          
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension ViewController: HeaderViewDelegate {
    func onClick(sectionModel: TableSectionModel) {
        
        //tableSection.forEach({$0.opened = false})
        
        tableSection.forEach { model in
            if model === sectionModel {
                model.opened.toggle()
                tableView.reloadData()
            }
        }
    }
}


//MARK: -TableModel

class TableSectionModel {
    enum SectionType {
        case color, message, image
    }
    var title: String
    var sectionType: SectionType
    var itemType: [TableItemModel]
    var opened: Bool
    
    init(title: String, sectionType: SectionType, itemType: [TableItemModel], opened: Bool) {
        self.title = title
        self.sectionType = sectionType
        self.itemType = itemType
        self.opened = opened
    }
    
}

enum TableItemModel{
    case colorItems(UIColor), label(String), imageView(String)
}
