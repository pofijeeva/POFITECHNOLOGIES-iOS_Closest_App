//
//  ExperienceCancellationViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 26/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import AFNetworking

class ExperienceCancellationViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var txtPolicy: UITextField!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var lblReturnCurrencySymbol: UILabel!

    @IBOutlet weak var metaDiscription: UITextView!
    @IBOutlet weak var txtViewKeywords: UITextView!
    @IBOutlet weak var txtMetaTitle: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var conTopSpace: NSLayoutConstraint!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelationPolicy: UILabel!
    @IBOutlet weak var pleaseSelect: UILabel!
    @IBOutlet weak var cancelPolicy: UILabel!
    @IBOutlet weak var securityDeposit: UILabel!
    @IBOutlet weak var metaTitle: UILabel!
    @IBOutlet weak var keyboards: UILabel!
    @IBOutlet weak var metaDescription: UILabel!
    @IBOutlet weak var cencelDescriptionEnTxt: UITextView!
    @IBOutlet weak var cancelDescriptionLbl: UILabel!
    @IBOutlet weak var cancelPercentTxt: UITextField!
    @IBOutlet weak var cancelPercentage: UILabel!
    
    var arrayOfPolicy = ["Strict","Flexible","Moderate"]
    let currencyDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.currencyDropdown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCurrencySymbol.font = UIFont(name: SemiBoldFont, size: 14)
        self.lblCurrencySymbol.text = ExperiencySelectedCurrency
        self.lblReturnCurrencySymbol.font = UIFont(name: SemiBoldFont, size: 14)
        self.lblReturnCurrencySymbol.text = ExperiencySelectedCurrency
        self.cancelPolicy.font = UIFont(name: RegularFont, size: 15.0)
        self.cancelPolicy.textColor = .darkGray
        
        self.securityDeposit.font = UIFont(name: RegularFont, size: 15.0)
        self.securityDeposit.textColor = .darkGray
        
        self.cancelDescriptionLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.cancelDescriptionLbl.textColor = .darkGray
        
        self.metaTitle.font = UIFont(name: RegularFont, size: 15.0)
        self.metaTitle.textColor = .darkGray
        
        self.keyboards.font = UIFont(name: RegularFont, size: 15.0)// actually it is keyword but the outlet taken as keyboard by Gopi Shunkara ha ha ha
        self.keyboards.textColor = .darkGray
        
        self.metaDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.metaDescription.textColor = .darkGray
        
        self.btnSave.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.btnSave.layer.cornerRadius = 5
        
        self.updateTextView(textView: self.cencelDescriptionEnTxt)
        self.updateTextView(textView: self.txtViewKeywords)
        self.updateTextView(textView: self.metaDiscription)
        
        self.txtPolicy.layer.borderWidth = 1
        self.txtPolicy.layer.borderColor = BorderColor.cgColor
        
        self.metaTitle.layer.borderWidth = 1
        self.metaTitle.layer.borderColor = BorderColor.cgColor
        
        self.txtPrice.layer.borderWidth = 1
        self.txtPolicy.layer.borderColor = BorderColor.cgColor
        
        self.cancelPercentTxt.layer.borderWidth = 1
        self.cancelPercentTxt.layer.borderColor = BorderColor.cgColor
        
//        self.btnSave.addTarget(self, action: #selector(updateSaveButton), for: .touchUpInside)
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        if arrayOfResult.count > 0 {
            let dictt = (arrayOfResult[0] as! NSDictionary).object(forKey: "cancellation_policy") as! NSDictionary
            self.txtPolicy.text = dictt.object(forKey: "cancel_policy") as! String
            self.txtPrice.text = dictt.object(forKey: "security_deposit") as! String
            self.cancelPercentTxt.text = dictt.object(forKey: "cancel_percentage") as! String
            self.cencelDescriptionEnTxt.text = dictt.object(forKey: "cancel_policy_description") as! String
            self.txtMetaTitle.text = dictt.object(forKey: "meta_title") as! String
            self.txtViewKeywords.text = dictt.object(forKey: "meta_keyword") as! String
            self.metaDiscription.text = dictt.object(forKey: "meta_description") as! String
        }
        
    }
    
    func updateTextView(textView: UITextView) {
       
        textView.textColor = UIColor.black
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = BorderColor.cgColor
        textView.layer.shadowColor = BorderColor.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowOpacity = 0.6
        textView.delegate = self
        textView.keyboardType = .default
        textView.returnKeyType = .done
    }
    
//    @objc func updateSaveButton() {
//        if self.cencelDescriptionEnTxt.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Description.")
//        }
//        else if cencelDescriptionEnTxt.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter Description.")
//        }
//        else if self.txtViewKeywords.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if txtViewKeywords.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if self.metaDiscription.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
//        else if metaDiscription.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
//        else if txtPrice.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Price.")
//        }
//        else if cancelPercentTxt.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Return amount.")
//        }
//        else if txtPolicy.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please select policy.")
//        }
//        else {
//
//            if Helper.sharedInstance.isConnectedToInternet() {
//                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
//                var params = NSMutableDictionary()
//                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"meta_description":self.metaDiscription.text!,"sec_deposit":self.txtPrice.text!,"cancel_policy":self.txtPolicy.text!,"meta_title":txtMetaTitle.text!,"meta_keyword":txtViewKeywords.text!,"cancel_percentage":self.cancelPercentTxt.text!,"cancel_policy_des":cencelDescriptionEnTxt.text!]
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//                print("params",params)
//                print("Api",AddExperienceCancelPolicy)
//                manager.post(AddExperienceCancelPolicy, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
//                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
//                    let responseDict:NSDictionary = resultData as! NSDictionary
//                    print("Response:",responseDict)
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
//                        let vc = storyBoardHome.instantiateViewController(withIdentifier: "xperienceCancellationViewController") as! ExperienceListingBaseViewController
//                        vc.isFromList = false
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) in
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
//
//            }
//            else {
//                self.showInformation(title: "Closest", message: "Check your internet connection")
//            }
//        }
//    }
    
    func dropDownForTextField() {
        let hours = arrayOfPolicy
        currencyDropdown.anchorView = self.txtPolicy
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.txtPolicy?.bounds.height)!)
        currencyDropdown.dataSource = hours
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtPolicy.text = item
            if item == "Strict" {
                self.cancelPercentTxt.text = "99"
                self.cancelPercentTxt.isUserInteractionEnabled = false
                self.cancelPercentTxt.isEnabled = false
                
            }else if item == "Moderate"{
                self.cancelPercentTxt.text = "50"
                self.cancelPercentTxt.isUserInteractionEnabled = false
                self.cancelPercentTxt.isEnabled = false

            }else{
                self.cancelPercentTxt.text = ""
                self.cancelPercentTxt.isUserInteractionEnabled = true
                self.cancelPercentTxt.isEnabled = true

            }
            
        }
    }
    
    
    
    @IBAction func buttonSaveAction(_ sender: Any) {
         if txtPolicy.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please select policy.")
        }
       
//        else if self.txtViewKeywords.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if txtViewKeywords.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if self.metaDiscription.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
//        else if metaDiscription.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
        else if txtPrice.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter Price.")
        }
        else if cancelPercentTxt.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter Return amount.")
        }
        else if self.cencelDescriptionEnTxt.text!.count == 0 {
             self.showInformation(title: "Closest", message: "Please enter Description.")
         }
         else if cencelDescriptionEnTxt.text == "  Enter your value" {
             self.showInformation(title: "Closest", message: "Please enter Description.")
         }
       
        else {
            
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"meta_description":self.metaDiscription.text!,"sec_deposit":self.txtPrice.text!,"cancel_policy":self.txtPolicy.text!,"meta_title":txtMetaTitle.text!,"meta_keyword":txtViewKeywords.text!,"cancel_percentage":self.cancelPercentTxt.text!,"cancel_policy_des":cencelDescriptionEnTxt.text!]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceCancelPolicy)
                manager.post(AddExperienceCancelPolicy, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        let vc = storyBoardHome.instantiateViewController(withIdentifier: "ExperienceListingBaseViewController") as! ExperienceListingBaseViewController
                        vc.isFromList = false
                        self.navigationController?.pushViewController(vc, animated: true)
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtPolicy {
            self.txtPolicy.resignFirstResponder()
            self.dropDownForTextField()
            currencyDropdown.show()
            return false
        }
        return true
    }
//    @IBAction func buttonSave(_ sender: Any) {
//
//        if self.cencelDescriptionEnTxt.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Description.")
//        }
//        else if cencelDescriptionEnTxt.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter Description.")
//        }
//        else if self.txtViewKeywords.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if txtViewKeywords.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter KeyWords.")
//        }
//        else if self.metaDiscription.text!.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
//        else if metaDiscription.text == "  Enter your value" {
//            self.showInformation(title: "Closest", message: "Please enter meta description.")
//        }
//        else if txtPrice.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Price.")
//        }
//        else if cancelPercentTxt.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter Return amount.")
//        }
//        else if txtPolicy.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please select policy.")
//        }
//        else {
//
//            if Helper.sharedInstance.isConnectedToInternet() {
//                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
//                var params = NSMutableDictionary()
//                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"meta_description":self.metaDiscription.text!,"sec_deposit":self.txtPrice.text!,"cancel_policy":self.txtPolicy.text!,"meta_title":txtMetaTitle.text!,"meta_keyword":txtViewKeywords.text!,"cancel_percentage":self.cancelPercentTxt.text!,"cancel_policy_des":cencelDescriptionEnTxt.text!]
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//                print("params",params)
//                print("Api",AddExperienceCancelPolicy)
//                manager.post(AddExperienceCancelPolicy, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
//                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
//                    let responseDict:NSDictionary = resultData as! NSDictionary
//                    print("Response:",responseDict)
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
//                        let vc = storyBoardHome.instantiateViewController(withIdentifier: "xperienceCancellationViewController") as! ExperienceListingBaseViewController
//                        vc.isFromList = false
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) in
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
//
//            }
//            else {
//                self.showInformation(title: "Closest", message: "Check your internet connection")
//            }
//        }
//    }
    
    
    }
    
 /*   func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == txtViewKeywords {
            if txtViewKeywords.text == "" {
                self.txtViewKeywords.text = "  Enter your value"
                self.txtViewKeywords.textColor = UIColor.lightGray
            }
        }
        else if textView == metaDiscription {
            if metaDiscription.text == "" {
                self.metaDiscription.text = "  Enter your value"
                self.metaDiscription.textColor = UIColor.lightGray
            }
        }
        else if textView == cencelDescriptionEnTxt {
            if cencelDescriptionEnTxt.text == "" {
                self.cencelDescriptionEnTxt.text = "  Enter your value"
                self.cencelDescriptionEnTxt.textColor = UIColor.lightGray
            }
        }
    }
}
 func textViewDidBeginEditing(_ textView: UITextView) {
     if textView == txtViewKeywords {
         if txtViewKeywords.textColor == UIColor.lightGray {
             txtViewKeywords.text = ""
             txtViewKeywords.textColor = UIColor.black
         }
     }
     else if textView == metaDiscription {
         if metaDiscription.textColor == UIColor.lightGray {
             metaDiscription.text = ""
             metaDiscription.textColor = UIColor.black
         }
     }
     else if textView == cencelDescriptionEnTxt {
         if cencelDescriptionEnTxt.textColor == UIColor.lightGray {
             cencelDescriptionEnTxt.text = ""
             cencelDescriptionEnTxt.textColor = UIColor.black
         }
     }
 }
 Z*/
