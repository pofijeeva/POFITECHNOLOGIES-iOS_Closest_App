//
//  BasicExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 18/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown

class BasicExperienceViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textFieldChooseType: UITextField!
    @IBOutlet weak var textFieldEnterYourValue: UITextField!
    @IBOutlet weak var textFieldExperienceCategory: UITextField!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var labelExperienceType: UILabel!
    @IBOutlet weak var labelNoOfDays: UILabel!
    @IBOutlet weak var labelExperienceCategory: UILabel!
    
    
    
    let currencyDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.currencyDropdown
            ]
    }()
    var arrayExperienceTypeDropDown = ["Immersion","Experience"]
    var arrayExperienceCategory = NSMutableArray()
    var arrayExperienceCategoryID = NSMutableArray()
    var selectedIndexForExperienceCategory = ""
    var experienceTypeID = ""
    var DaysCount = String()
    var HoursCount = String()
   
    override func viewDidLoad() {
        super.viewDidLoad()
                
        Helper.sharedInstance.UpdateTextfield(self.textFieldChooseType)
        Helper.sharedInstance.UpdateTextfield(self.textFieldExperienceCategory)
        Helper.sharedInstance.UpdateTextfield(self.textFieldEnterYourValue)
        
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.textFieldChooseType.font = UIFont(name: RegularFont, size: 15.0)
        self.textFieldEnterYourValue.font = UIFont(name: RegularFont, size: 15.0)
        self.textFieldExperienceCategory.font = UIFont(name: RegularFont, size: 15.0)
        self.labelExperienceType.textColor = .darkGray
        self.labelNoOfDays.textColor = .darkGray
        self.labelExperienceCategory.textColor = .darkGray
        self.labelExperienceType.font = UIFont(name: RegularFont, size: 15.0)
        self.labelNoOfDays.font = UIFont(name: RegularFont, size: 15.0)
        self.labelExperienceCategory.font = UIFont(name: RegularFont, size: 15.0)
        self.buttonNext.layer.cornerRadius = 5
        self.textFieldEnterYourValue.keyboardType = .numberPad
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
//known_languages
        self.getBaseDetails()
        if dictOfExperience.count > 0 {
            let dict = dictOfExperience["experience_categories"] as! [[String:AnyObject]]
            for item in dict {
                self.arrayExperienceCategory.add(item["experience_title"] as? String ?? "")
                self.arrayExperienceCategoryID.add(item["id"] as? String ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if isFromManage {
//            let data = (dictOfExperience.object(forKey: "result") as! NSArray).object(at: 0) as! NSDictionary
//            let dict = data.object(forKey: "Basics") as! NSDictionary
//            if "\(dict.object(forKey: "exp_type") as AnyObject)" == "1" {
//                self.textFieldChooseType.text = "Immersion"
//            }
//            else {
//                self.textFieldChooseType.text = "Experience"
//            }
//
//            
//        }
        if arrayOfResult.count > 0 {
            let dict = (arrayOfResult[0] as? NSDictionary)?.object(forKey: "Basics") as! NSDictionary
            if "\(dict.object(forKey: "exp_type") as AnyObject)" == "1" {
                self.textFieldChooseType.text = "Immersion"
                self.labelNoOfDays.text = "Number of Days *"
                self.DaysCount = "\(dict.object(forKey: "date_count") as AnyObject)"
                self.HoursCount = ""
                self.textFieldEnterYourValue.text = "\(dict.object(forKey: "date_count") as AnyObject)"


            }
            else {
                self.labelNoOfDays.text = "Total Hours *"
                self.textFieldChooseType.text = "Experience"
                self.DaysCount = ""
                self.HoursCount = "\(dict.object(forKey: "total_hours") as AnyObject)"
                self.textFieldEnterYourValue.text = "\(dict.object(forKey: "total_hours") as AnyObject)"

            }
            
           
            
            let catId = dict.object(forKey: "exp_category") as AnyObject
            
            if "\(catId)" == "" || "\(catId)" == "0"{
                
            }else{
                let index = self.arrayExperienceCategoryID.index(of: "\(catId)")
                let catName =  self.arrayExperienceCategory.object(at: index) as? String ?? ""
                self.textFieldExperienceCategory.text = catName
            }
            
           
           // self.DaysCount = "\(dict.object(forKey: "date_count") as AnyObject)"
        }
    }
    
    func getBaseDetails() {
        if Helper.sharedInstance.isConnectedToInternet() {
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id": currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",ExperienceBaseDetails)
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    dictOfExperience = responseDict
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    arrayOfResult = dictOfExperience["result"] as! NSArray
                    arrayOfBoolValues.removeAllObjects()
                    for i in 0..<arrayOfHeadings.count {
                        let str = ((arrayOfResult[0] as? NSDictionary)?.value(forKey:  arrayOfHeadings[i] as? String ?? "") as? NSDictionary)?.object(forKey: "step_completed") as AnyObject
                        arrayOfBoolValues.add("\(str)")
                    }
                 TimingsArray = (((dictOfExperience["result"] as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Timing") as? NSDictionary)?.object(forKey: "schedules") as! NSArray
                arrayOfResult = dictOfExperience["result"] as! NSArray
                        let dict = dictOfExperience["experience_categories"] as! [[String:AnyObject]]
                        for item in dict {
                            self.arrayExperienceCategory.add(item["experience_title"] as? String ?? "")
                            self.arrayExperienceCategoryID.add(item["id"] as? String ?? "")
                    }
                    let dictt = (arrayOfResult[0] as? NSDictionary)?.object(forKey: "Basics") as! NSDictionary
                    
                    if "\(dictt.object(forKey: "exp_type") as AnyObject)" == "" || "\(dictt.object(forKey: "exp_type") as AnyObject)" == "0"{
                         
                    }else {
                        if "\(dictt.object(forKey: "exp_type") as AnyObject)" == "1" {
                           self.textFieldChooseType.text = "Immersion"
                            self.labelNoOfDays.text = "Number of Days *"

                            self.textFieldEnterYourValue.text = "\(dictt.object(forKey: "date_count") as AnyObject)"
                       }
                       else {
                           self.textFieldChooseType.text = "Experience"
                        self.labelNoOfDays.text = "Total Hours *"

                        self.textFieldEnterYourValue.text = "\(dictt.object(forKey: "total_hours") as AnyObject)"
                       }
                       let catId = dictt.object(forKey: "exp_category") as AnyObject
                        
                        if "\(catId)" == "0" {
                            
                        }else{
                            let index = self.arrayExperienceCategoryID.index(of: "\(catId)")
                            let catName =  self.arrayExperienceCategory.object(at: index) as? String ?? ""
                            self.textFieldExperienceCategory.text = catName
                           
                        }
                      
                    }
                    
                    
                }
                else {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                  //  self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })

        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        Helper.sharedInstance.hideActivityIndicator(view: self.view)
    }
    
//    MARK: Functions and Obj-C Functions
    
    func commonCall() {
        print("common call initiated")
    }
    
    func minHrdropdown() {
        let hours = arrayExperienceTypeDropDown
        currencyDropdown.anchorView = self.textFieldChooseType
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.textFieldChooseType?.bounds.height)!)
        currencyDropdown.dataSource = hours
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textFieldChooseType.text = item
            self.experienceTypeID = "\(index+1)"
            
            if index == 0 {
                self.labelNoOfDays.text = "Number of Days *"
               
            }else{
                self.labelNoOfDays.text = "Total Hours *"
               

            }
            
            
          }
    }
    
    func experienceCategoryDropdown() {
        let hours = arrayExperienceCategory
        currencyDropdown.anchorView = self.textFieldExperienceCategory
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.textFieldExperienceCategory?.bounds.height)!)
        currencyDropdown.dataSource = hours as! [String]
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textFieldExperienceCategory.text = item
            self.selectedIndexForExperienceCategory = self.arrayExperienceCategoryID[index] as? String ?? ""
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("selected")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.textFieldChooseType {
            self.textFieldChooseType.resignFirstResponder()
            self.minHrdropdown()
            currencyDropdown.show()
            return false
        }
        else if textField == self.textFieldExperienceCategory {
            self.textFieldExperienceCategory.resignFirstResponder()
            self.experienceCategoryDropdown()
            currencyDropdown.show()
            return false
        }
        return true
    }
    
//    MARK: Button Actions
    
    @IBAction func buttonNext(_ sender: Any) {
        //BaseSelectedIndex = BaseSelectedIndex + 1
        let text = (self.textFieldEnterYourValue.text! as NSString).integerValue
        if textFieldChooseType.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter Experience type")
        }
        else if self.textFieldEnterYourValue.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter Number of days")
        }
        else if text == 1 {
            self.showInformation(title: "Closest", message: "Please enter Number of days more than 1")
        }
        else if self.textFieldExperienceCategory.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter Experience category")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
               
                if self.labelNoOfDays.text! == "Number of Days *" {
                    self.DaysCount = self.textFieldEnterYourValue.text!
                    self.HoursCount = ""
                }else{
                    self.DaysCount = ""
                    self.HoursCount = self.textFieldEnterYourValue.text!
                }
                
                
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","experience_type": self.experienceTypeID,"category_id":self.selectedIndexForExperienceCategory,"exp_id":currentExpId,"total_count_time":self.HoursCount,"total_count_date":self.DaysCount]
                print(params)
//
//                Santhosh SV (svsanthosh@pofitec.com) Timing upload quantity group size
//                experience_type=1&category_id=26&user_id=126&exp_id=&total_count_time=&device_type=android&currency_code=USD&total_count_date=3
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceBacic)
                manager.post(AddExperienceBacic, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        arrayOfdictBasics.addObjects(from: (responseDict.object(forKey: "result") as! NSArray) as! [Any])
                        let aray = arrayOfdictBasics[0] as! NSDictionary
                        var arrayOfDict = [[String:AnyObject]]()
                        sharedInstanceExperience.gotoStepTwo()
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
    
    @IBAction func buttonDropDownOne(_ sender: Any) {
        
    }
    
    @IBAction func buttonDropDownTwo(_ sender: Any) {
        
    }
        
    @IBAction func buttonDropdownThree(_ sender: Any) {
        
    }
    
}
