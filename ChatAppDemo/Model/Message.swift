//
//  Message.swift
//  ChatAppDemo
//
//  Created by Bharat Khatke on 24/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import Foundation

class Message {
    //TODO: Message need a message body and a sender variable
    
    
    var sender: String   = ""
    var messageBody: String = ""
    
    init(sender: String, messageBody: String) {
        self.messageBody = messageBody
        self.sender      = sender
    }
   
    
    
}
/*
 
 func CreateUser(emailID: String, password: String, completion:  (_ isSuccess: Bool, _ userID: Int) -> Void)  {
 let isSuccess = true
 let userID = 123
 completion(isSuccess, userID)
 
 let message = Message()
 message.CreateUser(emailID: "Bharat", password: "1234567") { (isSuccess, userID) in
     print(isSuccess)
     print(userID)
 }
 }*/
