//
//  TagLineExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 30/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class TagLineExperienceViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelWriteYourTagline: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var textViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
        
        self.labelWriteYourTagline.font = UIFont(name: RegularFont, size: 15.0)
        self.labelWriteYourTagline.textColor = .darkGray
        
        self.textViewDescription.font = UIFont(name: RegularFont, size: 15.0)
        
//        self.textViewDescription.text = "  Enter your value"
//        self.textViewDescription.textColor = UIColor.lightGray
        self.textViewDescription.layer.borderWidth = 1.0
        self.textViewDescription.layer.borderColor = BorderColor.cgColor
        self.textViewDescription.layer.cornerRadius = 5
        self.textViewDescription.delegate = self
        self.textViewDescription.keyboardType = .default
        self.textViewDescription.returnKeyType = .done
        
        self.buttonNext.layer.cornerRadius = 5
        
        if arrayOfResult.count > 0 {
            self.textViewDescription.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "Tagline") as! NSDictionary).object(forKey: "exp_tagline") as! String
        }
    }
    

    @IBAction func buttonNext(_ sender: Any) { //Please write your tag line.
        if textViewDescription.text == "" {
            self.showInformation(title: "Closest", message: "Enter Tag")
        }
        else if textViewDescription.text.count == 0 {
            self.showInformation(title: "Closest", message: "Enter Tag")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"exp_tagline":self.textViewDescription.text!]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceTagLine)
                manager.post(AddExperienceTagLine, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepSeven()
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
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
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
