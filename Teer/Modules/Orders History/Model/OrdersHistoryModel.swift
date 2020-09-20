//
//  OrdersHistoryModel.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/18/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class OrdersHistoryModel{
    
    //    class func getOrdersHistoryData(completion: @escaping ([OrdersData])-> Void) {
    //        ////        OrdersHistory.countryName = countryName[0]
    //        ////        OrdersHistory.categoryName = categoryName
    //        // let newsUrl = (categoryName == "HeadLines") ? Endpoints.countryHeadlines.url : Endpoints.categoryHeadlines.url
    //        let ordersHistoryUrl = URL(string: CodeHelper.APIBaseUrl+"orders/history")!
    //
    //        getOrdersHistoryFromApi(url: ordersHistoryUrl, responseType: OrdersHistory.self, completion: {(response, errorMessage, error)
    //            in
    //            guard let response = response else{
    //                completion([])
    //                return
    //            }
    //
    //            completion(response.data)
    //        })
    //    }
    //
    //    //    class func getSearchInEveryThingNews(keyword:String , completionHandler: @escaping ([OrdersData], String, Error?)-> Void) {
    //    //
    //    //        getNewsFromApi(countryName: [""], url: Endpoints.searchEverything(keyword).url, responseType: NewsResponse.self, completion: {(response, errorMessage, error) in
    //    //
    //    //            guard let response = response else{
    //    //                completionHandler([], errorMessage, error)
    //    //                return
    //    //            }
    //    //
    //    //            NewsData.totalPages = response.totalResults / 20
    //    //            completionHandler(response.articles, "", nil)
    //    //        })
    //    //    }
    //
    //    class func getOrdersHistoryFromApi <Response: Decodable> (url: URL, responseType: Response.Type, completion: @escaping (Response?, String, Error?)-> Void) {
    //        //NewsData.countryName = countryName[0]
    //        //let url = URL(string: "\(url)&apiKey=\(NewsData.apiKey)")
    //        let ordersHistoryUrl = URL(string: CodeHelper.APIBaseUrl+"orders/history")!
    //
    //        let headers : HTTPHeaders = ["Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
    //        AF.request(ordersHistoryUrl, method: .get, encoding : JSONEncoding.default, headers: headers).responseJSON { (myResponse) in
    //            print(myResponse)
    //            switch myResponse.result{
    //
    //            case .success:
    //                do {
    //                                        let responseJson = try JSONDecoder().decode(Response.self, from: myResponse.data!)
    //                                        DispatchQueue.main.async {
    //                                            completion(responseJson, "", nil)
    //                                            print(myResponse.data)
    //                                        }
    //                                    }
    ////                    let json = JSON(myResponse.value!)
    ////
    ////                    print(json)
    ////                    var ordersHistoryList = [OrdersData]()
    ////                    let ordersHistory = json["data"].arrayValue
    ////
    ////                    for order in ordersHistory
    ////                    {
    ////                        let key = order["key"].stringValue
    ////                        let clientName = order["clientName"].stringValue
    ////                        let address = order["address"].stringValue
    ////                        let price = order["price"].stringValue
    ////                        let status = order["status"].stringValue
    ////                        let deliverDate = order["deliverDate"].stringValue
    ////
    ////                        let orders = OrdersData(key: key, clientName: clientName, address: address, price: price, status: status, deliverDate: deliverDate)
    ////                        ordersHistoryList.append(orders)
    ////
    ////                        // completion(ordersHistoryList,"", nil)
    //
    //                    //}
    //              //  }
    //                    //                let json = JSON(response.value!)
    //                    //                print(json)
    //                    //                var currentOrdersList = [CurrentOrdersResponse]()
    //                    //                let currentOrders = json["data"].arrayValue
    //                    //                for currentOrder in currentOrders
    //                    //                {
    //                    //                 let key = currentOrder["key"].intValue
    //                    //                 let price = currentOrder["price"].doubleValue
    //                    //                 let currentOrder = CurrentOrdersResponse(key: key, price: price)
    //                    //                 currentOrdersList.append(currentOrder)
    //                    //
    //                    //                }
    //                catch {
    //                    do {
    //                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: myResponse.data!)
    //                        DispatchQueue.main.async {
    //                            completion(nil, errorResponse.message, error)
    //                        }
    //                    }
    //                    catch {
    //                        DispatchQueue.main.async {
    //                            completion(nil, "", error)
    //                        }
    //                    }
    //                }
    //
    //            case .failure:
    //                print("Error, could not get response from API")
    //            }
    //        }
    //    }
    //}
    //
    
    let ordersHistoryURL = URL(string: CodeHelper.APIBaseUrl+"orders/history")!
    
    func getAllOrdersHistory(completion: @escaping (String?, _ order:[OrdersData]?) -> Void) {
        let headers : HTTPHeaders = ["Content-Type": "application/json",
                                     "Accept": "application/json",
                                     "Authorization": "Bearer "+"\(CodeHelper.getCurrentUserToken())"]
        print("dddd",CodeHelper.getCurrentUserToken())
        
        AF.request(ordersHistoryURL, method: .get, parameters: nil, encoding : JSONEncoding.default, headers:headers).responseJSON { (response) in
            
            if response.response?.statusCode == 200{
                print(response)
                print("success")
            }
            switch response.result{
            case .failure:
                print("faild")
            case .success:
                
                let json = JSON(response.value!)
                print(json)
                var ordersHistory = [OrdersData]()
                let orders = json["data"].arrayValue
                for order in orders
                {
                    let key = order["key"].stringValue
                    let clientName = order["clientName"].stringValue
                    let address = order["address"].stringValue
                    let price = order["price"].stringValue
                    let status = order["status"].stringValue
                    let deliverDate = order["deliverDate"].stringValue
                    let orders = OrdersData(key: key, clientName: clientName, address: address, price: price, status: status, deliverDate: deliverDate)
                    ordersHistory.append(orders)
                    //ordersHistory.append(currentOrder)
                    
                }
                print("oder history\(ordersHistory)")
                completion(nil,ordersHistory)
                //   print(currentOrdersList[0].key)
            }
            
            
        }
    }
}
