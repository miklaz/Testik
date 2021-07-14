//
//  CellularVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import UIKit

final class CellularVC: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var settingsButton: UIButton!
    
    var prefsURl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        settingsButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
        updateUserInterface()
    }
    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            statusLabel.text = "Cellular is turned off.\nPlease turn on cellular!"
            statusLabel.textColor = .systemRed
            prefsURl = "App-prefs:"
            settingsButton.setTitle("Open settings", for: .normal)
            settingsButton.alpha = 1
        case .wwan:
            statusLabel.text = "Cellular is working!"
            statusLabel.textColor = .systemGreen
            settingsButton.alpha = 0
        case .wifi:
            statusLabel.text = "Please turn off Wi-Fi!"
            statusLabel.textColor = .systemYellow
            prefsURl = "App-prefs:WIFI"
            settingsButton.setTitle("Open Wi-fi settings", for: .normal)
            settingsButton.alpha = 1
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func showAlertLocation (title: String, message:String?,url:URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func openSettingsAction(_ sender: Any) {
        showAlertLocation (title: "Open Settings?", message: "", url: URL(string: prefsURl))
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.removeObserver(self)
    }
    

  

}
