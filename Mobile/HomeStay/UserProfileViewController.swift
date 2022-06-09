//
//  UserProfileViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 07/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Kingfisher
import AFNetworking

class UserProfileViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var btn_EditProfile: UIButton!
    @IBOutlet weak var lbl_emailVerificatn: UILabel!
    @IBOutlet weak var lbl_phoneVerification: UILabel!
    @IBOutlet weak var btn_emailVerify: UIButton!
    @IBOutlet weak var btn_mobileVerify: UIButton!

    @IBOutlet weak var TitleLbl: UILabel!
     @IBOutlet weak var VerficationsLbl: UILabel!
      @IBOutlet weak var GreetingTxt: UILabel!
    
    @IBOutlet weak var EmailVerificationGrayView: UIView!
    @IBOutlet weak var EmailVerificationLbl: UILabel!
    @IBOutlet weak var EnterVerificationCodeLbl: UILabel!
    @IBOutlet weak var EnterVerificationCodeTxf: UITextField!
    @IBOutlet weak var EmailCancelBtn: UIButton!
    @IBOutlet weak var EmailOkBtn: UIButton!

    
    

    
    var userName = String()
    var usermail = String()
    var userPhonenum = String()
    var Profile_Arr = [UserInfo]()
    var userAbt = String()
    var Work = String()
    var aboutMe = String()
    var ImgStr = String()
    var selectedRow = 0
    
    //MARK:- Variables
   // let listArr = ["Listings","Reviews","Disputes","Cancel","WishList"]
    //let listBtnArr = ["VIEW ALL LISTINGS","VIEW ALL REVIEWS","VIEW ALL DISPUTES","VIEW ALL CANCEL","VIEW ALL WISHLISTINGS"]
    let listArr = ["Listings","Reviews","User Cancellation","Boat Cancellation","Disputes","WishList"]
    let listBtnArr = ["VIEW ALL LISTINGS","VIEW ALL REVIEWS","VIEW ALL DISPUTES","VIEW ALL CANCEL","VIEW ALL CANCEL","VIEW ALL WISHLISTINGS"]
    //let listArr = ["Listings","Reviews","Disputes","WishList"]
   // let listBtnArr = ["VIEW ALL LISTINGS","VIEW ALL REVIEWS","VIEW ALL DISPUTES","VIEW ALL WISHLISTINGS"]

    //MARK:- Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.imgUser.layer.cornerRadius = 35
        self.imgUser.layer.masksToBounds = true
        self.imgUser.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.TitleLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.lblUserName.font = UIFont(name: SemiBoldFont, size: 17)
         self.lblEmail.font = UIFont(name: RegularFont, size: 14)
          self.lblPhone.font = UIFont(name: RegularFont, size: 14)
         self.VerficationsLbl.font = UIFont(name: SemiBoldFont, size: 17)
          self.lbl_emailVerificatn.font = UIFont(name: RegularFont, size: 15)
         self.lbl_phoneVerification.font = UIFont(name: RegularFont, size: 15)
           self.GreetingTxt.font = UIFont(name: RegularFont, size: 14)
        
        self.EmailVerificationLbl.font = UIFont(name: SemiBoldFont, size: 20)
        self.EnterVerificationCodeLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.EnterVerificationCodeTxf.font = UIFont(name: SemiBoldFont, size: 15)
        self.EmailOkBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
        self.EmailCancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)

        
        
        self.tblProfile.isHidden = true
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
             params = ["language":login_session.value(forKey: "APP_LANGUAGE") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"userid":login_session.value(forKey: "UserId")]
            
           print(params)
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(USER_INFO_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.tblProfile.isHidden = false
                    let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.userInfoModel = mod
                    
                    
                    let profinfo = responseDict.value(forKey: "profileinfo") as? NSArray
                    let trustverify = responseDict.value(forKey: "trust_verify") as? NSArray
                    for details in 0..<profinfo!.count
                    {
                        let dict = profinfo![details] as! NSDictionary
                        self.lblPhone.text = dict.value(forKey: "phone_no") as? String
                        self.userPhonenum = self.lblPhone.text!
                        self.lblEmail.text = dict.value(forKey: "email") as? String
                        self.lblUserName.text = dict.value(forKey: "firstname") as? String
                        // self.imgUser.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
                        
                        let imageType = (dict.value(forKey: "user_image"))!
                        if let image = imageType as? UIImage
                        {
                            self.imgUser.image = image
                            
                        }
                        else
                        {
                            
                             login_session.setValue((dict.value(forKey: "user_image") as? String)!, forKey: "ProfilePic")
                            let url = URL(string:((dict.value(forKey: "user_image") as? String)!))
                            
                            self.imgUser.kf.setImage(with: url, placeholder:UIImage(named:"user"))
                            
                        }
                        
                        //self.imgUser.kf.setImage(with: ((urlString: (dict.value(forKey: "user_image") as? String)!) as! Resource), placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                        
                        let userWork = dict.value(forKey: "work") as? String
                        self.Work = userWork!
                        let abtMe = dict.value(forKey: "description") as? String
                        self.aboutMe = abtMe!
                        //self.imgUser.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
                        self.ImgStr = (dict.value(forKey: "user_image") as? String)!
                        UserDefaults.standard.setValue(self.ImgStr, forKey: "USER_IMAGE")
                    }
                    
                    for verifications in 0..<trustverify!.count
                    {
                        let resultdict = trustverify![verifications] as! NSDictionary
                        let mailidverify = resultdict.value(forKey: "email_id_verified") as? Int
                        if mailidverify == 0
                        {
                            self.lbl_emailVerificatn.text = "Email id not verified"
                        }
                        else
                        {
                            self.lbl_emailVerificatn.text = "Email id verified"
                        }
                        
                        let phoneverify = resultdict.value(forKey: "phone_verified") as? Int
                        
                        if phoneverify == 0
                        {
                            self.lbl_phoneVerification.text = "Mobile not verified"
                        }
                        else
                        {
                            self.lbl_phoneVerification.text = "Mobile number verified"
                        }
                    }
                    self.tblProfile.reloadData()
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
            
            
            
            
//            self.showActivityIndicator(uiView: self.view)
//            let parameterStr = "language=\(login_session.value(forKey: "APP_LANGUAGE") as! String)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&userid=\(login_session.value(forKey: "UserId")!)"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: USER_INFO_API, APIKEY: "USER_INFO_API")
//            print(parameterStr)
        } else
        {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }

        if UserDefaults.standard.value(forKey: "ProfileImage") != nil {
            if UserDefaults.standard.value(forKey: "ProfileImage") as! String != "" {
               // imgUser.imageFromURL(urlString:  UserDefaults.standard.value(forKey: "ProfileImage") as! String)
                
                let profileImage = URL(string: UserDefaults.standard.value(forKey: "ProfileImage") as! String)
               imgUser.kf.setImage(with: profileImage, placeholder:UIImage(named:"user"))
                
               // imgUser.kf.setImage(with: ((urlString:  UserDefaults.standard.value(forKey: "ProfileImage") as! String) as! Resource), placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

                //let wishlistImgUrl = URL(string: UserDefaults.standard.value(forKey: "ProfileImage") as! String)
                //imgUser.kf.setImage(with:wishlistImgUrl!)
            }
        }
        
      //  let url = URL(string: ((login_session.value(forKey: "ProfilePic") as? String)!))
      //   imgUser.kf.setImage(with: url, placeholder:UIImage(named:"user"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
              var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
              
              if (cString.hasPrefix("#")) {
                  cString.remove(at: cString.startIndex)
              }
              
              if ((cString.count) != 6) {
                  return UIColor.gray
              }
              
              var rgbValue:UInt32 = 0
              Scanner(string: cString).scanHexInt32(&rgbValue)
              
              return UIColor(
                  red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0)
              )
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
    
    @IBAction func act_Editbtn(_ sender: UIButton) {
        let navg = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        navg?.phoneNum = self.userPhonenum
        navg?.work = self.Work
        navg?.abtMe = self.aboutMe
        navg?.UserImg = self.ImgStr
        self.navigationController?.pushViewController(navg!, animated: true)
    }
    @IBAction func act_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
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
               // params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","u_email":login_session.value(forKey: "Email") as! String,"userid":self.hostID] "userid":login_session.value(forKey: "UserId")!
                
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
                        
                        //self.showInformation(title: "Closest", message: "Email successfully verified")
                      //  self.lbl_emailVerificatn.text = "Email id verified"
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
    
    @IBAction func act_Search(_ sender: UIButton) {
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
    @IBAction func act_Home(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
        self.navigationController?.pushViewController(nav!, animated: true)
    }
}

extension UserProfileViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.userInfoModel != nil {
            return listArr.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserProfileCell
//        cell!.bgView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
//        cell!.lblName.text = listArr[indexPath.row]
//        cell!.btnViewAll.tag = indexPath.row
//        cell!.btnViewAll.setTitle(listBtnArr[indexPath.row], for: .normal)
//        cell!.btnViewAll.addTarget(self, action: #selector(ViewAll), for: .touchUpInside)
//        return cell!
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserProfileCell
          //  cell!.bgView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
            cell!.lblName.text = listArr[indexPath.row]
            cell!.btnViewAll.tag = indexPath.row
            cell?.countLbl.isHidden = true
            cell!.selectionStyle = .none
             cell!.lblName.font = UIFont(name: RegularFont, size: 14)
         cell!.countLbl.font = UIFont(name: RegularFont, size: 13)
        
        if self.selectedRow == indexPath.row {
            cell!.lblName.textColor = AppSecondColor
            cell!.btnViewAll.setImage(UIImage(named: "arrow-left4"), for: .normal)
        }else{
            cell!.lblName.textColor = .darkGray
            cell!.btnViewAll.setImage(UIImage(named: "arrow-left"), for: .normal)
        }
        
        cell!.countLbl.backgroundColor = AppSecondColor
        
        cell!.btnViewAll.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
            if indexPath.row == 2
            {
                let newnumber:Int = Singleton.sharedInstance.userInfoModel.profileinfo[0].cancellationAboutYouCount + Singleton.sharedInstance.userInfoModel.profileinfo[0].cancellationByYouCount
                print(newnumber)
                
                if  String(format: "%d", newnumber) == "0"
                {
                    cell?.countLbl.isHidden = true
                    
                }
                else
                {
                   
                    cell?.countLbl.text =  String(format: "%d", newnumber)
                    cell?.countLbl.isHidden = false
                    cell?.countLbl.layer.cornerRadius = 10
                    cell?.countLbl.layer.masksToBounds = true
                }
                
                
            }
            else if indexPath.row == 4
            {
                
                let newnumber:Int = Singleton.sharedInstance.userInfoModel.profileinfo[0].disputeByYouCount + Singleton.sharedInstance.userInfoModel.profileinfo[0].disputeAboutYouCount
                print(newnumber)
                
                if  String(format: "%d", newnumber) == "0"
                {
                    cell?.countLbl.isHidden = true
                    
                }
                else
                {
                    
                    cell?.countLbl.text =  String(format: "%d", newnumber)
                    cell?.countLbl.isHidden = false
                    cell?.countLbl.layer.cornerRadius = 10
                    cell?.countLbl.layer.masksToBounds = true
                }
                
            }
            else
            {
                
                cell?.countLbl.isHidden = true
            }
            
            cell!.btnViewAll.setTitle(listBtnArr[indexPath.row], for: .normal)
            cell!.btnViewAll.addTarget(self, action: #selector(ViewAll), for: .touchUpInside)
            
            
            return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        self.tblProfile.reloadData()
        let btnRowID = indexPath.row
        print("btnRow is :", btnRowID)
        if btnRowID == 0 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 1 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsShowViewController") as? ReviewsShowViewController
            
            
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 2 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "UserCancellationViewController") as? UserCancellationViewController//ReviewsViewController
           // navg!.selectId = btnRowID
            
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 3 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "HostCancellationViewController") as? HostCancellationViewController
            
            
            self.navigationController?.pushViewController(navg!, animated: true)
        }
        else if  btnRowID == 4 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
            navg!.selectId = btnRowID
            self.navigationController?.pushViewController(navg!, animated: true)
        }else if  btnRowID == 5 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "WishListController") as? WishListController
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else {
            
        }
        
    }
    
    
    @objc func ViewAll(sender: UIButton)
    {
        let btnRowID = sender.tag
        print("btnRow is :", btnRowID)
        if btnRowID == 0 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 1 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsShowViewController") as? ReviewsShowViewController
            
            
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 2 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "UserCancellationViewController") as? UserCancellationViewController//ReviewsViewController
           // navg!.selectId = btnRowID
            
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else if  btnRowID == 3 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "HostCancellationViewController") as? HostCancellationViewController
            //            navg!.selectId = btnRowID
            //             navg!.Reviewsby = "CANCELLED BY YOU"
            //            navg!.ReviewsAbt = "CANCELLED ABOUT YOU"
            
            self.navigationController?.pushViewController(navg!, animated: true)
        }
        else if  btnRowID == 4 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
            navg!.selectId = btnRowID
            self.navigationController?.pushViewController(navg!, animated: true)
        }else if  btnRowID == 5 {
            let navg = self.storyboard?.instantiateViewController(withIdentifier: "WishListController") as? WishListController
            self.navigationController?.pushViewController(navg!, animated: true)
            
        }else {
            
        }
        
    }
//    @objc func ViewAll(sender: UIButton)
//    {
//        let btnRowID = sender.tag
//        print("btnRow is :", btnRowID)
//        if btnRowID == 0 {
//            let navg = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
//            self.navigationController?.pushViewController(navg!, animated: true)
//
//        }else if  btnRowID == 1 {
//            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
//            navg!.selectId = btnRowID
//            navg!.isReviewabtYou = true
//            self.navigationController?.pushViewController(navg!, animated: true)
//
//        }else if  btnRowID == 2 {
//            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
//            navg!.selectId = btnRowID
//            navg!.isDisputeabtYou = true
//            self.navigationController?.pushViewController(navg!, animated: true)
//
//        }
//        else if  btnRowID == 3
//        {
//            let navg = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
//            navg!.selectId = btnRowID
//            navg!.isDisputeabtYou = true
//            self.navigationController?.pushViewController(navg!, animated: true)
//        }
//        else if  btnRowID == 4 {
//            let navg = self.storyboard?.instantiateViewController(withIdentifier: "WishListController") as? WishListController
//            self.navigationController?.pushViewController(navg!, animated: true)
//
//        }else {
//
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
        
    }
}

extension UserProfileViewController : HTTP_POST_STRING_REQUEST_PROTOCOL
{
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "USER_INFO_API"
        {
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            let profinfo = responseDict.value(forKey: "profileinfo") as? NSArray
            let trustverify = responseDict.value(forKey: "trust_verify") as? NSArray
            for details in 0..<profinfo!.count
            {
                let dict = profinfo![details] as! NSDictionary
                self.lblPhone.text = dict.value(forKey: "phone_no") as? String
                userPhonenum = self.lblPhone.text!
                self.lblEmail.text = dict.value(forKey: "email") as? String
                self.lblUserName.text = dict.value(forKey: "firstname") as? String
               // self.imgUser.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
                
                let imageType = (dict.value(forKey: "user_image"))!
                if let image = imageType as? UIImage
                {
                    self.imgUser.image = image
                    
                }
                else
                {
                    let url = URL(string:((dict.value(forKey: "user_image") as? String)!))
                    
                    self.imgUser.kf.setImage(with: url)
                    
                }
                
                //self.imgUser.kf.setImage(with: ((urlString: (dict.value(forKey: "user_image") as? String)!) as! Resource), placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

                let userWork = dict.value(forKey: "work") as? String
                self.Work = userWork!
                let abtMe = dict.value(forKey: "description") as? String
                self.aboutMe = abtMe!
                //self.imgUser.imageFromURL(urlString: (dict.value(forKey: "user_image") as? String)!)
                self.ImgStr = (dict.value(forKey: "user_image") as? String)!
                UserDefaults.standard.setValue(self.ImgStr, forKey: "USER_IMAGE")
            }
            
            for verifications in 0..<trustverify!.count
            {
                let resultdict = trustverify![verifications] as! NSDictionary
                let mailidverify = resultdict.value(forKey: "email_id_verified") as? Int
                if mailidverify == 0
                {
                    self.lbl_emailVerificatn.text = "Email id not verified"
                }
                else
                {
                    self.lbl_emailVerificatn.text = "Email id verified"
                }
                
                let phoneverify = resultdict.value(forKey: "phone_verified") as? Int
                
                if phoneverify == 0
                {
                    self.lbl_phoneVerification.text = "Mobile not verified"
                }
                else
                {
                    self.lbl_phoneVerification.text = "Mobile number verified"
                }
            }
            
        }
        else if APIKEY == "UPDATE_USER_PROF_API"
        {
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0
            {
            
            
            self.showInformation(title: "Closest", message: "Email successfully verified")
            self.lbl_emailVerificatn.text = "Email id verified"
            }
            else
            {
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                self.lbl_emailVerificatn.text = "Email id not verified"
            }

        }
        else
        {
            print("No Data")
        }
    }
}
