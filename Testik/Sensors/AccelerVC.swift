//
//  AccelerVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 20.06.2021.
//

import UIKit

final class AccelerVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "Shake your device"
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
            print("shake")
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
