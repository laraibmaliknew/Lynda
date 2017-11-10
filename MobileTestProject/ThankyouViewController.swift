//
//  ThankyouViewController.swift
//  LydiaApp
//
//  Created by Arkhitech on 17/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
class ThankyouViewController : UIViewController
{

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let when = DispatchTime.now() + 5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.performSegue(withIdentifier: "ThankyouToSelectBreakageVC", sender: self)
        }

    }


}
