//
//  ReportFormViewController.swift
//  LydiaApp
//
//  Created by Arkhitech on 14/10/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import Foundation

class ReportFormViewController: UIViewController {
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet var optionButton : UIButton!
    let dropDown = DropDown()

    var categoriesArray : [CategoryObject] = []
    
    var selectedCategoryObject : CategoryObject!
    var selectedRoomCategoryObject : CategoryObject!

    var items : [String] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
        self.getReportingForm()
        self.setupChooseDropDown()
    }
    
    func setupChooseDropDown() {
        dropDown.anchorView = optionButton
        dropDown.bottomOffset = CGPoint(x: 0, y: optionButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        
        // Action triggered on selection
        
        
        
    }
    func getReportingForm()
    {
        loadingIndicator.startAnimating()
        self.loadingIndicator.isHidden = false
         BusinessLayer.sharedInstance.getOptionList(tagId: selectedRoomCategoryObject.category_id, responseBlock: { (result, status, error) in
            self.loadingIndicator.stopAnimating()
             self.loadingIndicator.isHidden = true
            if(error == nil)
            {
                self.categoriesArray = result as! [CategoryObject]
                
                for categoryObj in self.categoriesArray
                {
                    self.items.append(categoryObj.name)
                }
                self.dropDown.dataSource = self.items
                self.dropDown.selectionAction = { [unowned self] (index, item) in
                    self.optionButton.setTitle(item, for: .normal)
                    self.selectedCategoryObject = self.categoriesArray[index]

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
        //self.showAlertView()
        dropDown.show()
    }
    
    @IBAction func nextButtonAction(sender : UIButton)
    {
        if(self.selectedCategoryObject == nil)
        {
            self.showAlertMessage(error: "Please select option to conitnue")
            return
        }
            self.performSegue(withIdentifier: "SelectReportToReportFormSubmissionVC", sender: self)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SelectReportToReportFormSubmissionVC"
        {
            
          
            let vc:ReportFormSubmissionViewController = segue.destination as! ReportFormSubmissionViewController
            vc.selectedRoomCategoryObject = self.selectedRoomCategoryObject
            vc.prevCategoryObject = self.selectedCategoryObject
        }
        
    }
    func showAlertView()
    {
    
        let params = Parameters(title: "Please Select One", items: items, cancelButton: "Cancel")
        
        SelectItemController().show(parent: self, params: params) { (index) in
            if let index = index {
                self.selectedCategoryObject = self.categoriesArray[index]
                self.optionButton.setTitle(self.selectedCategoryObject.name, for: .normal)
            } else {
                print("cancel")
            }
        }
    }
}
