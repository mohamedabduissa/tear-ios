//
//  NotificationsCell.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class NotificationsCell: UITableViewCell, NotificationsCellProtocol {
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellBody: UILabel!
    
    func displayNotifications(_ notification: (key: String, title: String, body: String, time: String, date: String)) {
        print("jhgfhjkl;.........")
        cellTitle.text = notification.title
        cellDate.text = notification.date
        cellBody.text = notification.body
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

protocol NotificationsCellProtocol {
//    func displayOrderPrice(price:Double)
//    func displayOrderStatus(status:String)
//    func displayOrderNumber(number:Int)
    func displayNotifications(_ notification: (key: String, title: String, body : String, time: String, date: String))
}
