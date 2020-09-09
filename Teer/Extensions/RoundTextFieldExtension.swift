//
//  RoundTextFieldExtension.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    func roundAndShodowTextField()
    {
        self.layer.masksToBounds = false
        self.borderStyle = .none
        
        //To apply corner radius
        self.layer.cornerRadius = self.frame.size.height / 2
        
        //To apply border
        self.layer.borderWidth = 0.30
        // self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        //textField.layer.shadowColor = UIColor.black.cgColor
        //To apply Shadow
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        // self.layer.shadowOffset = CGSize.zero // Use any CGSize
        self.layer.shadowColor = UIColor.gray.cgColor
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        
        
        
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
        self.clipsToBounds = false
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowColor = UIColor.gray.cgColor //Any dark color
    }
}
