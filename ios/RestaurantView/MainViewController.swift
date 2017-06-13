//
//  MainViewController.swift
//  RestaurantView
//
//  Created by Binh Nguyen on 6/12/17.
//  Copyright © 2017 Binh Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var searchName: UITextField!
    @IBOutlet weak var searchLocation: UITextField!
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    @IBAction func searchButton(_ sender: Any) {
        if (searchName == nil || searchLocation == nil) {
            let status = CLLocationManager.authorizationStatus()
            
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                return
            }
            
            if status == .denied || status == .restricted {
                let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                
                present(alert, animated: true, completion: nil)
                return
            }
            
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
        
        performSegue(withIdentifier: "segueSearch", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        startLocation = nil
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var restCollectionVC = segue.destination as! RestaurantCollectionViewController
        restCollectionVC.name = searchName.text!
        restCollectionVC.location = searchLocation.text!
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        searchName.text = String(describing: currentLocation?.coordinate.latitude)
        searchLocation.text = String(describing: currentLocation?.coordinate.longitude)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
