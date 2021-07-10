//
//  ButtonsVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 09.07.2021.
//

import UIKit
import AVFoundation

final class ButtonsVC: UIViewController {

    @IBOutlet var upVolumeLabel: UILabel!
    @IBOutlet var downVolumeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private var audioLevel : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenVolumeButton()
    }
    
    func listenVolumeButton() {
             
        let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true, options: [])
                audioSession.addObserver(self, forKeyPath: "outputVolume",
                                    options: NSKeyValueObservingOptions.new, context: nil)
                audioLevel = audioSession.outputVolume
            } catch {
                print("Error")
            }
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            let audioSession = AVAudioSession.sharedInstance()
            if audioSession.outputVolume > audioLevel {
                print("Up")
                upVolumeLabel.text = "👍"
            }
            if audioSession.outputVolume < audioLevel {
                print("Down:")
                downVolumeLabel.text = "👍"
            }
            audioLevel = audioSession.outputVolume
            print(audioSession.outputVolume)
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        self.dismiss(animated: true, completion: nil)
    }

}
