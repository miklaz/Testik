//
//  WiFi_VC.swift
//  Testik
//
//  Created by Михаил Зайцев on 07.07.2021.
//

import UIKit

final class WiFi_VC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var wifiSettingsButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = ""
        wifiSettingsButton.alpha = 0
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
            statusLabel.text = "Wi-Fi is turned off.\nPlease turn on Wi-Fi and select network!"
            statusLabel.textColor = .systemRed
            wifiSettingsButton.alpha = 1
        case .wwan:
            statusLabel.text = "Please select a Wi-Fi network!"
            statusLabel.textColor = .systemYellow
            wifiSettingsButton.alpha = 1
        case .wifi:
            statusLabel.text = "Wi-Fi is working and connected!"
            statusLabel.textColor = .systemGreen
            wifiSettingsButton.alpha = 0
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
    
    func showAlertWiFiSettings (title: String, message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Open", style: .default) { (alert) in
            UIApplication.shared.open(URL(string: "App-prefs:WIFI")!)
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }

    // MARK: - IBActions
    @IBAction func openWiFiSettings(_ sender: Any) {
        showAlertWiFiSettings (title: "Open Wi-Fi Settings?", message: "")
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.removeObserver(self)
    }

}

