//
//  MainViewController.swift
//  Testik
//
//  Created by Михаил Зайцев on 03.07.2021.
//

import UIKit

class MicrophoneVC: UIViewController {

    //MARK:- Properties
    private var recordingsViewController: RecordingsVC? {
        get {
            return children.compactMap({ $0 as? RecordingsVC }).first
        }
    }
    private var recorderViewController: RecorderVC? {
        get {
            return children.compactMap({ $0 as? RecorderVC }).first
        }
    }
    
    //MARK:- Outlets
    @IBOutlet weak var recordingsView: UIView!
    @IBOutlet weak var recorderView: UIView!
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let recorder = self.recorderViewController {
            recorder.delegate = self
        }
        if let recordings = self.recordingsViewController {
            recordings.delegate = self
        }

    }
    
    //MARK:- Actions
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension MicrophoneVC: RecorderViewControllerDelegate {
    func didStartRecording() {
        if let recordings = self.recordingsViewController {
            recordings.fadeView.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                recordings.fadeView.alpha = 1
            })
        }
    }
    
    func didFinishRecording() {
        if let recordings = self.recordingsViewController {
            recordings.view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.25, animations: {
                recordings.fadeView.alpha = 0
            }, completion: { (finished) in
                if finished {
                    recordings.fadeView.isHidden = true
                    DispatchQueue.main.async {
                        recordings.loadRecordings()
                    }
                }
            })
        }
    }
}

extension MicrophoneVC: RecordingsViewControllerDelegate {
    func didStartPlayback() {
        if let recorder = self.recorderViewController {
            recorder.fadeView.isHidden = false
            UIView.animate(withDuration: 0.25, animations: {
                recorder.fadeView.alpha = 1
            })
        }
    }
    
    func didFinishPlayback() {
        if let recorder = self.recorderViewController {
            recorder.view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.25, animations: {
                recorder.fadeView.alpha = 0
            }, completion: { (finished) in
                if finished {
                    recorder.fadeView.isHidden = true
                }
            })
        }
    }
}

