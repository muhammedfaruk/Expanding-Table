//
//  HeaderView.swift
//  Expanding Table
//
//  Created by Muhammed Faruk Söğüt on 26.02.2023.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func onClick(sectionModel: TableSectionModel)
}

class HeaderView: UITableViewHeaderFooterView {

    weak var delegate: HeaderViewDelegate?
   
    var sectionModel: TableSectionModel?
    
    static let reuseID = "HeaderView"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    @IBAction func onHeaderClick(_ sender: Any) {
        if let sectionModel = sectionModel {
            delegate?.onClick(sectionModel: sectionModel)
        }        
    }
    
}
