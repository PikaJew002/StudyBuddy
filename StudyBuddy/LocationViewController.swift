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
    //this sets the number of rows based on the data we collected during the create cram jam view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    //these initiate the tables with how many cram jams are within an annotation.
    func numberOfSections(in tableView: UITableView) -> Int {
        return localCramJams.count
    }
    //this is the title for the section.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "CramJam"
    }
    //these will set the titles based on the information about the cram jams, and the details on the row column in our database.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cramJamItem")
        if indexPath.row == 0 {
            cell!.textLabel!.text = localCramJams[indexPath.section].host
            cell!.detailTextLabel!.text = "Host"
        } else if indexPath.row == 1 {
            cell!.textLabel!.text = localCramJams[indexPath.section].subject
            cell!.detailTextLabel!.text = "Subject"
        } else if indexPath.row == 2 {
            cell!.textLabel!.text = localCramJams[indexPath.section].description
            cell!.detailTextLabel!.text = "Description"
        } else if indexPath.row == 3 {
            cell!.textLabel!.text = localCramJams[indexPath.section].start_time
            cell!.detailTextLabel!.text = "Start Time"
        } else if indexPath.row == 4 {
            cell!.textLabel!.text = localCramJams[indexPath.section].end_time
            cell!.detailTextLabel!.text = "End Time"
        } else if indexPath.row == 5 {
            cell!.textLabel!.text = String(localCramJams[indexPath.section].max_peeps)
            cell!.detailTextLabel!.text = "Max Amount of Atendees"
        }
        return cell!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
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
