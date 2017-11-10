//
//  User.swift
//  Profit Notifier
//
//  Created by Arkhitech on 03/07/2017.
//  Copyright © 2017 Azeem. All rights reserved.
//


import UIKit
class UserObject: NSObject {
    

    var user_name:String=String()
    var password:String=String()

    static var sharedUser:UserObject?
    
    static func currentUser() -> UserObject {
        
    
       
        if sharedUser == nil{
            sharedUser = UserObject()
        }
        return sharedUser!;
    }
    
    func InitWithValue(user_name :String , password: String) {
        
        
        
            //self.Pid = dict.value(forKey: "uid") as! Int

        self.user_name = user_name
        self.password = password
        let ecoder = NSMutableDictionary()
        self.encodeWithCoder(encoder: ecoder)
        
        
    }
    
    static func sharedInstance() -> UserObject {
        
        if(sharedUser == nil )
        {
          sharedUser = UserObject.currentUser()
        }
        
        return sharedUser!
        
        
    }

    
    func encodeWithCoder(encoder:NSMutableDictionary)
    {
    
        encoder.setValue(user_name, forKey: "user_name")
        encoder.setValue(password, forKey: "password")
        
        let defaults:UserDefaults = UserDefaults.standard

        
        defaults.set(encoder, forKey: "user")
        
        
      
        
    }
    
    

  }
