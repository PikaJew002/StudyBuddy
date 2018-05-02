//
//  cramCreateViewController.swift
//  StudyBuddy
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class cramCreateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var cramDescription: UITextView!
    @IBOutlet weak var locationPicker: UIPickerView!
    @IBOutlet weak var noLocationsLabel: UILabel!
    @IBOutlet weak var maxAttendees: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // all locations, the currently selected location, and user that's logged in
    var locations: [Location] = []
    var location: Location = Location()
    var user: User = User()
    
    // creates new cramjam
    @IBAction func backToMapView(_ sender: UIButton) {
        sender.isEnabled = false
        // validate input
        // none of the fields are empty
        if !cramDescription.text!.isEmpty && !subject.text!.isEmpty && !maxAttendees.text!.isEmpty {
            // the end datetime is not before the start
            if startTime.date < endTime.date {
                if Int(maxAttendees.text!) != nil {
                    if Int(maxAttendees.text!)! > 0 {
                        let df = DateFormatter()
                        df.dateFormat = "yyyyMMddHHmmss"
                        DataController.putData(table: "cram_jam", values: [user.email, df.string(from: startTime.date), df.string(from: endTime.date), subject.text!, maxAttendees.text!, cramDescription.text!, location.name], columns: ["host", "start_time", "end_time", "subject", "max_peeps", "description", "location"], completion: { (didInsert) in
                            DispatchQueue.main.async {
                                if didInsert {
                                    sender.isEnabled = true
                                    self.errorMessageLabel.text = ""
                                    self.dismiss(animated: true, completion: nil)
                                } else {
                                    sender.isEnabled = true
                                    self.errorMessageLabel.text = "Database error!"
                                }
                            }
                        })
                    } else {
                        sender.isEnabled = true
                        errorMessageLabel.text = "Please enter an integer greater than 0 for \"Max Number of Attendees\""
                    }
                } else {
                    sender.isEnabled = true
                    errorMessageLabel.text = "Please enter a valid integer for \"Max Number of Attendees\""
                }
            } else {
                sender.isEnabled = true
                errorMessageLabel.text = "Please make sure the end date and time is after the start date and time!"
            }
        } else {
            sender.isEnabled = true
            errorMessageLabel.text = "Please make sure all fields are filled!"
        }
    }
    // cancel creating a cram jam
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // dismisses keyboard
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // specifies number of components in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // specifies numer of rows in the component
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    // sets the title for each row (location name)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row].name
    }
    // sets currently selected location
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        location = locations[row]
    }
    // copies data from presenting view controller to this view controller and queries for locations to populate the picker with
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date = Calendar.current.date(byAdding: Calendar.Component.hour, value: 1, to: Date(), wrappingComponents: true)
        endTime.setDate(date!, animated: false)
        user = (presentingViewController as! mapViewController).user
        // get users location data for computing distances
        // get all saved locations from database
        DataController.getData(table: "location", many: true, condition: "") { (data) in
            DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    self.locations = try decoder.decode([Location].self, from: data!)
                    self.location = self.locations[0]
                    self.locationPicker.isHidden = false
                    self.noLocationsLabel.isHidden = true
                    self.locationPicker.reloadAllComponents()
                } catch  let error {
                    if String(decoding: data!, as: UTF8.self) == "{}" {
                        self.locations = []
                        self.location = Location()
                        self.locationPicker.isHidden = true
                        self.noLocationsLabel.isHidden = false
                    } else {
                        print("JSON: "+String(decoding: data!, as: UTF8.self))
                        print("Swfit error: "+error.localizedDescription)
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
