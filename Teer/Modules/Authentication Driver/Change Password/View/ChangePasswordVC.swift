//
//  ChangePasswordVC.swift
//  Teer
//
//  Created by Mohamed Tahoon on 5/30/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH
class ChangePasswordVC: UIViewController, ChangePassVCProtocol {
    
    let presenter = ChangePassPresenter(changePassModel: ChangePassModel())
    let toastMessage = ToastMessages()
    
    
    @IBOutlet weak var save: CustomBtn!
    @IBOutlet weak var backBtnImage: UIButton!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPassword.roundAndShodowTextField()
        newPassword.roundAndShodowTextField()
        confirmNewPassword.roundAndShodowTextField()
        hideKeyboardWhenTappedAround()
        oldPassword.delegate = self
        confirmNewPassword.delegate = self
        newPassword.delegate = self
        if  MOLHLanguage.isArabic(){
                      self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
            oldPassword.textAlignment = .right
            newPassword.textAlignment = .right
            confirmNewPassword.textAlignment = .right
               }
//        self.listen2Keyboard(withView: self.save)
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.setVCDelegate(vcDelegate: self)
    }
    
    @IBAction func onBackTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

//        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
//        self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func onSaveTapped(_ sender: Any) {
        self.presenter.changePass(oldPassword: oldPassword.text!, newPassword: newPassword.text!, passwordConfirmation: confirmNewPassword.text!)
    }
    
    func goToHomeScreen() {
    //    CodeHelper.saveCurrentUserToken(userToken: (user?.apiToken)!)
            //let homeScreen = UIStoryboard(name: "DeliveryStatus", bundle: nil)
        let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
            //let vc = homeScreen.instantiateInitialViewController()
            self.present(view, animated: true, completion: nil)
        
        }
        
        func showAlert(msg: String) {
            toastMessage.createToastMessage(msg)
        }
}


extension ChangePasswordVC: UITextFieldDelegate{
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
