//
//  NotificationsResponse.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/10/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
struct NotificatiosResponse {
    let data : [NotificationsData]?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case total = "total"
    }
}
struct NotificationsData {
    let key : String?
    let title : String?
    let body : String?
    let time : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case key = "key"
        case title = "title"
        case body = "body"
        case time = "time"
        case date = "date"
    }

    init?(data:NSDictionary) {
        let key: String = data.value(forKey: "key") as! String
        let title: String = data.value(forKey: "title") as! String
        let body: String = data.value(forKey: "body") as! String
        let time: String = data.value(forKey: "time") as! String
        let date: String = data.value(forKey: "date") as! String
        self.key = key
        self.title = title
        self.body = body
        self.time = time
        self.date = date
    }
}
