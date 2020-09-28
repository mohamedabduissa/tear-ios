//
//  ProfileViewController.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH

class ProfileViewController: UIViewController, ProfileVCProtocol {
    
    @IBOutlet weak var save: CustomBtn!
    @IBOutlet weak var backBtnImage: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    var loginModel = LoginPresenter(loginModel: LoginModel())
    let presenter = ProfilePresenter(profileModel: ProfileModel())
    let toastMessage = ToastMessages()
    override func viewDidLoad() {
        super.viewDidLoad()
        name.roundAndShodowTextField()
        email.roundAndShodowTextField()
        phone.roundAndShodowTextField()
        name.text = CodeHelper.getCurrentUserName()
        email.text = CodeHelper.getCurrentUserEmail()
        phone.text = CodeHelper.getCurrentUserPhone()
        phone.isUserInteractionEnabled = false
        if  MOLHLanguage.isArabic(){
            self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
        }
//        self.listen2Keyboard(withView: self.save)
        hideKeyboardWhenTappedAround()
        name.delegate = self
        phone.delegate = self
        email.delegate = self
        name.layer.cornerRadius = 20
        name.layer.borderWidth = 1.0
        name.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        email.layer.cornerRadius = 20
        email.layer.borderWidth = 1.0
        email.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        phone.layer.cornerRadius = 20
        phone.layer.borderWidth = 1.0
        phone.layer.borderColor = #colorLiteral(red: 0.7954400182, green: 0.7955744863, blue: 0.7954223156, alpha: 1)
        if  MOLHLanguage.isArabic(){
            self.phone.textAlignment = .right
            self.email.textAlignment = .right
            self.name.textAlignment = .right

        }
    }
    override func viewWillAppear(_ animated: Bool) {
       presenter.setVCDelegate(vcDelegate: self)
    }
    
    @IBAction func onSaveBtnTapped(_ sender: Any) {
        self.presenter.profileUpdate(name: name.text!, email: email.text!, phone: phone.text!)
    }
    
    @IBAction func onBackBtnTapped(_ sender: Any) {
        goToHomeScreen()
    }
    func goToHomeScreen() {
    
        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
            self.present(view, animated: true, completion: nil)
        
        }
        
        func showAlert(msg: String) {
            toastMessage.createToastMessage(msg)
        }
        

}
extension ProfileViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           view.endEditing(true)
           return false
       }
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
     
     @objc func dismissKeyboard() {
    view.endEditing(true)
         // do someting...
     }
}
