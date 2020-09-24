//
//  SelectDateVC.swift
//  Teer
//
//  Created by Mohamed Tahoon on 6/21/20.
//  Copyright © 2020 FudexEBS. All rights reserved.
//

import UIKit

class SelectDateVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectDatePopUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectDatePopUpView.layer.cornerRadius = 20
        selectDatePopUpView.layer.masksToBounds = true
    }
    

    var dateChoosed: String = ""
    @IBAction func onDoneBtnTapped(_ sender: Any) {
        let formatter = DateFormatter()
               
               let myLocale = NSLocale(localeIdentifier: "en_CA")
        formatter.locale = myLocale as Locale
        formatter.dateFormat = "YYYY-MM-dd"
        dateChoosed = formatter.string(from: datePicker.date)
        print("date formate ..............ffd",dateChoosed)
        CodeHelper.saveSelectedDate(selecteDate: dateChoosed)
        let view = UIStoryboard(name: "OrdersSearchByDate", bundle: nil).instantiateViewController(withIdentifier: "OrdersSearchByDateVC") as! OrdersSearchByDateVC
                      
               self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
