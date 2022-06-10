//
//  OrganizationExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 19/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class OrganizationExperienceViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var labelTelUs: UILabel!
    @IBOutlet weak var labelOrganizationName: UILabel!
    @IBOutlet weak var textfieldOrganization: UITextField!
    @IBOutlet weak var labelAboutOrganization: UILabel!
    @IBOutlet weak var textViewOrganization: UITextView!
    @IBOutlet weak var buttonNext: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTelUs.font = UIFont(name: RegularFont, size: 15.0)
        self.labelTelUs.textColor = .darkGray
        self.labelOrganizationName.font = UIFont(name: RegularFont, size: 15.0)
        self.labelOrganizationName.textColor = .darkGray
        self.textfieldOrganization.font = UIFont(name: RegularFont, size: 15.0)
        self.labelAboutOrganization.font = UIFont(name: RegularFont, size: 15.0)
        self.labelAboutOrganization.textColor = .darkGray
        self.textViewOrganization.font = UIFont(name: RegularFont, size: 15.0)
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        Helper.sharedInstance.UpdateTextfield(self.textfieldOrganization)
        
//        self.textViewOrganization.text = "  Enter your value"
        self.textViewOrganization.textColor = UIColor.black
        self.textViewOrganization.layer.borderWidth = 1.0
        self.textViewOrganization.layer.borderColor = BorderColor.cgColor
        self.textViewOrganization.layer.cornerRadius = 5
        self.textViewOrganization.delegate = self
        self.textViewOrganization.keyboardType = .default
        self.textViewOrganization.returnKeyType = .done
        self.buttonNext.layer.cornerRadius = 5
        
        
        if arrayOfResult.count > 0 {
            let dictt = (arrayOfResult[0] as? NSDictionary)?.object(forKey: "Organization") as! NSDictionary
            self.textfieldOrganization.text = dictt.object(forKey: "organization") as? String ?? ""
            self.textViewOrganization.text = dictt.object(forKey: "organization_des") as? String ?? ""
        }
    }
    
//    MARK: Fucntions and Obj -C :

    
//    MARK: Button Actions:
    
    @IBAction func buttonNext(_ sender: Any) {
        if self.textfieldOrganization.text!.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter organization name.")
        }
        else if textViewOrganization.text == "  Enter your value" {
            self.showInformation(title: "Closest", message: "Please enter about your organization")
        }
        else if textViewOrganization.text.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter about your organization")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"organization":self.textfieldOrganization.text!,"organization_des":self.textViewOrganization.text]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceOrganisation)
                manager.post(AddExperienceOrganisation, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepfour()
                    }
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) in
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
            }
            else {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
    }
    
//    MARK: TextField and TextView delegates:

//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textViewOrganization.textColor == UIColor.lightGray {
//            textViewOrganization.text = ""
//            textViewOrganization.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textViewOrganization.text == "" {
//            self.textViewOrganization.text = "  Enter your value"
//            self.textViewOrganization.textColor = UIColor.lightGray
//        }
//    }
    
}
