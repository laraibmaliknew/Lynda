//
//  AppDelegate.swift
//  MobileTestProject
//
//  Created by Arkhitech on 8/3/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import UIKit
extension UIViewController {
    func hideShowkeyboadMethods() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -60
        }

    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil) // this assumes your storyboard is titled "Main.storyboard"
        var status = false
        if let value = UserDefaults.standard.value(forKey: "msg_id")
        {
            if (value is Int)
            {
                status = true
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "StartCleaningViewController") as! StartCleaningViewController
                self.window?.rootViewController = controller     //  the move to the start cleaning vc
            }
            
        }
      if(!status)
      {
        if(UserDefaults.standard.bool(forKey:  "keepUserLoggedIn"))
        {
        //go to reporting view
            let reportVc = mainStoryboard.instantiateViewController(withIdentifier: "ReportSelectBreakageViewController") as! ReportSelectBreakageViewController // inside "YOUR_VC_IDENTIFIER" substitute the Storyboard ID you created in step 2 for the view controller you want to open here. And substitute YourViewController with the name of your view controller, like, for example, ViewController2.
            self.window?.rootViewController = reportVc
        }
        else{
        let signUpVc = mainStoryboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController // inside "YOUR_VC_IDENTIFIER" substitute the Storyboard ID you created in step 2 for the view controller you want to open here. And substitute YourViewController with the name of your view controller, like, for example, ViewController2.
        self.window?.rootViewController = signUpVc
        }
        }
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

