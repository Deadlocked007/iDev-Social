//
//  ViewController.swift
//  iDev Social
//
//  Created by Siraj Zaneer on 12/31/16.
//  Copyright © 2016 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onSignUp(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Yay")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        })
    }

    @IBAction func onLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Yay")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
}

