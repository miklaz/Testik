//
//  AccelerVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 20.06.2021.
//

import UIKit

class AccelerVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Shake your device"
        //dismissButton.alpha = 0
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            statusLabel.text = "Good, acceler works!"
            //dismissButton.alpha = 1
            print("shake")
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
