//
//  vifiry_code.swift
//  Teer
//
//  Created by Boo Doo on 9/13/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation

struct vifiry_code: Codable {
    var code: Int?
    var message: String?
    var status: Int?
}
struct reset_password: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
    let api_token: String?

   
}

// MARK: - DataClass
struct DataClass: Codable {
    let key, name, email, phone: String?
}
