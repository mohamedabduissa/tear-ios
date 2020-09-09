//
//  Reachability.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/18/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    static let instance = NetworkManager()
    
    
    
    private var timer : Timer?
    private var networkReachable = false
    var window : UIWindow?
    var isNetworkReachable :Bool{
        return self.networkReachable
    }
    private var toastLabel : UILabel?
    private init(){
        self.initToastLable()
    }
    private func initToastLable(){
        self.window = UIApplication.shared.keyWindow
        guard self.window != nil else{return}
        toastLabel = UILabel()
        toastLabel?.tag = 29
        toastLabel?.textColor = .white
        toastLabel?.backgroundColor = .black
        //toastLabel?.font = UIFont(name: iApp.HamellyFont.medium.font, size: CGFloat(15))
        toastLabel?.textAlignment = NSTextAlignment.center
        toastLabel?.numberOfLines = 0
        //toastLabel?.layer.shadowColor = UIColor.ThemeMain.cgColor;
        toastLabel?.layer.shadowOffset = CGSize(width:0, height:1.0);
        toastLabel?.layer.shadowOpacity = 0.5;
        toastLabel?.layer.shadowRadius = 1.0;
        toastLabel?.frame = CGRect(x: 0,
                                  y: window!.frame.height - 70,
                                  width: window!.frame.width,
                                  height: 70)
        toastLabel?.text = TeerError.connection.error
       
    }
    
    func observeReachability(_ val : Bool) {
        if val{
            self.startNetworkReachabilityObserver()
         self.timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(startNetworkReachabilityObserver), userInfo: nil, repeats: true)
        }else{
            self.timer = nil
        }
    }
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    @objc func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening{ status in
            switch status {
            case .notReachable:
                self.networkReachable = false
            case .unknown :
                self.networkReachable = false
            case .reachable(.ethernetOrWiFi):
                self.networkReachable = true
            case .reachable(.cellular):
                self.networkReachable = true
            }
        }
        self.updateToastStatus(self.networkReachable)
//        reachabilityManager?.startListening(nil)
    }
    
    private func updateToastStatus(_ val : Bool){
        guard let window = UIApplication.shared.keyWindow else{ return}
        guard self.toastLabel != nil else{
            self.initToastLable()
            return
        }
        if !window.subviews.contains(self.toastLabel!){
            window.addSubview(self.toastLabel!)
            window.bringSubviewToFront(self.toastLabel!)
            self.toastLabel!.transform = CGAffineTransform(translationX: 0, y: 70)
        }
        UIView.animate(withDuration: 0.3) {
            if val && self.toastLabel?.transform == .identity{//has net
                self.toastLabel!.transform = CGAffineTransform(translationX: 0, y: 70)
            }else if !val && self.toastLabel?.transform != .identity{//no net
                self.toastLabel!.transform = .identity
            }
            
        }
    }
}

enum TeerError : String {
    case server
    case connection
    var error:String {
        switch self {
        case .server:
            return "Internal server error, please try again.".localize
        case .connection:
            return "No internet connection.".localize
        }
    }
}
