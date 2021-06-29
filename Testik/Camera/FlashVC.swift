//
//  FlashVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 29.06.2021.
//

import UIKit
import AVFoundation

final class FlashVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var torchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.text = "Light OFF"
    }
    
    func flashlight() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else{
            return
        }
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                    statusLabel.text = "Light OFF"
                    torchButton.setTitle("☼", for: .normal)
                }
                else {
                    device.torchMode = .on // ☼☀︎
                    statusLabel.text = "Light ON"
                    torchButton.setTitle("☀︎", for: .normal)
                }
                device.unlockForConfiguration()
            }
            catch {
                statusLabel.text = "Torch could not be used!"
                torchButton.alpha = 0
                print(error)
            }
        }
        else {
            statusLabel.text = "Torch is not available!"
            torchButton.alpha = 0
            print("Torch is not available")
        }
    }
    
    @IBAction func flashActive(_ sender: Any) {
        flashlight()
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else{
            return
        }
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == .on) {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            }
            catch {
                print(error)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    

}
