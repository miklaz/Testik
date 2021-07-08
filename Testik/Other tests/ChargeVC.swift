//
//  ChargeVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import UIKit

class ChargeVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var CheckButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
    }
    
    func checkForCharging() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        if UIDevice.current.batteryState == .charging {
            statusLabel.text = "Okey, battery is charging!"
            statusLabel.textColor = .systemGreen
            CheckButton.alpha = 0
        }
        else if UIDevice.current.batteryState == .unplugged {
            statusLabel.text = "Check the cable!"
            statusLabel.textColor = .systemYellow
        }
    }
    
    @IBAction func CheckCargeButton(_ sender: Any) {
        checkForCharging()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        UIDevice.current.isBatteryMonitoringEnabled = false
        self.dismiss(animated: true, completion: nil)
    }
    
}

