//
//  RoundView.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func circular()
    {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
}
