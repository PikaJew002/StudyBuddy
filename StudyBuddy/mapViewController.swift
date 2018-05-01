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
    let locManager = CLLocationManager()
    var condition = ""
    var user: User = User()
    
    //to save the current filters
    var switches = [false, false, false] //0-subject, 1-time, 2-amount
    var filters = ["", ""]  //0-subject, 1-amount <- holds value of filters
    var timeFilter: Date?

    
    var cramJams: [CramJam] = []
    var locations: [Location] = []
    
    //map view that displays current CramJams and their locations
    @IBOutlet weak var cramJamMap: MKMapView!
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "toLocationView", sender: view)
    }
    
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
    /*
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            print(view.annotation!.title!) // annotation's title
            //Perform a segue here to navigate to another viewcontroller
            // On tapping the disclosure button you will get here
        }
    }
 */
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance, animated: Bool){ //centers map on location. I got this from https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        cramJamMap.setRegion(coordinateRegion, animated: animated)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        user = User()
        dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation = locations[locations.count - 1]
        centerMapOnLocation(location: curLocation, regionRadius: 500, animated: true)
    }
    
    @IBAction func toCreateCramJam(_ sender: Any) {
        
        performSegue(withIdentifier: "toCramCreate", sender: sender)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        user = (presentingViewController as! ViewController).user
        (presentingViewController as! ViewController).user = User()
        
        DataController.getData(table: "cram_jam", many: true, condition: condition) { data in
            do {
                let decoder = JSONDecoder()
                self.cramJams = try decoder.decode([CramJam].self, from: data!)
                DataController.getData(table: "location", many: true, condition: "", completion: { (data) in
                    do {
                        let decoder = JSONDecoder()
                        self.locations = try decoder.decode([Location].self, from: data!)
                        print("done")
                        DispatchQueue.main.async {
                            for l in self.locations {
                                let anno = LocationAnnotation(location: l)
                                self.cramJamMap.addAnnotation(anno)
                                print("added")
                            }
                        }
                    } catch let error {
                        print("location error: "+error.localizedDescription)
                    }
                })
            } catch let error {
                print("cram_jam error: "+error.localizedDescription)
                if String(decoding: data!, as: UTF8.self) == "{}" {
                    self.cramJams = []
                }
            }
        }
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
