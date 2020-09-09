//
//  OrdersCell.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/27/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class OrdersCell: UITableViewCell ,CurrentOrdersCellProtocol{
    func displayOrderPrice(price: Double) {
        orderPrice.text = String(price)
    }
    
    func displayOrderStatus(status: String) {
        
    }
    
    func displayOrderNumber(number: Int) {
        orderNumber.text = String(number)
    }
    
    
    @IBOutlet weak var shadowLayerView: UIView!
       
    @IBOutlet weak var mainBackgroundView: UIView!
   
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.masksToBounds = true
        shadowLayerView.layer.cornerRadius = 20
          /// Shadow
          shadowLayerView.layer.shadowColor = UIColor.black.cgColor
          shadowLayerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayerView.layer.shadowOpacity = 0.1
          shadowLayerView.layer.shadowRadius = 10.0
          shadowLayerView.layer.shouldRasterize = true
          /// Border
          shadowLayerView.layer.borderWidth = 1
          shadowLayerView.layer.borderColor = UIColor.lightGray.cgColor
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //    func orderDetails(order: OrderModel){
    //        orderNumber.text = order.
    //        orderStatus.text = order.
    //    }
}
protocol CurrentOrdersCellProtocol {
    func displayOrderPrice(price:Double)
    func displayOrderStatus(status:String)
    func displayOrderNumber(number:Int)
}
