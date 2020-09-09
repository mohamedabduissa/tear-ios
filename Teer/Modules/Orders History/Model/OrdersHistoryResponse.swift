//
//  OrdersHistoryResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/18/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation

struct OrdersData: Codable {
    let key: String?
    let clientName: String?
    let address: String
    let price: String?
    let status: String?
    let deliverDate: String?
    
    var oderHistoryData: (String, String,String,String,String,String){
        return (key: key!,
                clientName: clientName!,
                address: address,
                price: price!,
                status: status!,
                deliverDate: deliverDate!
        )
    }
    enum CodingKeys: String, CodingKey {
        
        case key = "key"
        case clientName = "clientName"
        case address = "address"
        case price = "price"
        case status = "status"
        case deliverDate = "deliverDate"
        
    }
}

struct OrdersHistory: Codable {
    let totalResults: Int
    let data: [OrdersData]
}

struct ErrorResponse: Codable {
    let message: String
}
