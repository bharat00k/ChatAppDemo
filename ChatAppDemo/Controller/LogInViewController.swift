//
//  LogInViewController.swift
//  ChatAppDemo
//
//  Created by Bharat Khatke on 24/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

    }
    
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (authData, error) in
            
            if error != nil {
                print("There was a error while login")
            }else{
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChat" {
            _ = segue.destination as! ChatViewController
            
        }
    }

}
