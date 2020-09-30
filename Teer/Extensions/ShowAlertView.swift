//
//  ShowAlertView.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright © 2020 Fudex. All rights reserved.
//

import Foundation
import UIKit

class ShowAlertView {
    
    class func showAlert (title: String , msg: String , sender: UIViewController){
        let alert = AlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
//        alert.setTitleImage(UIImage(named: "infoormation"))
//
//        alert.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        sender.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "ok".localize, style: .default, handler: { action in
            switch action.style{
            case .default:
                
                print(msg)
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("error")
                
            }}))
    }
}

