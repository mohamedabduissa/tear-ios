//
//  TermsAndConditions.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/16/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit
import MOLH
class TermsAndConditions: UIViewController ,TermsAndConditionsProtocol{
    
    @IBOutlet weak var backBtnImage: UIButton!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    
    let presenter = TermsAndConditionsPresenter(termsAndConditionsModel: TermsAndConditionsModel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.termsAndConditions()
        presenter.setVCDelegate(vcDelegate: self)
        if  MOLHLanguage.isArabic(){
               self.backBtnImage.transform = self.backBtnImage.transform.rotated(by: CGFloat(Double.pi))
            termsAndConditionsLabel.textAlignment = .right
        }
    }
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)

//       let view = UIStoryboard(name: "DeliveryStatus", bundle: nil).instantiateViewController(withIdentifier: "Home") as! DeliveryStatusViewController
//        self.present(view, animated: true, completion: nil)
    }
    func showError(msg: String) {
        
    }
    
    func termsAndConditions(data: String) {
        
        termsAndConditionsLabel.text = data
    }
    
}
