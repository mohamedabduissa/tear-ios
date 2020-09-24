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
    @IBOutlet weak var forgetPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.roundAndShodowTextField()
        password.roundAndShodowTextField()
        self.listen2Keyboard(withView: self.login)
        if  MOLHLanguage.isArabic(){
            self.phone.textAlignment = .right
            self.password.textAlignment = .right
            self.forgetPassword.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        }
        self.forgetPassword.setTitle("forget_password".localize, for: .normal)

        print("currente lang\(MOLHLanguage.currentAppleLanguage())")
        phone.delegate = self
        password.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
          presenter.setVCDelegate(vcDelegate: self)
       }
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
        
       validate_data()
        //print("btn login is pressed with phone: \(phone.text!), password: \(password.text!)")
        //print("welcome")
//         let view = UIStoryboard(name: "ChangeLanguage", bundle: nil).instantiateViewController(withIdentifier: "ChangeLanguageViewController") as! ChangeLanguageViewController
//               self.present(view, animated: true, completion: nil)
    }
    func validate_data()
    {
        guard let phone_txt = phone.text, !phone_txt.isEmpty else{
            
            showAlert(msg: "enter_phone".localize)
            phone.attributedPlaceholder =  NSAttributedString(string: "enter_phone".localize, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 12)!])
            
            return
        }
       guard let password_txt = password.text, !password_txt.isEmpty else{
            
        showAlert(msg: "enter_password".localize)
            password.attributedPlaceholder =  NSAttributedString(string: "enter_password".localize, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 12)!])
            
            return
        }
        
        self.presenter.loginWithPhone(phone: phone_txt, password: password_txt)
        
    }
    
    @IBAction func forget_password(_ sender: Any) {
        let view = UIStoryboard(name: "forgetPassword", bundle: nil).instantiateViewController(withIdentifier: "forgetpassword") as! forgetpassword
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)

    }
    
func goToHomeScreen() {
//    CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
//        let homeScreen = UIStoryboard(name: "DeliveryStatus", bundle: nil)
    let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
        //let vc = homeScreen.instantiateInitialViewController()
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
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
