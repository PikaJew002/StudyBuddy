//
//  filterViewController.swift
//  StudyBuddy
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class filterViewController: UIViewController {
    
    @IBOutlet weak var amountSwitch: UISwitch!
    @IBOutlet weak var timeSwitch: UISwitch!
    @IBOutlet weak var subjectSwitch: UISwitch!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var SubjectTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    func filterString() -> String{  //returns a string containing a sql where statement
        var condition = ""
        if (subjectSwitch.isOn){  //user wants to filter by subject
            if (SubjectTextField != nil){
                    condition += "(subject = \"\(SubjectTextField.text!)\") AND "
                }
            }
        if (timeSwitch.isOn){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            condition += "(start_time <= CAST(\"\(dateFormatter.string(from: timePicker.date))\" AS DATETIME) AND end_time >= CAST(\"\(dateFormatter.string(from: timePicker.date))\" AS DATETIME)) AND "
        }
        if (amountSwitch.isOn){
            if (amountTextField.text != nil){
                condition += "(max_peeps <= \(amountTextField.text!)) AND "
            }
        }
        if !condition.isEmpty {
            condition.removeLast(5)
        }
        return condition
    }
    // this will dismiss the user's keyboard when typing
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    // These three functions are when the switchs are activated the filter text and labels are shown.
    @IBAction func showSubject(_ sender: UISwitch) {
        SubjectLabel.isHidden = !subjectSwitch.isOn
        SubjectTextField.isHidden = !subjectSwitch.isOn
    }
    
    @IBAction func showTime(_ sender: UISwitch) {
        timeLabel.isHidden = !timeSwitch.isOn
        timePicker.isHidden = !timeSwitch.isOn
    }
    
    @IBAction func showAmount(_ sender: UISwitch) {
        amountLabel.isHidden = !amountSwitch.isOn
        amountTextField.isHidden = !amountSwitch.isOn
    }
    //  goes back to the map view, and will send data pertaining to things we want to keep when we return to this view.
    @IBAction func backToMapView(_ sender: UIButton) {
        let mc = (presentingViewController as! mapViewController)
        mc.condition = filterString()
        print("HERE IT IS \(mc.condition)")
        //save filters
        mc.switches[0] = subjectSwitch.isOn
        mc.switches[1] = timeSwitch.isOn
        mc.switches[2] = amountSwitch.isOn
        if (subjectSwitch.isOn){
            if (SubjectTextField != nil){
                mc.filters[0] = SubjectTextField.text!
            }
        }
        if (timeSwitch.isOn){
            mc.timeFilter = timePicker.date
        }
        if (amountSwitch.isOn){
            if (amountTextField != nil){
                mc.filters[1] = amountTextField.text!
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    // this will set the switches to be on or off based on the information sent in the function above.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let mc = (presentingViewController as! mapViewController)
        subjectSwitch.isOn = mc.switches[0]
        timeSwitch.isOn = mc.switches[1]
        amountSwitch.isOn = mc.switches[2]
        timeLabel.isHidden = !mc.switches[1]
        timePicker.isHidden = !mc.switches[1]
        SubjectLabel.isHidden = !mc.switches[0]
        SubjectTextField.isHidden = !mc.switches[0]
        amountLabel.isHidden = !mc.switches[2]
        amountTextField.isHidden = !mc.switches[2]
        if (mc.switches[0]){    //subject filter is on
            SubjectTextField.text = mc.filters[0]
        }
        if (mc.switches[1]){
            timePicker.date = mc.timeFilter!
        }
        if (mc.switches[2]){
            amountTextField.text = mc.filters[1]
        }
    }
    //first time the switches will be turned off, and the labels and such will be hidden.
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectSwitch.setOn(false, animated: false)
        timeSwitch.setOn(false, animated: false)
        amountSwitch.setOn(false, animated: false)
        timeLabel.isHidden = true
        timePicker.isHidden = true
        SubjectLabel.isHidden = true
        SubjectTextField.isHidden = true
        amountLabel.isHidden = true
        amountTextField.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
