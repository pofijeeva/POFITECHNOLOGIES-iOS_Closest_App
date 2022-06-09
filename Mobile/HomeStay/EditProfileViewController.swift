//
//  EditProfileViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 29/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var Img_Profile: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Work: UILabel!
    @IBOutlet weak var lbl_PhoneNum: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    @IBOutlet weak var tbl_HostListings: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var lbl_Listings: UILabel!
    
    @IBOutlet weak var lbl_emailVerificatn: UILabel!
    @IBOutlet weak var lbl_phoneVerification: UILabel!
    @IBOutlet weak var lbl_verifications: UILabel!
    @IBOutlet weak var btn_mobileVerify: UIButton!
    @IBOutlet weak var GreetingTxt: UILabel!
    
    
    @IBOutlet weak var EmailVerificationGrayView: UIView!
    @IBOutlet weak var EmailVerificationLbl: UILabel!
    @IBOutlet weak var EnterVerificationCodeLbl: UILabel!
    @IBOutlet weak var EnterVerificationCodeTxf: UITextField!
    @IBOutlet weak var EmailCancelBtn: UIButton!
    @IBOutlet weak var EmailOkBtn: UIButton!
    
    
    
    var emailVerificationSuccess = String()
    var emailVerficationFailure = String()
    var mobileNumberVerified = String()
    var mobileNumberNotVerified = String()
    var hostProps = NSArray()
    var propImg = String()
    var propName = String()
    var proplocation = String()
    var particularuser = String()
    var mailidverify = Int()
    var hostID = String()
    var prop_id = Int()
    
    override func viewDidLoad(){
    super.viewDidLoad()
        
        
        self.lbl_Name.font = UIFont(name: SemiBoldFont, size: 15)
        self.viewTitle.font = UIFont(name: SemiBoldFont, size: 16)
         self.lbl_Email.font = UIFont(name: RegularFont, size: 13)
          self.lbl_PhoneNum.font = UIFont(name: RegularFont, size: 13)
        self.lbl_verifications.font = UIFont(name: RegularFont, size: 14)
       //  self.VerficationsLbl.font = UIFont(name: SemiBoldFont, size: 15)
          self.lbl_emailVerificatn.font = UIFont(name: RegularFont, size: 13)
         self.lbl_phoneVerification.font = UIFont(name: RegularFont, size: 13)
           self.GreetingTxt.font = UIFont(name: RegularFont, size: 12)
        
        self.EmailVerificationLbl.font = UIFont(name: SemiBoldFont, size: 20)
        self.EnterVerificationCodeLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.EnterVerificationCodeTxf.font = UIFont(name: SemiBoldFont, size: 15)
        self.EmailOkBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
        self.EmailCancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
        
        
        if  login_session.value(forKey: "APP_CURRENCY") as? String == nil || login_session.value(forKey: "APP_CURRENCY_SYMBOL") as? String == nil {
            login_session.setValue("USD" , forKey: "APP_CURRENCY")
            login_session.setValue("$" , forKey: "APP_CURRENCY_SYMBOL")
            login_session.synchronize()
        }
        self.Img_Profile.layer.masksToBounds = true
        self.Img_Profile.layer.cornerRadius = 35
    }
        override func viewWillAppear(_ animated: Bool) {
            let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
            if choose == "en"
            {
                self.emailVerificationSuccess = LocalizeHelper().localizedStringForKey("emailverified")
                self.emailVerficationFailure = LocalizeHelper().localizedStringForKey("emailnotverified")
                self.mobileNumberVerified = LocalizeHelper().localizedStringForKey("mobileverified")
                self.mobileNumberNotVerified = LocalizeHelper().localizedStringForKey("mobilenotverified")
                self.viewTitle.text = LocalizeHelper().localizedStringForKey("profile")
//                self.verifications.text = LocalizeHelper().localizedStringForKey("verifications")
            }
            Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
            let id = Singleton.sharedInstance.selectedCategory!
            if (Reachability()?.isReachable)!
            {
                self.showActivityIndicator(uiView: self.view)
                
                var params = NSMutableDictionary()
                
               
                 params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","currency_code":login_session.value(forKey: "APP_CURRENCY")!,"userid":self.hostID,"base_id":id]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(USER_INFO_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        print("GET_WISHLIST_API Response:::",responseDict)
                        let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.userInfoModel = mod
                        if mod.propertyListing.count != 0
                        {
                            
                            self.tbl_HostListings.reloadData()
                        }
                        let profinfo = responseDict.value(forKey: "profileinfo") as? NSArray
                        let prolistings = responseDict.value(forKey: "property_listing") as? NSArray
                        for items in 0..<prolistings!.count
                        {
                            
                            let listingdict = prolistings![items] as! NSDictionary
                            self.prop_id = (listingdict.value(forKey: "property_id") as? Int)!
                        }
                        
                        
                        for details in 0..<profinfo!.count
                        {
                            let dict = profinfo![details] as! NSDictionary
                            self.lbl_Email.text = dict.value(forKey: "email") as? String
                            self.lbl_Name.text = dict.value(forKey: "firstname") as? String
                            self.lbl_PhoneNum.text = dict.value(forKey: "phone_no") as? String
                            self.lbl_Work.text = dict.value(forKey: "work") as? String
                            // self.Img_Profile.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
                            // self.Img_Profile.kf.setImage(with: (urlString: (dict.value(forKey: "user_image") as? String)!) as! Resource, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                            
                        }
                        
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
                
                
                
//                let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&currency_code=\(login_session.value(forKey: "APP_CURRENCY")!)&userid=\(self.hostID)&base_id=\(id)"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: USER_INFO_API, APIKEY: "USER_INFO_API")
            }
            else
            {
                self.showInformation(title: "Closest", message: "Check your internet connection")
            }
        }
  
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     //MARK:- Button Actions

    @IBAction func act_backBtn(_ sender: UIButton)
    {
      self.navigationController?.popViewController(animated: true)
      self.hideActivityIndicator(uiView: self.view)
    }
    
    @IBAction func act_EmailCancel(_ sender: UIButton)
    {
        self.EmailVerificationGrayView.isHidden = true
        
    }
    @IBAction func act_emailOk(_ sender: UIButton)
    {
        if self.EnterVerificationCodeTxf.text == "" {
             self.showInformation(title: "Closest", message: "Field cannot be empty")
        }else if self.EnterVerificationCodeTxf.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Field cannot be empty")

        } else{
            print("email verify tapped")
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","u_email":login_session.value(forKey: "Email") as! String,
                          "email_otp":self.EnterVerificationCodeTxf.text!]
               // params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","u_email":login_session.value(forKey: "Email") as! String,"userid":self.hostID] "userid":login_session.value(forKey: "UserId")!
                
               
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(CHECKEMAILVERIFICATION, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.lbl_emailVerificatn.text = "Email id verified"

                        self.EmailVerificationGrayView.isHidden = true
                        
                        self.showInformation(title: "Closest", message: "Email successfully verified")
                    }
                        
                    else {
                        
                        self.lbl_emailVerificatn.text = "Email id not verified"
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
            } else
            {
                self.showInformation(title: "Closest", message: "Check your internet connection")
            }
        }
        
    }
    
    @IBAction func act_emailVerifybtnTapped(_ sender: UIButton)
    {
         Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if self.lbl_emailVerificatn.text == "Email id verified" {
             self.showInformation(title: "Closest", message: "Email already verified")
        }else{
            print("email verify tapped")
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","u_email":login_session.value(forKey: "Email") as! String]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EMAILVERIFICATION, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.EmailVerificationGrayView.isHidden = false
//                        self.showInformation(title: "Closest", message: "Email successfully verified")
//                        self.lbl_emailVerificatn.text = "Email id verified"
                    }
                        
                    else {
                        
                        self.lbl_emailVerificatn.text = "Email id not verified"
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
            } else
            {
                self.showInformation(title: "Closest", message: "Check your internet connection")
            }
        }
       

    }
    
    @IBAction func act_mobileVerifybtnTapped(_ sender: UIButton)
    {
        print("mobile verify tapped")

    }
}


extension EditProfileViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if Singleton.sharedInstance.userInfoModel != nil
            {
                return Singleton.sharedInstance.userInfoModel.propertyListing.count
            }
            else
            {
                return 0
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HostpropCell
        
        cell?.lbl_PropName.font = UIFont(name: SemiBoldFont, size: 14)
        cell?.lbl_LocationProp.font = UIFont(name: SemiBoldFont, size: 14)
        
        cell?.lbl_PropName.textColor = AppColor
        
             cell?.lbl_PropName.text = Singleton.sharedInstance.userInfoModel.propertyListing[indexPath.row].propertyTitle
             cell?.lbl_LocationProp.text = Singleton.sharedInstance.userInfoModel.propertyListing[indexPath.row].propertyAddress
            let imgurl = URL(string: Singleton.sharedInstance.userInfoModel.propertyListing[indexPath.row].propertyImage!)
             cell?.img_Property.kf.setImage(with: imgurl)
            return cell!
        }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailViewController") as? PropertyDetailViewController
//        nav!.headerTxt =  Singleton.sharedInstance.userInfoModel.propertyListing[indexPath.row].propertyAddress!.uppercased()
//            nav!.base_ID = Singleton.sharedInstance.selectedCategory
//           // nav!.PROP_ID = self.prop_id
//        nav!.PROP_ID = Singleton.sharedInstance.userInfoModel.propertyListing[indexPath.row].propertyId!
//
//        self.navigationController?.pushViewController(nav!, animated: true)
}
}

//MARK:- HTTP Reponse Method
extension EditProfileViewController : HTTP_POST_STRING_REQUEST_PROTOCOL
{
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String)
    {
        self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "USER_INFO_API"
        {
            if errorDict.count == 0
            {
                let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.userInfoModel = mod
                if mod.propertyListing.count != 0
                {
                    
                    self.tbl_HostListings.reloadData()
                }
            let profinfo = responseDict.value(forKey: "profileinfo") as? NSArray
           let prolistings = responseDict.value(forKey: "property_listing") as? NSArray
          for items in 0..<prolistings!.count
            {
            
                let listingdict = prolistings![items] as! NSDictionary
                prop_id = (listingdict.value(forKey: "property_id") as? Int)!
                }

                
            for details in 0..<profinfo!.count
            {
                let dict = profinfo![details] as! NSDictionary
                 self.lbl_Email.text = dict.value(forKey: "email") as? String
                 self.lbl_Name.text = dict.value(forKey: "firstname") as? String
                 self.lbl_PhoneNum.text = dict.value(forKey: "phone_no") as? String
                 self.lbl_Work.text = dict.value(forKey: "work") as? String
                // self.Img_Profile.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
               // self.Img_Profile.kf.setImage(with: (urlString: (dict.value(forKey: "user_image") as? String)!) as! Resource, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

            }

            }
        else
        {
            print("No data")
        }
        }
        else
        {
            print("No data")
        }

}
}
