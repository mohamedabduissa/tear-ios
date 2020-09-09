//
//  SideMenuTableViewCell.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/29/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(item: SideItems) {
        self.cellTitle.text = item.title
        self.cellImage.image = item.image
    }

}
