//
//  WhatAndWhereViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 30/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class WhatAndWhereViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var buttonNext: UIButton!
    
    var isWhatOrWhere = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
        
        self.labelSubTitle.font = UIFont(name: RegularFont, size: 15.0)
        self.labelSubTitle.textColor = .darkGray
        
        self.textViewDescription.font = UIFont(name: RegularFont, size: 15.0)
//        self.textViewDescription.text = "  Enter your value"
        self.textViewDescription.textColor = UIColor.black
        self.textViewDescription.layer.borderWidth = 1.0
        self.textViewDescription.layer.borderColor = BorderColor.cgColor
        self.textViewDescription.layer.cornerRadius = 5
        self.textViewDescription.delegate = self
        self.textViewDescription.keyboardType = .default
        self.textViewDescription.returnKeyType = .done
        
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.buttonNext.layer.cornerRadius = 5
        
        if isWhatOrWhere == "what" {
            self.labelDescription.text = "Describe in detail what you will be doing with your guests. The more information you can give, the better."
            self.labelSubTitle.text = "What you will do*"
        }
        else {
            self.labelDescription.text = "Name all the locations you will visit. Give guests a glimpse of why they are meaningful"
            self.labelSubTitle.text = "Where we will be*"
        }
        
        if self.isWhatOrWhere == "what" {
            if arrayOfResult.count > 0 {
                self.textViewDescription.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "What_you_will_do") as! NSDictionary).object(forKey: "experience_description") as! String
            }
        }else {
            if arrayOfResult.count > 0 {
                self.textViewDescription.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "where_you_will_be") as! NSDictionary).object(forKey: "location_description") as! String
            }
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isWhatOrWhere == "what" {
            self.labelDescription.text = "Describe in detail what you will be doing with your guests. The more information you can give, the better."
            self.labelSubTitle.text = "What you will do*"
        }
        else {
            self.labelDescription.text = "Name all the locations you will visit. Give guests a glimpse of why they are meaningful"
            self.labelSubTitle.text = "Where we will be*"
        }
        
        if self.isWhatOrWhere == "what" {
            if arrayOfResult.count > 0 {
                self.textViewDescription.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "What_you_will_do") as! NSDictionary).object(forKey: "experience_description") as! String
            }
        }else {
            if arrayOfResult.count > 0 {
                self.textViewDescription.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "where_you_will_be") as! NSDictionary).object(forKey: "location_description") as! String
            }
        }    }
    

    @IBAction func buttonNext(_ sender: Any) { //Please enter few words about your organization.
        if textViewDescription.text == "" {
            self.showInformation(title: "Closest", message: "Please enter details")
        }
        else if textViewDescription.text.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter details")
        }
        else {
            if isWhatOrWhere == "what" {
                if Helper.sharedInstance.isConnectedToInternet() {
                    Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                    var params = NSMutableDictionary()
                    params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"what_we_do":self.textViewDescription.text]
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    print("params",params)
                    print("Api",AddExperienceWhatYouWillDo)
                    manager.post(AddExperienceWhatYouWillDo, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                        Helper.sharedInstance.hideActivityIndicator(view: self.view)
                        let responseDict:NSDictionary = resultData as! NSDictionary
                        print("Response:",responseDict)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                            sharedInstanceExperience.gotoStepNine()
                            self.isWhatOrWhere = "where"
                            self.labelDescription.text = "Name all the locations you will visit. Give guests a glimpse of why they are meaningful"
                            self.labelSubTitle.text = "Where we will be*"
                        }
                        else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }, failure: { (operation, error) in
                        print(error)
                        self.showInformation(title: "Closest", message: error.localizedDescription)
                    })
                }
                else {
                    self.showInformation(title: "Closest", message: "Check your internet connection")
                }
            }
            else {
                if Helper.sharedInstance.isConnectedToInternet() {
                    Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                    var params = NSMutableDictionary()
                    params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"location_description":self.textViewDescription.text]
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    print("params",params)
                    print("Api",AddExperienceWhereYouWillBe)
                    manager.post(AddExperienceWhereYouWillBe, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                        Helper.sharedInstance.hideActivityIndicator(view: self.view)
                        let responseDict:NSDictionary = resultData as! NSDictionary
                        print("Response:",responseDict)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                            sharedInstanceExperience.gotoStepTen()
                        }
                        else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }, failure: { (operation, error) in
                        print(error)
                        self.showInformation(title: "Closest", message: error.localizedDescription)
                    })
                }
                else {
                    self.showInformation(title: "Closest", message: "Check your internet connection")
                }
            }
        }
    }
    
    //    MARK: TextField and TextView delegates:
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textViewDescription.textColor == UIColor.lightGray {
//            textViewDescription.text = ""
//            textViewDescription.textColor = UIColor.black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textViewDescription.text == "" {
//            self.textViewDescription.text = "  Enter your value"
//            self.textViewDescription.textColor = UIColor.lightGray
//        }
//    }
}
