//
//  HeadphonesSpeakVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 05.07.2021.
//

import UIKit
import AVFoundation

final class HeadphonesSpeakVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    let fakeSound = URL(fileURLWithPath: Bundle.main.path(forResource: "fakeSound2", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    var headphonesConnected: Bool = false  //to do
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusLabel.text = "Please connect your headphones!"
        playButton.alpha = 0
        setupNotifications()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fakeSound)
            audioPlayer.play()
        } catch {
            print("Couldn't load file :(")
        }
    }
    
    func setupNotifications() {
        // Get the default notification center instance.
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(handleRouteChange),
                       name: AVAudioSession.routeChangeNotification,
                       object: nil)
    }
    
    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
                return
        }
        
        // Switch over the route change reason.
        switch reason {

        case .newDeviceAvailable: // New device found.
            let session = AVAudioSession.sharedInstance()
            headphonesConnected = hasHeadphones(in: session.currentRoute)
            statusLabel.text = "Headphone plugged in!"
            playButton.alpha = 1
        
        case .oldDeviceUnavailable: // Old device removed.
            if let previousRoute =
                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                headphonesConnected = hasHeadphones(in: previousRoute)
                self.statusLabel.text = "Headphone pulled out!"
                playButton.alpha = 0
            }
        
        default: ()
        }
    }

    func hasHeadphones(in routeDescription: AVAudioSessionRouteDescription) -> Bool {
        // Filter the outputs to only those with a port type of headphones.
        return !routeDescription.outputs.filter({$0.portType == .headphones}).isEmpty
    }
    
    func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func play(_ sender: UIButton) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            showAlert("Couldn't load file :(")
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        self.dismiss(animated: true, completion: nil)
    }

}
