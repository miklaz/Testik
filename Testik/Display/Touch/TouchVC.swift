//
//  TouchVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 12.06.2021.
//


import UIKit

final class TouchVC: UIViewController {

    var canvas = CanvasTouch()
    
    @IBOutlet var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(canvas)
        canvas.backgroundColor = .orange
        canvas.frame = view.frame
        view.addSubview(dismissButton)
    }
    
    override var prefersStatusBarHidden: Bool {
         return true
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
