//
//  RegisterViewController.swift
//  ChatAppDemo
//
//  Created by Bharat Khatke on 24/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        //Set up new user on our firebase database
        
        Auth.auth().createUser(withEmail: emailTextfield.text ?? "", password: passwordTextfield.text!) { (authDataResult, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Connection Issue")
            }else {
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
