//
//  mapViewController.swift
//  StudyBuddy
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class mapViewController: UIViewController, CLLocationManagerDelegate{
    let locManager = CLLocationManager()
    var locations: [String: Location] = [:]
    var condition = ""
    var user: User = User()
    
    var cramJams: [CramJam] = []
    
    //map view that displays current CramJams and their locations
    @IBOutlet weak var cramJamMap: MKMapView!
    
    func getLocations(){
        for cj in cramJams{
            var cjLocation = Location()
            DataController.getData(table: "location", many: false, condition: "name = \(cj.location)", completion: { (data) in
                 DispatchQueue.main.async {
                    do{
                        let decoder = JSONDecoder()
                        cjLocation = try decoder.decode(Location.self, from: data!)
                        self.locations[cjLocation.name] = cjLocation
                        } catch {
                            //jk ... for now
                            }
                    }
                })
            }
        }
    
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance){ //centers map on location. I got this from https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        cramJamMap.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        user = User()
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation = locations[locations.count - 1]
        centerMapOnLocation(location: curLocation, regionRadius: 500)
    }
    
    @IBAction func toCreateCramJam(_ sender: Any) {
        
        performSegue(withIdentifier: "toCramCreate", sender: sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataController.getData(table: "cram_jam", many: true, condition: condition) { data in
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    self.cramJams = try decoder.decode([CramJam].self, from: data!)
                } catch {
                    if String(decoding: data!, as: UTF8.self) == "{}" {
                        self.cramJams = []
                    }
                }
            }
        }
        
        getLocations()
        for l in locations{
            let coord = CLLocationCoordinate2D(latitude: CLLocationDegrees((l.value.lat as NSDecimalNumber).doubleValue), longitude: CLLocationDegrees((l.value.lon as NSDecimalNumber).doubleValue))
            let anno = MKPointAnnotation()
            anno.coordinate = coord
            cramJamMap.addAnnotation(anno)
        }
        
        
        user = (presentingViewController as! ViewController).user
        (presentingViewController as! ViewController).user = User()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //centerMapOnLocation(location: initialLocation)    //testing
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.distanceFilter = 25 //number of meters user must move before the map updates
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
