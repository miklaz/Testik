//
//  RGB_VC.swift
//  Testik
//
//  Created by Михаил Зайцев on 12.06.2021.
//

import UIKit

class RGB_VC: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var hideItems: UILabel!
    
    
    let colorOpt = [UIColor.red, UIColor.green, UIColor.blue]
    let colorOptItem = [UIColor.white, UIColor.black, UIColor.white]
    var isBleach = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.colorView.addGestureRecognizer(tapGestureRecognizer)
        //UIApplication.shared.isStatusBarHidden = true
        
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
    
    @objc func handleTap() {
        self.isBleach = !self.isBleach
        self.segmentControl.alpha = self.isBleach ? 0 : 1.0
        self.dismissButton.alpha = self.isBleach ? 0 : 1.0
        self.hideItems.alpha = self.isBleach ? 0 : 1.0
    }
    
    @IBAction func changeColor(_ sender: Any) {
        self.colorView.backgroundColor = colorOpt[self.segmentControl.selectedSegmentIndex]
        //self.segmentControl.tintColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        self.hideItems.textColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        self.dismissButton.tintColor = colorOptItem[self.segmentControl.selectedSegmentIndex]
        //self.dismissButton.tintColor = colorOpt[self.segmentControl.selectedSegmentIndex]
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
