//
//  LoginModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation

struct Data : Codable {
    let key : Int?
    let name : String?
    let email : String?
    let phone : String?
    let apiToken: String?
    
    var user: (String, String, Int,String){
        return (name: name!,
                phone: phone!,
                key: key!,
                email: email!
                //apiToken: apiToken!
               )
    }

    enum CodingKeys: String, CodingKey {

        case key = "key"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case apiToken = "api_Token"
    }


}
