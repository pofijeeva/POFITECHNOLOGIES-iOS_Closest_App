//
//  ExperienceRequirementsViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class ExperienceRequirementsViewController: UIViewController, UITextViewDelegate {

          
    @IBOutlet weak var textViewRequirements: UITextView!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var AddReqLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    
          
    var ListingActivityDelegate: listingActivityProtocol!
          
          
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.AddReqLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.DescLbl.textColor = .darkGray
        self.AddReqLbl.textColor = .darkGray
        self.NextBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.NextBtn.layer.cornerRadius = 5
       
        self.textViewRequirements.textColor = UIColor.black
        self.textViewRequirements.layer.borderWidth = 1.0
        self.textViewRequirements.layer.borderColor = BorderColor.cgColor
        self.textViewRequirements.layer.shadowColor = BorderColor.cgColor
        self.textViewRequirements.layer.cornerRadius = 5
        self.textViewRequirements.layer.shadowOffset = CGSize.zero
        self.textViewRequirements.layer.shadowOpacity = 0.6
        self.textViewRequirements.delegate = self
        self.textViewRequirements.keyboardType = .default
        self.textViewRequirements.returnKeyType = .done
        // Do any additional setup after loading the view.
        if arrayOfResult.count > 0 {
            self.textViewRequirements.text = ((arrayOfResult[0] as? NSDictionary)?.object(forKey: "guest_reqirement") as? NSDictionary)?.object(forKey: "guest_requirement") as? String ?? ""
        }
    }
          
    @IBAction func act_AddAddRequirements(_ sender: UIButton) {
        if textViewRequirements.text == "  Enter your value" {
            self.showInformation(title: "Closest", message: "Mention anything that guests will have to bring")
        }
        else if textViewRequirements.text.count == 0 {
            self.showInformation(title: "Closest", message: "Mention anything that guests will have to bring")
        }else{
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","guest_requirement":self.textViewRequirements.text!,"device_type":"ios"]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceRequirements, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                }
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    //let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    //   Singleton.sharedInstance.rentYourSpace = mod
                    //self.showInformation(title: "Closest", message: mod.message)
                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    sharedInstanceExperience.gotoStepFifteen()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textViewRequirements.textColor == UIColor.lightGray {
//            textViewRequirements.text = ""
//            textViewRequirements.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textViewRequirements.text == "" {
//            self.textViewRequirements.text = "  Enter your value"
//            self.textViewRequirements.textColor = UIColor.lightGray
//        }
//    }
//
}
