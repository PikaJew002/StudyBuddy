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
            (parent as! ViewController).getData(table: "user", condition: "email%20=%20%22\(username.text!)%22") { isValid in
                DispatchQueue.main.async {
                    if (self.parent as! ViewController).user.email.isEmpty {
                        
                        //self.dismiss(animated: true, completion: nil)
                    } else {
                        self.errorMessageLabel.text = "That user already exists!"
                    }
                }
            }
        } else {
            errorMessageLabel.text = "You have empty fields!"
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
