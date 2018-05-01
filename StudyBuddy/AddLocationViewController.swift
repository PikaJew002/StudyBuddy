//
//  AddLocationViewController.swift
//  StudyBuddy
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    var locations: [Location] = []
    
    @IBOutlet weak var locationName: UITextField!
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func addLocation(_ sender: UIButton) {
        let location = ((presentingViewController as! cramCreateViewController).presentingViewController as! mapViewController).locManager.location
        let lat = Decimal((location!.coordinate.latitude))
        let lon = Decimal((location!.coordinate.longitude))
        print("Name: \(locationName.text!), Lat: \(lat), Lon: \(lon)")
        DataController.putData(table: "location", values: [locationName.text!.replacingOccurrences(of: " ", with: "%20"), "\(lat)", "\(lon)"], columns: []) { (didInsert) in
            DispatchQueue.main.async {
                if didInsert {
                    //(self.presentingViewController as! cramCreateViewController).updateLocations()
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // throw error message
                    print("error!")
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
