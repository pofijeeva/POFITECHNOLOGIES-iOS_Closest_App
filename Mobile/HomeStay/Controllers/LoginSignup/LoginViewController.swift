//
//  LoginViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 12/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//HomeTabBarViewController

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import FBSDKCoreKit

//import LinkedinSwift
import WebKit
import AFNetworking
import AuthenticationServices
//import ACFloatingTextfield_Swift

class LoginViewController: BaseViewController,WKNavigationDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding,UITextFieldDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var viewLoginFeild: UIView!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var btnLinkedin: UIButton!
    @IBOutlet weak var btnGooglePlus: UIButton!
    @IBOutlet weak var btnFaceBook: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignupNow: UIButton!
    @IBOutlet weak var btnForgetPassWord: UIButton!
    @IBOutlet weak var btnRemberMe: UIButton!
    @IBOutlet weak var idonthaveacc: UILabel!
    @IBOutlet weak var rememberme: UILabel!
    @IBOutlet weak var LoginWithLbl: UILabel!
    @IBOutlet weak var WelcomeLbl: UILabel!
    @IBOutlet weak var WelcomeDescLbl: UILabel!
    @IBOutlet weak var OrsignLbl: UILabel!
    @IBOutlet weak var CountinueLbl: UILabel!
    @IBOutlet weak var btntermsConditions: UIButton!
    
    @IBOutlet weak var linkedlnBGView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var linkedLnBackButton: UIButton!
    
    @IBOutlet weak var fbBtnViewYpsition: NSLayoutConstraint!
    @IBOutlet weak var fbImageViewYpsition: NSLayoutConstraint!
    
    var userSelectedLogin: String?
    // MARK:- Variables
    
    
    let linkedInKey = "81o7lmpst2s4wa"
    
    let linkedInSecret = "gWW9DbT2SMwkHqmZ"
    
    let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
    
    let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
    
    var isRememberPassword: Bool = false
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var password: String = ""
    var key: String = ""
    var loginType: String = ""
    var deviceType: String = ""
    var fcmTokenStr : String = ""
    // Linkedin intialization helper.
    var appleID: String = ""
    var requestString = ""
    var Authorization : String = ""
    var fcmToken : String = ""
    let loginManager = LoginManager()
    
    
    
    
    // MARK:- Lifecycle Methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.setView()
        linkedlnBGView.isHidden = true
        webView.navigationDelegate = self
        
        setupSOAppleSignIn1()
        
        if UserDefaults.standard.value(forKey: "fcmToken") != nil {
            let fcmRegToken:String = UserDefaults.standard.value(forKey: "fcmToken") as? String ?? ""
            print(fcmRegToken)
            fcmTokenStr = fcmRegToken
            print("Fcm Token is: ",fcmTokenStr)
        }
        
        
        
        
        
        self.imgBg.contentMode = .scaleAspectFill
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        if app_session.bool(forKey: "CAN_REMEMBER_PASS") == false {
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.btnRemberMe.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btnRemberMe.backgroundColor = .clear
        } else {
            self.btnRemberMe.setImage(UIImage(named: "tick-on"), for: .normal)
            self.btnRemberMe.backgroundColor = .white
            self.txtEmail.text = app_session.string(forKey: "APP_LOGIN_EMAIL")
            self.txtPassword.text = app_session.string(forKey: "APP_LOGIN_PASSWORD")
        }
        isRememberPassword =  UserDefaults.standard.bool(forKey: "isRememberPassword")
        
        if isRememberPassword == true {
            
            
            self.btnRemberMe.setImage(UIImage(named: "tick-on"), for: .normal)
            self.btnRemberMe.backgroundColor = .white
            self.txtEmail.text = app_session.string(forKey: "APP_LOGIN_EMAIL")
            self.txtPassword.text = app_session.string(forKey: "APP_LOGIN_PASSWORD")
        }else{
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.btnRemberMe.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btnRemberMe.backgroundColor = .clear
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            self.txtEmail.textAlignment = .left
            self.txtPassword.textAlignment = .left
        }else{
            self.txtEmail.textAlignment = .right
            self.txtPassword.textAlignment = .right
        }
        
        
        self.btnForgetPassWord.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14.0)
        self.txtEmail.font = UIFont(name: RegularFont, size: 15)
        self.txtPassword.font = UIFont(name: RegularFont, size: 15)
        self.btnLogin.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.btnLogin.backgroundColor = AppColor
        self.btnFaceBook.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btnGooglePlus.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btnLinkedin.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.LoginWithLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.rememberme.font = UIFont(name: RegularFont, size: 15)
        self.idonthaveacc.font = UIFont(name: SemiBoldFont, size: 15)
        self.btnSignupNow.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
        self.WelcomeLbl.font = UIFont(name: SemiBoldFont, size: 22
        )
        self.LoginWithLbl.text = GlobalLanguageDictionary.object(forKey: "Key_LoginWith") as? String ?? ""
        self.WelcomeLbl.text = GlobalLanguageDictionary.object(forKey: "Key_Welcome") as? String ?? ""
        self.WelcomeDescLbl.text = GlobalLanguageDictionary.object(forKey: "Key_WelcomeDesc") as? String ?? ""
        self.txtEmail.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Email") as? String ?? ""
        self.txtPassword.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Password") as? String ?? ""
        self.rememberme.text = GlobalLanguageDictionary.object(forKey: "Key_Remember") as? String ?? ""
        self.btnForgetPassWord.setTitle(GlobalLanguageDictionary.object(forKey: "Key_ForgotPasword") as? String ?? "", for: .normal)
        self.btnLogin.setTitle(GlobalLanguageDictionary.object(forKey: "Key_login") as? String ?? "", for: .normal)
        self.idonthaveacc.text = GlobalLanguageDictionary.object(forKey: "Key_DonthaveAcc") as? String ?? ""
        self.btnSignupNow.setTitle(GlobalLanguageDictionary.object(forKey: "Key_signUp") as? String ?? "", for: .normal)
        self.OrsignLbl.text = GlobalLanguageDictionary.object(forKey: "Key_orSignLbl") as? String ?? ""
        self.btnFaceBook.setTitle(GlobalLanguageDictionary.object(forKey: "Key_facebook") as? String ?? "", for: .normal)
        self.btnGooglePlus.setTitle(GlobalLanguageDictionary.object(forKey: "Key_google") as? String ?? "", for: .normal)
        self.btnLinkedin.setTitle(GlobalLanguageDictionary.object(forKey: "Key_Apple") as? String ?? "", for: .normal)
        self.CountinueLbl.text = GlobalLanguageDictionary.object(forKey: "Key_countinueDesc") as? String ?? ""
        self.btntermsConditions.setTitle(GlobalLanguageDictionary.object(forKey: "Key_TermsOfService") as? String ?? "", for: .normal)
        
        //        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.setSoialMediaButtons()
    }
    
    
    
    @IBAction func act_termsOfService(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfServiceViewController") as! TermsOfServiceViewController
        vc.ComingType = "Terms"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK:- Custome Methods.
    
    func setView(){
        self.btnRemberMe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.viewLoginFeild.layer.cornerRadius = 5.0
    }
    
    
    
    func validate(password: String) -> Bool {
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard texttest.evaluate(with: password) else { return false }
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) else { return false }
        return true
    }
    
    func loginAPI() {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable ?? false) {
            //showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
            params = ["lang_code": login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","u_email":self.email,"password":self.password]
            
            let manager = AFHTTPSessionManager()
            // manager.req
            // request.setValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json","application/x-www-form-urlencoded charset=utf-8"]) as Set<NSObject> as? Set<String>
            let headers = HeaderManager.headers()
            
            APIManager.apiPostWithHeaders(serviceName: REQ_LOGIN, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                //  self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "code") as? Int == 200 {
                    self.hideActivityIndicator(uiView: self.view)
                    //   let userDetailsArr = (responseDict.value(forKey: "user_details") as? NSDictionary)
                    let userDetailsArr = ((responseDict.value(forKey: "data") as? NSDictionary)?.value(forKey: "user_details") as? NSDictionary)
                    
                    print("Userdetails",userDetailsArr ?? "NIL")
                    
                    let token = userDetailsArr!.object(forKey: "token")as? String ?? ""
                    
                    login_session.setValue(token, forKey: "user_token")
                    let tokenStr:String = login_session.object(forKey: "user_token") as? String ?? ""
                    print("TokenString",tokenStr)
                    
                    if UserDefaults.standard.object(forKey: "fcmToken") != nil{
                        self.fcmToken = UserDefaults.standard.object(forKey: "fcmToken") as? String ?? ""
                    }else{
                        self.fcmToken = ""
                    }
                    
                    ///  if userDetailsArr.count != 0 {
                    //  let userDetails = userDetailsArr[0] as? NSDictionary
                    let userid = userDetailsArr!.value(forKey: "user_id")
                    login_session.setValue(true, forKey: "IS_USER_LOGGEDIN")
                    login_session.setValue((userDetailsArr!.value(forKey: "firstname")), forKey: "Firstname")
                    //  login_session.setValue(userDetailsArr.value(forKey: "lastname"), forKey: "Lastname")
                    login_session.setValue(userid, forKey: "UserId")
                    //                    let token = userDetailsArr.value(forKey: "token")
                    //                    login_session.setValue(token, forKey: "user_token")
                    
                    login_session.setValue(userDetailsArr?.value(forKey: "email"), forKey: "Email")
                    let imageUrl = (userDetailsArr?.value(forKey: "userimage") as? String)
                    print(imageUrl!)
                    login_session.setValue(imageUrl, forKey: "ProfilePic")
                    lanuguage_selection.set(LANG_EN, forKey: "language")
                    
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
                    self.navigationController?.pushViewController(nav!, animated: true)
                    //                                        self.discoverApi()
                    
                    
                }else{
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
                }
                
            }
            
        }
    }
    // Custom 'Sign in with Apple' button
    func setupSOAppleSignIn1() {
        //linkedIn Color = 0, 119, 181
        if #available(iOS 13.0, *) {
            userSelectedLogin = "apple"
            btnLinkedin.backgroundColor = UIColor.black
            btnLinkedin.layer.borderColor = UIColor.black.cgColor
            btnLinkedin.setTitle("Sign in with Apple", for: .normal)
            btnLinkedin.setTitleColor(UIColor.white, for: .normal)
            btnLinkedin.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            btnLinkedin.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
            btnLinkedin.translatesAutoresizingMaskIntoConstraints = false
            
        }
    }
    
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    // Authorization Failed
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple login error:::::",error.localizedDescription)
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization){
        print("Apple login success called")
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        {
            print("Successfully login")
            
            userSelectedLogin = "apple"
            /*// Get user data with Apple ID credentitial
             let appleId = appleIDCredential.user
             //userId = appleId
             let appleUserFirstName = appleIDCredential.fullName?.givenName
             firstName = appleUserFirstName ?? ""
             let appleUserLastName = appleIDCredential.fullName?.familyName
             lastName = appleUserLastName ?? ""
             let appleUserEmail = appleIDCredential.email
             email = appleUserEmail ?? ""*/
            
            // Create an account as per your requirement
            
            var userIdentifier : String = ""
            var fullName  : String = ""
            var email : String = ""
            if appleIDCredential.fullName?.givenName != nil {
                userIdentifier = appleIDCredential.user
                fullName = appleIDCredential.fullName?.givenName! ?? ""
                email = appleIDCredential.email!
                login_session.setValue(userIdentifier, forKey: "user_apple_id")
                login_session.setValue(email, forKey: "user_apple_mailid")
                login_session.setValue(fullName, forKey: "user_apple_name")
                login_session.synchronize()
            }
            else
            {
                if login_session.object(forKey: "user_apple_id") != nil {
                    userIdentifier = login_session.object(forKey: "user_apple_id") as? String ?? ""
                    email = login_session.object(forKey: "user_apple_mailid") as? String ?? ""
                    fullName = login_session.object(forKey: "user_apple_name") as? String ?? ""
                }
            }
            
            
            print("userIdentifier", userIdentifier)
            print("email", email)
            print("fullName", fullName)
            
            self.firstName = fullName
            self.lastName = ""
            self.loginType = "apple"
            self.deviceType = "ios"
            self.password = "apple"
            self.email = email
            self.key = userIdentifier
            self.appleID = userIdentifier
            
            self.checkForEmail(loginType: loginType)
            
            //Write your code
        }
        else if let passwordCredential = authorization.credential as? ASPasswordCredential
        {
            print("failed apple login")
            
            // Get user data using an existing iCloud Keychain credential
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            
            print("appleUsername::::",appleUsername)
            print("applePassword::::",applePassword)
            
            // Write your code
        }
    }
    
    @available(iOS 13.0, *)
    func getCredentialState() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "USER_ID") { (credentialState, error) in
            switch credentialState {
            case .authorized:
                // Credential is valid
                // Continiue to show 'User's Profile' Screen
                break
            case .revoked:
                // Credential is revoked.
                // Show 'Sign In' Screen
                break
            case .notFound:
                // Credential not found.
                // Show 'Sign In' Screen
                break
            default:
                break
            }
        }
    }
    
    @objc func actionHandleAppleSignin() {
        if #available(iOS 13.0, *) {
            userSelectedLogin = "apple"
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    func ForGotPassword() {
        
        
        var params = NSMutableDictionary()
        if (Reachability()?.isReachable ?? false) {
            self.showActivityIndicator(uiView: self.view)
            
            
            params =  ["u_email": self.email,
                       "lang_code" : lanuguage_selection.value(forKey: "language") ?? "en"]
            
            print("Social login params::::", params)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(REQ_FORGET_PASSWORD, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async
                {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
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
            
            
        } else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    func socialMediaLogin() {
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        if (Reachability()?.isReachable ?? false)
        {
            self.showActivityIndicator(uiView: self.view)
            
            let paramstoSend =  ["lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en",
                                 "u_first_name":self.firstName,
                                 "email":self.email,"facebook_id":self.key,"google_id":self.key,"apple_id": self.appleID,"login_type": self.loginType]
            
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            APIManager.apiPostWithHeaders(serviceName: REQ_SIGNUP, parameters: paramstoSend as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                
                if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                    
                    
                    // let userDetailsArr = (responseDict.value(forKey: "user_details") as? NSDictionary)
                    
                    let userDetailsArr = ((responseDict.value(forKey: "data") as? NSDictionary)?.value(forKey: "user_details") as? NSDictionary)
                    
                    print("Userdetails",userDetailsArr ?? "NIL")
                    
                    let token = userDetailsArr!.object(forKey: "token")as? String ?? ""
                    
                    login_session.setValue(token, forKey: "user_token")
                    let tokenStr:String = login_session.object(forKey: "user_token") as? String ?? ""
                    print("TokenString",tokenStr)
                    
                    if userDetailsArr!.count != 0 {
                        let userDetails = userDetailsArr
                        let userid = userDetails!.value(forKey: "userid")
                        login_session.setValue(true, forKey: "IS_USER_LOGGEDIN")
                        login_session.setValue((userDetails!.value(forKey: "firstname")), forKey: "Firstname")
                        login_session.setValue(userDetails!.value(forKey: "lastname"), forKey: "Lastname")
                        login_session.setValue(userid, forKey: "UserId")
                        login_session.setValue(userDetails?.value(forKey: "email"), forKey: "Email")
                        let imageUrl = userDetails!.value(forKey: "userimage") as? String
                        //  print(imageUrl!)
                        login_session.setValue(imageUrl, forKey: "ProfilePic")
                        lanuguage_selection.set(LANG_EN, forKey: "language")
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
                        self.navigationController?.pushViewController(nav!, animated: true)
                    }
                    
                    
                } else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }
        }
    }
    func checkForEmail(loginType: String)
    {
        if (self.email.count) < 5
        {
            let alert = UIAlertController(title: "Closest", message: "\(GlobalLanguageDictionary.object(forKey: "Key_your") as? String ?? "") \(loginType) \(GlobalLanguageDictionary.object(forKey: "Key_noemail_warning") as? String ?? "")", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Email") as? String ?? ""
            }
            
            let okButton = UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as? String ?? "", style: .default, handler: {  (_) in
                let textField = alert.textFields![0] // Force unwrapping because we know it exists.
                self.email = textField.text ?? ""
                if (self.email.count) == 0
                {
                    self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")
                }
                else if isValidEmail(email: self.email) == false {
                    self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseentervalidemailid") as? String ?? "")
                }
                else
                {
                    self.socialMediaLogin()
                }
            })
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            
            alert.addAction(okButton)
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        } else {
            self.socialMediaLogin()
        }
    }
    
    // MARK:- Hide KeyBoard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= self.txtPassword.frame.size.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    // MARK:- Button Actions
    
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_LinkedLnBack(_ sender: UIButton)
    {
        linkedlnBGView.isHidden = true
    }
    
    @IBAction func act_RememberMe(_ sender: Any) {
        if isRememberPassword {
            self.isRememberPassword = false
            UserDefaults.standard.setValue(false, forKey: "isRememberPassword")//value(forKey: "UserId")
            app_session.set(false, forKey: "CAN_REMEMBER_PASS")
            self.btnRemberMe.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btnRemberMe.backgroundColor = .clear
            
        } else {
            self.isRememberPassword = true
            UserDefaults.standard.setValue(true, forKey: "isRememberPassword")//value(forKey: "UserId")
            
            app_session.set(true, forKey: "CAN_REMEMBER_PASS")
            self.btnRemberMe.setImage(UIImage(named: "tick-on"), for: .normal)
            self.btnRemberMe.backgroundColor = .white
            
        }
        app_session.synchronize()
    }
    
    @IBAction func act_ForgotPassword(_ sender: UIButton) {
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_ForgotDesc") as? String ?? "", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Email") as? String ?? ""
        }
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as? String ?? "", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            self.email = (textField?.text)!
            if self.email == "" {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")
            }
            else{
                
                self.ForGotPassword()
                
                
            }
        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as? String ?? "", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func act_Login(_ sender: UIButton) {
        if self.txtEmail.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")
            self.viewLoginFeild.shakeEffect()
        } else if isValidEmail(email: self.txtEmail.text) == false {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseentervalidemailid") as? String ?? "")
            self.viewLoginFeild.shakeEffect()
        } else if self.txtPassword.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseenteryourpassword") as? String ?? "")
            self.viewLoginFeild.shakeEffect()
        }
        //        else if (self.txtPassword.text?.count)! < 8 {
        //            showInformation(title: "Closest", message: "Your Password should have 8 character with atleast 1 uppercase and 1 digit")
        //             self.viewLoginFeild.shakeEffect()
        //        }
        //        else if !(validate(password: (self.txtPassword.text)!)) {
        //            showInformation(title: "Closest", message: "Your Password should have 8 character with atleast 1 uppercase and 1 digit")
        //            self.viewLoginFeild.shakeEffect()
        //        }
        else {
            self.email = self.txtEmail.text!
            self.password = self.txtPassword.text!
            app_session.set(self.txtEmail.text, forKey: "APP_LOGIN_EMAIL")
            app_session.set(self.txtPassword.text, forKey: "APP_LOGIN_PASSWORD")
            
            UserDefaults.standard.set(self.txtEmail.text!, forKey: "APP_LOGIN_EMAIL")
            UserDefaults.standard.set(self.txtPassword.text!, forKey: "APP_LOGIN_PASSWORD")
            app_session.synchronize()
            self.loginAPI()
        }
    }
    
    
    @IBAction func act_Facebook(_ sender: UIButton) {
        
        if (Reachability()?.isReachable ?? false)
        {
            self.showActivityIndicator(uiView: self.view)
            let completion = {
                (result:LoginResult) in
                switch result
                {
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print("YES! \n--- GRANTED PERMISSIONS ---\n\(grantedPermissions) \n--- DECLINED PERMISSIONS ---\n\(declinedPermissions) \n--- ACCESS TOKEN ---\n\(accessToken)")
                    print("check\(declinedPermissions.description)")
                    if(declinedPermissions.contains("email")){
                        print("correct\(declinedPermissions.description)")
                        let loginManager = LoginManager()
                        loginManager.logOut()
                        //Utility().showAlertWithTitle(alertTitle: APP_NAME as NSString, alertMsg:FB_PERMISSION_ALERT as NSString, viewController: self)
                    }else{
                        self.getFBUserData()
                    }
                case .failed(let error):
                    self.hideActivityIndicator(uiView: self.view)
                    print("No...\(error)")
                case .cancelled:
                    self.hideActivityIndicator(uiView: self.view)
                    print("Cancelled.")
                }
            }
            loginManager.logOut()
            loginManager.logIn(permissions: [.publicProfile,.email], viewController: self, completion: completion)
        }
        
        
        
        
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //    self.dict = result as! [String : AnyObject]
                    let responseDict = result as! NSDictionary
                    self.showActivityIndicator(uiView: self.view)
                    self.email = responseDict.object(forKey: "email")as? String ?? ""
                    self.key = responseDict.object(forKey: "id")as? String ?? ""
                    self.firstName = responseDict.object(forKey: "name")as? String ?? ""
                    self.loginType = "facebook"
                    self.deviceType = "iphone"
                    self.password = "facebook"
                    self.checkForEmail(loginType: "facebook")
                    
                    
                }
                
            })
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            self.txtPassword.becomeFirstResponder()
        } else if textField == self.txtPassword {
            self.txtPassword.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func act_Google(_ sender: UIButton) {
        if (Reachability()?.isReachable ?? false)
        {
            //GIDSignIn.sharedInstance().uiDelegate = self
            userSelectedLogin = "google"
            //            GIDSignIn.sharedInstance()?.presentingViewController = self
            //            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            //            GIDSignIn.sharedInstance().delegate = self
            //            GIDSignIn.sharedInstance().signIn()
        } else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
    }
    
}

//MARK:- Google Plus Delegate GIDSignInUIDelegate
//extension LoginViewController: GIDSignInDelegate
//{
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print("\(error.localizedDescription)")
//        } else {
//
//            //Login parameters:
//            self.firstName = user.profile.givenName ?? " "
//            self.lastName = user.profile.name ?? " "
//            self.email = user.profile.email ?? " "
//            self.password = "google"
//            self.key = user.userID ?? " "
//            self.loginType = "google"
//            self.deviceType = "iphone"
//            self.checkForEmail(loginType: "Google")
//        }
//    }
//
//    private func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        print("signInWillDispatch")
//    }
//
//    // Present a view that prompts the user to sign in with Google
//    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
//        print("present")
//    }
//
//    // Dismiss the "Sign in with Google" view
//    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        print("dismiss")
//    }
//}

//MARK:- HTTP  Delegates

extension LoginViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        print(responseDict)
        if APIKEY == "USER_LOGIN" {
            if errorDict == "" {
                if responseDict.count != 0 {
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 0 {
                        linkedlnBGView.isHidden = true
                        hideActivityIndicator(uiView: self.view)
                        showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                    else
                    {
                        linkedlnBGView.isHidden = true
                        let userDetailsArr = responseDict.value(forKey: "user_details") as! NSArray
                        if userDetailsArr.count != 0 {
                            let userDetails = userDetailsArr[0] as? NSDictionary
                            let userid = userDetails?.value(forKey: "userid")
                            login_session.setValue(true, forKey: "IS_USER_LOGGEDIN")
                            login_session.setValue((userDetails?.value(forKey: "firstname")), forKey: "Firstname")
                            login_session.setValue(userDetails?.value(forKey: "lastname"), forKey: "Lastname")
                            login_session.setValue(userid, forKey: "UserId")
                            login_session.setValue(userDetails?.value(forKey: "email"), forKey: "Email")
                            let imageUrl = userDetails?.value(forKey: "userimage") as? String
                            print(imageUrl!)
                            login_session.setValue(imageUrl, forKey: "ProfilePic")
                            lanuguage_selection.set(LANG_EN, forKey: "language")
                            //                            if (login_session.value(forKey: "ProfilePic") as? String) != nil {
                            //                            login_session.setValue(userDetails?.value(forKey: "image"), forKey: "ProfilePic")
                            //                            }
                            login_session.synchronize()
                        }
                        let requestStr = "email_id=\(login_session.value(forKey: "Email") as? String ?? "")&page_Id=\(1)&lang_code=en"
                        Network.shared.POSTRequest(withParameterString: requestStr, serviceURL:DISCOVER_API , APIKEY: "DISCOVER_API")
                    }
                    print(responseDict)
                } else {
                    hideActivityIndicator(uiView: self.view)
                    showInformation(title: "Closest", message:errorDict )
                }
            } else {
                hideActivityIndicator(uiView: self.view)
                showInformation(title: "Error", message: errorDict)
            }
            
        }
        else if APIKEY == "REQ_FORGET_PASSWORD"
        {
            if  responseDict.count != 0{
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }else{
                print("No data")
            }
            hideActivityIndicator(uiView: self.view)
        }else if APIKEY == "DISCOVER_API" {
            hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                let model = UserDetailModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.userDetailModel = model
                //let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
                //self.navigationController?.pushViewController(vc, animated: true)
                let baseIdString:String = "1"
                Singleton.sharedInstance.selectedCategory = baseIdString
                if baseIdString == "1" {
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
                    self.navigationController?.pushViewController(nav!, animated: true)
                }
            } else {
                showInformation(title: "Error", message: errorDict)
            }
        }
    }
}
