//
//  ViewController.swift
//  iDev Social live
//
//  Created by Siraj Zaneer on 1/17/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordFIeld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onSignUp(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordFIeld.text!, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
    
    
    @IBAction func onLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordFIeld.text!, completion: { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "Ok", style: .cancel, handler: { (alert) in
                    
                    self.parent?.dismiss(animated: true, completion: {
                    })
                    
                })
                
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: { 
                    
                })
            } else {
                print("hi")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        })
    }
    

}

