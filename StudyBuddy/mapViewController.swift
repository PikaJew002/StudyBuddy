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

class mapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    // location manager, current condition string, and user that's logged in
    let locManager = CLLocationManager()
    var condition = ""
    var user: User = User()
    
    //to save the current filters
    var switches = [false, false, false] //0-subject, 1-time, 2-amount
    var filters = ["", ""]  //0-subject, 1-amount <- holds value of filters
    var timeFilter: Date?

    // all locations
    var locations: [Location] = []
    // all locations and the cramjams being hosted there
    var cramJamsInLocation: [String: [CramJam]] = [:]
    
    //map view that displays current CramJams and their locations
    @IBOutlet weak var cramJamMap: MKMapView!
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "toLocationView", sender: view)
    }
    // this will send the cramjams at that location to the viewcontroller being presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLocationView" {
            let view = sender as! MKMarkerAnnotationView
            let vc = segue.destination as! LocationViewController
            vc.localCramJams = cramJamsInLocation[(view.annotation as! LocationAnnotation).title!]!
        } else {
            for anno in cramJamMap.annotations {
                cramJamMap.removeAnnotation(anno)
            }
        }
    }
    // this creates the mapView and adds a annotation view for each annotation.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anno = annotation as! LocationAnnotation
        
        let id = "location"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) {
            dequeuedView.annotation = anno
            view = dequeuedView as! MKMarkerAnnotationView
        } else {
            view = MKMarkerAnnotationView(annotation: anno, reuseIdentifier: id)
        }
        return view
    }
    // this will find the center of the location.
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance, animated: Bool){ //centers map on location. I got this from https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        cramJamMap.setRegion(coordinateRegion, animated: animated)
    }
    // logs the user out
    @IBAction func backToLogin(_ sender: Any) {
        user = User()
        (presentingViewController as! ViewController).user = User()
        dismiss(animated: true, completion: nil)
    }
    // this will get the users location and zoom in on the center.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation = locations[locations.count - 1]
        centerMapOnLocation(location: curLocation, regionRadius: 500, animated: true)
    }
    //sends the user to create cram jam view.
    @IBAction func toCreateCramJam(_ sender: Any) {
        
        performSegue(withIdentifier: "toCramCreate", sender: sender)
    }
    // grab all locations, and the locations with cramjams that match our filter conditions are given annotation and are put onto map.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = (presentingViewController as! ViewController).user
        DataController.getData(table: "location", many: true, condition: "", completion: { (data) in
            do {
                let decoder = JSONDecoder()
                self.locations = try decoder.decode([Location].self, from: data!)
                DispatchQueue.main.async {
                    for l in self.locations {
                        var realCondition = ""
                        if !self.condition.isEmpty {
                            realCondition = " AND \(self.condition)"
                        }
                        DataController.getData(table: "cram_jam", many: true, condition: "(location = \"\(l.name)\")\(realCondition)", completion: { (data) in
                            do {
                                let decoder = JSONDecoder()
                                self.cramJamsInLocation[l.name] = try decoder.decode([CramJam].self, from: data!)
                                let anno = LocationAnnotation(location: l)
                                self.cramJamMap.addAnnotation(anno)
                            } catch let error {
                                if String(decoding: data!, as: UTF8.self) == "{}" {
                                    self.cramJamsInLocation[l.name] = []
                                } else {
                                    print(error.localizedDescription)
                                    print("Page: "+String(decoding: data!, as: UTF8.self))
                                }
                            }
                        })
                    }
                }
            } catch let error {
                print("location error: "+error.localizedDescription)
                print("Page: "+String(decoding: data!, as: UTF8.self))
            }
        })
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
