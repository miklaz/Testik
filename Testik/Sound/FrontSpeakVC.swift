//
//  FrontSpeakVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 02.07.2021.
//

import UIKit
import AVFoundation

final class FrontSpeakVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateProximitySensor(isOn: true)
        self.statusLabel.text = "Bring your iPhone to your ear"
    }
    
    func activateProximitySensor(isOn: Bool) {
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = isOn
        if isOn {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: device)
            let session = AVAudioSession.sharedInstance()
            do{
                try session.setCategory(.playAndRecord)
                try session.setActive(true)
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                print ("\(#file) - \(#function) error: \(error.localizedDescription)")
            }
        } else {
            NotificationCenter.default.removeObserver(self, name: UIDevice.proximityStateDidChangeNotification, object: device)
        }
    }

    @objc func proximityStateDidChange(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device.name) detected!")
            let session = AVAudioSession.sharedInstance()
            do{
                let routePort: AVAudioSessionPortDescription? = session.currentRoute.outputs.first
                let portType = routePort?.portType
                if let type = portType, type.rawValue == "Receiver" {
                    try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                } else {
                    try session.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
                        audioPlayer.play()
                        self.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
                    } catch {
                        showAlert("Couldn't load file :(")
                    }
                    
                }
            } catch {
                print ("\(#file) - \(#function) error: \(error.localizedDescription)")
            }
            
        }
    }
    
    func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        _ = UIDevice.current.isProximityMonitoringEnabled = false
        self.dismiss(animated: true, completion: nil)
    }

}
