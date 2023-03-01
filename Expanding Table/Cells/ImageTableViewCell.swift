//
//  ImageTableViewCell.swift
//  Expanding Table
//
//  Created by Muhammed Faruk Söğüt on 26.02.2023.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var istanbulImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
