//
//  TitleExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 19/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class TitleExperienceViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var labelTitleandSummary: UILabel!
    @IBOutlet weak var labelExperienceTitle: UILabel!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var buttonNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelTitleandSummary.font = UIFont(name: RegularFont, size: 15.0)
        self.labelTitleandSummary.textColor = .darkGray
        self.labelExperienceTitle.font = UIFont(name: RegularFont, size: 15.0)
        self.labelExperienceTitle.textColor = .darkGray
        self.textFieldTitle.font = UIFont(name: RegularFont, size: 15.0)
        Helper.sharedInstance.UpdateTextfield(self.textFieldTitle)
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.buttonNext.layer.cornerRadius = 5
        
        if arrayOfResult.count > 0 {
            let dictt = (arrayOfResult[0] as! NSDictionary).object(forKey: "Experience_Title") as! NSDictionary
            self.textFieldTitle.text = dictt.object(forKey: "experience_title") as! String
        }
    }


    @IBAction func buttonNext(_ sender: Any) {
        if textFieldTitle.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please Enter Title")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"experience_title":self.textFieldTitle.text!]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceTitle)
                manager.post(AddExperienceTitle, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepfive()
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
