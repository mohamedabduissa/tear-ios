//
//  CurrentOrdersResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/4/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
struct CurrentOrdersResponse  {
    private static let userDefault = UserDefaults.standard

    let key : Int
    let price : Double
    
    
    var currentOrder: (Int, Double){
        return (key: key,
                price: price
        )
    }
    enum CodingKeys: String, CodingKey {
        
        case key = "key"
        case price = "price"
        
    }
   static func save(_ key: String){
        userDefault.set(key,
                         forKey: "orderNumber")
     }
    static func getOrderNumber()-> String {
        return userDefault.string(forKey: "orderNumber") ?? "3"
      }

}
