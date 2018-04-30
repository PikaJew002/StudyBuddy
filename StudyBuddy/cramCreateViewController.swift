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
    
    // Need to connect picker view, and add stuff to it later.
    @IBAction func backToMapView(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        print(dateFormatter.string(from: startTime.date))
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func getData(table: String, condition: String, completion: @escaping (Bool)->()){
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=select&table=\(table)"
        if !condition.isEmpty {
            urlStr += "&condition=\(condition)"
        }
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                do {
                    let decoder = JSONDecoder()
                    if data != nil {
                        self.locations = try decoder.decode([Location].self, from: data!)
                        completion(true)
                    } else {
                        completion(false)
                    }
                } catch {
                    completion(false)
                }
            }).resume()
        } else {
            completion(false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // database query (getData) to get saved locations
        getData(table: "location", condition: "") { (success) in
            DispatchQueue.main.async {
                if success {
                    if self.locations.count == 0 {
                        self.locationPicker.isHidden = true
                        self.noLocationsLabel.isHidden = false
                    }
                } else {
                    print("An error occured when fetching locations")
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
