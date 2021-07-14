//
//  DistanseVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 20.06.2021.
//

import UIKit

final class DistanсeVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Hold there until the test is comlite."
        activateProximitySensor()
    }

    func activateProximitySensor() {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChangedd(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
    }
    
    @objc func proximityChangedd(notification: NSNotification) {
        
        if let device = notification.object as? UIDevice {
            print("\(device.name) detected!")
            statusLabel.text = "Good, Proximity sensor works!"
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        _ = UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(self)
        self.dismiss(animated: true, completion: nil)
    }
    
}
