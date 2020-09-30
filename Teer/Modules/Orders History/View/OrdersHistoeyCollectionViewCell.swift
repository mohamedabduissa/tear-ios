//
//  OrdersHistoeyCollectionViewCell.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH
class OrdersHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var orderCost: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    
    
    
    func setupCell(){
        //self.contentView.layer.borderColor = UIColor.gray.cgColor
        address.sizeToFit()
        self.contentView.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.borderWidth = 0.1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        //newsImage.layer.cornerRadius = 10.0
        //newsImage.kf.indicator?.startAnimatingView()
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        if MOLHLanguage.isArabic() {
            address.textAlignment = .right
            name.textAlignment = .right
            orderCost.textAlignment = .right
            orderStatus.textAlignment = .right

        }
    }
    
}

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
}
