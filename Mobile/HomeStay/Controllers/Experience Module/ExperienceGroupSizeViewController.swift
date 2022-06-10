//
//  ExperienceGroupSizeViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


class ExperienceGroupSizeViewController: UIViewController {
    
    @IBOutlet weak var AddGroupSize: UITextField!
    
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var AddGroupLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    
    
    var ListingActivityDelegate: listingActivityProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.AddGroupLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.DescLbl.textColor = .darkGray
        self.AddGroupLbl.textColor = .darkGray
        self.NextBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.NextBtn.layer.cornerRadius = 5
        
        Helper.sharedInstance.UpdateTextfield(self.AddGroupSize)
        if arrayOfResult.count > 0 {
            self.AddGroupSize.text = ((arrayOfResult[0] as? NSDictionary)?.object(forKey: "group_size") as? NSDictionary)?.object(forKey: "group_size") as? String ?? ""
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func act_AddGroupSize(_ sender: UIButton) {
        if self.AddGroupSize.text! == "" {
            self.showInformation(title: "Closest", message: "Enter Group Size")
        }else{
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","group_size":self.AddGroupSize.text!,"device_type":"ios"]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceGroupSize, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                }
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    sharedInstanceExperience.gotoStepSixteen()
                    //let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    //   Singleton.sharedInstance.rentYourSpace = mod
                   // self.showInformation(title: "Closest", message: mod.message)
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
}
