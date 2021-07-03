//
//  MSpeakVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 02.07.2021.
//

import UIKit
import AVFoundation

class MSpeakVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var info: UILabel!
    
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "testSound2", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    @IBAction func Play(_ sender: UIButton) {
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            print("couldn't load file :(")
        }
        
        self.statusLabel.text = "Okay, if you heard the sound, then the main speaker works!"
        self.info.alpha = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusLabel.text = ""
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
