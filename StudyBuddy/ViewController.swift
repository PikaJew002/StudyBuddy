//
//  ViewController.swift
//  StudyBuddy
//
//  Created by student on 4/10/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var user: User = User()
    // This will check the database if the email matches the username and will allow access if so. otherwise it will send error messages.
    @IBAction func login(_ sender: UIButton) {
        if !username.text!.isEmpty && !password.text!.isEmpty {
            DataController.getData(table: "user", many: false, condition: "email = \"\(username.text!)\"") { (data) in
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        self.user = try decoder.decode(User.self, from: data!)
                        if self.password.text == self.user.password {
                            self.username.text = ""
                            self.password.text = ""
                            self.errorMessageLabel.text = ""
                            self.performSegue(withIdentifier: "toMapView", sender: self)
                        } else {
                            self.user = User()
                            self.password.text = ""
                            self.errorMessageLabel.text = "The password for that user is incorrect!"
                        }
                    } catch let error {
                        print("user error: "+error.localizedDescription)
                        if String(decoding: data!, as: UTF8.self) == "{}" {
                            self.user = User()
                            self.password.text = ""
                            self.username.text = ""
                            self.errorMessageLabel.text = "That user does not exist!"
                        } else {
                            print(String(decoding: data!, as: UTF8.self))
                        }
                    }
                }
            }
        } else {
            errorMessageLabel.text = "You have empty username or password fields!"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    //this will send the user to register.
    @IBAction func toRegistrationView(_ sender: UIButton) {
        user = User()
        performSegue(withIdentifier: "toRegistrationView", sender: self)
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

