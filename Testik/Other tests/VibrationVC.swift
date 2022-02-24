//
//  VibrationVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import UIKit
import AudioToolbox

final class VibrationVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Tap the button for check Vibration"
    }
    
    // MARK: - IBActions
    @IBAction func vibration(_ sender: Any) {
        statusLabel.text = "Okay, if you feel the vibration, then it works!"
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
