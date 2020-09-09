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
        self.listen2Keyboard(withView: self.save)
        
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
