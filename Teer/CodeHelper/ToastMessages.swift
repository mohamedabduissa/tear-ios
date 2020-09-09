//
//  ToastMessages.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/25/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit

class ToastMessages {
    // MARK: - Display Toast Message
    func createToastMessage(_ strMessage:String, bgColor: UIColor = .black, textColor: UIColor = .white)
    {
        guard let win = UIApplication.shared.keyWindow else {
            return
        }
        let lblMessage = UILabel(frame: CGRect(x: 0, y: (win.frame.size.height)+70, width: win.frame.size.width, height: 70))
        
        //lblMessage.tag = 500
        //lblMessage.text = YSSupport.isNetworkRechable() ? strMessage : iApp.HamellyError.connection.error
        lblMessage.layer.cornerRadius = 25
        lblMessage.text = strMessage.localize
        lblMessage.clipsToBounds = true
        lblMessage.backgroundColor = .black
        lblMessage.textColor = .white
        //lblMessage.font = .systemFont(ofSize: 15, weight: .regular)
        lblMessage.font = UIFont.init(name: "Cairo", size: 15)
        lblMessage.textAlignment = NSTextAlignment.center
        lblMessage.numberOfLines = 0
        lblMessage.layer.shadowColor = UIColor.black.cgColor
        lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0)
        lblMessage.layer.shadowOpacity = 0.5
        lblMessage.layer.shadowRadius = 1.0
        
        moveLabelToYposition(lblMessage)
        UIApplication.shared.keyWindow?.addSubview(lblMessage)
    }
    
    func createToastMessageForAlamofire(_ strMessage:String, bgColor: UIColor = .black, textColor: UIColor = .lightText, forView:UIView)
    {
        let lblMessage=UILabel(frame: CGRect(x: 0, y: (forView.frame.size.height)+70, width: (forView.frame.size.width), height: 70))
        lblMessage.tag = 500
        //lblMessage.text = YSSupport.isNetworkRechable() ? NSLocalizedString(strMessage, comment: "") : NSLocalizedString(iApp.HamellyError.connection.error, comment: "")
        lblMessage.textColor = UIColor.lightText
        lblMessage.backgroundColor = UIColor.black
        lblMessage.font = .systemFont(ofSize: 15, weight: .regular)
        lblMessage.textAlignment = NSTextAlignment.center
        lblMessage.numberOfLines = 0
        lblMessage.layer.shadowColor = UIColor.black.cgColor
        lblMessage.layer.shadowOffset = CGSize(width:0, height:1.0)
        lblMessage.layer.shadowOpacity = 0.5
        lblMessage.layer.shadowRadius = 1.0
        
        downTheToast(lblView: lblMessage, forView: forView)
        UIApplication.shared.keyWindow?.addSubview(lblMessage)
    }
    
    func downTheToast(lblView:UILabel, forView:UIView) {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (forView.frame.size.height)-70, width: (forView.frame.size.width), height: 70)
        }, completion: { (finished: Bool) -> Void in
            self.closeTheToast(lblView, forView: forView)
        })
    }
    
    func closeTheToast(_ lblView:UILabel, forView:UIView)
    {
        UIView.animate(withDuration: 0.3, delay: 3.5, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (forView.frame.size.height)+70, width: (forView.frame.size.width), height: 70)
        }, completion: { (finished: Bool) -> Void in
            lblView.removeFromSuperview()
        })
    }
    
    // MARK: - Show the Animation
    func moveLabelToYposition(_ lblView:UILabel)
    {
        guard let win = UIApplication.shared.keyWindow else {
            return
        }
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (win.frame.size.height)-70, width: win.frame.size.width, height: 70)
        }, completion: { (finished: Bool) -> Void in
            self.onCloseAnimation(lblView)
        })
    }
    // MARK: - close the Animation
    func onCloseAnimation(_ lblView:UILabel)
    {
        guard let win = UIApplication.shared.keyWindow else {
            return
        }
        UIView.animate(withDuration: 0.3, delay: 3.5, options: UIView.AnimationOptions(), animations: { () -> Void in
            lblView.frame = CGRect(x: 0, y: (win.frame.size.height)+70, width: (win.frame.size.width), height: 70)
        }, completion: { (finished: Bool) -> Void in
            lblView.removeFromSuperview()
        })
    }
}
