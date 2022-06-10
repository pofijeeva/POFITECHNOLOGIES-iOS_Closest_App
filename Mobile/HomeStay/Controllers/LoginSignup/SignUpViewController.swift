//  SignUpViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 18/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import AFNetworking
import AuthenticationServices
import WebKit
let loginManager = LoginManager()
   

class SignUpViewController: BaseViewController,WKNavigationDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    //MARK:- Outlets
    
    @IBOutlet weak var imgBg: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnGooglePlus: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnLinkedin: UIButton!
    @IBOutlet weak var viewSignUpFields: UIView!
    @IBOutlet weak var lblTermsAndCondition: UILabel!
    @IBOutlet weak var btnTermsAndCondition: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldConfirmPassword: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldphone: UITextField!
    @IBOutlet weak var SignUpWithLbl: UILabel!
    @IBOutlet weak var orsignLbl: UILabel!

      @IBOutlet weak var TermsAndConditionlbl: UILabel!
    //MARK:- Variables
    
    var isAgreeTerms: Bool!
    var firstName : String!
    var lastName : String!
    var email : String!
    var password : String!
    var key : String!
    var loginType : String!
    var deviceType : String!
    var requestString = ""
    var fcmTokenStr = String()
    // Linkedin intialization helper.
    var appleID: String = ""
    var fcmToken = String()

 
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.SignUpWithLbl.text = GlobalLanguageDictionary.object(forKey: "Key_signupWith") as? String
        self.orsignLbl.text = GlobalLanguageDictionary.object(forKey: "Key_orsignwith") as? String
        
        self.btnLogin.setTitle(GlobalLanguageDictionary.object(forKey: "Key_login") as? String, for: .normal)
        self.btnSignUp.setTitle(GlobalLanguageDictionary.object(forKey: "Key_Csignup") as? String, for: .normal)
        self.btnFacebook.setTitle(GlobalLanguageDictionary.object(forKey: "Key_facebook") as? String, for: .normal)
        self.btnGooglePlus.setTitle(GlobalLanguageDictionary.object(forKey: "Key_google") as? String, for: .normal)
        self.btnLinkedin.setTitle(GlobalLanguageDictionary.object(forKey: "Key_google") as? String, for: .normal)
        
 
        
        
        self.txtFldFirstName.placeholder = GlobalLanguageDictionary.object(forKey: "Key_firstname") as? String
        self.txtFldLastName.placeholder = GlobalLanguageDictionary.object(forKey: "Key_lastname") as? String
        self.txtFldEmail.placeholder = GlobalLanguageDictionary.object(forKey: "key_CEmail") as? String
        self.txtFldphone.placeholder = GlobalLanguageDictionary.object(forKey: "key_Phone") as? String
        self.txtFldPassword.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Cpassword") as? String
        self.txtFldConfirmPassword.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Cconfirmpassword") as? String
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setupSOAppleSignIn1()

        
        if UserDefaults.standard.value(forKey: "fcmToken") != nil {
            let fcmRegToken:String = UserDefaults.standard.value(forKey: "fcmToken") as? String ?? ""
            print(fcmRegToken)
            fcmTokenStr = fcmRegToken
            print("Fcm Token is: ",fcmTokenStr)
            accessToken = fcmTokenStr
        }
        
        
        
        self.isAgreeTerms = false
       
        self.viewSignUpFields.dropShadow()
        self.imgBg.contentMode = .scaleAspectFill
        let myString = "By registering you confirm that you accept the Terms and Conditions and Privacy Policy"
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]

            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.red]

        let attributedString1 = NSMutableAttributedString(string:GlobalLanguageDictionary.object(forKey: "Key_TerMess") as? String ?? "", attributes:attrs1)

        let attributedString2 = NSMutableAttributedString(string:GlobalLanguageDictionary.object(forKey: "Key_TerMess1") as? String ?? "", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:GlobalLanguageDictionary.object(forKey: "Key_TerMess2") as? String ?? "", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:GlobalLanguageDictionary.object(forKey: "Key_TerMess3") as? String ?? "", attributes:attrs2)

            attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        attributedString1.append(attributedString4)

            self.lblTermsAndCondition.attributedText = attributedString1
        self.btnTermsAndCondition.tintColor = .black
        self.TermsAndConditionlbl.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btnFacebook.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.txtFldEmail.font = UIFont(name: RegularFont, size: 15)
        self.txtFldPassword.font = UIFont(name: RegularFont, size: 15)
        self.txtFldConfirmPassword.font = UIFont(name: RegularFont, size: 15)
        self.txtFldFirstName.font = UIFont(name: RegularFont, size: 15)
        self.txtFldLastName.font = UIFont(name: RegularFont, size: 15)
        self.txtFldphone.font = UIFont(name: RegularFont, size: 15)
        self.btnLinkedin.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btnGooglePlus.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btnSignUp.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.btnSignUp.backgroundColor = AppSecondColor
        self.lblTermsAndCondition.font = UIFont(name: SemiBoldFont, size: 14)
        self.btnLogin.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
        
        
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            self.txtFldFirstName.textAlignment = .left
            self.txtFldLastName.textAlignment = .left
            self.txtFldEmail.textAlignment = .left
            self.txtFldphone.textAlignment = .left
            self.txtFldPassword.textAlignment = .left
            self.txtFldConfirmPassword.textAlignment = .left
            self.TermsAndConditionlbl.textAlignment = .left


        }else{
            self.txtFldFirstName.textAlignment = .right
            self.txtFldLastName.textAlignment = .right
            self.txtFldEmail.textAlignment = .right
            self.txtFldphone.textAlignment = .right
            self.txtFldPassword.textAlignment = .right
            self.txtFldConfirmPassword.textAlignment = .right
            self.TermsAndConditionlbl.textAlignment = .right

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Hide KeyBoard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        self.view.frame.origin.y -= self.txtFldEmail.frame.size.height
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y  = 0
        
    }
    


    
    // Custom 'Sign in with Apple' button
    func setupSOAppleSignIn1() {
        //linkedIn Color = 0, 119, 181
        if #available(iOS 13.0, *) {
            btnLinkedin.backgroundColor = UIColor.black
            btnLinkedin.layer.borderColor = UIColor.black.cgColor
            btnLinkedin.setTitle("SIGN IN WITH APPLE", for: .normal)
            btnLinkedin.setTitleColor(UIColor.white, for: .normal)
            btnLinkedin.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            btnLinkedin.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
            btnLinkedin.translatesAutoresizingMaskIntoConstraints = false

        }
    }
    
    @objc func actionHandleAppleSignin() {
           if #available(iOS 13.0, *) {
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
    
    @available(iOS 13.0, *)
        func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
            return self.view.window!
        }
        
        
        // Authorization Failed
        @available(iOS 13.0, *)
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error)
        {
            print("Apple login error:::::",error.localizedDescription)
        }
        
        // ASAuthorizationControllerDelegate function for successful authorization
        @available(iOS 13.0, *)
        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization)
        {
            print("Apple login success called")

            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
            {
                print("Successfully login")

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

                 var userIdentifier = String()
                 var fullName  = String()
                 var email = String()
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
                
                 self.signupAPI()

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
    
   
    
    //MARK:- Button Actions
    
    @IBAction func act_termsOfService(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfServiceViewController") as! TermsOfServiceViewController
        vc.ComingType = "Terms"

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Google(_ sender: UIButton) {
        if (Reachability()?.isReachable)! {
            //GIDSignIn.sharedInstance().uiDelegate = self
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            GIDSignIn.sharedInstance().delegate = self
            GIDSignIn.sharedInstance().signIn()
        } else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
    }
    
    @IBAction func act_Facebook(_ sender: UIButton)
    {

        if (Reachability()?.isReachable)!
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
                    self.signupAPI()
                    
 
                   
                }
                
            })
        }
    }
    
  
    
    @IBAction func TermsAndCondition(_ sender: UIButton) {
        if isAgreeTerms {
            self.isAgreeTerms = false
            self.btnTermsAndCondition.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btnTermsAndCondition.backgroundColor = .clear

        } else {
            self.isAgreeTerms = true
            self.btnTermsAndCondition.setImage(UIImage(named: "tick-on"), for: .normal)
            self.btnTermsAndCondition.backgroundColor = .white

        }
    }
    
    @IBAction func PrivacyPolicy(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsOfServiceViewController") as! TermsOfServiceViewController
        vc.ComingType = "Policy"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func checkTextSufficientComplexity(`var` text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)


        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)


      
        return capitalresult && numberresult

    }
    
    @IBAction func act_SignUp(_ sender: UIButton) {
        
         if self.txtFldFirstName.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_Pleaseenterthefirstnametocontinue") as? String ?? "")
        } else if self.txtFldLastName.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_PleaseentertheLastnametocontinue") as? String ?? "")
        }
        else if self.txtFldEmail.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")
        } else if isValidEmail(email: self.txtFldEmail.text) == false {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseentervalidemailid") as? String ?? "")
        } else if self.txtFldPassword.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseenteryourpassword") as? String ?? "")
        }
//        else if (checkTextSufficientComplexity(`var`: self.txtFldPassword.text!)) == false{
//            showInformation(title: "Closest", message: "Password must be 8 characters(Must contain 1 digit and uppercase)")
//        }
        else if self.txtFldConfirmPassword.text?.count == 0{
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseenteryourconfirmpassword") as? String ?? "")
        } else if self.txtFldConfirmPassword.text != self.txtFldPassword.text {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_NotMatch") as? String ?? "")
        } else if  self.isAgreeTerms == false{
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_pleaseagreetheterms") as? String ?? "")
        } else {
            self.firstName = self.txtFldFirstName.text
            self.lastName = self.txtFldLastName.text
            self.email = self.txtFldEmail.text
            self.password = self.txtFldPassword.text
            self.key = "121"
            self.loginType = "121"
            self.deviceType = "iphone"
            self.signupAPI()
        }
    }
    
    func signupAPI() {
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self

        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
   
            params =  ["u_first_name": self.firstName!,"u_last_name":self.lastName!,"email":self.email!,"phone":self.txtFldphone.text ?? "","u_psd":self.password!,"login_type":"normal","apple_id":self.appleID,"google_id":self.key,"facebook_id": self.key!,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en"]

            print("signupAPI login params::::", params)
         
            APIManager.apiPostWithHeaders(serviceName: REQ_SIGNUP, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Closest", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                    let userDetailsArr = (responseDict.value(forKey: "data") as? NSDictionary)?.value(forKey: "user_details") as! NSDictionary
                    
                    
                    if userDetailsArr.count != 0 {
                        let userDetails = userDetailsArr
                        //let userid = String(describing: userDetails?.value(forKey: "userid"))
                        let token = userDetailsArr.object(forKey: "token")as? String ?? ""
                        
                        login_session.setValue(token, forKey: "user_token")
                        let tokenStr:String = login_session.object(forKey: "user_token") as? String ?? ""
                        print("TokenString",tokenStr)
                        
                        if UserDefaults.standard.object(forKey: "fcmToken") != nil{
                            self.fcmToken = UserDefaults.standard.object(forKey: "fcmToken") as? String ?? ""
                        }else{
                            self.fcmToken = ""
                        }
                        
                        print("\(self.fcmToken)")
                        
                        let userid = userDetails.value(forKey: "userid")
                        login_session.setValue(true, forKey: "IS_USER_LOGGEDIN")
                        login_session.setValue((userDetails.value(forKey: "firstname")), forKey: "Firstname")
                        login_session.setValue(userDetails.value(forKey: "lastname"), forKey: "Lastname")
                        login_session.setValue(userDetails.value(forKey: "user_phone"), forKey: "PhoneNumber")
                        login_session.setValue(userid, forKey: "UserId")
                        login_session.setValue(userDetails.value(forKey: "email"), forKey: "Email")
                        let imgUrl = userDetails.value(forKey: "userimage") as? String
                       // print(imgUrl!)
                        lanuguage_selection.set("en", forKey: "language")
                        login_session.set(userDetails.value(forKey: "userimage"), forKey: "ProfilePic")
                        if (login_session.value(forKey: "ProfilePic") as? String) != nil {
                            login_session.setValue(userDetails.value(forKey: "userimage"), forKey: "ProfilePic")
                        }
                        login_session.synchronize()
                        
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
                                            self.navigationController?.pushViewController(nav!, animated: true)
                    }
                    
                    let refreshAlert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_loggedInSus") as? String, preferredStyle: UIAlertControllerStyle.alert)

                    refreshAlert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as? String, style: .default, handler: { (action: UIAlertAction!) in
      //                  self.discoverApi()

                        
                    }))

                    self.present(refreshAlert, animated: true, completion: nil)
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
 
    }
    }
    }
    
 
}

//MARK:- Textfield Delegate methods

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField) {
        case self.txtFldEmail:
            self.txtFldPassword.becomeFirstResponder()
        case self.txtFldPassword:
            self.txtFldConfirmPassword.becomeFirstResponder()
        case self.txtFldConfirmPassword:
            self.txtFldFirstName.becomeFirstResponder()
        case self.txtFldFirstName:
            self.txtFldLastName.becomeFirstResponder()
        case self.txtFldLastName:
            self.txtFldLastName.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
}

//MARK:- Google Plus Delegate GIDSignInUIDelegate
extension SignUpViewController: GIDSignInDelegate
{
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Saving user details in Userdefaults.
            
            login_session.setValue(user.profile.name, forKey: "Firstname")
            login_session.setValue(user.profile.givenName, forKey: "Lastname")
            login_session.setValue(user.userID , forKey: "GoogleId")
            login_session.setValue(user.profile.email, forKey: "Email")
            //            login_session.setValue(UserDetail.value(forKey: "url"), forKey: "ProfilePic")
            login_session.synchronize()
            
            // Signup Datas
            
            self.firstName = user.profile.givenName ?? " "
            self.lastName = user.profile.name ?? " "
            self.email = user.profile.email ?? " "
            self.password = "google"
            self.key = user.userID ?? " "
            self.loginType = "google"
            self.deviceType = "iphone"
            self.signupAPI()
        }
    }
    
    private func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        print("signInWillDispatch")
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        print("present")
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        print("dismiss")
    }
}

//MARK:- HTTP Delegates

extension SignUpViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        print(responseDict)
        hideActivityIndicator(uiView: self.view)
        if APIKEY == "SIGNUP" {
            if errorDict == "" {
                if responseDict.count != 0 {
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 0 {
                        showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    } else {
                        let userDetailsArr = responseDict.value(forKey: "user_details") as! NSArray
                        if userDetailsArr.count != 0 {
                            let userDetails = userDetailsArr[0] as? NSDictionary
                            //let userid = String(describing: userDetails?.value(forKey: "userid"))
                            let userid = userDetails?.value(forKey: "userid")
                            print(userDetails)
                            login_session.setValue(true, forKey: "IS_USER_LOGGEDIN")
                            login_session.setValue((userDetails?.value(forKey: "firstname")), forKey: "Firstname")
                            login_session.setValue(userDetails?.value(forKey: "lastname"), forKey: "Lastname")
                            
                            login_session.setValue(userid, forKey: "UserId")
                            login_session.setValue(userDetails?.value(forKey: "email"), forKey: "Email")
                            let imgUrl = userDetails?.value(forKey: "userimage") as? String
                            print(imgUrl!)
                            lanuguage_selection.set("en", forKey: "language")
                            login_session.set(userDetails?.value(forKey: "userimage"), forKey: "ProfilePic")
                            if (login_session.value(forKey: "ProfilePic") as? String) != nil {
                            login_session.setValue(userDetails?.value(forKey: "userimage"), forKey: "ProfilePic")
                            }
                            login_session.synchronize()
                        }
                        let requestStr = "email_id=\(login_session.value(forKey: "Email") as? String ?? "")&page_Id=\(1)&lang_code=en"
                        Network.shared.POSTRequest(withParameterString: requestStr, serviceURL:DISCOVER_API , APIKEY: "DISCOVER_API")
                    }
                    print(responseDict)
                } else {
                    showInformation(title: "Closest", message:errorDict )
                }
            } else {
                showInformation(title: "Error", message: errorDict)
            }
        } else if APIKEY == "DISCOVER_API" {
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
