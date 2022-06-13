//
//  ContactUsViewController.swift
//  HomeStay
//
//  Created by Apple7 on 25/02/22.
//  Copyright © 2022 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
//import ACFloatingTextfield_Swift

class ContactUsViewController: BaseViewController {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var SubmitBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerLbl.font = UIFont(name: SemiBoldFont, size: 20)
        self.firstNameTxt.font = UIFont(name: SemiBoldFont, size: 15)
        self.lastNameTxt.font = UIFont(name: SemiBoldFont, size: 15)
        self.emailTxt.font = UIFont(name: SemiBoldFont, size: 15)
        self.mobileNumberTxt.font = UIFont(name: SemiBoldFont, size: 15)
        self.messageTxtView.font = UIFont(name: SemiBoldFont, size: 15)
        self.SubmitBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 20)
        self.SubmitBtn.backgroundColor = AppColor
        
        self.headerLbl.text = GlobalLanguageDictionary.object(forKey: "key_contactUs") as? String ?? ""
        self.firstNameTxt.placeholder = GlobalLanguageDictionary.object(forKey: "Key_firstname") as? String ?? ""
        self.lastNameTxt.placeholder = GlobalLanguageDictionary.object(forKey: "Key_lastname") as? String ?? ""
        self.emailTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_CEmail") as? String ?? ""
        self.mobileNumberTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_mobilenUm") as? String ?? ""
        self.messageTxtView.layer.borderWidth = 1
        self.messageTxtView.layer.borderColor = UIColor.lightGray.cgColor
        
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            self.firstNameTxt.textAlignment = .left
            self.lastNameTxt.textAlignment = .left
            self.emailTxt.textAlignment = .left
            self.mobileNumberTxt.textAlignment = .left
            self.messageTxtView.textAlignment = .left
        }else{
            self.firstNameTxt.textAlignment = .right
            self.lastNameTxt.textAlignment = .right
            self.emailTxt.textAlignment = .right
            self.mobileNumberTxt.textAlignment = .right
            self.messageTxtView.textAlignment = .right
        }
        

        // Do any additional setup after loading the view.
    }
    
    func getWishlistApiResponse(params: [String:Any]){
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable ?? false) {
            APIManager.apiPostWithHeaders(serviceName: CONTACTUS, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Info", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                    self.showInformation(title: "Closest", message: responseDict.object(forKey: "message") as? String ?? "")
                }
                else if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 400 {
                
                }
            }
        }
        else {
            self.showInformation(title: GlobalLanguageDictionary.object(forKey: "key_info") as? String ?? "", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }

    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_submit(_ sender: UIButton) {
        
        if firstNameTxt.text!.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_Pleaseenterthefirstnametocontinue") as? String ?? "")
        }else if lastNameTxt.text!.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_PleaseentertheLastnametocontinue") as? String ?? "")

        }else if emailTxt.text!.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")

        }else if mobileNumberTxt.text!.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_enterMobileNum") as? String ?? "")

        }else if messageTxtView.text.count == 0{
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_enteryourMessage") as? String ?? "")

        }else{
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "first_name": self.firstNameTxt.text!,
                 "last_name": self.lastNameTxt.text!,
                 "email_id": self.emailTxt.text!,
                 "phone_number": self.mobileNumberTxt.text!,
                 "message": self.messageTxtView.text!
                ]
            self.getWishlistApiResponse(params: parameters)
        }
        
      
    }
    /*
    // MARK: - Navigation
     {"lang_code":"en","first_name":"kamalesh","last_name":"kamalesh","email_id":"efewes@gmail.com","phone_number":"12345","message":"12345"}

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
