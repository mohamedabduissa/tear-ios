//
//  new_password.swift
//  Teer
//
//  Created by Boo Doo on 9/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit

class new_password: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    @IBOutlet weak var save: UIButton!
    var presenter = new_password_presenter(loginModel: forget_password_model())
    var code: Int?
    var phone: String?
    let toastMessage = ToastMessages()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        set_up_view()
    }
    func set_up_view()
    {
        password.placeholder = "new_password".localize
        confirm_password.placeholder = "re_enter_password".localize
        save.setTitle("save".localize, for: .normal)
        save.layer.cornerRadius = 10
        save.layer.masksToBounds = true
//        presenter?.delegate = self
        presenter.setVCDelegate(vcDelegate: self)
        password.delegate = self
        confirm_password.delegate = self
    }

    @IBAction func saveBTN_tapped(_ sender: Any) {
        validate_data()
//        self.presenter.verifiy()
    }
    func validate_data()
    {
        guard let phone_number = phone, let password1 = password.text, let password2 = confirm_password.text, !password1.isEmpty, !password2.isEmpty, !phone_number.isEmpty else {
            return
        }
        if password1 == password2 {
            print("equal")
           self.presenter.verifiy(phone: phone_number, password: password1, confirmed_password: password2)
        }
        else{
            showAlert(msg: "password_dismatch".localize)
            print("dismatch")
        }
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension new_password: new_passwordVCProtocol{
    
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)

    }
    
    func go_login() {
        let view = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginScreen") as! LoginViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    
   
    
    
}
extension new_password: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           view.endEditing(true)
           return false
       }
}
