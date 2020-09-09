//
//  HandelShowKeyboard.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/21/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import Foundation
import UIKit
import MOLH

extension UIViewController{
    //keyboard
    func listen2Keyboard(withView view : UIView){

        
        self.view.subviews.forEach { (childView) in
            if childView == view{
                childView.tag = 23
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyboardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func listen2Keyboard(withViews views : [UIView]){
        
        
        self.view.subviews.forEach { (childView) in
            views.forEach({ (moveableView) in
                if childView == moveableView{
                    childView.tag = 23
                }
            })
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyboardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.KeyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func KeyboardShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.view.subviews.forEach { (childView) in
            if childView.tag == 23{
                UIView.animate(withDuration: 0.15) {
                    childView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height/* - childView.height(ofCent: 50)*/)
                }
            }
        }
    }
    //hide the keyboard
    @objc func KeyboardHidden(notification: NSNotification)
    {
       
        self.view.subviews.forEach { (childView) in
            if childView.tag == 23{
                UIView.animate(withDuration: 0.15) {
                    childView.transform = .identity
                }
            }
        }
    }
    func isPresented() -> Bool {
        if self.presentingViewController != nil {
            return true
        } else if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        } else if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    func setSemantic(_ val : Bool)->Bool{//If semantic is set to RTL returns true
        if val{
           if MOLHLanguage.isArabic(){
                  UIView.appearance().semanticContentAttribute = .forceRightToLeft
                   return true
            }
        
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                return false
        }
            return false
        }
    
    
}
