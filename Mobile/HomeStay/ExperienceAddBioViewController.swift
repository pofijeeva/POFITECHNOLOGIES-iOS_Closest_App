//
//  ExperienceAddBioViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


class ExperienceAddBioViewController: UIViewController,UITextViewDelegate {
    

    @IBOutlet weak var textViewBio: UITextView!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var AddBioLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
       
       
        var ListingActivityDelegate: listingActivityProtocol!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
        
        self.DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.AddBioLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.DescLbl.textColor = .darkGray
        self.AddBioLbl.textColor = .darkGray
        self.NextBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.NextBtn.layer.cornerRadius = 5
//        self.textViewBio.text = "  Enter your value"
        self.textViewBio.textColor = UIColor.black
        self.textViewBio.layer.borderWidth = 1.0
        self.textViewBio.layer.borderColor = BorderColor.cgColor
        self.textViewBio.layer.shadowColor = BorderColor.cgColor
        self.textViewBio.layer.cornerRadius = 5
        self.textViewBio.layer.shadowOffset = CGSize.zero
        self.textViewBio.layer.shadowOpacity = 0.6
        self.textViewBio.delegate = self
        self.textViewBio.keyboardType = .default
        self.textViewBio.returnKeyType = .done
           // Do any additional setup after loading the view.
        if arrayOfResult.count > 0 {
            self.textViewBio.text = ((arrayOfResult[0] as! NSDictionary).object(forKey: "about_you") as! NSDictionary).object(forKey: "about_host") as! String
        }
       }
       
    @IBAction func act_AddBio(_ sender: UIButton) {
        
        if textViewBio.text == "  Enter your value" {
            self.showInformation(title: "Closest", message: "Enter About You")
        }
        else if textViewBio.text.count == 0 {
            self.showInformation(title: "Closest", message: "Enter About You")
        }else{
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"about_host":self.textViewBio.text!,"device_type":"ios"]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceAddBio, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                }
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                   // let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    //   Singleton.sharedInstance.rentYourSpace = mod
                   // self.showInformation(title: "Closest", message: mod.message)
                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    sharedInstanceExperience.gotoStepFourteen()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
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
//        if textViewBio.textColor == UIColor.lightGray {
//            textViewBio.text = ""
//            textViewBio.textColor = UIColor.black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textViewBio.text == "" {
//            self.textViewBio.text = "  Enter your value"
//            self.textViewBio.textColor = UIColor.lightGray
//        }
//    }
}
