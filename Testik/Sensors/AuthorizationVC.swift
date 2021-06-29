//
//  AuthorizationVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 29.06.2021.
//

import UIKit
import LocalAuthentication

final class AuthorizationVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tapForTestButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusLabel.text = ""
    }
    
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
    
    /*
    @IBAction func useBiometrics(sender: UIButton) {
            let context = LAContext()
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate to proceed.") { (success, error) in
                    if success {
                        DispatchQueue.main.async {
                            // Что-то сделать
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        guard let error = error else { return }
                        print(error.localizedDescription)
                    }
                }
            }
        }
*/
}
