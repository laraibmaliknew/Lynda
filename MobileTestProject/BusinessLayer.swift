//
//  BusinessLayer.swift
//  MobileTestProject
//
//  Created by Arkhitech on 8/3/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
class BusinessLayer
{

    static let sharedInstance : BusinessLayer = {
        let instance = BusinessLayer()
        return instance
    }()
    
    
    func makeUserSignUp(username : String , password : String , first_name : String , last_name : String , responseBlock : @escaping APIRequestResponseBlock) {
        
   
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        let paramsDict = ["username":username ,
                    "password": password,
                    "first_name": first_name,
                    "last_name": last_name,
                    ]
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>

        manager.post(Constants.signupUrl, parameters: paramsDict, progress: nil, success: { (URLSessionDataTask, responseObject) in
            if(((responseObject as! NSDictionary).value(forKey: "msg")) as! NSString == "Username Already Exists")
            {
                responseBlock("Username Already Exists",false,nil)

            }
            else
            {
                
            UserDefaults.standard.setValue(username, forKey: "user_name")
             UserDefaults.standard.synchronize()
            responseBlock(responseObject,true,nil)
            }

        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)

        })
    
    }
    
    
    func makeUserSignIn(username : String , password : String, responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>

        let paramsDict = ["username":username ,
                          "password": password,
                        ]
        
        manager.post(Constants.signInUrl, parameters: paramsDict, progress: nil, success: { (URLSessionDataTask, responseObject) in
            UserDefaults.standard.setValue(username, forKey: "user_name")
            UserDefaults.standard.synchronize()
            responseBlock(responseObject,true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }
    
    
    func getStaffsList(responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>
        
        manager.post(Constants.staffUrl, parameters: nil, progress: nil, success: { (URLSessionDataTask, responseObject) in
            
            let result:NSMutableArray = NSMutableArray()
            
            if(responseObject is NSDictionary)
            {
                
                
                let array:NSArray = (responseObject as! NSDictionary).object(forKey: "category") as! NSArray
                print(array)
                
                if(array.count>0)
                {
                    for obj in array
                    {
                        let categoryObject:CategoryObject = CategoryObject()
                        categoryObject.InitWithDic(dict: obj as! NSDictionary)
                        result.add(categoryObject)
                        
                    }
                }
                
            }
            responseBlock(result,true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }
    
    
    
    
    
    func getTagsList(responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>

        manager.post(Constants.tagsUrl, parameters: nil, progress: nil, success: { (URLSessionDataTask, responseObject) in
            
            let result:NSMutableArray = NSMutableArray()

            if(responseObject is NSDictionary)
            {
            
                
                let array:NSArray = (responseObject as! NSDictionary).object(forKey: "category") as! NSArray
                print(array)
                
                if(array.count>0)
                {
                    for obj in array
                    {
                        let categoryObject:CategoryObject = CategoryObject()
                        categoryObject.InitWithDic(dict: obj as! NSDictionary)
                        result.add(categoryObject)
                        
                    }
                }

            }
            responseBlock(result,true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }
    
    
    
    
    func getOptionList(tagId: Int ,  responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>

        let paramsDict = ["tag_id":tagId ,
                          ]

        
        manager.post(Constants.optionsUrl, parameters: paramsDict, progress: nil, success: { (URLSessionDataTask, responseObject) in
            
            let result:NSMutableArray = NSMutableArray()
            
            if(responseObject is NSDictionary)
            {
                
                
                let array:NSArray = (responseObject as! NSDictionary).object(forKey: "category") as! NSArray
                print(array)
                
                if(array.count>0)
                {
                    for obj in array
                    {
                        let categoryObject:CategoryObject = CategoryObject()
                        categoryObject.InitWithDic(dict: obj as! NSDictionary)
                        result.add(categoryObject)
                        
                    }
                }
                
            }
            responseBlock(result,true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }
    
        
       
    
    
    
    func submittedForm(rec_id:String,staff : String , cleaned :String , ad_notes:String, responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>
        
//        let paramsDict = ["tags":tags ,
//                          "user_id":user_id ,
//                          "staff":staff ,
//                          "suboption":suboption ,
//                          "cleaned":cleaned ,
//                          "ad_notes":ad_notes ,
//                          ]
   
        let paramsDict = [
                          "rec_id":rec_id ,
                          "staff":staff ,
                          "cleaned":cleaned ,
                          "ad_notes":ad_notes ,
                          ]
        
        
        
        
        
        manager.post(Constants.submitUrl, parameters: paramsDict, progress: nil, success: { (URLSessionDataTask, responseObject) in
            
            let result:NSMutableArray = NSMutableArray()
            
            print(responseObject)
            responseBlock(result,true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }

    
    
    
    func submittedTimeStamp(tags: String,user_id:String, suboption:String, responseBlock : @escaping APIRequestResponseBlock) {
        
        
        
        
        let manager:AFHTTPSessionManager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html") as? Set<String>
        
        let paramsDict = ["tags":tags ,
                          "user_id":user_id ,
                          "suboption":suboption ,
                          
                          ]
        
        
        manager.post(Constants.submitNewUrl, parameters: paramsDict, progress: nil, success: { (URLSessionDataTask, responseObject) in
            
            
            print(responseObject)
            responseBlock((responseObject as! NSDictionary).value(forKey: "msg"),true,nil)
            
        }, failure: { (URLSessionDataTask, responseObject) in
            responseBlock(responseObject,false,responseObject)
            
        })
        
    }
    


}
