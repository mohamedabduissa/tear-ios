//
//  LocalizExtension.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/18/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
