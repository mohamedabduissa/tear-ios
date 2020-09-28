//
//  forgetpassword.swift
//  Teer
//
//  Created by Boo Doo on 9/13/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH
class forgetpassword: UIViewController {

    
    
    @IBOutlet weak var forgetLBL: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var forgetDES: UILabel!
    @IBOutlet weak var nextBTN: UIButton!
    
    @IBOutlet weak var back: UIButton!
    let presenter = forget_password_presenter(loginModel: forget_password_model())
    let toastMessage = ToastMessages()
    var phone_number: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        set_up_view()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    func set_up_view(){
        nextBTN.layer.cornerRadius = 10
        nextBTN.layer.masksToBounds = true
        forgetLBL.text = "forget_password".localize
        forgetDES.text = "enter_phone".localize
        nextBTN.setTitle("next".localize, for: .normal)
        phone.placeholder = "phone".localize
        presenter.setVCDelegate(vcDelegate: self)
        phone.delegate = self
        if  MOLHLanguage.isArabic(){
                   self.back.transform = self.back.transform.rotated(by: CGFloat(Double.pi))
               }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBTN_tapped(_ sender: Any) {
        
        validate_data()
    }
    func validate_data()
    {
        guard let phone_txt = phone.text, !phone_txt.isEmpty else{
            
            showAlert(msg: "enter_phone".localize)
            phone.attributedPlaceholder =  NSAttributedString(string: "enter_phone".localize, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 12)!])
            
            return
        }
        self.phone_number = phone_txt
        self.presenter.forget(phone: phone_txt)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showAlert(msg: String) {
           toastMessage.createToastMessage(msg)
       }
}
extension forgetpassword: forget_passwordVCProtocol{
    func go_verification(code: Int) {
        
        let view = UIStoryboard(name: "forgetPassword", bundle: nil).instantiateViewController(withIdentifier: "verifiy_password") as! verifiy_password
        view.code = code
        view.phone = self.phone_number
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
        
        
    }
    
    
}
extension forgetpassword: UITextFieldDelegate{
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
