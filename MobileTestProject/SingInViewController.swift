//
//  SingInViewController.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
class SingInViewController : UIViewController
{

    @IBOutlet var userNameTextField : UITextField!
    @IBOutlet var paswordNameTextField : UITextField!
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    var shouldStaySignIn = false

    override func viewDidLoad() {
        super.viewDidLoad()

        Constants.styleUpTextField(textFied: userNameTextField, message: "User Name")
        Constants.styleUpTextField(textFied: paswordNameTextField, message: "Password")
        self.loadingIndicator.isHidden = true
        self.hideShowkeyboadMethods()
        
    }
    
    
    @IBAction func signInButtonAction(sender : UIButton)
    {
        
        
        if((paswordNameTextField.text?.characters.count)! <= 0)
        {
            self.showAlertMessage(error: "Password cananot be empty")
            return
        }
        
        
        if((userNameTextField.text?.characters.count)! <= 0)
        {
            self.showAlertMessage(error: "User Name cananot be empty")
            return
        }
        
        
        
        loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        
          BusinessLayer.sharedInstance.makeUserSignIn(username: self.userNameTextField.text!, password: self.paswordNameTextField.text!) { (result, status, error) in
            self.loadingIndicator.stopAnimating()
            
            if(error == nil)
            {
                if(self.shouldStaySignIn)
                {
                    UserDefaults.standard.set(true, forKey: Constants.keepUserLoggedIn)
                    UserDefaults.standard.synchronize()
                }

                self.goToNextView()
            }
            else
            {
                self.showAlertMessage(error: (error?.localizedDescription)!)
                
            }
            
        }
    }
    
    func showAlertMessage(error : String)
    {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToNextView() {
        //SigninToReportingView
        //ReportToSelectBreakageVC
        self.performSegue(withIdentifier: "SignInToSelectBreakageVC", sender: self)
    }

    @IBAction func staySignInButtonAction(sender : UIButton)
    {
        shouldStaySignIn = !shouldStaySignIn
        
        if(shouldStaySignIn )
        {
            sender.setTitle("✓", for: .normal)
        }
        else
        {
            sender.setTitle("", for: .normal)
            
        }
    }

}
