//
//  ReportFormSubmissionViewController.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation
//
//  ReportFormViewController.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

class ReportFormSubmissionViewController: UIViewController {
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet var textView : UITextView!
    let dropDown = DropDown()

    @IBOutlet var optionButton : UIButton!
    var prevCategoryObject : CategoryObject!
    var staffsArray : [CategoryObject] = []
    var selectedRoomCategoryObject : CategoryObject!

    var categoriesArray : [CategoryObject] = []
    var selectedCategoryObject : CategoryObject!
    var items : [String] = [];
    var cleanValue  = ""
    var staffName = ""
    @IBOutlet var cleanedButton : UIButton!
    @IBOutlet var notSatisfactoryButton : UIButton!
    @IBOutlet var notCleanedButton : UIButton!
    @IBOutlet var scrollView : UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
       self.getStaffInfo()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.init(colorLiteralRed: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0).cgColor
        self.notCleanedButton(sender: notCleanedButton)
        self.hideShowkeyboadMethods()
        self.setupChooseDropDown()

    }
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width , height: self.scrollView.contentSize.height)
    }
    
  
    func setupChooseDropDown() {
        dropDown.anchorView = optionButton
        dropDown.bottomOffset = CGPoint(x: 0, y: optionButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        
        // Action triggered on selection
  
    }
    func getStaffInfo()
    {
        loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.isHidden = false
        BusinessLayer.sharedInstance.getStaffsList( responseBlock:  { (result, status, error) in
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            if(error == nil)
            {
                self.staffsArray = result as! [CategoryObject]
               
                for categoryObj in self.staffsArray
                {
                    self.items.append(categoryObj.name)
                }
                self.dropDown.dataSource = self.items
                self.dropDown.selectionAction = { [unowned self] (index, item) in
                    self.optionButton.setTitle(item, for: .normal)
                    self.selectedCategoryObject = self.staffsArray[index]
                    self.staffName = self.selectedCategoryObject.name
                    self.optionButton.setTitle(self.selectedCategoryObject.name, for: .normal)
                }

            }
            else
            {
                self.showAlertMessage(error: (error?.localizedDescription)!)
                
            }
            
        })
    }

    
    func showAlertMessage(error : String)
    {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func selectReportRoomButtonAction(sender : UIButton)
    {
        dropDown.show()
     //   self.showAlertView()
    }
    func disSelectedAllButtons()
    {
        cleanedButton.isSelected = false
        notSatisfactoryButton.isSelected = false
        notCleanedButton.isSelected = false
    }
    
    @IBAction func  cleanedButton(sender : UIButton)
    {
        self.disSelectedAllButtons()
        cleanedButton.isSelected = true
        cleanValue = "Cleaned"

        
    }
    @IBAction func  notCleanedButton(sender : UIButton)
    {
        self.disSelectedAllButtons()
        notCleanedButton.isSelected = true
        cleanValue = "Not yet cleaned"
    }
    
    @IBAction func  notSatisfactoryCleanedButton(sender : UIButton)
    {
        self.disSelectedAllButtons()
        notSatisfactoryButton.isSelected = true
        cleanValue = "Not cleaned to satisfaction"

    }
    
    @IBAction func  submitButton(sender : UIButton)
        
    {
        if(staffName == "")
        {
        self.showAlertMessage(error: "Please select staff name")
            return
        }
    
        self.loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
        BusinessLayer.sharedInstance.submittedForm(tags: self.selectedRoomCategoryObject.name, user_id: UserDefaults.standard.object(forKey: "user_name") as! String, staff: self.staffName, suboption: self.prevCategoryObject.name, cleaned: cleanValue, ad_notes: textView.text)  { (result, status, error) in
            
            if(error == nil)
            {
                
//                let alert = UIAlertController(title: "Success", message: "Info has been submitted!", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: self.goToNextView))
//                self.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "SubmissionToThankyouVC", sender: self)
            }
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
        
    }
    
    func goToNextView(alert: UIAlertAction!) {
        //SigninToReportingView
        //ReportToSelectBreakageVC
        self.performSegue(withIdentifier: "FormSubmissionToSelectBreakageVC", sender: self)
    
    }

    func showAlertView()
    {
        
        let params = Parameters(title: "Please Select One", items: items, cancelButton: "Cancel")
        
        SelectItemController().show(parent: self, params: params) { (index) in
            if let index = index {
                self.selectedCategoryObject = self.staffsArray[index]
                self.staffName = self.selectedCategoryObject.name
                self.optionButton.setTitle(self.selectedCategoryObject.name, for: .normal)
            } else {
                print("cancel")
            }
        }
    }
}
