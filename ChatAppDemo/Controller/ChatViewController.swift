//
//  ChatViewController.swift
//  ChatAppDemo
//
//  Created by Bharat Khatke on 24/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    // Declare instance variables here
    var messageArray: [Message] = [Message] ()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true
        
        
        //TODO: Set yourself as the delegate of the text field here:
        self.messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTap))
        
        messageTableView.addGestureRecognizer(tapGesture)
        //TODO: Register your MessageCell.xib file here:
        
        messageTableView.register(UINib(nibName: "MessageTableCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
       
        
        configureTablevIew()
        retriveMessageData()
    }
  
   
    //MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! MessageTableCell
       
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email  {
            cell.messageBody.textColor = UIColor.flatGray()
            cell.messageBackground.backgroundColor = UIColor.flatWhite()
            cell.avatarImageView.backgroundColor   = UIColor.flatMint()
            
        }else{
            cell.messageBody.textColor = UIColor.flatWhite()
            cell.messageBackground.backgroundColor = UIColor.flatGreen()
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
        }
        
        
        return cell
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTablevIew() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func tableViewTap()  {
        messageTextfield.endEditing(true)
    }
    
    
    //MARK: - Send & Recieve from Firebase

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled       = false
        
        let messageDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextfield.text!]
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            if error != nil {
                print(error?.localizedDescription ?? "Not Found")
            }else {
                print("Message saved successfully!")
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled       = true
                self.messageTextfield.text      = ""
            }
        }
        
    }
    
    //MARK:- Create the retrieveMessages method here:
    func retriveMessageData()  {

        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapShot) in
            
            if let snapShotValue = snapShot.value as? Dictionary<String, String> {
                let messageText   = snapShotValue["MessageBody"]
                let sender        = snapShotValue["Sender"]
                
                let messageObj = Message(sender: sender ?? "", messageBody: messageText ?? "")
                
                self.messageArray.append(messageObj)
                self.messageTableView.reloadData()
            }
        }
    }
    
    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToYourViewController(ofClass: WelcomeViewController.self, animated: true)
        } catch  {
            print("There was a problem in sign out")
        }
        
        
    }

}
