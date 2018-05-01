//
//  registrationViewController.swift
//  StudyBuddy
//
//  Created by student on 4/12/18.
//  Copyright © 2018 cs@eku.edu. All rights reserved.
//

import UIKit

class registrationViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBAction func backToLogin(_ sender: UIButton) {
        if !firstName.text!.isEmpty && !lastName.text!.isEmpty && !email.text!.isEmpty && !username.text!.isEmpty && !password.text!.isEmpty {
            DataController.putData(table: "user", values: [email.text!, firstName.text!, lastName.text!, password.text!, username.text!], columns: [], completion: { (didInsert) in
                DispatchQueue.main.async {
                    if didInsert {
                        self.email.text = ""
                        self.firstName.text = ""
                        self.lastName.text = ""
                        self.password.text = ""
                        self.username.text = ""
                        self.errorMessageLabel.text = ""
                        (self.presentingViewController as! ViewController).errorMessageLabel.text = "User successfully created!"
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.email.text = ""
                        self.errorMessageLabel.text = "A user with that email already exists!"
                    }
                }
            })
        } else {
            errorMessageLabel.text = "You have empty fields!"
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
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
