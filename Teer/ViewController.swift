//
//  ViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import Reachability

@available(iOS 10.0, *)
class ViewController: UIViewController {
   

    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.instance.observeReachability(true)

           Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {timer in
               if CodeHelper.getCurrentUserId() == 0 { //login
//                   let storyBoard : UIStoryboard = UIStoryboard(name: "DeliveryStatus", bundle:nil)
//                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! UIViewController
//                self.present(nextViewController, animated: true, completion: nil)

                //nextViewController.modalTransitionStyle = .flipHorizontal
//                let storyBoard : UIStoryboard = UIStoryboard(name: "forgetPassword", bundle:nil)
//                
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "forgetpassword") as! UIViewController
//                
//                nextViewController.modalPresentationStyle = .fullScreen
//                //self.resetRoot()
//                self.present(nextViewController, animated:true, completion:nil)
                
//                     r
                let myViewController = LanguageController(nibName: "ChooseLanguage", bundle: nil)
                myViewController.modalPresentationStyle =  .fullScreen
                self.present(myViewController, animated: true, completion: nil)
////                  self.present(myViewController, animated: true, completion: nil)
               
               }
               else {
                   let storyBoard : UIStoryboard = UIStoryboard(name: "DeliveryStatus", bundle:nil)

//                let storyBoard : UIStoryboard = UIStoryboard(name: "NewOrderDetails", bundle:nil)
                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! UIViewController
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewOrderDetailsViewController") as! UIViewController
                   nextViewController.modalPresentationStyle = .fullScreen
                //self.resetRoot()
                   self.present(nextViewController, animated:true, completion:nil)
               }
           })
           
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            }
            
}


