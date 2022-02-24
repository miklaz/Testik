//
//  AmbientLightSensorVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 26.06.2021.
//

import UIKit

final class AmbientLightSensorVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    let lightStartStatus = UIScreen.main.brightness
    
    // MARK: - Methods
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onScreenBrightnessChanged(_:)), name: UIScreen.brightnessDidChangeNotification, object:nil)
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        statusLabel.text = "Hold there until the test is comlite."
        addObservers()
    }

    @objc func onScreenBrightnessChanged(_ sender: Notification) {
        if (UIScreen.main.brightness < lightStartStatus) == true || (UIScreen.main.brightness > lightStartStatus) == true //0...1
        {
            statusLabel.text = "Good, ambient light sensor works!"
        }
        else {
            statusLabel.text = "Hold there until the test is comlite."
        }
        
    }
    
    deinit {
        removeObservers()
    }
    
    // MARK: - IBActions
    @IBAction func dismissAction(_ sender: Any) {
        _ = UIDevice.current.isProximityMonitoringEnabled = false
        self.dismiss(animated: true, completion: nil)
    }
}
