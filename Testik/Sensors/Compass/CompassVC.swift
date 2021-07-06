//
//  CompassVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 27.06.2021.
//

import UIKit
import CoreLocation

final class CompassVC: UIViewController, CLLocationManagerDelegate {

    let canvasView = CanvasCompassV()
    let comppassLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        canvasView.frame.size = CGSize(width: view.bounds.width, height: view.bounds.width)
        canvasView.center = view.center
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)
        
        super.viewDidLoad()
        
        comppassLocationManager.delegate = self
        comppassLocationManager.startUpdatingHeading()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let angle = newHeading.trueHeading * .pi / 180
        UIView.animate(withDuration: 0.5) {
            self.canvasView.transform = CGAffineTransform(rotationAngle: -CGFloat(angle)) //-CGFloat(angle)
        }
        
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        comppassLocationManager.stopUpdatingHeading()
        self.dismiss(animated: true, completion: nil)
    }

}

