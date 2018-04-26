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
        dismiss(animated: true, completion: nil)
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
