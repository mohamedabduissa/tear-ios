//
//  ChangePassResposne.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/30/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation

struct ChangePassResposne: Codable {
    let status: Int
    let message: String
    let errors : String?
    
    var changePass: (Int,String,String){
        return (status: status, message: message, errors: errors!)
    }
}
