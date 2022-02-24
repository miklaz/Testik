//
//  AuthorizationVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 29.06.2021.
//

import UIKit
import LocalAuthentication

final class AuthorizationVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tapForTestButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusLabel.text = ""
    }
    
    // MARK: - IBActions
    @IBAction func touchID(_ sender: Any) {
        let context:LAContext = LAContext ()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We want to login with your finger print or face", reply: { (wasCorrrct, error) in
                if wasCorrrct {
                    print("Correct")
                    DispatchQueue.main.async {
                    self.statusLabel.text = "Good, TouchID/FaceID works!"
                    self.tapForTestButton.alpha = 0
                    }
                }
                else {
                    print("Incorrect")
                    DispatchQueue.main.async {
                    self.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :(  Maybe again?"
                    }
                }
            })
        }
        else {
            print ("Doesn't work")
            self.statusLabel.text = "Oops... it looks like TouchID/FaceID doesn't work :("
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
