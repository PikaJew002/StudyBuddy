//
//  cramCreateViewController.swift
//  StudyBuddy
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class cramCreateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var cramDescription: UITextView!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var noLocationsLabel: UILabel!
    @IBOutlet weak var maxAttendees: UITextField!
    
    var locations: [Location] = []
    var location: Location = Location()
    
    // Need to connect picker view, and add stuff to it later.
    // ^ I did that - AE
    @IBAction func backToMapView(_ sender: UIButton) {
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyyMMddHHmmss"
        //print(dateFormatter.string(from: startTime.date))
        
        // validate input
        if !cramDescription.text.isEmpty {
            
        } else {
            
        }
        
        // put data
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        location = locations[row]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Calendar.current.date(byAdding: Calendar.Component.hour, value: 1, to: Date(), wrappingComponents: true)
        endTime.setDate(date!, animated: false)
        // get users location data for computing distances
        updateLocations()
        // get all saved locations from database
        DataController.getData(table: "location", condition: "") { (data) in
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    self.locations = try decoder.decode([Location].self, from: data!)
                    self.location = self.locations[0]
                    self.locationPicker.isHidden = false
                    self.noLocationsLabel.isHidden = true
                    if self.locations.count > 0 {
                        for i in 0 ... self.locations.count - 1 {
                            print("Name: \(self.locations[i].name)")
                        }
                    } else {
                        print("No locations loaded")
                    }
                    self.locationPicker.reloadAllComponents()
                } catch {
                    if String(decoding: data!, as: UTF8.self) == "{}" {
                        print("errorrrrr")
                        self.locations = []
                        self.location = Location()
                        self.locationPicker.isHidden = true
                        self.noLocationsLabel.isHidden = false
                    } else {
                        print("nope")
                        print(String(decoding: data!, as: UTF8.self))
                    }
                }
            }
        }
    }
    
    func updateLocations() {
        // get all saved locations from database
        DataController.getData(table: "location", condition: "") { (data) in
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    self.locations = try decoder.decode([Location].self, from: data!)
                    self.location = self.locations[0]
                    self.locationPicker.isHidden = false
                    self.noLocationsLabel.isHidden = true
                    if self.locations.count > 0 {
                        for i in 0 ... self.locations.count - 1 {
                            print("Name: \(self.locations[i].name)")
                        }
                    } else {
                        print("No locations loaded")
                    }
                    self.locationPicker.reloadAllComponents()
                } catch {
                    if String(decoding: data!, as: UTF8.self) == "{}" {
                        print("errorrrrr")
                        self.locations = []
                        self.location = Location()
                        self.locationPicker.isHidden = true
                        self.noLocationsLabel.isHidden = false
                    }
                }
            }
        }
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
