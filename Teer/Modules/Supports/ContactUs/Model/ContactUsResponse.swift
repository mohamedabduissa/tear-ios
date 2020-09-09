//
//  ContactUsResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation

struct ContactUsResponse : Codable {
   
    let status : Int?
    let message : String?
    
    var contactUs: (Int, String){
        return (status: status!,
                message: message!
               )
    }

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
    }
}

