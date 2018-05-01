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
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addLocation(_ sender: UIButton) {
        let location = ((presentingViewController as! cramCreateViewController).presentingViewController as! mapViewController).locManager.location
        let lat = Decimal((location!.coordinate.latitude))
        let lon = Decimal((location!.coordinate.longitude))
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
