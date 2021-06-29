//
//  Contrast&GammaVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 17.06.2021.
//

import UIKit

final class Contrast_GammaVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet var colorImage: UIImageView!
    
    let colorOpt = ["Contrast_iphone11", "Gradient_iphone11", "Gamma_iphone11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
    
    @IBAction func changeColor(_ sender: Any) {
        self.colorImage.image = UIImage(named: colorOpt[self.segmentControl.selectedSegmentIndex])
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
