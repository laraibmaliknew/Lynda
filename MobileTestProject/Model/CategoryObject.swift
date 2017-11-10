//
//  CategoryObject.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation


class CategoryObject: NSObject {
    
    
    var category_id:Int=Int()
    var name:String=String()
    var status:String=String()
    var created_on:String=String()

    var staff:String=String()

    func InitWithDic(dict : NSDictionary) {
        
        
        
        //self.Pid = dict.value(forKey: "uid") as! Int
        
        self.category_id = Int(dict.value(forKey: "id") as! String)!
        self.name = dict.value(forKey: "name") as! String
        self.created_on = dict.value(forKey: "created_on") as! String
        if let status = dict.value(forKey: "status")
        {
            if status is String
            {
                self.status = status as! String
            }
        }

        
        if let staff = dict.value(forKey: "staff")
        {
            if staff is String
            {
                self.staff = staff as! String
            }
        }

    }
    
    
    
}



