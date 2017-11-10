//
//  ViewController.swift
//  MobileTestProject
//
//  Created by Arkhitech on 8/3/17.
//  Copyright © 2017 Arkhitech. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerViewMainView: UIView!
    var itemsArray:NSMutableArray = []
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicator.isHidden = true;
        
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsArray.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return ""//itemsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        self.view.endEditing(true)
    }
    
    
    
    @IBAction  func closeBtnAction(sender: UIButton) {
        self.pickerViewMainView.isHidden = true;
    }
    
    
    @IBAction func doneBtnAction(sender: UIBarButtonItem) {
        
        
        pickerViewMainView.isHidden = true
        
    }
    
    @IBAction func cancelBtnAction(sender: UIBarButtonItem) {
        pickerViewMainView.isHidden = true
        
    }
    
    
}

