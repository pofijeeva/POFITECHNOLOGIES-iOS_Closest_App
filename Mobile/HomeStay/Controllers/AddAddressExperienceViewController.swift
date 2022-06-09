//
//  AddAddressExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 01/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class AddAddressExperienceViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelSelectAddress: UILabel!
    @IBOutlet weak var imageViewmapPin: UIImageView!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldNumber: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var viewAddress: UIView!
    var dict = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.viewAddress.isHidden = true
        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
        self.labelSelectAddress.font = UIFont(name: RegularFont, size: 15.0)
        self.labelSelectAddress.textColor = .darkGray
        self.textFieldAddress.font = UIFont(name: RegularFont, size: 15.0)
        self.textFieldNumber.font = UIFont(name: RegularFont, size: 15.0)
        self.textFieldCity.font = UIFont(name: RegularFont, size: 15.0)
        self.textFieldCountry.font = UIFont(name: RegularFont, size: 15.0)
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        Helper.sharedInstance.UpdateTextfield(self.textFieldAddress)
        Helper.sharedInstance.UpdateTextfield(self.textFieldNumber)
        Helper.sharedInstance.UpdateTextfield(self.textFieldCity)
        Helper.sharedInstance.UpdateTextfield(self.textFieldCountry)
        // Do any additional setup after loading the view.
        
            if arrayOfResult.count > 0 {
                let dictt = (arrayOfResult[0] as! NSDictionary).object(forKey: "where_we_will_meet") as! NSDictionary//).object(forKey: "experience_description") as! String
                self.textFieldAddress.text = dictt.object(forKey: "address") as! String
                self.textFieldNumber.text = dictt.object(forKey: "zip") as! String
                self.textFieldCity.text = dictt.object(forKey: "city") as! String
                self.textFieldCountry.text = dictt.object(forKey: "country") as! String
            }

    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewAddress.isHidden = true
        dict = Helper.sharedInstance.getObjectForKey(addressKey)
        if dict.count > 0 {
            print("login_session.object(forKey: addressKey)",dict)
            self.viewAddress.isHidden = false
            self.textFieldAddress.text = dict["subLocality"] as! String
            self.textFieldCity.text = dict["locality"] as! String
            self.textFieldCountry.text = dict["country"] as! String
            self.textFieldNumber.text = dict["pin"] as! String
           // self.textFieldAddress = dict["locality"] as! String + dict[""]
        }
        print("login_session.object(forKey: addressKey)",                        Helper.sharedInstance.getObjectForKey(addressKey))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == textFieldAddress {
            let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
            let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
            searchVC?.isFrom = "exp"
            self.navigationController?.pushViewController(searchVC!, animated: true)
            self.view.endEditing(true)
        }
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        sharedInstanceExperience.gotoStepEleven()
        
        if textFieldAddress.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the address.")
        }
        if textFieldNumber.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the postal code.")
        }
        if textFieldCity.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the city.")
        }
        if textFieldCountry.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the country.")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"country":self.textFieldCountry.text!,"city":textFieldCity.text,"post_code":textFieldNumber.text,"latitude":"","longitude":"","state": "","address_location":self.textFieldAddress.text]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceLocationDetails)
                manager.post(AddExperienceLocationDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepEleven()
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
