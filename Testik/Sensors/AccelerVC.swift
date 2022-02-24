//
//  AccelerVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 20.06.2021.
//

import UIKit

final class AccelerVC: UIViewController {

    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    
    // MARK: - Methods
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
    
    // MARK: - IBActions
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
