//
//  ChangeOrderStatusResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/12/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
struct ChangeOrderStatusResponse {
    var message : String
//    var statusMessage: (String) {
//        return (message: message)
//    }
   
    enum CodingKeys: String, CodingKey {
    
        case message = "message"}
}
