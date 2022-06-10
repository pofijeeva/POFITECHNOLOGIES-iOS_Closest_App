//
//  ExperienceAddNotesViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


class ExperienceAddNotesViewController: UIViewController, UITextViewDelegate {

    
    
    
    
     @IBOutlet weak var DescLbl: UILabel!
     @IBOutlet weak var AddNotesLbl: UILabel!
     @IBOutlet weak var NextBtn: UIButton!
    
    @IBOutlet weak var textViewNotes: UITextView!
    
     var ListingActivityDelegate: listingActivityProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.AddNotesLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.DescLbl.textColor = .darkGray
        self.AddNotesLbl.textColor = .darkGray
        self.NextBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.NextBtn.layer.cornerRadius = 5
//        self.textViewNotes.text = "  Enter your value"
        self.textViewNotes.textColor = UIColor.black
        self.textViewNotes.layer.borderWidth = 1.0
        self.textViewNotes.layer.borderColor = BorderColor.cgColor
        self.textViewNotes.layer.shadowColor = BorderColor.cgColor
        self.textViewNotes.layer.cornerRadius = 5
        self.textViewNotes.layer.shadowOffset = CGSize.zero
        self.textViewNotes.layer.shadowOpacity = 0.6
        self.textViewNotes.delegate = self
        self.textViewNotes.keyboardType = .default
        self.textViewNotes.returnKeyType = .done
        
        
        if arrayOfResult.count > 0 {
            self.textViewNotes.text = ((arrayOfResult[0] as? NSDictionary)?.object(forKey: "notes") as? NSDictionary)?.object(forKey: "note_to_guest") as? String ?? ""
        }
        // Do any additional setup after loading the view.
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textViewNotes.textColor == UIColor.lightGray {
//            textViewNotes.text = ""
//            textViewNotes.textColor = UIColor.black
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textViewNotes.text == "" {
//            self.textViewNotes.text = "  Enter your value"
//            self.textViewNotes.textColor = UIColor.lightGray
//        }
//    }
    
    @IBAction func act_AddNotes(_ sender: UIButton) {
        if textViewNotes.text == "  Enter your value" {
            self.showInformation(title: "Closest", message: "Enter Notes")
        }
        else if textViewNotes.text.count == 0 {
            self.showInformation(title: "Closest", message: "Enter Notes")
        }
        else{
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","note_to_guest":self.textViewNotes.text!,"device_type":"ios"]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceAddNotes, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                }
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                   // let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    //   Singleton.sharedInstance.rentYourSpace = mod
                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    sharedInstanceExperience.gotoStepThirteen()
                    //self.showInformation(title: "Closest", message: mod.message)
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
