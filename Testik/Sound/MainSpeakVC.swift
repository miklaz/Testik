//
//  MainSpeakVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 02.07.2021.
//

import UIKit
import AVFoundation

final class MainSpeakVC: UIViewController {
    
    // MARK: - Const, Var & Outlets
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.text = ""
    }
    
    func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - IBActions
    @IBAction func play(_ sender: UIButton) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            showAlert("Couldn't load file :(")
        }
        
        self.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
        self.info.alpha = 0
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
