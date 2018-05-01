//
//  LocationViewController.swift
//  StudyBuddy
//
//  Created by student on 5/1/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var locations: [Location] = []
    var cramJams: [CramJam] = []
    var localCramJams: [CramJam] = []
    var curLocation: Location = Location()
    
    @IBOutlet weak var cramJamTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(localCramJams.count)
        return localCramJams.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cramJamItem")
        if indexPath.row == 0 {
            cell!.textLabel!.text = localCramJams[indexPath.section].host
        } else if indexPath.row == 1 {
            cell!.textLabel!.text = localCramJams[indexPath.section].subject
        } else if indexPath.row == 2 {
            cell!.textLabel!.text = localCramJams[indexPath.section].description
        } else if indexPath.row == 3 {
            cell!.textLabel!.text = localCramJams[indexPath.section].start_time
        } else if indexPath.row == 4 {
            cell!.textLabel!.text = localCramJams[indexPath.section].end_time
        } else if indexPath.row == 5 {
            cell!.textLabel!.text = String(localCramJams[indexPath.section].max_peeps)
        }
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLocationView" {
            let view = sender as! MKMarkerAnnotationView
            cramJams = (presentingViewController as! mapViewController).cramJams
            locations = (presentingViewController as! mapViewController).locations
            print("all cjs: "+String(cramJams.count))
            for cj in cramJams {
                if cj.location == (view.annotation as! LocationAnnotation).title {
                    localCramJams.append(cj)
                    print(localCramJams.count)
                }
            }
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
