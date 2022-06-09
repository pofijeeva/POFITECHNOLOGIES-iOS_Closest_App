
//  AccountViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 19/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import AFNetworking


class AccountViewController: BaseViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var btn_PayoutPref: UIButton!
    @IBOutlet weak var btn_TransactionHistory: UIButton!
    @IBOutlet weak var btn_Security: UIButton!
    @IBOutlet weak var btn_Residence: UIButton!
    @IBOutlet weak var conYellowWidth: NSLayoutConstraint!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var grayView: UIView!
    
    // Payout preferences
    
    @IBOutlet weak var viewPayoutPreferences: UIView!
    @IBOutlet weak var lblAddPayoutDetails: UILabel!
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtAccountName: UITextField!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblAcocuntName: UILabel!
    @IBOutlet weak var PaypalEmailLbl: UILabel!
    @IBOutlet weak var PaypalEmailTxtField: UITextField!

    @IBOutlet weak var conAddPayOutTopSpace: NSLayoutConstraint!
    
    

    
    // Transaction History
    
    @IBOutlet weak var viewTransactionHistory: UIView!
    @IBOutlet weak var segCompleteOrFuture: UISegmentedControl!
    @IBOutlet weak var tblTransactionHistory: UITableView!
    @IBOutlet weak var lblNoCompltedTransaction: UILabel!
    @IBOutlet weak var tblTransactionCompleteHistory: UITableView!
     @IBOutlet weak var NoTransAction: UIImageView!
    
    // Security
    
    @IBOutlet weak var viewSecurity: UIView!
    @IBOutlet weak var lblChangePassword: UILabel!
    @IBOutlet weak var lblOldPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPasword: UITextField!
    @IBOutlet weak var conChangePassTopSpace: NSLayoutConstraint!
    @IBOutlet weak var countrylbl: UILabel!
    // Country of Residence
    @IBOutlet weak var lblCountryOfResidence: UILabel!
    @IBOutlet weak var txtCountryName: UITextField!
    @IBOutlet weak var view_ResidenceView: UIView!
    @IBOutlet weak var tbl_Countrylist: UITableView!
    // Variables
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var selcountry: UIButton!
    @IBOutlet weak var saveCountryResidence: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    
    
       @IBOutlet weak var TypeView: UIView!
    @IBOutlet weak var TypeCollection: UICollectionView!
    
    
    
    var showDeatilForRow = Int()
    var isDetailShow = false
    var Completed = [Accountinfo]()
    var Future = [Accountinfo]()
    var isCompleted = true
    var currencySymbol = "$"
    var AccountName : String!
    var AccountNum : String!
    var BankName : String!
    var paypalEmail : String!
    var oldPassword : String!
    var newPassword : String!
    var confirmPassword : String!
    var countryid = String()
    var selectedCountryName = String()
    
    var TypeArray = NSMutableArray()
    var SelectedRow = 0

    
    // MARK:- Lifecycle methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.txtAccountName.delegate = self
        self.PaypalEmailTxtField.delegate = self
        self.txtAccountNumber.delegate = self
        self.txtBankName.delegate = self
        
        
        self.lblNoCompltedTransaction.isHidden = true
        self.NoTransAction.isHidden = true
        tblTransactionHistory.tableFooterView = UIView()

        tblTransactionCompleteHistory.tableFooterView = UIView()
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if accountSelectedCountry != "" {
          //  selcountry.setTitle(accountSelectedCountry, for: .normal)
            self.txtCountryName.text = accountSelectedCountry
        }
        else {
           // selcountry.setTitle("Select Country Of Residence", for: .normal)
            self.txtCountryName.text = ""
             self.txtCountryName.placeholder = "Select Country Of Residence"
        }
        if (Reachability()?.isReachable)!
        {
            UserAccountApi()
//            let id = Singleton.sharedInstance.selectedCategory!
//            showActivityIndicator(uiView: self.view)
//            let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: GET_USER_ACCOUNT_DETAILS, APIKEY: "GET_USER_ACCOUNT_DETAILS")
//            print(parameterStr)
        }
        else
        {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
          self.viewTitle.font = UIFont(name: SemiBoldFont, size: 15)
           self.btn_PayoutPref.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.btn_TransactionHistory.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.btn_Security.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.btn_Residence.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.yellowView.backgroundColor = AppSecondColor
        self.lblNoCompltedTransaction.font = UIFont(name: RegularFont, size: 15)
        self.TypeArray = ["  PAYOUT PREFERENCES  ","  TRANSACTION HISTORY  ","SECURITY","RESIDENCE"]
        self.updateButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.updateButton.backgroundColor = AppSecondColor
        self.txtOldPassword.font = UIFont(name: RegularFont, size: 15)
         self.txtNewPassword.font = UIFont(name: RegularFont, size: 15)
         self.txtConfirmPasword.font = UIFont(name: RegularFont, size: 15)
        self.lblChangePassword.font = UIFont(name: BoldFont, size: 18)
        self.lblChangePassword.textColor = AppColor
         self.lblCountryOfResidence.textColor = AppColor
         self.lblOldPassword.font = UIFont(name: SemiBoldFont, size: 12)
         self.lblNewPassword.font = UIFont(name: SemiBoldFont, size: 12)
          self.lblConfirmPassword.font = UIFont(name: SemiBoldFont, size: 12)
        
          self.saveCountryResidence.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
           self.lblCountryOfResidence.font = UIFont(name: SemiBoldFont, size: 15)
         self.txtCountryName.font = UIFont(name: SemiBoldFont, size: 12)
        //  self.selcountry.backgroundColor = AppSecondColor
        self.lblAddPayoutDetails.font = UIFont(name: BoldFont, size: 16)
        self.lblAddPayoutDetails.textColor = AppSecondColor
          self.lblAcocuntName.font = UIFont(name: RegularFont, size: 12)
         self.lblAccountNumber.font = UIFont(name: RegularFont, size: 12)
          self.lblBankName.font = UIFont(name: RegularFont, size: 12)
        self.PaypalEmailLbl.font = UIFont(name: RegularFont, size: 12)
          self.txtAccountName.font = UIFont(name: RegularFont, size: 14)
          self.txtAccountNumber.font = UIFont(name: RegularFont, size: 14)
          self.txtBankName.font = UIFont(name: RegularFont, size: 14)
         self.PaypalEmailTxtField.font = UIFont(name: RegularFont, size: 14)
        self.submitButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
     //    self.selcountry.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
         self.txtCountryName.font = UIFont(name: SemiBoldFont, size: 14)
        self.submitButton.backgroundColor = AppSecondColor
        self.lblAddPayoutDetails.textColor = AppColor
          self.lblAddPayoutDetails.textColor = AppColor
         self.txtOldPassword.text = ""
         self.txtNewPassword.text = ""
         self.txtConfirmPasword.text = ""
     }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    func UserAccountApi() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
         params = ["userid":login_session.value(forKey: "UserId"),"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
       
        print(params)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(GET_USER_ACCOUNT_DETAILS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                print("GET_ACCOUNT_API Response:::",responseDict)
                let mod = AccountInfoModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.accInfoModel = mod
                self.txtAccountName.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].accname
                self.txtAccountNumber.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].accno
                self.txtBankName.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].bankname
                 self.PaypalEmailTxtField.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].paypalEmail
                
                let CountryId = Singleton.sharedInstance.accInfoModel.accountinfo[0].country!
                self.countryid = "\(Singleton.sharedInstance.accInfoModel.accountinfo[0].country!)"
                for i in 0..<Singleton.sharedInstance.accInfoModel.countryList.count{
                    let name = Singleton.sharedInstance.accInfoModel.countryList[i].countryName
                      let CntId = Singleton.sharedInstance.accInfoModel.countryList[i].id
                    
                    if CntId == CountryId {
                        accountSelectedCountry = name ?? ""
                       //  self.selcountry.setTitle(accountSelectedCountry, for: .normal)
                         self.txtCountryName.text = accountSelectedCountry
                    }
                }
                
                
//                if accountSelectedCountry != "" {
//                    self.selcountry.setTitle(accountSelectedCountry, for: .normal)
//                }
                if Singleton.sharedInstance.accInfoModel.futureTransaction.count == 0 {
                 self.lblNoCompltedTransaction.isHidden = false
                    self.NoTransAction.isHidden = false

                 self.tblTransactionHistory.isHidden = true
                 }
                 else {
                 self.lblNoCompltedTransaction.isHidden = true
                    self.NoTransAction.isHidden = true

                 self.tblTransactionHistory.isHidden = false
                 }
                 if Singleton.sharedInstance.accInfoModel.completedTransaction.count == 0 {
                 self.lblNoCompltedTransaction.isHidden = false
                    self.NoTransAction.isHidden = false

                 self.tblTransactionCompleteHistory.isHidden = true
                 }
                 else {
                 self.lblNoCompltedTransaction.isHidden = true
                    self.NoTransAction.isHidden = true

                 self.tblTransactionCompleteHistory.isHidden = false
                 }
                self.tblTransactionCompleteHistory.reloadData()
                self.tbl_Countrylist.reloadData()
                self.tblTransactionCompleteHistory.reloadData()

                self.tblTransactionHistory.reloadData()
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
    
    //MARK:- Button Actions
    
 
    
    @IBAction func act_SelectCountryofResidence(_ sender: UIButton)
    {
        self.tbl_Countrylist.isHidden = false
        self.grayView.isHidden = false
        
        if (Reachability()?.isReachable)!
        {
            UserAccountApi()
//            let id = Singleton.sharedInstance.selectedCategory!
//            showActivityIndicator(uiView: self.view)
//            let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: GET_USER_ACCOUNT_DETAILS, APIKEY: "GET_USER_ACCOUNT_DETAILS")
        }
        else
        {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
    }
    
    @IBAction func act_SaveCountryOfResidance(_ sender: UIButton) {
        if countryid != "" && countryid != "0"{
            self.SubmitAPI()
        }
        else {
            showInformation(title: "Closest", message: "Plesae select your Country")
        }
    }
    func SubmitAPI()
    {
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","device_type":"IOS","base_id":1,"country":self.countryid,"userid":login_session.value(forKey: "UserId")!]
          
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(USER_ACC_UPDATE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    print("GET_WISHLIST_API Response:::",responseDict)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    
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
//            let id = Singleton.sharedInstance.selectedCategory!
//            print(id)
//            showActivityIndicator(uiView: self.view)
//            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&device_type=IOS&base_id=\(id)&country=\(self.countryid!)&userid=\(login_session.value(forKey: "UserId")!)"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL:USER_ACC_UPDATE_API , APIKEY: "USER_ACC_UPDATE_API")
//            print(parameterStr)
        } else {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
    }
    
    @IBAction func act_SubmitPayoutRef(_ sender: UIButton) {
        if self.txtAccountName.text?.count == 0
        {
            showInformation(title: "Closest", message: "Account Name cannot be empty")
        }
        else if self.PaypalEmailTxtField.text?.count == 0
        {
            showInformation(title: "Closest", message: "PayPal Email cannot be empty")
        }
        else if isValidEmail(email: self.PaypalEmailTxtField.text) == false {
           showInformation(title: "Closest", message: "Enter valid email")
        }
        else if self.txtAccountNumber.text?.count == 0
        {
            showInformation(title: "Closest", message: "Account Number cannot be empty")
        }
        else if self.txtBankName.text?.count == 0
        {
            showInformation(title: "Closest", message: "Bank Name cannot be empty")
        }
       

        else
        {
            self.AccountName = self.txtAccountName.text
            self.AccountNum = self.txtAccountNumber.text
            self.BankName = self.txtBankName.text
            self.paypalEmail = self.PaypalEmailTxtField.text
            PayoutPreferencesSubmitApi()
        }
    }
    
    func PayoutPreferencesSubmitApi() {
        if (Reachability()?.isReachable)! {
            let id = Singleton.sharedInstance.selectedCategory!
            print(id)
            showActivityIndicator(uiView: self.view)
            //let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&accno=\(self.AccountNum!)&base_id=\(id)&bankname=\(self.BankName!)&accname=\(self.AccountName!)&user_id=\(login_session.value(forKey: "UserId")!)"
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","device_type":"IOS","base_id":1,"accno":self.AccountNum!,"bankname":self.BankName!,"paypal_email":self.paypalEmail!,"accname":self.AccountName!,"userid":login_session.value(forKey: "UserId")!]


            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>

            manager.post(USER_ACC_UPDATE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {

                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    print("GET_WISHLIST_API Response:::",responseDict)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)

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
//            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&device_type=IOS&base_id=\(id)&accno=\(self.AccountNum!)&bankname=\(self.BankName!)&paypal_email=\(self.paypalEmail!)&accname=\(self.AccountName!)&userid=\(login_session.value(forKey: "UserId")!)"
//            print(parameterStr)
//
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL:USER_ACC_UPDATE_API , APIKEY: "USER_ACC_UPDATE_API")
//            print(parameterStr)
        } else {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
    }
    
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func act_UpdatePassword(_ sender: UIButton) {
        if self.txtOldPassword.text?.count == 0
        {
            showInformation(title: "Closest", message: "Please enter old Password")
        }
        else if self.txtNewPassword.text?.count == 0
        {
            showInformation(title: "Closest", message: "Please enter new Password")
        }else if (checkTextSufficientComplexity(`var`: self.txtNewPassword.text!)) == false{
            showInformation(title: "Closest", message: "Password must be 8 characters(Must contain 1 digit and uppercase)")
        }
//        else if (self.txtNewPassword.text?.count)! < 6 {
//            showInformation(title: "Closest", message: "Your Password should have minimum six character")
//        }
        else if self.txtConfirmPasword.text?.count == 0
        {
            showInformation(title: "Closest", message: "Please enter confirm password")
        }
        else if self.txtConfirmPasword.text != self.txtNewPassword.text
        {
            showInformation(title: "Closest", message: "Passwords not matching")
        }
        else
        {
            self.oldPassword = self.txtOldPassword.text
            self.newPassword = self.txtNewPassword.text
            self.confirmPassword = self.txtConfirmPasword.text
            self.updatePasswordAPI()
        }
    }
    func updatePasswordAPI()
    {
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
           
             params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","new_password":self.newPassword!]
            
            print(params)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(USER_PASSWD_UPDATE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    print("GET_WISHLIST_API Response:::",responseDict)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    
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
//            showActivityIndicator(uiView: self.view)
//            let parameterStr = "old_password=\(self.oldPassword!)&userid=\(login_session.value(forKey: "UserId")!)&new_password=\(self.newPassword!)"
//
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL:USER_PASSWD_UPDATE_API , APIKEY: "USER_PASSWD_UPDATE_API")
        } else
        {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
    }
    
    @IBAction func act_SegmentTapped(_ sender: UISegmentedControl)
    {
        segCompleteOrFuture.addTarget(self, action: Selector(("segmentedControlValueChanged:")), for:.touchUpInside)
        let getIndex = segCompleteOrFuture.selectedSegmentIndex
        print(getIndex)
        
        switch (getIndex) {
        case 0:
            
           
            self.lblNoCompltedTransaction.isHidden = false
            self.NoTransAction.isHidden = false

            self.tblTransactionHistory.isHidden = true
           
            
            if Singleton.sharedInstance.accInfoModel.completedTransaction.count == 0 {
                 self.tblTransactionCompleteHistory.isHidden = true
            }else{
                 self.tblTransactionCompleteHistory.isHidden = false
            }
            
            
            self.tblTransactionCompleteHistory.reloadData()
            break
        case 1:
            self.lblNoCompltedTransaction.isHidden = false
            self.NoTransAction.isHidden = false



            self.tblTransactionHistory.isHidden = false
            self.tblTransactionCompleteHistory.isHidden = true
            
            if Singleton.sharedInstance.accInfoModel.futureTransaction.count == 0 {
                            self.tblTransactionHistory.isHidden = true
                       }else{
                            self.tblTransactionHistory.isHidden = false
                       }
            self.tblTransactionHistory.reloadData()
            break
        default:
            //            self.lblNoCompltedTransaction.isHidden = false
            break
        }
    }
    
    
    @IBAction func act_PayoutPreference(_ sender: UIButton) {
        self.viewSecurity.isHidden = true
        self.view_ResidenceView.isHidden = true
        self.viewTransactionHistory.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.viewPayoutPreferences.isHidden = false
            self.yellowView.frame = CGRect(x: 20, y: self.yellowView.frame.origin.y, width: self.btn_PayoutPref.frame.size.width  , height: 3)
        }
    }
    
    @IBAction func act_TransactionHistory(_ sender: UIButton) {
        self.viewSecurity.isHidden = true
        self.view_ResidenceView.isHidden = true
        self.viewPayoutPreferences.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.viewTransactionHistory.isHidden = false
            self.yellowView.frame = CGRect(x: self.btn_TransactionHistory.frame.origin.x , y: self.yellowView.frame.origin.y, width: self.btn_TransactionHistory.frame.size.width  , height: 3)
        }
    }
    
    @IBAction func act_Residency(_ sender: UIButton) {
        self.tbl_Countrylist.isHidden = true
        self.grayView.isHidden = true
        self.viewSecurity.isHidden = true
        self.viewTransactionHistory.isHidden = true
        self.viewPayoutPreferences.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.view_ResidenceView.isHidden = false
            self.yellowView.frame = CGRect(x: self.btn_Residence.frame.origin.x , y: self.yellowView.frame.origin.y, width: self.btn_Residence.frame.size.width  , height: 3)
        }
    }
    
    @IBAction func act_Security(_ sender: UIButton) {
        self.viewPayoutPreferences.isHidden = true
        self.view_ResidenceView.isHidden = true
        self.viewTransactionHistory.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.viewSecurity.isHidden = false
            self.yellowView.frame = CGRect(x: self.btn_Security.frame.origin.x , y: self.yellowView.frame.origin.y, width: self.btn_Security.frame.size.width  , height: 3)
        }
    }
    
    @objc  func showAmountDetails(sender: UIButton) {
        showDeatilForRow = sender.tag
        if isDetailShow == false {
            isDetailShow = true
        } else {
            isDetailShow = false
        }
        self.tblTransactionHistory.reloadData()
    }
}

extension AccountViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {            
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == tblTransactionCompleteHistory
        {
            if Singleton.sharedInstance.accInfoModel == nil
            {
                return 0
            }
            else
            {
                return Singleton.sharedInstance.accInfoModel.completedTransaction.count
            }
        }
        else if tableView == tblTransactionHistory
        {
            if Singleton.sharedInstance.accInfoModel == nil
            {
                return 0
            }
            else
            {
                return Singleton.sharedInstance.accInfoModel.futureTransaction.count
            }
        }
        else
        {
            if Singleton.sharedInstance.accInfoModel == nil
            {
                return 0
            }
            else
            {
                return Singleton.sharedInstance.accInfoModel.countryList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == tblTransactionCompleteHistory
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TransactionCompleteTableViewCell
            cell!.lbl_TransactionMethodname.font = UIFont(name: SemiBoldFont, size: 15)
            cell!.TransactionMethodname.font = UIFont(name: RegularFont, size: 13)
            cell!.TransactionId.font = UIFont(name: RegularFont, size: 13)
            cell!.Amount.font = UIFont(name: RegularFont, size: 13)
              cell!.lbl_TransactionId.font = UIFont(name: SemiBoldFont, size: 15)
              cell!.lbl_TransactionAmount.font = UIFont(name: SemiBoldFont, size: 15)
            cell!.BookingDateLbl.font = UIFont(name: SemiBoldFont, size: 13.0)
               cell!.BookingId.font = UIFont(name: SemiBoldFont, size: 13.0)
            cell!.BookingId.text = "(Booking No: \(Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].bookingno!))"
             cell!.BookingDateLbl.text = "\(Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].dateadded!)"
            cell!.lbl_TransactionMethodname.text = Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].transactionMethod
            cell!.lbl_TransactionId.text = Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].transactionId!
            cell!.lbl_TransactionAmount.text = "\(Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].currencySymbol!)" + " " +  "\(String(describing: Singleton.sharedInstance.accInfoModel.completedTransaction[indexPath.row].amount!))" 
            return cell!
        }
        else if tableView == tblTransactionHistory
        {
            let  fcell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TransactionHistoryCell
            fcell!.btnTotal.tag = indexPath.row
            
            fcell!.lblDateID.font = UIFont(name: SemiBoldFont, size: 16)
            fcell!.lblPropertyName.font = UIFont(name: SemiBoldFont, size: 16)
            fcell!.lblName.font = UIFont(name: RegularFont, size: 14)
            
            fcell!.lblTotal.font = UIFont(name: RegularFont, size: 14)
            fcell!.lblTotalValue.font = UIFont(name: RegularFont, size: 14)
            
            fcell!.lblServiceFee.font = UIFont(name: RegularFont, size: 14)
            fcell!.lbl_ServicefeeAmount.font = UIFont(name: RegularFont, size: 14)
            
            fcell!.lblNetAmount.font = UIFont(name: RegularFont, size: 14)
            fcell!.lblNetAmountAmount.font = UIFont(name: RegularFont, size: 14)
            
            fcell!.lblHostFee.font = UIFont(name: RegularFont, size: 14)
            fcell!.lblHostFeeAmount.font = UIFont(name: RegularFont, size: 14)
            
            fcell!.lblNetAmount.text = "Net Amount"
            fcell!.lblTotal.text = "Total"

            fcell!.btnTotal.addTarget(self, action: #selector(showAmountDetails), for: .touchUpInside)
            fcell!.lblDateID.text = Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].dateadded! + " " + "(Booking No: " + "\((Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].bookingno!))" + ")"
            fcell!.lblPropertyName.text = Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].propertyTitle
            if let firstNameStr :String = Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].firstname{
                fcell!.lblName.text = firstNameStr
            }
            
            fcell!.lblTotalValue.text = currencySymbol + "\(String(describing: Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].subTotal!))"
            //fcell!.lbl_ServicefeeAmount.text = currencySymbol + "\(String(Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].serviceFee!))"
           
            

            let str = (Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].serviceFee!)

            if str as? Float != nil
            {
                fcell!.lbl_ServicefeeAmount.text = currencySymbol + "\(str)"

            }
            else
            {
                fcell!.lbl_ServicefeeAmount.text = currencySymbol + "\((Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].serviceFee!))"
            }

            

            fcell!.lblNetAmountAmount.text = currencySymbol + "\(String(describing:Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].payableAmount!))"
            fcell?.lblHostFeeAmount.text = currencySymbol + "\(String(describing:Singleton.sharedInstance.accInfoModel.futureTransaction[indexPath.row].securityDeposit!))"
            
            //return fcell!
            
            if showDeatilForRow == indexPath.row {
                
                if isDetailShow == true {
                    
                    UIView.animate(withDuration: 0.5)
                    {
                        fcell!.viewDropdown.isHidden = false
                        fcell!.imgDropDown.transform = CGAffineTransform(rotationAngle: .pi)
                    }
                } else {
                    UIView.animate(withDuration: 0.5) {
                        fcell!.viewDropdown.isHidden = true
                        fcell!.imgDropDown.transform = CGAffineTransform.identity
                    }
                }
            }
            return fcell!
        }
        else
        {
            let ccell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CountrylistTableViewCell
             ccell!.lbl_CountryName.font = UIFont(name: RegularFont, size: 16)
            ccell!.lbl_CountryName.text = Singleton.sharedInstance.accInfoModel.countryList[indexPath.row].countryName!
            return ccell!
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if showDeatilForRow == indexPath.row {
//            if isDetailShow == true
//            {
//                return 190
//
//            } else
//            {
//                return 100
//            }
//        } else
//        {
//            return 100
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView == tbl_Countrylist {
            self.grayView.isHidden = true
            self.tbl_Countrylist.isHidden = true
            let countryId = Singleton.sharedInstance.accInfoModel.countryList[indexPath.row].id!
            countryid = String(countryId)
            txtCountryName.text = " "
            selectedCountryName = Singleton.sharedInstance.accInfoModel.countryList[indexPath.row].countryName!
            accountSelectedCountry = selectedCountryName
           // selcountry.setTitle(selectedCountryName, for: .normal)
            self.txtCountryName.text = selectedCountryName
        }
        else {
            self.grayView.isHidden = true
        }
    }
}

extension AccountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch (textField) {
        case self.txtAccountName:
            self.txtAccountNumber.becomeFirstResponder()
        case self.txtAccountNumber:
            self.txtBankName.becomeFirstResponder()
        case self.txtBankName:
            self.txtBankName.resignFirstResponder()
        case self.PaypalEmailTxtField:
            self.PaypalEmailTxtField.resignFirstResponder()
        case self.txtOldPassword:
            self.txtOldPassword.becomeFirstResponder()
        case self.txtNewPassword:
            self.txtNewPassword.becomeFirstResponder()
        case self.txtConfirmPasword:
            self.txtConfirmPasword.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
     
        if textField == txtAccountName {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 24
            //return count <= 1056466
        }
        else if textField == PaypalEmailTxtField  {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 30
        }
        else if textField == txtAccountNumber {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 24
        }
        else if textField == txtBankName{
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 20
        }
        return result
    }
    
}

extension AccountViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "GET_USER_ACCOUNT_DETAILS" {
            print(responseDict)
            hideActivityIndicator(uiView: self.view)
            
            if responseDict.count != 0
            {
                let mod = AccountInfoModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.accInfoModel = mod
                self.txtAccountName.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].accname
                self.txtAccountNumber.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].accno
                self.txtBankName.text = Singleton.sharedInstance.accInfoModel.payoutPerference[0].bankname
                if accountSelectedCountry != "" {
                 //   selcountry.setTitle(accountSelectedCountry, for: .normal)
                     self.txtCountryName.text = accountSelectedCountry
                }
                /*if Singleton.sharedInstance.accInfoModel.futureTransaction.count == 0 {
                    self.lblNoCompltedTransaction.isHidden = false
                    self.tblTransactionHistory.isHidden = true
                }
                else {
                    self.lblNoCompltedTransaction.isHidden = true
                    self.tblTransactionHistory.isHidden = false
                }
                if Singleton.sharedInstance.accInfoModel.completedTransaction.count == 0 {
                    self.lblNoCompltedTransaction.isHidden = false
                    self.tblTransactionCompleteHistory.isHidden = true
                }
                else {
                    self.lblNoCompltedTransaction.isHidden = true
                    self.tblTransactionCompleteHistory.isHidden = false
                }*/
                tblTransactionCompleteHistory.reloadData()
                tbl_Countrylist.reloadData()
            }
            else
            {
                self.tblTransactionHistory.reloadData()
            }
        }
        else if APIKEY == "USER_ACC_UPDATE_API" {
            print(responseDict)
            hideActivityIndicator(uiView: self.view)
            if responseDict.count != 0 {
                if responseDict.value(forKey: "status") as! Int == 1 {
                    showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
                else {
                    showInformation(title: "Closest", message: "Check your internet connection")
                }
            }
        }
        else if APIKEY == "USER_PASSWD_UPDATE_API" {
            print(responseDict)
            hideActivityIndicator(uiView: self.view)
            if responseDict.count != 0 {
                
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
            else {
                showInformation(title: "Closest", message: "Check your internet connection")
            }
        }
            
        else {
            print("No Data")
        }
    }
}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       
            return 4
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as? TypeCollectionViewCell
       
        cell?.TypeLbl.font = UIFont(name: SemiBoldFont, size: 14)
       
        cell?.TypeLbl.text = TypeArray.object(at: indexPath.row)  as? String
        
        if SelectedRow == indexPath.row {
            cell?.TypeLbl.backgroundColor = AppSecondColor
            cell?.TypeLbl.textColor = .white
        }else{
             cell?.TypeLbl.textColor = .black
            cell?.TypeLbl.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        }
       // cell?.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
        
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.SelectedRow = indexPath.row
        self.TypeCollection.reloadData()
        if indexPath.row == 0 {
            self.viewSecurity.isHidden = true
                 self.view_ResidenceView.isHidden = true
                 self.viewTransactionHistory.isHidden = true
               
                     self.viewPayoutPreferences.isHidden = false
                   
        }else if indexPath.row == 1{
            self.viewSecurity.isHidden = true
                self.view_ResidenceView.isHidden = true
                self.viewPayoutPreferences.isHidden = true
            
                    self.viewTransactionHistory.isHidden = false
                   
        }else if indexPath.row == 2 {
            self.viewPayoutPreferences.isHidden = true
                  self.view_ResidenceView.isHidden = true
                  self.viewTransactionHistory.isHidden = true
               
                      self.viewSecurity.isHidden = false
                     
        }else{
            self.tbl_Countrylist.isHidden = true
                  self.grayView.isHidden = true
                  self.viewSecurity.isHidden = true
                  self.viewTransactionHistory.isHidden = true
                  self.viewPayoutPreferences.isHidden = true
                
                      self.view_ResidenceView.isHidden = false
                    
        }
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 0.3)
    }
    func reloadCollectionView() {
        self.TypeCollection.reloadData()
    }
    @objc func updateStepsRemaining() {
        
        self.TypeCollection.scrollToItem(at: IndexPath(row: self.SelectedRow, section: 0), at: .centeredHorizontally, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}
