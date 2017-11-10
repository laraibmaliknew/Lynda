//
//  SignUpViewControllera.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
// Put this piece of code anywhere you like

class SignUpViewController : UIViewController
{

    @IBOutlet var firstNameTextField : UITextField!
    @IBOutlet var lastNameTextField : UITextField!
    @IBOutlet var userNameTextField : UITextField!
    @IBOutlet var paswordNameTextField : UITextField!
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet var scrollView : UIScrollView!

    var shouldStaySignIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        Constants.styleUpTextField(textFied: firstNameTextField, message: "First Name")
        Constants.styleUpTextField(textFied: lastNameTextField, message: "Last Name")
        Constants.styleUpTextField(textFied: userNameTextField, message: "User Name")
        Constants.styleUpTextField(textFied: paswordNameTextField, message: "Password")
        self.loadingIndicator.isHidden = true
        self.hideShowkeyboadMethods()
        
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
     //   handleViewRotaion(orientation: toInterfaceOrientation)
    }
    
    //MARK: - Rotation controls
    
    func handleViewRotaion(orientation:UIInterfaceOrientation) -> Void {
        switch orientation {
        case .portrait :
            print("portrait view")
             scrollView.contentSize = CGSize(width: 0 , height:  UIScreen.main.bounds.size.width)
            break
        case .portraitUpsideDown :
            
             scrollView.contentSize = CGSize(width: 0, height: UIScreen.main.bounds.size.width)
            print("portraitUpsideDown view")
            break
        case .landscapeLeft :
            print("landscapeLeft view")
             scrollView.contentSize = CGSize(width: 0, height:  UIScreen.main.bounds.size.height + 250)
            break
        case .landscapeRight :
            print("landscapeRight view")
             scrollView.contentSize = CGSize(width: 0, height:  UIScreen.main.bounds.size.height + 250)
            break
        case .unknown :
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width , height: self.scrollView.contentSize.height)
//        if UIDevice.current.orientation.isLandscape {
//            print("landscape")
//            scrollView.contentSize = CGSize(width: 0, height:  UIScreen.main.bounds.size.width + 250)
//
//        } else {
//            print("portrait")
//            scrollView.contentSize = CGSize(width:0, height:  UIScreen.main.bounds.size.height + 100)
//
//        }
    }
    @IBAction func signInButtonAction(sender : UIButton)
    {
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
    
    
    @IBAction func signUpButtonAction(sender : UIButton)
    {
        if((firstNameTextField.text?.characters.count)! <= 0)
        {
        self.showAlertMessage(error: "First Name cananot be empty")
            return
        }
        if((lastNameTextField.text?.characters.count)! <= 0)
        {
            self.showAlertMessage(error: "Last Name cananot be empty")
            return
        }
        
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

        BusinessLayer.sharedInstance.makeUserSignUp(username: self.userNameTextField.text!, password: self.paswordNameTextField.text!, first_name: self.firstNameTextField.text!, last_name: self.lastNameTextField.text!) { (result, status, error) in
            self.loadingIndicator.stopAnimating()

            if(status == true)
            {
                
            
                let alert = UIAlertController(title: "Success", message: "User has been registered successfully", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: self.goToNextView))
                self.present(alert, animated: true, completion: nil)
                if(self.shouldStaySignIn)
                {
                    UserDefaults.standard.set(true, forKey: Constants.keepUserLoggedIn)
                    UserDefaults.standard.synchronize()
                }

            }
            else
            {
                if(result as! NSString == "Username Already Exists")
                {
                       self.showAlertMessage(error:  "Username Already Exists")
                }
                else
                {
                
                    self.showAlertMessage(error: (error?.localizedDescription)!)
                }
            
            }
            
        }
    }
    
    func showAlertMessage(error : String)
    {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
       func goToNextView(alert: UIAlertAction!) {
        //SignupToReportingView
        //SignUpToSelectBreakageVC
        self.performSegue(withIdentifier: "SignUpToSelectBreakageVC", sender: self)
    }
}
