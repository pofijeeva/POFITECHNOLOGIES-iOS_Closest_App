//
//  NewProfileViewController.swift
//  HomeStay
//
//  Created by M.NAGENDRANATH REDDY on 14/08/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
//import CountryList
import MobileCoreServices
import AVFoundation
import Photos
import Alamofire
import FlagPhoneNumber
import AFNetworking
import SideMenu

class NewProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    
    var verifiedType = ""
    var MobileNum = ""
    
    var cou = CountryList()
    
    @IBOutlet var MoveView: UIView!
    @IBOutlet var MoveCollection: UICollectionView!
    
    @IBOutlet var PImageview: UIImageView!
    @IBOutlet var TVImageview: UIImageView!
    @IBOutlet weak var phoneNumberVerifyStatsImageV: UIImageView!
    @IBOutlet var PFirstName: UITextField!
    @IBOutlet var PLastName: UITextField!
    @IBOutlet var PEmailAddress: UITextField!
    @IBOutlet var PPhoneNumber: UITextField!
    @IBOutlet var TVPhoneNumber: FPNTextField!
    
    @IBOutlet weak var phoneNumberDescTestHeight: NSLayoutConstraint!
    @IBOutlet weak var phoneNumberLblDescTestHeight: NSLayoutConstraint!
    @IBOutlet weak var otpLblHeight: NSLayoutConstraint!
    @IBOutlet weak var otpTextFieldHeight: NSLayoutConstraint!
    // @IBOutlet weak var phoneNumberFieldTestHeight: NSLayoutConstraint!
    // @IBOutlet weak var phoneNumberTextFieldTestHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var TVlblPhoneNumber: UILabel!
    @IBOutlet weak var PhoneNumberlbl: UILabel!
    @IBOutlet weak var PhoneNumbertext:UILabel!
    @IBOutlet weak var PhoneNumberVerificationtext:UILabel!
    
    
    @IBOutlet weak var TVEmailAddressVerifyLbl: UILabel!
    @IBOutlet weak var TVPhoneNumberVerifyLbl: UILabel!
    @IBOutlet weak var TVbtnChange: UIButton!
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var changePassword: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var viewTrustandVerification: UIView!
    @IBOutlet weak var viewPassportverify: UIView!
    @IBOutlet weak var verificationListView: UITableView!
    
    @IBOutlet weak var btnPVPassword: UIButton!
    @IBOutlet weak var btnPVVoterid: UIButton!
    @IBOutlet weak var btnPVDrivingLicense: UIButton!
    @IBOutlet weak var btnProfileSubmit: UIButton!
    @IBOutlet weak var btnTVEmail: UIButton!
    @IBOutlet weak var btnTVSms: UIButton!
    @IBOutlet weak var btnTVSave: UIButton!
    @IBOutlet weak var btnPVSave: UIButton!
    @IBOutlet weak var btnTVSubmit: UIButton!
    @IBOutlet weak var verificationImageV: UIImageView!
    @IBOutlet weak var nofileChoosen: UILabel!
    @IBOutlet weak var verificationListTV: UITableView!
    @IBOutlet var txtpassword: UITextField!
    @IBOutlet var txtChangePassword: UITextField!
    @IBOutlet var txtOldpassword: UITextField!
    @IBOutlet var headerLbl: UILabel!
    
    @IBOutlet weak var BtnPasswordSave: UIButton!
    
    
    @IBOutlet weak var VerifyNowBtn: UIButton!
    @IBOutlet var PFirstNameLbl: UILabel!
    @IBOutlet var PLastNameLbl: UILabel!
    @IBOutlet var PEmailAddressLbl: UILabel!
    @IBOutlet var PPhoneNumberLbl: UILabel!
    @IBOutlet var verifyBtn: UIButton!
    
    
    @IBOutlet var UploadnewImg: UILabel!
    @IBOutlet var MaximumLbl: UILabel!
    
    @IBOutlet var EmailVerficationLbl: UILabel!
    @IBOutlet var PhoneNumVerficationLbl: UILabel!
    @IBOutlet var verficationListLbl: UILabel!
    @IBOutlet var VerificationList: UILabel!
    @IBOutlet var passportLbl: UILabel!
    @IBOutlet var VoterIdLbl: UILabel!
    @IBOutlet var DrivingLbl: UILabel!
    
    @IBOutlet var UploadYourDocumentLbl: UILabel!
    @IBOutlet var UploadPictureLbl: UILabel!
    @IBOutlet var NoteLbl: UILabel!
    @IBOutlet var NoteLbl1: UILabel!
    @IBOutlet var NoteUpload: UILabel!
    @IBOutlet var NoteUpload1: UILabel!
    @IBOutlet var BtnChoose: UIButton!
    @IBOutlet var verficationTypeLbl: UILabel!
    
    var Array : NSMutableArray = []
    var SelectedRow = 0
    var idVerifyStatus: Int = 0
    var idProofImgUrl: String = ""
    var SelectedIndex : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        
        //        phoneNumberTextField.delegate = self
        verificationListTV.tableFooterView = UIView()
        
        btnProfileSubmit.layer.cornerRadius = 20
        btnTVEmail.layer.cornerRadius = 20
        btnTVSms.layer.cornerRadius = 20
        btnPVSave.layer.cornerRadius = 20
        TVbtnChange.layer.cornerRadius = 20
        btnTVSubmit.layer.cornerRadius = 20
        btnTVEmail.backgroundColor = AppSecondColor1
        btnTVSubmit.backgroundColor = AppSecondColor1
        btnTVSms.backgroundColor = AppSecondColor1
        btnPVSave.backgroundColor = AppSecondColor1
        TVbtnChange.backgroundColor = AppSecondColor1
        btnProfileSubmit.backgroundColor = AppSecondColor1
        BtnPasswordSave.backgroundColor = AppSecondColor1
        BtnPasswordSave.layer.cornerRadius = 25
        
        
        
        PImageview.layer.borderWidth = 1
        PImageview.layer.masksToBounds = false
        PImageview.layer.borderColor = UIColor.black.cgColor
        PImageview.layer.cornerRadius = PImageview.frame.height/2
        PImageview.clipsToBounds = true
        
        
        
        
        //        TVPhoneNumber.setLeftIcon()
        
        // Do any additional setup after loading the view.
        //        TVPhoneNumber.leftView?.isHidden = false
        TVPhoneNumber.setFlag(key: .IN)
        TVPhoneNumber.set(phoneNumber: "1234567890")
        TVPhoneNumber.delegate = self
        PFirstName.text =    login_session.value(forKey: "Firstname") as? String
        PLastName.text = login_session.value(forKey: "Lastname") as? String
        PEmailAddress.text =   login_session.value(forKey: "Email") as? String
        PPhoneNumber.text =  login_session.value(forKey: "PhoneNumber") as? String
        
        if (login_session.value(forKey: "verificationStatus") as? String  == "Verified"){
            self.TVEmailAddressVerifyLbl.text = "Verified"
            self.TVImageview.image = #imageLiteral(resourceName: "check-circle")
            self.btnTVEmail.isHidden = true
        }
        
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            PhoneNumberVerificationtext.textAlignment = .left
            txtOldpassword.textAlignment = .left
            txtChangePassword.textAlignment = .left
            txtpassword.textAlignment = .left
            PFirstNameLbl.textAlignment = .left
            PFirstName.textAlignment = .left
            PLastNameLbl.textAlignment = .left
            PLastName.textAlignment = .left
            PEmailAddressLbl.textAlignment = .left
            PEmailAddress.textAlignment = .left
            PPhoneNumberLbl.textAlignment = .left
            PPhoneNumber.textAlignment = .left
            
            
            
        }else{
            PhoneNumberVerificationtext.textAlignment = .right
            txtOldpassword.textAlignment = .right
            txtChangePassword.textAlignment = .right
            txtpassword.textAlignment = .right
            PFirstNameLbl.textAlignment = .right
            PFirstName.textAlignment = .right
            PLastNameLbl.textAlignment = .right
            PLastName.textAlignment = .right
            PEmailAddressLbl.textAlignment = .right
            PEmailAddress.textAlignment = .right
            PPhoneNumberLbl.textAlignment = .right
            PPhoneNumber.textAlignment = .right
        }
        
        PFirstName.font = UIFont(name: SemiBoldFont, size: 15)
        PLastName.font = UIFont(name: SemiBoldFont, size: 15)
        PEmailAddress.font = UIFont(name: SemiBoldFont, size: 15)
        PPhoneNumber.font = UIFont(name: SemiBoldFont, size: 15)
        UploadnewImg.font = UIFont(name: SemiBoldFont, size: 16)
        MaximumLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        PFirstNameLbl.font = UIFont(name: SemiBoldFont, size: 15)
        PLastNameLbl.font = UIFont(name: SemiBoldFont, size: 15)
        PEmailAddressLbl.font = UIFont(name: SemiBoldFont, size: 15)
        PPhoneNumberLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        EmailVerficationLbl.font = UIFont(name: SemiBoldFont, size: 16)
        PhoneNumberVerificationtext.font = UIFont(name: SemiBoldFont, size: 16)
        PhoneNumberlbl.font = UIFont(name: SemiBoldFont, size: 15)
        PhoneNumbertext.font = UIFont(name: SemiBoldFont, size: 15)
        TVlblPhoneNumber.font = UIFont(name: SemiBoldFont, size: 15)
        nofileChoosen.font = UIFont(name: SemiBoldFont, size: 15)
        NoteLbl.font = UIFont(name: SemiBoldFont, size: 15)
        NoteLbl1.font = UIFont(name: SemiBoldFont, size: 15)
        NoteUpload.font = UIFont(name: SemiBoldFont, size: 15)
        NoteUpload1.font = UIFont(name: SemiBoldFont, size: 15)
        verficationTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)
        passportLbl.font = UIFont(name: SemiBoldFont, size: 15)
        VoterIdLbl.font = UIFont(name: SemiBoldFont, size: 15)
        DrivingLbl.font = UIFont(name: SemiBoldFont, size: 15)
        TVEmailAddressVerifyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        TVPhoneNumberVerifyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        TVPhoneNumber.font = UIFont(name: SemiBoldFont, size: 15)
        UploadYourDocumentLbl.font = UIFont(name: SemiBoldFont, size: 15)
        UploadPictureLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.VerifyNowBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
        self.btnTVEmail.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.VerificationList.font = UIFont(name: SemiBoldFont, size: 16)
        self.TVbtnChange.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.btnTVSubmit.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.btnTVSms.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.BtnChoose.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.btnProfileSubmit.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.btnPVSave.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        txtpassword.font = UIFont(name: SemiBoldFont, size: 15)
        self.txtOldpassword.font = UIFont(name: SemiBoldFont, size: 15)
        txtChangePassword.font = UIFont(name: SemiBoldFont, size: 15)
        self.BtnPasswordSave.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.BtnPasswordSave.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.btnProfileSubmit.setTitle(GlobalLanguageDictionary.object(forKey: "key_update") as? String ?? "", for: .normal)
        self.VerifyNowBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_verifyNow") as? String ?? "", for: .normal)
        self.VerifyNowBtn.titleLabel?.textColor = AppColor
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            getUserInfo()
            self.Array = ["  Account  ","  Trust & Verification  ","  Change password  "]
            if self.SelectedIndex == "VerifyNow"{
                self.SelectedRow = 1
                self.Trust_Verification()
                
                self.viewProfile.isHidden = true
                self.changePassword.isHidden = true
                self.viewPassportverify.isHidden = false
                self.viewTrustandVerification.isHidden = false
                self.verificationListTV.isHidden = false
                self.MoveCollection.reloadData()
            }
        }else{
            showSimpleAlert()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
        }else{
            showSimpleAlert()
            
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        var maxLength = 12
        if (self.TVPhoneNumber.placeholder == "Enter OTP"){
            maxLength = 8
        }
        let currentString: NSString = TVPhoneNumber.text! as NSString
        let newString: String = currentString.replacingCharacters(in: range, with: string) as String
        return newString.count <= maxLength
    }
    
    
    
    // USER_INFO_API
    func getUserInfo() {
        let parameters:[String : Any] =
        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en"]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: USER_INFO_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                
                //                        let userData = responseDict["data"] as! [String : Any]
                //                        let userDetails = userData["user_details"] as! [String: Any]
                //                        self.TVPhoneNumber.text = "+91\(userDetails["phone_no"] as? String ?? "")"
                //                        let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                //                        Singleton.sharedInstance.homeModel = mod
                
                let userData = responseDict["data"] as! [String : Any]
                let userDetails = userData["user_details"] as! [String: Any]
                
                let UserDetails = NSMutableDictionary()
                UserDetails.addEntries(from: ((responseDict.value(forKey: "data") as? NSDictionary)?.object(forKey: "user_details") as? NSDictionary) as? [AnyHashable : Any] ?? [:])
                self.TVPhoneNumber.text = "\(userDetails["phone_no"] as? String ?? "")"
                let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.homeModel = mod
                let VerifyNowStatus = "\(UserDetails.object(forKey: "email_id_verified") as AnyObject)"
                if VerifyNowStatus == "0" {
                    self.VerifyNowBtn.isHidden = false
                }else{
                    self.VerifyNowBtn.isHidden = true
                }
                
                self.PFirstName.text = UserDetails.object(forKey: "firstname") as? String ?? ""  //login_session.value(forKey: "Firstname") as? String
                self.PLastName.text = UserDetails.object(forKey: "lastname") as? String ?? ""
                self.PEmailAddress.text = UserDetails.object(forKey: "email") as? String ?? ""
                self.PPhoneNumber.text = UserDetails.object(forKey: "phone_no") as? String ?? ""
                let UrlStr = UserDetails.object(forKey: "user_image") as? String ?? ""
                self.PImageview.imageFromURL(urlString: UrlStr)
                
            }
            else
            {
                
                //   self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                //self.showInformation(title: AppName, message: responseDict.value(forKey:"message") as? String ?? "")
            }
            
            
        }
    }
    
    @IBAction func PAct_Submit(_ sender: Any) {
        
        
        let parameters:[String : Any] =
        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
         "u_first_name":PFirstName.text ?? "" , "u_last_name":PLastName.text ?? "" ,
         "u_phone":PPhoneNumber.text ?? "","email": login_session.value(forKey: "Email") as? String ?? ""
        ]
        print(parameters)
        //Header HERE
        let headers = [
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]
        let postheaders : HTTPHeaders = HeaderManager.headers()
        
        let imgData = self.PImageview.image!.jpegData(compressionQuality: 0.7)!
        
        AF.upload(multipartFormData: { multipartFormData in
            //Parameter for Upload files
            multipartFormData.append(imgData, withName: "u_profile",fileName: "Profile.png" , mimeType: "image/png")
            
            for (key, value) in parameters
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: UPDATE_USER_PROF_API, usingThreshold: UInt64.init(), method: .post, headers: postheaders).responseJSON { (response) in
            
            //        }, usingThreshold:UInt64.init(),
            //                  to: UPDATE_USER_PROF_API, //URL Here
            //                  method: .post,
            //                  headers: postheaders, //pass header dictionary here
            //                  encodingCompletion: { (result) in
            
            switch(response.result) {
            case .success(_):
                print("the status code is :")
                
                //                upload.uploadProgress(closure: { (progress) in
                //                    print("something")
                //                })
                //
                //                upload.responseJSON { response in
                //                    print("the resopnse code is : \(response.response?.statusCode)")
                //                    print("the response is : \(response)")
                //                    switch(response.result) {
                //                    case .success(_):
                if let data = response.value{
                    let json = data as? NSDictionary
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                        self.getUserInfo()
                        
                        let refreshAlert = UIAlertController(title: "Closest", message: "Updated Successfully", preferredStyle: UIAlertController.Style.alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                        }))
                        self.present(refreshAlert, animated: true, completion: nil)
                    }else{
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }
                //                        break
                //                    case .failure(_):
                //                        // add your error alert message here
                //                        break
                //                    }
                //
                //                }
                break
            case .failure(_):
                //                print("the error is  : \(error.localizedDescription)")
                break
            }
        }
        
        
        //        let parameters:[String : Any] =
        //                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
        //                     "u_first_name":PFirstName.text ?? "" , "u_last_name":PLastName.text ?? "" ,
        //                     "u_phone":PPhoneNumber.text ?? "","email": login_session.value(forKey: "Email") as? String ?? ""
        //                ]
        //                print(parameters)
        //                        APIManager.apiPostWithHeaders(serviceName: UPDATE_USER_PROF_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
        //                    DispatchQueue.main.async {  }
        //                    if error != nil {
        //                        print(error?.localizedDescription ?? "")
        //                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
        //                        return
        //                    }
        //                    let responseDict:NSDictionary = json!
        //                    print(responseDict)
        //                    if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
        //                    //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
        //
        //                       // let resData = responseDict["data"] as! [String:Any]
        //
        //
        //                       // self.PAct_SubmitResponse()
        //                        self.getUserInfo()
        //
        //                        let refreshAlert = UIAlertController(title: "Closest", message: "Updated Successfully", preferredStyle: UIAlertController.Style.alert)
        //
        //                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
        //
        //
        //                        }))
        //
        //                        self.present(refreshAlert, animated: true, completion: nil)
        //
        //                    }
        //                    else
        //                    {
        //
        //                     //   self.hideActivityIndicator(uiView: self.view)
        //                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
        //                        //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
        //                    }
        //
        //                }
    }
    
    
    
    
    @IBAction func didTapButton(_ sender: Any) {
        
        //            let vc = UIImagePickerController()
        //            vc.sourceType = .photoLibrary
        //            vc.delegate = self
        //            vc.allowsEditing = true
        //            present(vc, animated: true)
        //        imagePicker.allowsEditing = false
        //        imagePicker.sourceType = .photoLibrary
        ////
        //        present(imagePicker, animated: true, completion: nil)
        self.openCameraGalleryMethod()
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
    
    //    func TrustandVerification()  {
    //
    ////        {
    ////        "lang_code":"en",
    ////        "verification_type":"idproof",//email,phone,idproof
    ////        "verify_email":"sathyapriya@pofitec.com",
    ////        "phone_no":"+919656719052",
    ////        "proof_type":"passport",//passport,voterid,licence
    ////        "proof_file":
    ////        }
    //
    //        let parameters:[String : Any] =
    //                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
    //                     "verification_type":"idproof","proof_type":verifiedType,
    //                     "phone_no":TVPhoneNumber.text ?? "","verify_email": login_session.value(forKey: "Email") as? String ?? "" ,"proof_file":""
    //                ]
    //                print(parameters)
    //                APIManager.apiPostWithHeaders(serviceName: TRUST_VERIFY_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
    //                    DispatchQueue.main.async {  }
    //                    if error != nil {
    //                        print(error?.localizedDescription ?? "")
    //                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
    //                        return
    //                    }
    //                    let responseDict:NSDictionary = json!
    //                    print(responseDict)
    //                    if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
    //                    //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
    //
    //                        let resData = responseDict["data"] as! [String:Any]
    //
    //
    //                        let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
    //                        Singleton.sharedInstance.homeModel = mod
    //
    //
    //                    }
    //                    else
    //                    {
    //
    //                     //   self.hideActivityIndicator(uiView: self.view)
    //                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
    //                        //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
    //                    }
    //
    //
    //    }
    //
    //
    //            }
    
    
    
    @IBAction func Act_TVEmailVerify(_ sender: Any) {
        
        let parameters:[String : Any] =
        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
         "verification_type":"email","proof_type":"",
         "phone_no": "","verify_email": login_session.value(forKey: "Email") as? String ?? "" ,"proof_file":""
        ]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: TRUST_VERIFY_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 400 {
                //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                
                let resData = responseDict["data"] as! [String:Any]
                let verifyDict = resData["verification_arr"] as! [String:Any]
                let emailStatus: Int = verifyDict["email_status"] as? Int ?? 0
                if emailStatus == 1 {
                    self.TVEmailAddressVerifyLbl.text = "Verified"
                    self.TVImageview.image = #imageLiteral(resourceName: "check-circle")
                    self.btnTVEmail.isHidden = true
                    login_session.set("Verified", forKey: "verificationStatus")
                    
                }
                
            }
            else
            {
                
                //   self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                
            }
            
        }
    }
    @IBAction func Act_TVSmsVerify(_ sender: Any) {
        let Text = self.TVPhoneNumber.setFlag(key: .IN)
        let Te = self.TVPhoneNumber.text!
        let Xe = Te.replacingOccurrences(of: " ", with: "")
        let Ph = "+91\(Xe)"
        self.MobileNum = Ph
        let parameters:[String : Any] =
        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
         "verification_type":"phone","proof_type":"",
         "phone_no": Ph,"verify_email": "" ,"proof_file":""
        ]
        
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: TRUST_VERIFY_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                
                let resData = responseDict["data"] as! [String:Any]
                let verifyDict = resData["verification_arr"] as! [String:Any]
                let phoneNumberStatus: Int = verifyDict["u_mobile_status"] as? Int ?? 0
                if phoneNumberStatus == 1 {
                    self.TVPhoneNumberVerifyLbl.text = "Verified"
                    self.phoneNumberVerifyStatsImageV.image = #imageLiteral(resourceName: "Mask Group 3")
                    self.btnTVSms.setTitle("SAVE", for: .normal)
                    
                    return
                } else {
                    self.TVlblPhoneNumber.text = "OTP *"
                    self.btnTVSms.isHidden = true
                    self.TVPhoneNumber.text = ""
                    self.TVPhoneNumber.placeholder = "Enter OTP"
                    self.TVPhoneNumber.leftView = nil
                    self.btnTVSubmit.isHidden = false
                    
                }
                
            } else {
                
                //   self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
            }
            
            
        }
    }
    
    func resetphonefields()  {
        
        self.PhoneNumberlbl.isHidden = false
        self.PhoneNumbertext.isHidden = false
        self.TVlblPhoneNumber.isHidden = false
        self.PhoneNumberVerificationtext.isHidden = false
        
        
    }
    @IBAction func Act_TVBtnChange(_ sender: Any) {
        resetphonefields()
        self.TVPhoneNumberVerifyLbl.text = "Not Verified"
        self.phoneNumberVerifyStatsImageV.image = #imageLiteral(resourceName: "Group 8826")
        self.btnTVSms.setTitle("VERIFY VIA SMS", for: .normal)
        self.TVlblPhoneNumber.text = "Phone Number *"
        self.TVlblPhoneNumber.isHidden = false
        self.PhoneNumbertext.isHidden = false
        self.PhoneNumberlbl.isHidden = false
        self.TVPhoneNumber.isHidden = true
        
        self.btnTVSms.isHidden = false
        //       self.TVPhoneNumber.text = ""
        //        self.TVPhoneNumber.placeholder = "Phone Number"
        
        self.btnTVSubmit.isHidden = true
        self.TVbtnChange.isHidden = true
    }
    
    @IBAction func Act_ChooseFile(_ sender: Any) {
        
        ImagePickerManager().pickImage(self){ image in
            //here is the image
            self.verificationImageV.image = image
            self.verificationImageV.isHidden = false
            self.nofileChoosen.isHidden = true
            //            self.profileImageView.image = image
            //            self.profileImageView.contentMode = .scaleAspectFit
        }
    }
    func Trust_Verification(){
        
        
        
        let parameters = [
            "lang_code": "en",
            "verification_type" : "",
            "proof_type": "",
            "phone_no":"",
            "verify_email": "",
            "proof_file":""
        ]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: TRUST_VERIFY_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                let resData = responseDict["data"] as! [String:Any]
                let verifyDict = resData["verification_arr"] as! [String:Any]
                self.idVerifyStatus = verifyDict["u_idproof_verified_status"] as? Int ?? 0
                self.idProofImgUrl = verifyDict["u_idproof"] as? String ?? ""
                self.verifiedType = "\(verifyDict["u_idproof_type"] as AnyObject)"
                if ("\(verifyDict["email_status"] as AnyObject)"  == "1"){
                    self.TVEmailAddressVerifyLbl.text = "Verified"
                    self.TVImageview.image = #imageLiteral(resourceName: "check-circle")
                    self.btnTVEmail.isHidden = true
                }
                
                if ("\(verifyDict["u_mobile_status"] as AnyObject)"  == "1"){
                    self.TVPhoneNumberVerifyLbl.text = "Verified"
                    self.phoneNumberVerifyStatsImageV.image = #imageLiteral(resourceName: "check-circle")
                    
                    self.phoneNumberDescTestHeight.constant = 0
                    self.phoneNumberLblDescTestHeight.constant = 0
                    self.btnTVSms.isHidden = true
                    
                }
                if ("\(verifyDict["u_proof_uploaded_sts"] as AnyObject)"  == "1"){
                    self.verificationListTV.isHidden = false
                    self.viewPassportverify.isHidden = true
                }else{
                    self.verificationListTV.isHidden = true
                    self.viewPassportverify.isHidden = false
                }
                
                
                self.verificationListTV.delegate = self
                self.verificationListTV.dataSource = self
                self.verificationListTV.reloadData()
            } else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
        }
    }
    
    @IBAction func Act_SaveDocument(_ sender: Any) {
        
        if verificationImageV.image == nil {
            self.showInformation(title: "Closest", message: "Please select File first")
        }else{
            
            if !(verifiedType == "") {
                //Parameter HERE
                let parameters = [
                    "lang_code": "en",
                    "verification_type" : "idproof",
                    "proof_type": verifiedType,
                    "phone_no":TVPhoneNumber.text ?? "",
                    "verify_email": login_session.value(forKey: "Email") as? String ?? "",
                ]
                //Header HERE
                let headers = [
                    "Content-type": "multipart/form-data",
                    "Content-Disposition" : "form-data"
                ]
                let postheaders : HTTPHeaders = HeaderManager.headers()
                
                
                let imgData = self.verificationImageV.image!.jpegData(compressionQuality: 0.7)!
                
                AF.upload(multipartFormData: { multipartFormData in
                    //Parameter for Upload files
                    multipartFormData.append(imgData, withName: "proof_file",fileName: "\(self.verifiedType).png" , mimeType: "image/png")
                    
                    for (key, value) in parameters
                    {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    
                    //                }, usingThreshold:UInt64.init(),
                    //                          to: TRUST_VERIFY_API, //URL Here
                    //                          method: .post,
                    //                          headers: postheaders, //pass header dictionary here
                    //                          encodingCompletion: { (result) in
                    
                }, to: TRUST_VERIFY_API, usingThreshold: UInt64.init(), method: .post, headers: postheaders).responseJSON { (response) in
                    
                    switch(response.result) {
                    case .success(_):
                        print("the status code is :")
                        
                        //                        upload.uploadProgress(closure: { (progress) in
                        //                            print("something")
                        //                        })
                        //
                        //                        upload.responseJSON { response in
                        //                            print("the resopnse code is : \(response.response?.statusCode)")
                        //                            print("the response is : \(response)")
                        //                            switch(response.result) {
                        //                            case .success(_):
                        if let data = response.value{
                            let json = data as? NSDictionary
                            let responseDict:NSDictionary = json!
                            print(responseDict)
                            if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                                //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                                
                                let resData = responseDict["data"] as! [String:Any]
                                let verifyDict = resData["verification_arr"] as! [String:Any]
                                self.idVerifyStatus = verifyDict["u_idproof_verified_status"] as? Int ?? 0
                                self.idProofImgUrl = verifyDict["u_idproof"] as? String ?? ""
                                
                                self.viewPassportverify.isHidden = true
                                self.verificationListTV.isHidden = false
                                self.verificationListTV.delegate = self
                                self.verificationListTV.dataSource = self
                                self.verificationListTV.reloadData()
                                
                            }
                            
                        }
                        //                                break
                        //                            case .failure(_):
                        //                                // add your error alert message here
                        //                                break
                        //                            }
                        //
                        //                        }
                        break
                    case .failure(_):
                        //                        print("the error is  : \(encodingError.localizedDescription)")
                        break
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func Act_SubmitOTP(_ sender: UIButton) {
        if self.TVlblPhoneNumber.text == "Phone Number*" ||  self.TVlblPhoneNumber.text == "OTP *" {
            let Text = self.TVPhoneNumber.setFlag(key: .IN)
            let Te = self.TVPhoneNumber.text!
            let Xe = Te.replacingOccurrences(of: " ", with: "")
            let Ph = "\(Xe)"
            let title = sender.titleLabel?.text ?? ""
            if title == "SUBMIT" {
                // verify api
                
                let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "mobile_verification_code":Ph,
                 "phone_no":self.MobileNum,
                ]
                
                print(parameters)
                APIManager.apiPostWithHeaders(serviceName: TRUST_VERIFY_OTP_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                        //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                        
                        let resData = responseDict["data"] as! [String:Any]
                        
                        
                        self.TVlblPhoneNumber.text = "OTP *"
                        self.btnTVSms.setTitle("SAVE", for: .normal)
                        self.btnTVSubmit.isHidden = false
                        
                        let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.homeModel = mod
                        self.btnTVEmail.isHidden = true
                        self.phoneNumberDescTestHeight.constant = 0
                        self.phoneNumberLblDescTestHeight.constant = 0
                        let phoneNumberStatus: Int = (resData["verification_arr"] as? NSDictionary)?.object(forKey: "u_mobile_status") as? Int ?? 0
                        
                        if phoneNumberStatus == 1 {
                            self.TVPhoneNumberVerifyLbl.text = "Verified"
                            self.phoneNumberVerifyStatsImageV.image = #imageLiteral(resourceName: "Mask Group 3")
                            self.btnTVSms.setTitle("SAVE", for: .normal)
                        } else {
                            self.TVlblPhoneNumber.text = "OTP *"
                            self.btnTVSms.isHidden = true
                            self.TVPhoneNumber.text = ""
                            self.TVPhoneNumber.placeholder = "Enter OTP"
                            self.TVPhoneNumber.leftView = nil
                            self.btnTVSubmit.isHidden = false
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                            
                        }
                        
                        
                    } else {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        
                    }
                    
                }
                
                
            }else {
                // submit otp api
                let isEmpty = (TVPhoneNumber.text ?? "").isEmpty
                
                if !isEmpty{
                    resetphonefields()
                    
                    let parameters:[String : Any] =
                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                     
                    ]
                    print(parameters)
                    APIManager.apiPostWithHeaders(serviceName: USER_INFO_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                        DispatchQueue.main.async {  }
                        if error != nil {
                            print(error?.localizedDescription ?? "")
                            self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                            return
                        }
                        let responseDict:NSDictionary = json!
                        print(responseDict)
                        if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                            //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                            
                            let resData = responseDict["data"] as! [String:Any]
                            
                            self.btnTVEmail.isHidden = true
                            self.phoneNumberDescTestHeight.constant = 0
                            self.phoneNumberLblDescTestHeight.constant = 0
                            self.otpLblHeight.constant = 0
                            //                                self.otpTextFieldHeight.constant = 0
                            self.btnTVSubmit.isHidden = true
                            self.TVPhoneNumberVerifyLbl.text = "Verified"
                            self.phoneNumberVerifyStatsImageV.image = #imageLiteral(resourceName: "check-circle")
                            self.TVPhoneNumber.isHidden = true
                            self.TVbtnChange.isHidden = false
                            self.PhoneNumberlbl.isHidden = true
                            self.PhoneNumbertext.isHidden = true
                            
                            //                                if self.TVPhoneNumber.text == "" {
                            //
                            //                                    let alertController = UIAlertController(title: "ProjectName", message: nil, preferredStyle: .actionSheet)
                            //                                    let OTP = UIAlertAction(title:  "Please Enter the OTP", style: .default) { (UIAlertAction) in
                            //
                            //                                        self.PhoneNumberlbl.isHidden = false
                            //                                        self.PhoneNumbertext.isHidden = false
                            ////                                        self.TVPhoneNumberVerifyLbl.text = "Not Verified"
                            //
                            //                                        self.TVPhoneNumber.isHidden = false
                            //                                        self.TVbtnChange.isHidden = true
                            //                                        self.btnTVSms.isHidden = true
                            //                                        self.btnTVSubmit.isHidden = false
                            //                                        self.btnTVSubmit.setTitle("SUBMIT", for: .normal)
                            //                                    }
                            //
                            //
                            //                                    alertController.addAction(OTP)
                            //
                            //                                    self.present(alertController, animated: true, completion: nil)
                            //
                            //
                            //                                }
                            
                            
                        }
                        else
                        {
                            
                            //   self.hideActivityIndicator(uiView: self.view)
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                            //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
                        }
                    }
                    
                    
                    
                }else {
                    let errorAlert = UIAlertController(title: "Closest", message: "Please Enter Valid OTP.", preferredStyle: UIAlertController.Style.alert)
                    
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        print("Handle Ok logic here")
                    }))
                    
                    
                    present(errorAlert, animated: true, completion: nil)
                    
                }
            }
        }
        
        
    }
    
    
    
    
    @IBAction func Act_PVPassword(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            btnPVPassword.setImage(#imageLiteral(resourceName: "Group 8822"), for: .normal)
            btnPVVoterid.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
            btnPVDrivingLicense.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
            verifiedType = "Passport"
        }
        
    }
    
    @IBAction func Act_Changepassword(_ sender: Any) {
        
        if self.txtOldpassword.text?.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_enteroldPassword") as? String ?? "")
        }else if txtpassword.text?.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_enternewPassword") as? String ?? "")
        }else if self.txtChangePassword.text?.count == 0 {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_enterconfirmPassword") as? String ?? "")
        }else{
            var params = NSMutableDictionary()
            
            params =  ["new_password": txtChangePassword.text!,
                       "lang_code" : lanuguage_selection.value(forKey: "language") ?? "en","old_password":self.txtOldpassword.text!]
            print(params)
            APIManager.apiPostWithHeaders(serviceName: USER_PASSWD_UPDATE_API, parameters: params as? [String : Any]) { response, error in
                DispatchQueue.main.async {
                    //                self.ListingActivityDelegate?.hideActivity()
                }
                let responseDict:NSDictionary = response as! NSDictionary
                print(response)
                
                if error != nil {
                    
                    let passAlert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_changeThePassword") as? String ?? "", preferredStyle: UIAlertController.Style.alert)
                    
                    passAlert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as? String ?? "", style: .default, handler: { [self] (action: UIAlertAction!) in
                        
                        
                    }))
                    self.present(passAlert, animated: true, completion: nil)
                    
                } else {
                    
                    
                    
                    if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                        
                        if (self.txtpassword.text != self.txtChangePassword.text){
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        }
                        let passwordAlert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_passwordChangesSuccessfully") as? String ?? "", preferredStyle: UIAlertController.Style.alert)
                        
                        passwordAlert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as? String ?? "", style: .default, handler: { [self] (action: UIAlertAction!) in
                            
                            
                        }))
                        
                        self.present(passwordAlert, animated: true, completion: nil)
                        
                    }else{
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }
            }
        }
        
    }
    
    @IBAction func Act_PVVoterid(_ sender: AnyObject) {
        btnPVPassword.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
        btnPVVoterid.setImage(#imageLiteral(resourceName: "Group 8822"), for: .normal)
        btnPVDrivingLicense.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
        verifiedType = "Driving license"
        
    }
    @IBAction func Act_PVDrivingLicense(_ sender: AnyObject) {
        
        btnPVPassword.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
        btnPVVoterid.setImage(#imageLiteral(resourceName: "Rectangle 4641"), for: .normal)
        btnPVDrivingLicense.setImage(#imageLiteral(resourceName: "Group 8822"), for: .normal)
        verifiedType = "Other"
        
    }
    
    @IBAction func verifyNow_Act(_ sender: UIButton) {
        self.Trust_Verification()
        self.SelectedRow = 1
        self.viewProfile.isHidden = true
        self.changePassword.isHidden = true
        self.viewPassportverify.isHidden = false
        self.viewTrustandVerification.isHidden = false
        self.verificationListTV.isHidden = false
        self.MoveCollection.reloadData()
        
    }
    
    
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenu") as! SideMenuNavigationController
            menu.menuWidth = self.view.bounds.width - 100
            // menu.delegate = self
            present(menu, animated: true, completion: nil)
            //                    if sender.tag == 0 {
            //                        sender.tag = 1
            //                        self.view.layoutIfNeeded()
            //                        rotateMenuButton()
            //                        UIView.animate(withDuration: 0.3) {
            //                            self.greyView.isHidden = false
            //                           // self.menuLeadingConstant.constant = 0.0
            //                            self.img_Menu.image = UIImage(named: "backBlack")
            //                            self.viewMenu.isHidden = false
            //                            self.view.layoutIfNeeded()
            //                        }
            //                    } else {
            //                        sender.tag = 0
            //                        self.view.layoutIfNeeded()
            //                        rotateMenuButton()
            //                        UIView.animate(withDuration: 0.3) {
            //                         //   self.menuLeadingConstant.constant = -500 backBlack
            //                            self.img_Menu.image = UIImage(named: "Menu_PR")
            //                            self.greyView.isHidden = true
            //                           self.viewMenu.isHidden = true
            //                            self.view.layoutIfNeeded()
            //                        }
            //                    }
        }else{
            
            showSimpleAlert()
            // self.LoginView.isHidden = false
        }
    }
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_areyousureLogin") as? String ?? "",         preferredStyle: UIAlertController.Style.alert)
        
        //        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as? String ?? "", style: UIAlertAction.Style.default, handler: { _ in
        //            //Cancel Action
        //            self.dismiss(animated: true, completion: nil)
        //        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_login") as? String ?? "",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
            self.navigationController?.pushViewController(navgt!, animated: true)
            
            
            //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}




extension NewProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.Array.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCollectionViewCell", for: indexPath) as? MoveCollectionViewCell else { return UICollectionViewCell() }
        
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCollectionViewCell", for: indexPath) as? MoveCollectionViewCell
        
        cell.MoveLbl.font = UIFont(name: SemiBoldFont, size: 14)
        
        cell.MoveLbl.text = Array.object(at: indexPath.row) as? String
        
        if SelectedRow == indexPath.row {
            cell.MoveLbl.backgroundColor = AppSecondColor
            cell.MoveLbl.textColor = .white
        }else{
            cell.MoveLbl.textColor = .black
            cell.MoveLbl.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        }
        // cell.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
        
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let selectedImage = info[.originalImage] as! UIImage
        PImageview.image = selectedImage
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.SelectedRow = indexPath.row
        self.MoveCollection.reloadData()
        if indexPath.row == 0 {
            // self.viewSecurity.isHidden = true
            self.viewPassportverify.isHidden = true
            self.changePassword.isHidden = true
            self.viewTrustandVerification.isHidden = true
            self.verificationListTV.isHidden = true
            self.viewProfile.isHidden = false
            
        }else if indexPath.row == 1{
            self.Trust_Verification()
            //self.viewSecurity.isHidden = true
            
            self.viewProfile.isHidden = true
            self.changePassword.isHidden = true
            self.viewPassportverify.isHidden = false
            self.viewTrustandVerification.isHidden = false
            self.verificationListTV.isHidden = false
            
        }
        else{
            
            self.viewProfile.isHidden = true
            self.viewPassportverify.isHidden = true
            self.viewTrustandVerification.isHidden = true
            self.changePassword.isHidden = false
            self.verificationListTV.isHidden = true
            
            
        }
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 0.3)
    }
    func reloadCollectionView() {
        self.MoveCollection.reloadData()
    }
    @objc func updateStepsRemaining() {
        
        self.MoveCollection.scrollToItem(at: IndexPath(row: self.SelectedRow, section: 0), at: .centeredHorizontally, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}

//extension NewProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//
//
//
//
//
//
//
//
////    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//////        if let image = info[UIImagePickerController.InfoKey(string: "UIImagePickerControllerEditedImage")] as? UIImage{
//////            PImageview.image = image
//////        }
//////
//////                dismiss(animated:true, completion: nil)
////
////    }
//
//
//
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//////        self.dismiss(animated: true, completion: nil)
////    }
//
//
////    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
////        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
////            //save image
////            //display image
////            PImageview.image = image
////        }
////        self.dismiss(animated: true, completion: nil)
////    }
////
////    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        self.dismiss(animated: true, completion: nil)
////    }
//
////    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
////
////
////
////        if let image = info[UIImagePickerController.InfoKey(string: "UIImagePickerControllerEditedImage")] as? UIImage{
////            PImageview.image = image
////        }
////
////
////
////
////        picker.dismiss(animated: true, completion: nil)
////    }
////
////    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        picker.dismiss(animated: true, completion: nil)
////    }
//}

//MARK:- UIIMagePicker Delegate Method
extension NewProfileViewController{
    //MARK:- Open Camera and Gallery Method
    func openCameraGalleryMethod()  {
        OperationQueue.main.addOperation {
            let alertController = UIAlertController(title: "Closest", message: "ProjectName", preferredStyle: .actionSheet)
            let takePhotoAction = UIAlertAction(title:  "camera", style: .default) { (UIAlertAction) in
                self.cameraPresent()
            }
            let libraryAction = UIAlertAction(title: "Choose From Library", style: .default) { (UIAlertAction) in
                self.galleryPresent()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            { (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(takePhotoAction)
            alertController.addAction(libraryAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Persent Camera
    func cameraPresent()  {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized:
            openCamera()
        case .denied:
            self.showImagesAlertMessages(title: "allowCameraSettings")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted == true {
                    self.openCamera()
                }else {
                    self.showImagesAlertMessages(title: "allowCameraSettings")
                }
            })
        default:
            print("Not permission")
        }
    }
    
    //MARK: - Open Camera
    //   ` func openCamera()  {
    //        if UIImagePickerController.isSourceTypeAvailable(.camera) {
    //            self.imagePicker.mediaTypes = [kUTTypeImage as String]
    //            self.imagePicker.sourceType = .camera
    //            self.imagePicker.allowsEditing = true
    //            self.present(self.imagePicker, animated: true, completion: nil)
    //        }else {
    //            self.noCamera()
    //        }
    //    }`
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: - Gallery Present
    func galleryPresent()  {
        let photos = PHPhotoLibrary.authorizationStatus()
        switch photos {
        case .authorized:
            openGallery()
        case .denied:
            showImagesAlertMessages(title:  "allowCameraSettings")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (granted) in
                switch granted {
                case .authorized:
                    self.openGallery()
                case.denied,.restricted:
                    self.showImagesAlertMessages(title: "allowCameraSettings")
                default:
                    print("Not Permission")
                }
            })
        default:
            print("Not Permision")
        }
    }
    
    //MARK:- Open Gallery Method
    func openGallery()  {
        DispatchQueue.main.async {
            
            //            self.imagePicker.mediaTypes = [kUTTypeImage as String]
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    //MARK:- no Camera Method
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: - Show Alert For Camera Permission
    func showImagesAlertMessages(title:String)  {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title:"OK", style:.default) { (UIAlertAction) in
            //UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Get Document Directory Path :
    func getDirectoryPath(name:String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    //MARK:- UIImagePickerController Delegate Method
    
    
    
    
    
}

extension NewProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerifyTableViewCell") as! VerifyTableViewCell
        
        //        cell.SNoLbl.text = "1"
        cell.FileImg.imageFromURL(urlString: idProofImgUrl)
        cell.ProofTypeLbl.text = verifiedType
        cell.ProofTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)
        cell.ProofStatusLbl.font = UIFont(name: SemiBoldFont, size: 16)
        cell.PfrtypLbl.font = UIFont(name: SemiBoldFont, size: 16)
        cell.PrfStsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        cell.FileTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)
        
        if "\(idVerifyStatus)" == "0" {
            cell.ProofStatusLbl.text = "Request Send"
        }else{
            cell.ProofStatusLbl.text = "Approved"
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
    
}

extension UITextField {
    
    /// set icon of 20x20 with left padding of 8px
    func setLeftIcon() {
        
        let padding = 8
        let size = 44
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: 44) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: 44))
        iconView.backgroundColor = .red
        outerView.backgroundColor = .green
        // iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
}

extension NewProfileViewController: FPNTextFieldDelegate {
    
    /// The place to present/push the listController if you choosen displayMode = .list
    func fpnDisplayCountryList() {
        //      let navigationViewController = UINavigationController(rootViewController: listController)
        
        //      present(navigationViewController, animated: true, completion: nil)
    }
    
    /// Lets you know when a country is selected
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
    }
    
    /// Lets you know when the phone number is valid or not. Once a phone number is valid, you can get it in severals formats (E164, International, National, RFC3966)
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            // Do something...
            textField.getFormattedPhoneNumber(format: .E164)          // Output "+33600000001"
            //         textField.getFormattedPhoneNumber(format: .International),  // Output "+33 6 00 00 00 01"
            //         textField.getFormattedPhoneNumber(format: .National),       // Output "06 00 00 00 01"
            //         textField.getFormattedPhoneNumber(format: .RFC3966),        // Output "tel:+33-6-00-00-00-01"
            //         textField.getRawPhoneNumber()                               // Output "600000001"
        } else {
            // Do something...
        }
    }
}
