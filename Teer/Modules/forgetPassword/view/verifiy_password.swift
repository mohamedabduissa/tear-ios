//
//  verifiy_password.swift
//  Teer
//
//  Created by Boo Doo on 9/17/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit

class verifiy_password: UIViewController {

    @IBOutlet weak var forget_LBL: UILabel!
    @IBOutlet weak var verifiy_text: UITextField!
    @IBOutlet weak var verifiy_lbl: UILabel!
    @IBOutlet weak var nextBTN: UIButton!
    var  toastMessage = ToastMessages()
    var code: Int?
    var phone: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        set_up_view()
    }
    func set_up_view()
    {
        
        forget_LBL.text = "forget_password".localize
        verifiy_lbl.text = "enter_code".localize
        verifiy_text.placeholder = "verification_code".localize
        nextBTN.setTitle("next".localize, for: .normal)
        nextBTN.layer.cornerRadius = 10
        nextBTN.layer.masksToBounds = true
        verifiy_text.delegate = self
    }

    @IBAction func nextBTN_tapped(_ sender: Any) {
        validate_data()
    }
    
    func validate_data()
    {
        guard let verifiy_code = verifiy_text.text, !verifiy_code.isEmpty else{
            
            showAlert(msg: "enter_verifiction".localize)
            verifiy_text.attributedPlaceholder =  NSAttributedString(string: "enter_verifiction".localize, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red,NSAttributedString.Key.font :UIFont(name: "Arial", size: 12)!])
            
            return
        }
        guard let code = code else{
            return
        }
        
        let text = Int(verifiy_code)
        if text == code{
            print("code is passed")
            go_next()
        }
        else{
            print("code not passed")
        }
        
    }
    func go_next()
    {
        let view = UIStoryboard(name: "forgetPassword", bundle: nil).instantiateViewController(withIdentifier: "new_password") as! new_password
        view.phone = self.phone
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    func showAlert(msg: String) {
        toastMessage.createToastMessage(msg)
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
extension verifiy_password: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           view.endEditing(true)
           return false
       }
}
