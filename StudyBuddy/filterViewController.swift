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
    
    
    func filterString() -> String{
        var condition = ""
        if (subjectSwitch.isOn){  //user wants to filter by subject
            if (SubjectTextField != nil){
                    condition += "subject%20=%20%22\(SubjectTextField.text!)%22"
                }
            }
        if (timeSwitch.isOn){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddhhmmss"
            condition += "cast(%22\(dateFormatter.string(from: timePicker.date))%22%20as%20date)%20between%20start_time%20and%20end_time"
        }
        if (amountSwitch.isOn){
            if (amountTextField.text != nil){
                condition += "max_peeps%20<=%20\(amountTextField.text!)"
                }
        }
        return condition
    }
    
    
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
    
    @IBAction func backToMapView(_ sender: UIButton) {
        let mc = (presentingViewController as! mapViewController)
        mc.condition = filterString()
        //save filters
        mc.switches[0] = subjectSwitch.isOn
        mc.switches[1] = timeSwitch.isOn
        mc.switches[2] = amountSwitch.isOn
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let mc = (presentingViewController as! mapViewController)
        subjectSwitch.isOn = mc.switches[0]
        timeSwitch.isOn = mc.switches[1]
        amountSwitch.isOn = mc.switches[2]
    }
    
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
