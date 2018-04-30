//
//  AddLocationViewController.swift
//  StudyBuddy
//
//  Created by student on 4/30/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var locations: [Location] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    @IBAction func getLocation(_ sender: UIButton) {
        // get device lat and lon
        // with defined radius of what will be considered the same building,
        // create conditions to pass as "condition" in getData()
        // remmeber to code spaces as %20 and double quotes as %22
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
