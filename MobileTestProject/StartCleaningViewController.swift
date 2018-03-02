//
//  StartCleaningViewController.swift
//  MobileTestProject
//
//  Created by Arkhitech on 3/2/18.
//  Copyright © 2018 Arkhitech. All rights reserved.
//



import Foundation

class StartCleaningViewController : UIViewController {
    @IBOutlet var loadingIndicator : UIActivityIndicatorView!
    @IBOutlet var scrollView : UIScrollView!
    @IBOutlet var label : UILabel!
    var items : [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let str =  UserDefaults.standard.value(forKey: "selectedRoomCategoryObject") as! String
        label.text = "Once you have finished cleaning the \(str), please click next to continue your report."
    }
    override func viewDidAppear(_ animated: Bool) {
      //  scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width , height: self.scrollView.contentSize.height)
    }
    
   
  
    
    @IBAction func nextButtonAction(sender : UIButton)
    {
     
        self.performSegue(withIdentifier: "CleaningToReportFormSubmissionVC", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SelectReportToReportFormSubmissionVC"
        {
            
            
            let vc:ReportFormSubmissionViewController = segue.destination as! ReportFormSubmissionViewController
//            vc.selectedRoomCategoryObject = self.selectedRoomCategoryObject
//            vc.prevCategoryObject = self.selectedCategoryObject
        }
        
    }
   
}

