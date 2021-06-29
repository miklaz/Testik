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
    
    
    /*
    func checkLocationEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            setupManager ()
            checkAutorization()        }
        else {
            showAlertLocation (title: "You have geolocation turned off", message: "Want to turn on?", url: URL(string: "App-Precfs:root=LOCATION_SERVICES"))
        }
    }
    
    func setupManager () {
        comppassLocationManager.delegate = self
        comppassLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkAutorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            //mapView.showsUserLocation = true
            comppassLocationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "You have banned the use of geolocation", message: "Want to change this?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            comppassLocationManager.requestWhenInUseAuthorization()
        @unknown default:
            print ("Oops...")
        }
    }
    
    func showAlertLocation (title: String, message:String?,url:URL?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
            if let url = url{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
 */

}

