//
//  LoginViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/23/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH

class LoginViewController: UIViewController, LoginVCProtocol{
    
    let presenter = LoginPresenter(loginModel: LoginModel())
    let toastMessage = ToastMessages()
    
    @IBOutlet weak var login: CustomBtn!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.roundAndShodowTextField()
        password.roundAndShodowTextField()
        self.listen2Keyboard(withView: self.login)
        if  MOLHLanguage.isArabic(){
            self.phone.textAlignment = .right
            self.password.textAlignment = .right
        }
    }
    override func viewWillAppear(_ animated: Bool) {
          presenter.setVCDelegate(vcDelegate: self)
       }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        self.presenter.loginWithPhone(phone: phone.text!, password: password.text!)
        //print("btn login is pressed with phone: \(phone.text!), password: \(password.text!)")
        //print("welcome")
//         let view = UIStoryboard(name: "ChangeLanguage", bundle: nil).instantiateViewController(withIdentifier: "ChangeLanguageViewController") as! ChangeLanguageViewController
//               self.present(view, animated: true, completion: nil)
    }
func goToHomeScreen() {
//    CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
        //let homeScreen = UIStoryboard(name: "DeliveryStatus", bundle: nil)
//    let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
//        //let vc = homeScreen.instantiateInitialViewController()
//        self.present(view, animated: true, completion: nil)
    let view = UIStoryboard(name: "ChangeLanguage", bundle: nil).instantiateViewController(withIdentifier: "ChangeLanguageViewController") as! ChangeLanguageViewController
    self.present(view, animated: true, completion: nil)
    
    }
    
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
    }
    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        presenter.setVCDelegate(vcDelegate: self)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: Notification.Name.UIResponder.keyboardWillHideNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: Notification.Name.UIResponder.keyboardWillChangeFrameNotification, object: nil)
//    }
//
//
//
//    @objc func handleKeyboard(notification: Notification){
//
//        let userInfo = notification.userInfo!
//
//        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardIsLocalUserInfoKey] as! NSValue).cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//        if notification.name == Notification.Name.UIKeyboardWillHide {
//            scrollView.contentInset = UIEdgeInsets.zero
//        }else {
//            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 300
//                , right: 0)
//        }
//
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//    }
    
}
