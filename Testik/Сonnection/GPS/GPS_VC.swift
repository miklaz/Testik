//
//  GPS_VC.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import UIKit
import MapKit

final class GPS_VC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var noButton: UIButton!
    //@IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.text = "You are here?"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    func checkLocationEnabled () {
        if CLLocationManager.locationServicesEnabled() {
            setupManager ()
            checkAutorization()        }
        else {
            showAlertLocation (title: "You have geolocation turned off", message: "Want to turn on?", url: URL(string: "App-prefs:LOCATION_SERVICES"))
        }
    }
    
    func setupManager () {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkAutorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "You have banned the use of geolocation", message: "Want to change this?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
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
    
    @IBAction func yesAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func noAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}

