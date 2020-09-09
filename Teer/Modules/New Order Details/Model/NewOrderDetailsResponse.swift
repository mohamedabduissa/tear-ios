//
//  NewOrderDetailsResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/9/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
struct NewOrderDetailsResponse  {
    static var orderNum = ""
    let orderNo : Int
    let name : String
    let phone : String
    let address : String
    let price: String
    let clientName : String
    let status : String
    let receivedAtTime : String
    let startedAtTime :String
    let finishedAtTime:String
    let time :String
    var orderDetails: (Int, String, String, String,String,String,String,String,String,String,String){
        return (orderNo: orderNo,
                name: name,
                phone: phone,
                address: address,
                price : price,
                clientName:clientName,
                status : status,
                receivedAtTime: receivedAtTime,
                startedAtTime:startedAtTime,
                finishedAtTime:finishedAtTime,
                time:time
        )
    }
    enum CodingKeys: String, CodingKey {
        
        case orderNo = "orderNo"
        case name = "name"
        case phone = "phone"
        case address = "address"
        case price = "price"
        case clientName = "clientName"
        case status = "status"
        case receivedAtTime = "receivedAt"
        case startedAtTime = "startedAt"
        case finishedAtTime = "finishedAt"
        case time = "time"
    }
}
