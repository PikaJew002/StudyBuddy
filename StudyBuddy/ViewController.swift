//
//  ViewController.swift
//  StudyBuddy
//
//  Created by student on 4/10/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

struct User: Codable {
    var email: String
    var first_name: String
    var last_name: String
    var password: String
    var username: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user: User = User(email: "", first_name: "", last_name: "", password: "", username: "")
    
    @IBAction func login(_ sender: UIButton) {
        if !username.text!.isEmpty && !password.text!.isEmpty {
            // select * from user where email = $email
            if getData() {
                performSegue(withIdentifier: "toMapView", sender: self)
            }
        }
    }
    
    func getData() -> Bool {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        let urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=select&table=user&condition=email%20=%20%22\(username.text!)%22"
        if let url = URL(string: urlStr) {
            var success = false
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                do {
                    let decoder = JSONDecoder()
                    if data != nil {
                        self.user = try decoder.decode(User.self, from: data!)
                        print("success!")
                        print("Email: "+self.user.email)
                        success = true
                    }
                } catch {
                    
                }
            }).resume()
            return success
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

