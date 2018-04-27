//
//  ViewController.swift
//  StudyBuddy
//
//  Created by student on 4/10/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

struct User: Codable {
    var email: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var password: String = ""
    var username: String = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var user: User = User()
    
    @IBAction func login(_ sender: UIButton) {
        if !username.text!.isEmpty && !password.text!.isEmpty {
            // select * from user where email = $email
            getData(table: "user", condition: "email%20=%20%22\(username.text!)%22") { isValid in
                if isValid {
                    // DispatchQueue.main.async {}, might need to put all UI updates in this after boolean check on isValid
                    if self.password.text == self.user.password {
                        self.username.text = ""
                        self.password.text = ""
                        self.performSegue(withIdentifier: "toMapView", sender: self)
                    } else {
                        user = User()
                        self.password.text = ""
                        self.errorMessageLabel.text = "The password for that user is incorrect!"
                    }
                } else {
                    user = User()
                    self.password.text = ""
                    self.username.text = ""
                    self.errorMessageLabel.text = "That user does not exist!"
                }
            }
        } else {
            errorMessageLabel.text = "You have empty username or password fields!"
        }
    }
    
    @IBAction func toRegistrationView(_ sender: UIButton) {
        user = User(email: "", first_name: "", last_name: "", password: "", username: "")
        performSegue(withIdentifier: "toRegistrationView", sender: self)
    }
    
    func getData(table: String, condition: String, completion: @escaping (Bool)->()) {
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
                        self.user = try decoder.decode(User.self, from: data!)
                        if !self.user.email.isEmpty {
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                } catch {
                    completion(false)
                }
            }).resume()
        } else {
            completion(false)
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

