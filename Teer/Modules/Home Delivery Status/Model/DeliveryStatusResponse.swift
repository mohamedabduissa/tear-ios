//
//  DeliveryStatusResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/25/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
struct DeliveryStatusResponse  {
    let new : Int
    let cancel : Int
    let complete : Int
    let processing : Int
    
    var order: (Int, Int, Int, Int){
        return (new: new,
                cancel: cancel,
                complete: complete,
                processing: processing
        )
    }
    enum CodingKeys: String, CodingKey {
        
        case new = "new"
        case cancel = "cancel"
        case complete = "complete"
        case processing = "processing"
    }
}
