//
//  Constants.swift
//  MobileTestProject
//
//  Created by Arkhitech on 8/3/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
class Constants {
    static let staffUrl = "http://todonerd.com/app_admin/staff.php"
    static let signupUrl =  "http://todonerd.com/app_admin/signup.php"
    static let signInUrl =  "http://todonerd.com/app_admin/signin.php"//
    static let tagsUrl =  "http://todonerd.com/app_admin/tags.php"//
    static let optionsUrl =  "http://todonerd.com/app_admin/option.php"//
    static let submitUrl =  "http://todonerd.com/app_admin/submit.php"//
    static let submitNewUrl  = "http://todonerd.com/app_admin/n_submit.php"
    static let keepUserLoggedIn = "keepUserLoggedIn"
    
    static func styleUpTextField (textFied : UITextField , message : String)
    {
        textFied.attributedPlaceholder = NSAttributedString(string: message,
                                                               attributes: [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0)])
    
    }
}
