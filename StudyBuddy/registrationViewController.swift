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
            self.putData(table: "user", values: [self.email.text!, self.firstName.text!, self.lastName.text!, self.password.text!, self.username.text!], completion: { (didComplete) in
                if didComplete {
                    DispatchQueue.main.async {
                        self.email.text = ""
                        self.firstName.text = ""
                        self.lastName.text = ""
                        self.password.text = ""
                        self.username.text = ""
                        self.errorMessageLabel.text = ""
                        (self.presentingViewController as! ViewController).errorMessageLabel.text = "User successfully created!"
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.email.text = ""
                        self.errorMessageLabel.text = "A user with that email already exists!"
                    }
                }
            })
        } else {
            errorMessageLabel.text = "You have empty fields!"
        }
    }
    
    func putData(table: String, values: [String], completion: @escaping (Bool)->()) {
        let id = "21232f297a57a5a743894a0e4a801fc3"
        var urlStr = "http://baruchhaba.org/StudyBuddy/query.php?id=\(id)&type=insert&table=\(table)&values="
        for i in 0 ... values.count - 2 {
            urlStr += "%22\(values[i])%22%2C%20"
        }
        urlStr += "%22\(values[values.count - 1])%22"
        print(urlStr)
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                let dataStr = String(decoding: data!, as: UTF8.self)
                print(dataStr)
                if Int(dataStr) == 1 {
                    completion(true)
                } else {
                    completion(false)
                }
            }).resume()
        } else {
            completion(false)
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
