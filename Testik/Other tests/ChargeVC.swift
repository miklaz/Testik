//
//  ChargeVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import UIKit

final class ChargeVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Plug in the power cable and press the button"
    }
    
    func checkForCharging() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        if UIDevice.current.batteryState == .charging {
            statusLabel.text = "Okey, battery is charging!"
            statusLabel.textColor = .systemGreen
            checkButton.alpha = 0
        }
        else if UIDevice.current.batteryState == .unplugged {
            statusLabel.text = "Check the cable!"
            statusLabel.textColor = .systemYellow
        }
    }
    
    /*
    func activateCharge() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(chargeChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceBatteryStateDidChange"), object: nil)
        
    }
    
    @objc func chargeChanged(notification: NSNotification) {
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
    */
    
    @IBAction func CheckCargeButton(_ sender: Any) {
        checkForCharging()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        //NotificationCenter.default.removeObserver(self)
        UIDevice.current.isBatteryMonitoringEnabled = false
        self.dismiss(animated: true, completion: nil)
    }
    
}

