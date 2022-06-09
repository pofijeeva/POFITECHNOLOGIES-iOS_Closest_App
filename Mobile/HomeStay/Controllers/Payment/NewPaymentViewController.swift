//
//  NewPaymentViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 12/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import AFNetworking
import CCValidator
import BraintreeDropIn
import Braintree
import PassKit




class NewPaymentViewController: BaseViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var PaymentTable: UITableView!
    @IBOutlet weak var GrayView: UIView!
    @IBOutlet weak var PayBtn: UIButton!
    @IBOutlet weak var headerLbl: UILabel!

    @IBOutlet weak var PaymentDoneLbl: UILabel!
    @IBOutlet weak var TransSuccessLbl: UILabel!
    @IBOutlet weak var TransSuccessBtn: UIButton!

    
   

    var booking_type = String()
    var balenceWalletPrice = String()
    var PaymentsArray = NSMutableArray()
    var CouponShow = 1
    var WalletShow = 1
    var choosePaymentType = String()
    var ChoosePaymentInt = Int()
    var PaymentFor = String()
    var clientToken:String = ""
    var cardtype = String()
    var cardnumber = String()
    var cc_exp_day = String()
    var cc_exp_year = String()
    var credit_card_identifier = String()
    var iscoupon = Bool()
    var iswalletPayment = Bool()
    
    var enquiryid = String()
    var subTotal = String()
    var TotalAmount = String()
    var StartDate = String()
    var EndDate = String()
    var GuestCount = Int()
    var Message = String()
    var ServiceFee = String()
    var SecurityDeposit = String()
    var CurrentTotal = String()
    var cardsArr = ["Visa","American Express","Master Card","Discover"]
    var cardsImgArr = NSArray()
    let cardTypedropdowns = DropDown()
    let YearDropDown = DropDown()

    let MonthDropDown = DropDown()
    var window: UIWindow?
    var book_id = String()


    var isCheck = Bool()
    var paymentComingType = String()
    
    var Commission = String()
    var CommissionType = String()
    var HostId = String()
    var HostingPrice = String()
    var TotalPrice = String()
    var currency_cron_id = String()
    var AgentShow:Bool = false
    
    var agent_id = String()
    var Agent_Commission = String()
    var agent_Code = String()
    var agent_status = String()
    var agent_percentage = String()
    var CouponTotAmount = String()
    var CouponDiscountAmount = String()
    var AmounttobePaid = String()
    var CouponCode:String = ""
    
    var MonthsArray = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let year = Calendar.current.component(.year, from: Date())
    var YearsArray = NSMutableArray()
    var PropertId = String()
    
    var choosed_option = String()
    var pay_balance = Int()
    
    var ApplePayToken = String()
    var AppleData = Data()
    
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.cardTypedropdowns,
            self.YearDropDown,
            self.MonthDropDown
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PayBtn.backgroundColor = AppColor
        self.PaymentTable.tableFooterView = UIView()
        
        self.YearsArray.removeAllObjects()
        for i in 0..<15 {
            let currentYear = year + i
            print(currentYear)
            self.YearsArray.add("\(currentYear)")
        }
        print(self.YearsArray)
        
        self.fetchClientToken()
 
        self.headerLbl.font = UIFont(name: SemiBoldFont, size: 20)
        self.headerLbl.text = GlobalLanguageDictionary.object(forKey: "Key_paymentMethods") as! String
        self.PayBtn.setTitle(GlobalLanguageDictionary.object(forKey: "Key_payNow") as! String, for: .normal)
        self.PaymentDoneLbl.text = GlobalLanguageDictionary.object(forKey: "key_paymentDone") as! String
        self.TransSuccessLbl.text = GlobalLanguageDictionary.object(forKey: "key_PaymentSuccess") as! String
        self.TransSuccessBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_done") as! String, for: .normal)
        
        self.CurrentTotal = self.TotalAmount
        self.PayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.PayBtn.backgroundColor = AppColor
        self.TransSuccessBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.TransSuccessBtn.backgroundColor = AppColor
        // Do any additional setup after loading the view.
    }
    
    func WalletApi(){
        
        
        
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
         params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"user_id":login_session.value(forKey: "UserId")!]
        
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(WALLET_AVAILABLE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                                let userDetailsArr = responseDict.value(forKey: "user_wallet") as! NSArray
                                let userDetails = userDetailsArr[0] as? NSDictionary
                //
                //
                //
                //
                //                let totalWalletAmout = userDetails?.value(forKey: "total_wallet_amount") as! NSNumber
                //                self.totalwallet = String(format: "%@",totalWalletAmout)
                           let balenceWalletAmout = userDetails?.value(forKey: "balance_from_wallet") as! NSNumber
                self.balenceWalletPrice = String(format: "%@",balenceWalletAmout)
                self.PaymentTable.reloadData()

                //                let usedWalletAmout = userDetails?.value(forKey: "used_from_wallet") as! NSNumber
                //                self.usedwallet = String(format: "%@",usedWalletAmout)
                //
                //                let balenceWallet = String(format: "%@",balenceWalletAmout)
                //
                //                let currency = userDetails?.value(forKey: "user_currency_symbol")
                //                self.usealletLbl.text = String(format: " %@ %@ (Use Wallet) ",currency as! CVarArg, balenceWallet)
                
                
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
    
    
     func textFieldDidBeginEditing(_ textField: UITextField) {
        //delegate method
        let txtMonth = self.PaymentTable.viewWithTag(102)as? UITextField
        let txtYear = self.PaymentTable.viewWithTag(101)as? UITextField
        
        let CredittxtMonth = self.PaymentTable.viewWithTag(202)as? UITextField
        let CredittxtYear = self.PaymentTable.viewWithTag(201)as? UITextField

        if textField == txtMonth || textField == CredittxtMonth {
            self.MonthDropDown.show()
            textField.resignFirstResponder()
        }else if textField == txtYear || textField == CredittxtYear {
            self.YearDropDown.show()
            textField.resignFirstResponder()
        }else{
            textField.becomeFirstResponder()
        }
    }

    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        
        let tempCard = self.PaymentTable.viewWithTag(100) as? UITextField
        let txtYear = self.PaymentTable.viewWithTag(101)as? UITextField
        let txtMonth = self.PaymentTable.viewWithTag(102)as? UITextField
        let txtCvv = self.PaymentTable.viewWithTag(103)as? UITextField
        
        
        let tempCard1 = self.PaymentTable.viewWithTag(200) as? UITextField
        let txtYear1 = self.PaymentTable.viewWithTag(201)as? UITextField
        let txtMonth1 = self.PaymentTable.viewWithTag(202)as? UITextField
        let txtCvv1 = self.PaymentTable.viewWithTag(203)as? UITextField
        
        
        if textField == tempCard || textField == tempCard1 {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 16
            //return count <= 1056466
        }
        else if textField == txtCvv || textField == txtCvv1  {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 3
        }
        else if textField == txtYear || textField == txtYear1 {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 4
        }
        else if textField == txtMonth || textField == txtMonth1 {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 2
        }
        return result
    }
    
    @objc func StripeCarddropdown(sender:UIButton)
    {
        
        
        cardTypedropdowns.show()
    }
    
    @objc func dropdown(sender:UIButton)
    {
        
        
        MonthDropDown.show()
    }
    
    @objc func WalletCheck(sender:UIButton)
    {
        if self.isCheck == true {
            self.isCheck = false
        }else{
            self.isCheck = true
        }
        self.ChoosePaymentInt = 0
        self.CouponShow = 2
        self.WalletShow = 2
        self.choosePaymentType = ""
        self.PaymentTable.reloadData()
    }
    
    
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_PaymentDone(_ sender: UIButton) {
        isFromBookingDetails = true

        if self.paymentComingType == "RentalBooking" {
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//            self.navigationController?.pushViewController(nav!, animated: true)
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
            SelectTabIndex = 0
            self.window?.rootViewController = mainViewController
            self.window?.makeKeyAndVisible()
        }else if self.paymentComingType == "ExperienceBooking" {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceHistoryViewController") as? ExperienceHistoryViewController
            self.navigationController?.pushViewController(nav!, animated: true)
        }else if self.paymentComingType == "RentalListing" {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
            self.navigationController?.pushViewController(nav!, animated: true)
        }else if self.paymentComingType == "ExperienceListing" {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceListingBaseViewController") as? ExperienceListingBaseViewController
            nav?.isFromList = true
            self.navigationController?.pushViewController(nav!, animated: true)
        }
        
        
    }
    
    @IBAction func act_PayNow(_ sender: UIButton) {
        
        
        if self.choosePaymentType == "" {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_pleaseSelectPaymentType") as! String)
            
        }else{
            if self.choosePaymentType == "Stripe" {
                if PaymentFor == "Booking" {
                    self.isValidCard()
                } else {
                    self.isValidCard()
                }
            }
            else if self.choosePaymentType == "PayPal" {
                
                
                if PaymentFor == "Booking" {
                    //callPayPalMethod()
                    self.showDropIn(clientTokenOrTokenizationKey: self.clientToken)
                }
                else {
                    //callPayPalForListing()
                    self.showDropIn(clientTokenOrTokenizationKey: self.clientToken)
                    
                }
            }else if self.choosePaymentType == "ApplePay" {
                self.applePayAct()
            }
            else{
                if PaymentFor == "Booking" {
                     self.isCreditCardValid()
                }
                else {
                     self.isCreditCardValid()
                }
            }

        }
        
    }
    
    
    
    // MARK: isValidCard
    func isValidCard() {
      
        let tempCard = self.PaymentTable.viewWithTag(100) as? UITextField
        let txtYear = self.PaymentTable.viewWithTag(101)as? UITextField
        let txtMonth = self.PaymentTable.viewWithTag(102)as? UITextField
        let txtCvv = self.PaymentTable.viewWithTag(103)as? UITextField
        
        let tempCardType = self.PaymentTable.viewWithTag(104) as? UILabel
        
        
        
        let isvalid = CCValidator.validate(creditCardNumber: tempCard!.text!)
        let month = txtMonth!.text!
        let year = txtYear!.text!
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let currentyear =  components.year
        let currentmonth = components.month
        let card_type =  CCValidator.typeCheckingPrefixOnly(creditCardNumber: tempCard!.text!)
        if tempCardType?.text! == "Choose your card"{
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_selectCardType") as! String)
        }else if tempCard!.text!.count == 0 {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_catdNumCantbeEmpty") as! String)
        }
        else if isvalid == false  {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_validCardNum") as! String)
        } else if txtCvv!.text?.count == 0 {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_enterCvv") as! String)
        } else if year < String(currentyear!) {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_selectExpiryYear") as! String)
        }else if txtMonth?.text?.count == 0 {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_selectExpiryMonth") as! String)
        }
        else if year == String(currentyear!){
            if month > String(currentmonth!) && month < "13"{
                self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "key_selectenterVaildMonth") as! String)
            } else {
                
                 self.cardtype = self.getCardType(forId: card_type.rawValue)
                self.cardnumber = tempCard!.text!
                self.cc_exp_day = txtMonth!.text!
                self.cc_exp_year = txtYear!.text!
                self.credit_card_identifier = txtCvv!.text!
                //              self.currencycode = "USD"
                //              self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
                //              self.user_id = String(describing: login_session.value(forKey: "UserId")!)
                self.showActivityIndicator(uiView: self.view)
                payByStripe()
            }
        } else {
            self.cardtype =  self.getCardType(forId: card_type.rawValue)
            self.cardnumber = tempCard!.text!
            self.cc_exp_day = txtMonth!.text!
            self.cc_exp_year = txtYear!.text!
            self.credit_card_identifier = txtCvv!.text!
            //          self.currencycode = "USD"
            //          self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
            //          self.user_id = String(describing: login_session.value(forKey: "UserId")!)
            self.showActivityIndicator(uiView: self.view)
            payByStripe()
        }
    }
    
    // MARK: getCardType
    func getCardType(forId: Int) -> String {
        switch forId {
        case 0:
            return "AmericanExpress"
        case 1:
            return "Dankort"
        case 2:
            return "DinersClub"
        case 3:
            return "Discover"
        case 4:
            return "JCB"
        case 5:
            return "Maestro"
        case 6:
            return "MasterCard"
        case 7:
            return "UnionPay"
        case 8:
            return "VisaElectron"
        case 9:
            return "Visa"
        default:
            return "NotRecognized"
        }
    }
    // MARK: payByStripe
    
    func payByStripe() {
        
        self.showActivityIndicator(uiView: self.view)
        
        
        
        if self.paymentComingType == "ExperienceBooking" {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
            
            
            params = ["exp_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardNumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","CCExpMonth":self.cc_exp_day,"CCExpYear":self.cc_exp_year,"exp_id":self.PropertId,"total_price":self.TotalAmount,"base_id":"1","subtotal":self.subTotal,"enquiry_id":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"","currency_cron_id":self.currency_cron_id,"coupon_discount_amt":"","serviceFee":self.ServiceFee,"creditCardIdentifier":self.credit_card_identifier,"exp_price":self.TotalAmount,"email":login_session.value(forKey: "Email") as! String,"device_type": "IOS","user_currencycode":login_session.value(forKey: "UserId")!]
            
////           var choosed_option = String()
//            var pay_balance = Int()
//
//            exp_currencycode=USD&total_price=683.9&exp_price=683.9&CCExpYear=2021&currency_cron_id=&creditCardIdentifier=123&device_type=android&CCExpMonth=8&currency_code=USD&user_id=126&exp_id=373&enquiry_id=214&user_currencycode=USD&cardNumber=4242424242424242&email=mani%40yopmail.com
           print(params)
            

            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html"]) as Set<NSObject> as? Set<String>
            
            manager.post(EXPERIENCEPAYBYSTRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(uiView: self.view)
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.hideActivityIndicator(uiView: self.view)
                    isFromBookingDetails = true
                    print(responseDict)
//                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                    self.GrayView.isHidden = false
                    
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(uiView: self.view)
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
//            https://www.bensonboat.pofirentals.in/json/experience_guest_pay_stripe
//            https://www.bensonboat.pofirentals.in//json/experience_guest_pay_stripe
            
            
        }else if self.paymentComingType == "ExperienceListing" {
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
            
            
            params = ["exp_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardNumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","CCExpMonth":self.cc_exp_day,"CCExpYear":self.cc_exp_year,"exp_id":self.PropertId,"total_price":self.TotalAmount,"base_id":"1","subtotal":self.subTotal,"enquiry_id":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"","currency_cron_id":self.currency_cron_id,"coupon_discount_amt":"","serviceFee":self.ServiceFee,"creditCardIdentifier":self.credit_card_identifier,"exp_price":self.TotalAmount,"email":login_session.value(forKey: "Email") as! String,"device_type": "IOS","user_currencycode":login_session.value(forKey: "UserId")!,"host_id":self.HostId,"commission":self.Commission,"commission_type":self.CommissionType,"payment_method":"Stripe","hosting_price":self.HostingPrice,"amount":self.TotalPrice]
            print(params)


            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html"]) as Set<NSObject> as? Set<String>
            
            manager.post(EXPERIENCEHOSTPAYBYSTRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(uiView: self.view)
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.hideActivityIndicator(uiView: self.view)
                    isFromBookingDetails = true
                    print(responseDict)
//                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                    self.GrayView.isHidden = false
                    
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(uiView: self.view)
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
//            https://www.bensonboat.pofirentals.in/json/experience_guest_pay_stripe
//            https://www.bensonboat.pofirentals.in//json/experience_guest_pay_stripe

            
          
            
            
        }
        
        
        
        
        else if paymentComingType == "RentalBooking"
        {
            if (Reachability()?.isReachable)!
            {
                
                
                if self.iscoupon == true
                {
                    
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","card_no":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","ccExpiryMonth":self.cc_exp_day,"ccExpiryYear":self.cc_exp_year,"property_id":self.PropertId,"total_price":self.TotalAmount,"base_id":"1","subtotal":self.TotalAmount,"book_id":self.enquiryid,"wallet_amount":"","coupon_code":self.CouponCode,"offer_type":"coupon","coupon_discount_amt":self.CouponDiscountAmount,"serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance,"num_of_guests":self.GuestCount,"is_coupon_used":"1","coupon_id":self.CouponCode,                        "cvvNumber":self.credit_card_identifier,"used_coupon_amount":CouponDiscountAmount]
                    print(params)
                    
                  
                        
                    
                APIManager.apiPostWithHeaders(serviceName: PAY_BY_STRIPE, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                       DispatchQueue.main.async {  }
                       if error != nil {
                           print(error!.localizedDescription)
                           self.showInformation(title: "Closest", message: error!.localizedDescription)
                           return
                       }
                       let responseDict:NSDictionary = json!
                       print(responseDict)
                       if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.hideActivityIndicator(uiView: self.view)
                        isFromBookingDetails = true
                        self.GrayView.isHidden = false

                        }
                       else
                       {
                           
                           self.hideActivityIndicator(uiView: self.view)
                           self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                            
                       }
                       
                   }
                    
                    
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//                            self.hideActivityIndicator(uiView: self.view)
//                        }
//
////                        APIManager.apiPostWithHeaders(serviceName: PAY_BY_STRIPE, parameters: params as? [String : Any]) { response, error in
//                        //                            DispatchQueue.main.async {
//                        //                                self.ListingActivityDelegate?.hideActivity()
//                        //                            }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//                            self.hideActivityIndicator(uiView: self.view)
//                            isFromBookingDetails = true
//                            print(responseDict)
////                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
////                            let alertController = UIAlertController(title: "Closest", message: amount + " " + "self.paySuccess", preferredStyle: .alert)
////                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
////                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
////                                self.navigationController?.pushViewController(nav!, animated: true)
////                                let when = DispatchTime.now()
////                                DispatchQueue.main.asyncAfter(deadline: when){
////
////                                }
////                            }))
////                            self.present(alertController, animated: true, completion: nil)
//                            self.GrayView.isHidden = false
//
//
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//                            self.hideActivityIndicator(uiView: self.view)
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })
                    
                    
                    
                    
                }
                else if self.iswalletPayment == true
                {
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.PropertId,"total_price":"self.couponTotalAmount","base_id":"1","subtotal":self.TotalAmount,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"self.textfild.text!","offer_type":"coupon","coupon_discount_amt":"self.discountAmount","serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            self.hideActivityIndicator(uiView: self.view)
                            isFromBookingDetails = true
                            print(responseDict)
                            isFromBookingDetails = true
                            print(responseDict)
                          //  let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            self.GrayView.isHidden = false
//                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                            let alertController = UIAlertController(title: "Closest", message: amount + "self.paySuccess", preferredStyle: .alert)
//                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
//                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//                                self.navigationController?.pushViewController(nav!, animated: true)
//                                let when = DispatchTime.now()
//                                DispatchQueue.main.asyncAfter(deadline: when){
//
//                                }
//                            }))
//                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                            
                        else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }, failure: { (operation, error) -> Void in
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        print(error)
                        self.showInformation(title: "Closest", message: error.localizedDescription)
                    })
                    
                    
                    
                }
                else{
                    
                    
                    showActivityIndicator(uiView: self.view)
                    
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    params = [
                        "book_id":self.enquiryid,
                        "card_no":self.cardnumber,
                        "ccExpiryMonth":self.cc_exp_day,
                        "ccExpiryYear":self.cc_exp_year,
                        "num_of_guests":self.GuestCount,
                        "booking_type":self.booking_type,
                    "property_id":self.PropertId,
                        "cvvNumber":self.credit_card_identifier,
                    "currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,
                    "coupon_id": "",
                    "is_coupon_used":"0",
                    "lang_code":"en"
                    ]
                        
                            print(params)
                    APIManager.apiPostWithHeaders(serviceName: PAY_BY_STRIPE, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                               DispatchQueue.main.async {  }
                               if error != nil {
                                   print(error!.localizedDescription)
                                   self.showInformation(title: "Closest", message: error!.localizedDescription)
                                   return
                               }
                               let responseDict:NSDictionary = json!
                               print(responseDict)
                               if responseDict.value(forKey: "code") as! NSNumber == 200 {
                                self.hideActivityIndicator(uiView: self.view)
                                isFromBookingDetails = true
                                print(responseDict)
                                let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                                self.GrayView.isHidden = false
                               }
                               else
                               {
                                   
                                   self.hideActivityIndicator(uiView: self.view)
                                   self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                                    
                               }
                               
                           }
                    
//                    var params = NSMutableDictionary()
//
////                    "card_no":"4111111111111111",
////                    "ccExpiryMonth":"12",
////                    "ccExpiryYear":"23",
////                    "cvvNumber":"123",
////                    "lang_code":"en",
////                    "currency_code":"USD",
////                    "property_id":"9",
//
//                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"card_no":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","ccExpiryMonth":self.cc_exp_day,"ccExpiryYear":self.cc_exp_year,"property_id":self.PropertId,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"cvvNumber":self.credit_card_identifier]
//                    print(params)
//
//
////                        {credit_card_identifier=123, cc_exp_day=2, agent_id=, depositFee=10, device_type=android, currencycode=USD, agent_commission=, currency_code=USD, cc_exp_year=2021, agent_percentage=, agent_status=, cardtype=Visa, enquiryid=465, agent_code=, offer_type=no, serviceFee=15.0, coupon_code=, total_price=175.00, coupon_discount_amt=, property_id=161, user_id=112, subtotal=150.0, cardnumber=4242424242424242, creditvalue=authorize, wallet_amount=}
//
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//                            self.hideActivityIndicator(uiView: self.view)
//                        }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//                        self.hideActivityIndicator(uiView: self.view)
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//                            self.hideActivityIndicator(uiView: self.view)
//                            isFromBookingDetails = true
//                            print(responseDict)
//                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                            self.GrayView.isHidden = false
//
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//                            self.hideActivityIndicator(uiView: self.view)
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })
                    
                    
                }
                
            }
                
            else{
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        } else {
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                //                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":self.currencycode,"credit_card_identifier":self.credit_card_identifier,"device_type":"IOS","cc_exp_day":self.cc_exp_day,"property_id":self.property_id,"creditvalue":"Stripe","cardnumber":self.cardnumber,"cc_exp_year":self.cc_exp_year,"enquiryid":self.enquiryid,"user_id":self.user_id,"total_price":self.total_price!,"cardtype":self.cardtype,"email":login_session.value(forKey: "Email") as! String]
                //
                //
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"card_no":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","ccExpiryMonth":self.cc_exp_day,"ccExpiryYear":self.cc_exp_year,"property_id":self.PropertId,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"cvvNumber":self.credit_card_identifier]
                print(params)
                
                APIManager.apiPostWithHeaders(serviceName: LISTING_PAY_BY_STRIPE, parameters: params as! [String : Any]) { response, error in
                    if let err = error {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        
                        self.showInformation(title: "Closest", message: err.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        
                        let responseDict:NSDictionary = response!
                        print(responseDict)

                        if responseDict.value(forKey: "code") as! Int == 200 {
                            self.hideActivityIndicator(uiView: self.view)
                            isFromPaymentSuccess = true
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
    
                            self.hideActivityIndicator(uiView: self.view)
                            print(responseDict)

                            self.GrayView.isHidden = false

                        }

                        else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }
                }
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                manager.post(LISTING_PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator(uiView: self.view)
//                    }
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        self.hideActivityIndicator(uiView: self.view)
//                        isFromPaymentSuccess = true
//                        let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
////                        let alertController = UIAlertController(title: "Closest", message: amount + "self.paySucces", preferredStyle: .alert)
////                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
////                            let when = DispatchTime.now()
////                            DispatchQueue.main.asyncAfter(deadline: when){
////                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
////                                self.navigationController?.pushViewController(nav!, animated: true)
////                            }
////                        }))
////                        self.present(alertController, animated: true, completion: nil)
//
//                        self.hideActivityIndicator(uiView: self.view)
//                        print(responseDict)
//
//                        self.GrayView.isHidden = false
//
//                    }
//
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator(uiView: self.view)
//                    }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
                
                
            }
            else{
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
           
            
            
        }
       
    }
    
    @objc func couponRejectAct(sender:UIButton){
        iscoupon = false
        iswalletPayment = false
        
        
        self.TotalAmount = self.CurrentTotal
        self.ChoosePaymentInt = 0
        self.CouponShow = 2
        self.WalletShow = 1
        self.choosePaymentType = ""
        self.PaymentTable.reloadData()
    }
    
    @objc func agentExpandAct(sender:UIButton){
        
        if self.AgentShow == true {
            self.AgentShow = false
        }else{
            self.AgentShow = true
        }
        self.PaymentTable.reloadData()
    }
    
    @objc func AgentCodeCancelAct(sender:UIButton){
        self.AgentShow = false
        
      //  self.choosePaymentType = ""
        self.PaymentTable.reloadData()
    }
    
    @objc func AgentCodeApplyAct(sender:UIButton){
        
        let tempCard = self.PaymentTable.viewWithTag(121) as? UITextField


        if tempCard!.text == ""
        {
            
            
            
            self.showInformation(title: "Closest", message: "Fill agent Code")
        }
            
        else
        {
            
            
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            let PropertyId = Singleton.sharedInstance.PropertyDetail.rentalId!
            params = [ "coupon_code":tempCard!.text!,"product_id": PropertyId,"sub_total" : subTotal,"service_fee":self.ServiceFee,"deposit_fee":self.SecurityDeposit,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","agent_code":tempCard?.text!]
            
            print(params)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(AgentCodeApply, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    
                   
                    self.agent_id = "\(((responseDict.object(forKey: "agent_amount") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "agent_id") as AnyObject)"
                    self.Agent_Commission = "\(((responseDict.object(forKey: "agent_amount") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "agent_commission") as AnyObject)"
                    self.agent_Code = (tempCard?.text!)!
                    self.agent_status = "\(((responseDict.object(forKey: "agent_amount") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "agent_status") as AnyObject)"
                    self.agent_percentage = "\(((responseDict.object(forKey: "agent_amount") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "commission_percentage") as AnyObject)"
                    
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
        }
    }
    
    
    
    @objc func couponApplyAct(sender:UIButton){
        
        
        let tempCard = self.PaymentTable.viewWithTag(200) as? UITextField
        if tempCard!.text == ""
        {
            
            
            
            self.showInformation(title: "Closest", message: "Fill Coupon Code")
        }
            
        else
        {
            
            
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
          //  let PropertyId = Singleton.sharedInstance.PropertyDetail.rentalId!
            params = [ "coupon_code":tempCard!.text!,"product_id": self.PropertId,"sub_total" : subTotal,"service_fee":self.ServiceFee,"deposit_fee":self.SecurityDeposit,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":"en","book_id":self.enquiryid]
            
            
                   print(params)
            APIManager.apiPostWithHeaders(serviceName: COPON_APPLY_API, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                       DispatchQueue.main.async {  }
                       if error != nil {
                           print(error!.localizedDescription)
                           self.showInformation(title: "Closest", message: error!.localizedDescription)
                           return
                       }
                       let responseDict:NSDictionary = json!
                       print(responseDict)
                       if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.hideActivityIndicator(uiView: self.view)
                        self.CouponCode = tempCard!.text!
                        self.iscoupon = true
                        self.iswalletPayment = false
                        
                        self.TotalAmount = "\((responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "total_amt") as AnyObject)"
                        self.CouponTotAmount = "\((responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "total_amt") as AnyObject)"
                        self.AmounttobePaid = "\((responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "payable") as AnyObject)"
                        self.CouponDiscountAmount = "\((responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "coupon_amt") as AnyObject)"
//
//                        let userDetailsArr = responseDict.value(forKey: "coupon_amount") as! NSArray
//                                            let userDetails = userDetailsArr[0] as? NSDictionary
//                                            self.TotalAmount = "\(userDetails?.value(forKey: "total_amt") as AnyObject)"
//
//                        self.CouponTotAmount = "\(userDetails?.value(forKey: "sub_total") as AnyObject)"
//                        self.CouponDiscountAmount = "\(userDetails?.value(forKey: "amount_discount") as AnyObject) (\(userDetails?.value(forKey: "coupon_price") as AnyObject))"
//                        self.AmounttobePaid = "\(userDetails?.value(forKey: "total_amount") as AnyObject)"
                        
                        self.PaymentTable.reloadData()
                       }
                       else
                       {
                           
                           self.hideActivityIndicator(uiView: self.view)
                           self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                            
                       }
                       
                   }
            
//            let manager = AFHTTPSessionManager()
//            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//            manager.post(COPON_APPLY_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                DispatchQueue.main.async {
//
//                }
//                let responseDict:NSDictionary = responseObject as! NSDictionary
//                print(responseDict)
//                self.hideActivityIndicator(uiView: self.view)
//                if responseDict.value(forKey: "status") as! Int == 1 {
//                    self.CouponCode = tempCard!.text!
//                    self.iscoupon = true
//                    self.iswalletPayment = false
//                    //
//                    //                    self.responseCoponLbl.isHidden = true
//
//                                        let userDetailsArr = responseDict.value(forKey: "coupon_amount") as! NSArray
//                                        let userDetails = userDetailsArr[0] as? NSDictionary
//                                        self.TotalAmount = "\(userDetails?.value(forKey: "total_amount") as AnyObject)"
//
//                    self.CouponTotAmount = "\(userDetails?.value(forKey: "sub_total") as AnyObject)"
//                    self.CouponDiscountAmount = "\(userDetails?.value(forKey: "amount_discount") as AnyObject) (\(userDetails?.value(forKey: "coupon_price") as AnyObject))"
//                    self.AmounttobePaid = "\(userDetails?.value(forKey: "total_amount") as AnyObject)"
//
//                    self.PaymentTable.reloadData()
//
//                    //                    let doubleStr = String(format: "%.2f", total_amount as CVarArg) // "3.14"
//                    //                    let total = String(doubleStr)
//                    //                    self.couponTotalAmount  = total
//                    //
//                    //
//                    //
//                    //                    let disAmount = userDetails?.value(forKey: "amount_discount") as? NSNumber
//                    //                    let dissamount = NSDecimalNumber(string: "\(disAmount!)")
//                    //                    let rounding = Double(truncating: dissamount)
//                    //                    self.discountAmount = String(format: "%.2f",rounding)
//                    //                    print(self.discountAmount)
//                    //
//                    //
//                    //
//                    //
//                    //                    let subtotal = userDetails?.value(forKey: "sub_total") as AnyObject
//                    //                    let amount = NSDecimalNumber(string: "\(subtotal)")
//                    //                    let rounding1 = Double(truncating: amount)
//                    //                    let subStr = String(format: "%.2f",rounding1)
//                    //                    print(subStr)
//                    //
//                    //
//                    //                    let couponprice = userDetails?.value(forKey: "coupon_price")as AnyObject
//                    //
//                    //
//                    //
//                    //                    self.payView.isHidden = false
//                    //                    // self.noteCouponLabel.isHidden = false
//                    //
//                    //                    self.payView.layer.shadowColor = UIColor.gray.cgColor
//                    //                    self.payView.layer.shadowOpacity = 0.5
//                    //                    self.payView.layer.shadowOffset = CGSize.zero
//                    //                    self.payView.layer.shadowRadius = 10
//                    //
//                    //                    self.totLAmountLbl.text = String(format: "Total Amount :%@ %@","" ,subStr as CVarArg )
//                    //                    self.discountAmountLbl.text = String(format: "Amount Discount :%@ (%@)", self.discountAmount as CVarArg,couponprice as! CVarArg)
//                    //                    self.amountTopaidLbl.text = String(format: "Amount to be paid :%@ %@", "",  self.couponTotalAmount as CVarArg )
//                    //                    self.total_price = userDetails?.value(forKey: "total_amount") as! Double as AnyObject
//                    //                    self.showInformation(title: "Closest", message: "Coupon applied successfully!")
//                    //                     self.textfild.text = ""
//                }
//
//                else {
//                    //
//                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                }
//            }, failure: { (operation, error) -> Void in
//                DispatchQueue.main.async {
//
//                }
//                print(error)
//                self.showInformation(title: "Closest", message: error.localizedDescription)
//            })
            
            
        }
        
    }
    @objc func WalletRejectAct(){
        iswalletPayment = false
        iscoupon = false
        
        isCheck = false
        
        self.TotalAmount = self.CurrentTotal
        self.ChoosePaymentInt = 0
        self.CouponShow = 2
        self.WalletShow = 1
        self.choosePaymentType = ""
        self.PaymentTable.reloadData()
        self.showInformation(title: "Closest", message: "Wallet Removed Successfully")
    }
    
    @objc func WalletApplyAct()
    {
        if isCheck == true
        {
            
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                let PropertyId = Singleton.sharedInstance.PropertyDetail.rentalId!
                params = ["sub_total":subTotal,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"user_id":login_session.value(forKey: "UserId")!,"deposit_fee":self.SecurityDeposit,"product_id":PropertyId,"wallet_amount":self.balenceWalletPrice,"service_fee":self.ServiceFee]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(WALLET_APPLY_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.iswalletPayment = true
                        self.iscoupon = false
                        
                        let userDetailsArr = responseDict.value(forKey: "wallet_amount_details") as! NSArray
                                                             let userDetails = userDetailsArr[0] as? NSDictionary
                                                             self.TotalAmount = "\(userDetails?.value(forKey: "total_amount") as AnyObject)"
                        //                                let userDetailsArr = responseDict.value(forKey: "wallet_amount_details") as! NSArray
                        //                                let userDetails = userDetailsArr[0] as? NSDictionary
                        //                                let currencySymbol = userDetails?.value(forKey: "user_currency_symbol")
                        //
                        //
                        //
                        //
                        //                                let totalWalletAmout = userDetails?.value(forKey: "wallet_amount")
                        //                                let walletAmountStr = String(format: "%@",totalWalletAmout as! CVarArg)
                        //
                        //
                        //                                let subtotal = userDetails?.value(forKey: "sub_total")
                        //                                let subtotalStr = String(format: "%@",subtotal as! CVarArg)
                        //
                        //
                        //
                        //                                let paidWalletAmout = userDetails?.value(forKey: "total_amount")
                        //                                let paidWalletAmoutStr = String(format: "%@",paidWalletAmout as! CVarArg)
                        //
                        //
                        //
                        //                                self.walletPayView.isHidden = false
                        //                                self.walletPayView.layer.shadowColor = UIColor.gray.cgColor
                        //                                self.walletPayView.layer.shadowOpacity = 0.5
                        //                                self.walletPayView.layer.shadowOffset = CGSize.zero
                        //                                self.walletPayView.layer.shadowRadius = 10
                        //                                self.walletSubTtlLbl.text = String(format: "Sub Total Amount :%@ %@",currencySymbol as! CVarArg ,subtotalStr)
                        //                                self.walletAmountLbl.text = String(format: "Wallet Amount :%@ %@", currencySymbol as! CVarArg,walletAmountStr)
                        //                                self.walletPaidAmountLbl.text = String(format: "Amount To be Paid :%@ %@",currencySymbol as! CVarArg,paidWalletAmoutStr)
                        //                                self.walletTotalAmount = paidWalletAmoutStr
                        //                                 self.total_price = userDetails?.value(forKey: "total_amount") as! Double as AnyObject
                        //                                self.showInformation(title: "Closest", message: "Wallet applied successfully!")
                        //                            }
                        //
                        //                            else {
                        //                                self.walletPayView.isHidden = true
                        //                                // self.noteCouponLabel.isHidden = true
                        //                                self.noWalletLbl.isHidden = false
                        //                                self.noWalletLbl.text = responseDict.value(forKey: "message") as? String
                                                     self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }else {
                         self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
                
                //                showActivityIndicator(uiView: self.view)
                //
                //                let parameterStr = "sub_total=\(totalsubtotal)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&user_id=\(login_session.value(forKey: "UserId")!)&deposit_fee=\(self.totalDeposit)&product_id=\(self.property_id)&wallet_amount=\(self.balenceWalletPrice)&service_fee=\(self.totalserviceFee)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: WALLET_APPLY_API, APIKEY: "WALLET_APPLY_API")
                //
                //                print(parameterStr)
                
                
            }
            else
            {
                self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
            
        }
        else
        {
            self.showInformation(title: "Warning", message: "Please Select Use wallet")
            
        }
        
    }
    
    func fetchClientToken() {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            self.clientToken = String(data: data!, encoding: String.Encoding.utf8)!
            print("clientToken:::", self.clientToken)
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
        }.resume()
    }
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        request.cardDisabled = true
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
            
        { (controller, result, error) in
            if (error != nil)
            {
                print("ERROR:::",error as Any)
            }
            else if (result?.isCancelled == true) {
                print("CANCELLED")
            }
            else if let result = result
            {
                print("result112233::::", result)
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
                
                let selectedPaymentMethod = result.paymentMethod! // retrieve the payment method.
                self.postNonceToServer(paymentMethodNonce: selectedPaymentMethod.nonce) // call postNonceToServer() with the nonce from the selected payment method.
                
                print("selectedPaymentMethod::::",selectedPaymentMethod)
                print("selectedPaymentMethod.nonce::::",selectedPaymentMethod.nonce)
//                print("selectedPaymentMethod.nonce::::",selectedPaymentMethod.data)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    func postNonceToServer(paymentMethodNonce: String) {
        
        let reachability = Reachability()!
        if reachability.isReachable {
            
            
            if self.paymentComingType == "ExperienceBooking" {
                
   
                
                self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"txn_id":paymentMethodNonce,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.TotalAmount,"exp_id":self.PropertId,"enquiry_id":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"total_price":self.TotalAmount,"exp_price":self.TotalAmount,"user_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"host_id":self.HostId]
                
               
                
                print(params)
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EXPERIENCEPAYBYPAYPALGUEST, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        isFromBookingDetails = true
                        print(responseDict)
//                        let paymentSuccessArr:NSArray = responseDict.value(forKey: "payment_success") as! NSArray
//                        let total_priceStr:NSNumber = ((paymentSuccessArr[0] as AnyObject).value(forKey: "total_price") as? NSNumber)!
//                        print(String(describing:total_priceStr))
                        self.GrayView.isHidden = false
                        
                    }
                        
                    else {
                        self.hideActivityIndicator(uiView: self.view)
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                

                
            }else  if self.paymentComingType == "ExperienceListing" {
                
                self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"txn_id":paymentMethodNonce,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.TotalAmount,"exp_id":self.PropertId,"enquiry_id":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"total_price":self.TotalAmount,"hosting_price":self.HostingPrice,"commission":self.Commission,"commission_type":self.CommissionType,"host_id":self.HostId]
                print(params)

//                txn_id=PAY-18X32451H0459092JKO7KFUI, hosting_price=20.12, payer_email=mani@yopmail.com, exp_id=455, commission=20.123, device_type=android, commission_type=flat, host_id=126, currency_code=USD
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EXPERIENCEPAYBYPAYPALHOST, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        isFromBookingDetails = true
                        print(responseDict)
//                        let paymentSuccessArr:NSArray = responseDict.value(forKey: "payment_success") as! NSArray
//                        let total_priceStr:NSNumber = ((paymentSuccessArr[0] as AnyObject).value(forKey: "total_price") as? NSNumber)!
//                        print(String(describing:total_priceStr))
                        self.GrayView.isHidden = false
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
            }
            
            
            
            else if self.PaymentFor == "RentalBooking" {
                
                    if (Reachability()?.isReachable)!
                    {
                        
                        
                        if self.iscoupon == true
                        {
                            
                            
                            showActivityIndicator(uiView: self.view)
                            var params = NSMutableDictionary()
                            
                            
//                            "lang_code":"en",
//                            "paymentNonce":"fake-valid-nonce",
//                            "deviceData":"cd4847b23e914fbb8d2abb034645debd",
//                            "property_id":"1"
                        
                            
                            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.PropertId,"total_price":"self.couponTotalAmount","base_id":"1","subtotal":self.TotalAmount,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"self.textfild.text!","offer_type":"coupon","coupon_discount_amt":"self.discountAmount","serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"txn_id":paymentMethodNonce,"payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.TotalAmount,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                            
                            let manager = AFHTTPSessionManager()
                            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                            
                            manager.post(PAY_BY_PAYPAL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                                DispatchQueue.main.async {
                                    self.hideActivityIndicator(uiView: self.view)
                                }
                                
                                
        //                        APIManager.apiPostWithHeaders(serviceName: PAY_BY_PAYPAL, parameters: params as? [String : Any]) { response, error in
        //                            DispatchQueue.main.async {
        //                                self.ListingActivityDelegate?.hideActivity()
        //                            }
                                
                                
                                let responseDict:NSDictionary = responseObject as! NSDictionary
                                print(responseDict)
                               
                                if responseDict.value(forKey: "status") as! Int == 1 {
                                    self.hideActivityIndicator(uiView: self.view)
                                    isFromBookingDetails = true
                                    print(responseDict)
//                                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                                    let alertController = UIAlertController(title: "Closest", message: amount + " " + "self.paySuccess", preferredStyle: .alert)
//                                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
//                                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//                                        self.navigationController?.pushViewController(nav!, animated: true)
//                                        let when = DispatchTime.now()
//                                        DispatchQueue.main.asyncAfter(deadline: when){
//
//                                        }
//                                    }))
//                                    self.present(alertController, animated: true, completion: nil)
                                    self.GrayView.isHidden = false

                                }
                                    
                                else {
                                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                                }
                            }, failure: { (operation, error) -> Void in
                                DispatchQueue.main.async {
                                    self.hideActivityIndicator(uiView: self.view)
                                }
                                print(error)
                                self.showInformation(title: "Closest", message: error.localizedDescription)
                            })
                            
                            
                            
                            
                        }
                        else if self.iswalletPayment == true
                        {
                            showActivityIndicator(uiView: self.view)
                            var params = NSMutableDictionary()
                            
                            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.PropertId,"total_price":"self.couponTotalAmount","base_id":"1","subtotal":self.TotalAmount,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"self.textfild.text!","offer_type":"coupon","coupon_discount_amt":"self.discountAmount","serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"txn_id":paymentMethodNonce,"payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.TotalAmount,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                            
                            let manager = AFHTTPSessionManager()
                            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                            
                            manager.post(PAY_BY_PAYPAL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                                DispatchQueue.main.async {
                                    self.hideActivityIndicator(uiView: self.view)
                                }
                                let responseDict:NSDictionary = responseObject as! NSDictionary
                                print(responseDict)
                                
                                if responseDict.value(forKey: "status") as! Int == 1 {
                                    self.hideActivityIndicator(uiView: self.view)
                                    isFromBookingDetails = true
                                    print(responseDict)
//                                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                                    let alertController = UIAlertController(title: "Closest", message: amount + "self.paySuccess", preferredStyle: .alert)
//                                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
//                                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//                                        self.navigationController?.pushViewController(nav!, animated: true)
//                                        let when = DispatchTime.now()
//                                        DispatchQueue.main.asyncAfter(deadline: when){
//
//                                        }
//                                    }))
//                                    self.present(alertController, animated: true, completion: nil)
                                    self.GrayView.isHidden = false

                                }
                                    
                                else {
                                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                                }
                            }, failure: { (operation, error) -> Void in
                                DispatchQueue.main.async {
                                    self.hideActivityIndicator(uiView: self.view)
                                }
                                print(error)
                                self.showInformation(title: "Closest", message: error.localizedDescription)
                            })
                            
                            
                            
                        }
                        else{
                            
                            var params = NSMutableDictionary()

                            showActivityIndicator(uiView: self.view)
                            params = [
                                "lang_code":"en",
                                "paymentNonce":paymentMethodNonce,
                                "deviceData":UIDevice.current.identifierForVendor!.uuidString
,
                                    "property_id":self.PropertId,
                                    "book_id":self.enquiryid,
                                "num_of_guests":GuestCount,
                                "booking_type":self.booking_type ,//1-Daily,2-Hourly
                                "is_coupon_used":"0",//0-No,1-Yes
                                "coupon_id": ""
                                ]
                            
                            print(params)
                            
                            
                            
                                   print(params)
                            APIManager.apiPostWithHeaders(serviceName: PAY_BY_PAYPAL, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                                       DispatchQueue.main.async {  }
                                       if error != nil {
                                           print(error!.localizedDescription)
                                           self.showInformation(title: "Closest", message: error!.localizedDescription)
                                           return
                                       }
                                       let responseDict:NSDictionary = json!
                                       print(responseDict)
                                       if responseDict.value(forKey: "code") as! NSNumber == 200 {
                                        if responseDict.value(forKey: "status") as! Int == 1 {
                                            self.hideActivityIndicator(uiView: self.view)
                                            isFromBookingDetails = true
                                            print(responseDict)
                                       }
                                       else
                                       {
                                           
                                           self.hideActivityIndicator(uiView: self.view)
                                           self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                                            
                                       }
                                       
                                       }else{
                                        self.hideActivityIndicator(uiView: self.view)
                                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                                       }
                            }
                        
                    }
                    }
                        else{
                            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
                        }
                    
              //  }
                
                
                
                
                
//                self.showActivityIndicator(uiView: self.view)
//                var params = NSMutableDictionary()
//                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"txn_id":paymentMethodNonce,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.TotalAmount,"property_id":self.PropertId,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!]
//                print(params)
//
//
//
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                manager.post(PAY_BY_PAYPAL, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//                    self.hideActivityIndicator(uiView: self.view)
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        isFromBookingDetails = true
//                        print(responseDict)
//                        let paymentSuccessArr:NSArray = responseDict.value(forKey: "payment_success") as! NSArray
//                        let total_priceStr:NSNumber = ((paymentSuccessArr[0] as AnyObject).value(forKey: "total_price") as? NSNumber)!
//                        print(String(describing:total_priceStr))
//                        self.GrayView.isHidden = false
//
//                    }
//
//                    else {
//                        self.hideActivityIndicator(uiView: self.view)
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator(uiView: self.view)
//                    }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
                
              
            } else {
                
                self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
//                "lang_code":"en",
//                "paymentNonce":"fake-valid-nonce",
//                "deviceData":"cd4847b23e914fbb8d2abb034645debd",
//                "property_id":"1"
                   let devicedata = UIDevice.current.identifierForVendor?.uuidString
                
                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                          "property_id":self.PropertId,
                          "paymentNonce": paymentMethodNonce,
                          "deviceData": devicedata]
                
//                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"txn_id":paymentMethodNonce,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payment_gross":self.TotalAmount,"payer_email":login_session.value(forKey: "Email") as! String,"property_id":self.PropertId,"total_price":self.TotalAmount,"user_id":login_session.value(forKey: "UserId")!]
                
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                manager.post(LISTING_PAY_BY_PAYPAL, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
                print(params)
                APIManager.apiPostWithHeaders(serviceName: LISTING_PAY_BY_PAYPAL, parameters: params as! [String : Any]) { response, error in
                    if let err = error {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        
                        self.showInformation(title: "Closest", message: err.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.hideActivityIndicator(uiView: self.view)
                        }
                        
                        let responseDict:NSDictionary = response!
                        print(responseDict)

                        if responseDict.value(forKey: "code") as! Int == 200 {
                            isFromPaymentSuccess = true
                            print(responseDict)
                        // let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            self.GrayView.isHidden = false

                        }

                        else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }
                }
                
                
                    
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//                    self.hideActivityIndicator(uiView: self.view)
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        isFromPaymentSuccess = true
//                        print(responseDict)
//                       // let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                        self.GrayView.isHidden = false
//                    }
//
//                    else {
//                        self.hideActivityIndicator(uiView: self.view)
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator(uiView: self.view)
//                    }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })

            }
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as! String)
        }

        
    }
    
    // MARK: isCreditCardValid
    func isCreditCardValid()
    
    
    {
        
      
                
        let tempCard = self.PaymentTable.viewWithTag(200) as? UITextField
        let txtYear = self.PaymentTable.viewWithTag(201)as? UITextField
        let txtMonth = self.PaymentTable.viewWithTag(202)as? UITextField
        let txtCvv = self.PaymentTable.viewWithTag(203)as? UITextField
        
        let tempCardType = self.PaymentTable.viewWithTag(204) as? UILabel
        
        let isvalid = CCValidator.validate(creditCardNumber: tempCard!.text!)
        let month = txtMonth!.text!
        let year = txtYear!.text!
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let currentyear =  components.year
        let currentmonth = components.month
        let card_type =  CCValidator.typeCheckingPrefixOnly(creditCardNumber: tempCard!.text!)
                if tempCardType?.text! == "Choose your card"{
                    self.showInformation(title: "Error", message: "Please select card type")
                }else if tempCard!.text!.count == 0 {
                    self.showInformation(title: "Error", message: "Credit card number can not be empty")
                }
        else if isvalid == false  {
            self.showInformation(title: "Error", message: "Please enter valid card number")
        } else if (txtCvv!.text?.count)! < 3 || (txtCvv!.text?.count)! > 4 {
            self.showInformation(title: "Error", message: "Please enter valid CVV")
        }  else if year < String(currentyear!) {
            self.showInformation(title: "Error", message: "Select Expiry Year")
        }else if txtMonth?.text?.count == 0 {
            self.showInformation(title: "Error", message: "Select Expiry Month")
        } else if year == String(currentyear!){
             if month > String(currentmonth!) && month < "13"{
                self.showInformation(title: "Error", message: "Please enter valid month")
            } else {
                
                
                self.cardnumber = tempCard!.text!
                self.cc_exp_day = txtMonth!.text!
                self.cc_exp_year = txtYear!.text!
                self.credit_card_identifier = txtCvv!.text!
                
                
//                self.cardtype = self.getCardType(forId: card_type.rawValue)
//                self.cardnumber = self.txtccNum.text!
//                self.cc_exp_day = self.txfMonth.text!
//                self.cc_exp_year = self.txfYear.text!
//                self.credit_card_identifier = self.txfCvv.text!
//                self.currencycode = "USD"
//                self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
//                self.user_id = String(describing: login_session.value(forKey: "UserId")!)
                payByCredircard()
            } }
        else {
            self.cardnumber = tempCard!.text!
            self.cc_exp_day = txtMonth!.text!
            self.cc_exp_year = txtYear!.text!
            self.credit_card_identifier = txtCvv!.text!
//            self.cardtype =  self.getCardType(forId: card_type.rawValue)
//            self.cardnumber = self.txtccNum.text!
//            self.cc_exp_day = self.txfMonth.text!
//            self.cc_exp_year = self.txfYear.text!
//            self.credit_card_identifier = self.txfCvv.text!
//            self.currencycode = "USD"
//            self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
//            self.user_id = String(describing: login_session.value(forKey: "UserId")!)
            payByCredircard()
        }
    }
    
    // MARK: payByCredircard
    func payByCredircard() {
        if (Reachability()?.isReachable)! {
            let id = Singleton.sharedInstance.selectedCategory!
            
            if self.paymentComingType == "ExperienceBooking" {
                showActivityIndicator(uiView: self.view)

                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["cardtype":self.cardtype,"cardNumber":self.cardnumber,"CCExpMonth":self.cc_exp_day,"CCExpYear":self.cc_exp_year,"creditvalue":"authorize","exp_id":self.PropertId,"creditCardIdentifier":self.credit_card_identifier,"total_price":self.TotalAmount,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"exp_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"user_id":login_session.value(forKey: "UserId")!,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","exp_price":self.TotalAmount,"currency_cron_id":self.currency_cron_id,"device_type":"IOS","enquiry_id":self.enquiryid,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"user_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String]
                
                print(params)
              
//                exp_currencycode=126&total_price=683.9&CCExpYear=2030&exp_price=683.9&cardType=Visa&currency_cron_id=&creditCardIdentifier=123&device_type=android&CCExpMonth=8&currency_code=USD&user_id=126&exp_id=373&enquiry_id=235&user_currencycode=USD&cardNumber=4111111111111111&email=mani%40yopmail.com&creditvalue=authorize
//
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EXPERIENCEPAYBYCREDITCARD, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        isFromBookingDetails = true
                        self.GrayView.isHidden = false
                    }
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "Payment not successfully")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                

            }
            
            
            else if PaymentFor == "RentalBooking" {
                
                
                
                    
                    
                    if self.iscoupon == true
                    {
                        
                        
                        showActivityIndicator(uiView: self.view)
                        var params = NSMutableDictionary()
                        
                        params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.PropertId,"total_price":"self.couponTotalAmount","base_id":"1","subtotal":self.TotalAmount,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"self.textfild.text!","offer_type":"coupon","coupon_discount_amt":"self.discountAmount","serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                        
                        let manager = AFHTTPSessionManager()
                        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                        
                        manager.post(PAY_BY_CREDITCARD_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            let responseDict:NSDictionary = responseObject as! NSDictionary
                            print(responseDict)
                           
                            if responseDict.value(forKey: "status") as! Int == 1 {
                                self.hideActivityIndicator(uiView: self.view)
                                isFromBookingDetails = true
                                print(responseDict)
//                                let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                                let alertController = UIAlertController(title: "Closest", message: amount + " " + "self.paySuccess", preferredStyle: .alert)
//                                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
//                                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//                                    self.navigationController?.pushViewController(nav!, animated: true)
//                                    let when = DispatchTime.now()
//                                    DispatchQueue.main.asyncAfter(deadline: when){
//
//                                    }
//                                }))
//                                self.present(alertController, animated: true, completion: nil)
                                self.GrayView.isHidden = false

                                
                            }
                                
                            else {
                                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                            }
                        }, failure: { (operation, error) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            print(error)
                            self.showInformation(title: "Closest", message: error.localizedDescription)
                        })
                        
                        
                        
                        
                    }
                    else if self.iswalletPayment == true
                    {
                        showActivityIndicator(uiView: self.view)
                        var params = NSMutableDictionary()
                        
                        params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":"Visa","cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.PropertId,"total_price":"self.couponTotalAmount","base_id":"1","subtotal":self.TotalAmount,"enquiryid":self.enquiryid,"user_id":login_session.value(forKey: "UserId")!,"wallet_amount":"","coupon_code":"self.textfild.text!","offer_type":"coupon","coupon_discount_amt":"self.discountAmount","serviceFee":self.ServiceFee,"depositFee":"","agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                        
                        let manager = AFHTTPSessionManager()
                        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                        
                        manager.post(PAY_BY_CREDITCARD_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            let responseDict:NSDictionary = responseObject as! NSDictionary
                            print(responseDict)
                            
                            if responseDict.value(forKey: "status") as! Int == 1 {
                                self.hideActivityIndicator(uiView: self.view)
                                isFromBookingDetails = true
                                print(responseDict)
//                                let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
//                                let alertController = UIAlertController(title: "Closest", message: amount + "self.paySuccess", preferredStyle: .alert)
//                                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
//                                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
//                                    self.navigationController?.pushViewController(nav!, animated: true)
//                                    let when = DispatchTime.now()
//                                    DispatchQueue.main.asyncAfter(deadline: when){
//
//                                    }
//                                }))
//                                self.present(alertController, animated: true, completion: nil)
                                self.GrayView.isHidden = false

                            }
                                
                            else {
                                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                            }
                        }, failure: { (operation, error) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            print(error)
                            self.showInformation(title: "Closest", message: error.localizedDescription)
                        })
                        
                        
                        
                    }
                    else{
                        
                        
                        showActivityIndicator(uiView: self.view)
                        var params = NSMutableDictionary()
                        
                        
                        
                        params = ["cardtype":self.cardtype,"cardnumber":self.cardnumber,"cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"creditvalue":"authorize","property_id":self.PropertId,"credit_card_identifier":self.credit_card_identifier,"total_price":self.TotalAmount,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"user_id":login_session.value(forKey: "UserId")!,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","enquiryid":self.enquiryid,"user_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
                        print(params)
                        
                     
    //                        {credit_card_identifier=123, cc_exp_day=2, agent_id=, depositFee=10, device_type=android, currencycode=USD, agent_commission=, currency_code=USD, cc_exp_year=2021, agent_percentage=, agent_status=, cardtype=Visa, enquiryid=465, agent_code=, offer_type=no, serviceFee=15.0, coupon_code=, total_price=175.00, coupon_discount_amt=, property_id=161, user_id=112, subtotal=150.0, cardnumber=4242424242424242, creditvalue=authorize, wallet_amount=}
                        
                        let manager = AFHTTPSessionManager()
                        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                        
                        manager.post(PAY_BY_CREDITCARD_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            let responseDict:NSDictionary = responseObject as! NSDictionary
                            print(responseDict)
                            self.hideActivityIndicator(uiView: self.view)
                            if responseDict.value(forKey: "status") as! Int == 1 {
                                self.hideActivityIndicator(uiView: self.view)
                                isFromBookingDetails = true
                                print(responseDict)
                              //  let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                                self.GrayView.isHidden = false
                                
                            }
                                
                            else {
                                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                            }
                        }, failure: { (operation, error) -> Void in
                            DispatchQueue.main.async {
                                self.hideActivityIndicator(uiView: self.view)
                            }
                            print(error)
                            self.showInformation(title: "Closest", message: error.localizedDescription)
                        })
                        
                        
                    }
                    
                
                
                
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["cardtype":self.cardtype,"cardnumber":self.cardnumber,"cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"creditvalue":"authorize","property_id":self.PropertId,"credit_card_identifier":self.credit_card_identifier,"total_price":self.TotalAmount,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"user_id":login_session.value(forKey: "UserId")!,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","enquiryid":self.enquiryid,"user_currencycode":login_session.value(forKey: "APP_CURRENCY")as! String,"agent_id":self.agent_id,"agent_commission":self.Agent_Commission,"agent_status":self.agent_status,"agent_percentage":self.agent_percentage,"agent_code":self.agent_Code,"choosed_option":self.choosed_option,"pay_balance":self.pay_balance]
              
//                print(params)
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                manager.post(PAY_BY_CREDITCARD_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//                        self.hideActivityIndicator(uiView: self.view)
//                    }
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//                        isFromBookingDetails = true
//                        self.GrayView.isHidden = false
//
//                    }
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "Payment not successfully")
//                    }
//                }, failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async { self.hideActivityIndicator(uiView: self.view) }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
                
                
            }
        }
        else
        {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
    }
    
    func ApplePayAct(){
       
        let A = self.ApplePayToken.toJSON() as? [String:AnyObject]
        
        let mutDict = NSMutableDictionary()
        mutDict.setValue("applepay", forKey: "type")
        mutDict.setValue(A, forKey: "token")
        var dateFormatJsonString = String()
 
        do {
               let arrJson = try JSONSerialization.data(withJSONObject: mutDict, options: JSONSerialization.WritingOptions.prettyPrinted)
               let string = String(data: arrJson, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            dateFormatJsonString = string! as String
                print("%%%%%%",dateFormatJsonString)
           }catch let error as NSError{
               print(error.description)
           }
         let dict = dateFormatJsonString.toJSON() as? [String:AnyObject] // can be any type here

        print("dict is::",dict)
        
        let Amt = self.TotalAmount.replacingOccurrences(of: ",", with: "")

       var paidAmt = Float(Amt)!
        paidAmt = paidAmt * 100
        print("paidAmt is::",paidAmt)
        
        let Sample = "\(paidAmt)"
        
        let amount = Sample.components(separatedBy: ".") as NSArray
        
        var params = NSMutableDictionary()

        showActivityIndicator(uiView: self.view)
        params = [
            "lang_code":"en",
            "paymentMethodNonce":dict,
            "deviceData":UIDevice.current.identifierForVendor!.uuidString
,
                "property_id":self.PropertId,
                "book_id":self.enquiryid,
            "num_of_guests":GuestCount,
            "booking_type":self.booking_type ,//1-Daily,2-Hourly
            "is_coupon_used":"0",//0-No,1-Yes
            "coupon_id": ""
            ]
        
        print(params)
        
        
        
               print(params)
        APIManager.apiPostWithHeaders(serviceName: APPLE_PAY, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                   DispatchQueue.main.async {  }
                   if error != nil {
                       print(error!.localizedDescription)
                       self.showInformation(title: "Closest", message: error!.localizedDescription)
                       return
                   }
                   let responseDict:NSDictionary = json!
                   print(responseDict)
                   if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.hideActivityIndicator(uiView: self.view)
                        isFromBookingDetails = true
                        self.GrayView.isHidden = false

                   
                   }else{
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                   }
        }


    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension NewPaymentViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return self.CouponShow
        }else if section == 1 {
            return 0//self.WalletShow
        } else{
            return self.PaymentsArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCouponTitleTableViewCell") as? PaymentCouponTitleTableViewCell
                cell!.selectionStyle = .none
                cell!.TypeName.text = GlobalLanguageDictionary.object(forKey: "key_haveCoupon") as! String
                cell!.TypeName.font = UIFont(name: SemiBoldFont, size: 16)
                
                
                
                return cell!
            }
            if indexPath.row == 10 {//self.CouponShow-1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AgentCodeTableViewCell") as? AgentCodeTableViewCell
                cell!.selectionStyle = .none
                
                cell!.AgentCodeTxt.font = UIFont(name: SemiBoldFont, size: 14)
                cell!.DescLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell!.ApplyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
                cell!.cancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
                cell!.AgentCodeTxt.tag = 121
                cell!.AgentCodeTxt.text = self.agent_Code
                
                if self.AgentShow == true {
                    cell!.DataView.isHidden = true//false
                    cell!.DataViewHeight.constant = 0//120
                }else {
                    cell!.DataView.isHidden = true
                    cell!.DataViewHeight.constant = 0
                }
                
                if self.agent_Code != ""{
                    cell!.ApplyBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_applied") as! String, for: .normal)
                }else{
                    cell!.ApplyBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_apply") as! String, for: .normal)

                }
                
                cell!.expandBtn.addTarget(self, action: #selector(agentExpandAct), for: .touchUpInside)
                
                cell!.ApplyBtn.addTarget(self, action: #selector(AgentCodeApplyAct), for: .touchUpInside)
                cell!.cancelBtn.addTarget(self, action: #selector(AgentCodeCancelAct), for: .touchUpInside)
                
                return cell!
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CouponUseTableViewCell") as? CouponUseTableViewCell
            cell!.selectionStyle = .none
            
            cell!.CouponTxt.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.NoteLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.ApplyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
            cell!.CancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
            
            cell!.TotalAmountLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.TotalAmountValueLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.AmountDiscountLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.AmountDiscountValueLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.AmounttobePaidLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.AmounttobePaidValueLbl.font = UIFont(name: RegularFont, size: 14)
            
            cell!.ApplyBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_apply") as! String, for: .normal)
            cell!.CancelBtn.setTitle(GlobalLanguageDictionary.object(forKey: "Key_cancel") as! String, for: .normal)
            
            cell!.NoteLbl.text = GlobalLanguageDictionary.object(forKey: "key_couponusedcantcancel") as! String
            
            cell!.TotalAmountLbl.text = GlobalLanguageDictionary.object(forKey: "key_totalamount") as! String
            cell!.AmountDiscountLbl.text = GlobalLanguageDictionary.object(forKey: "key_amountDiscount") as! String
            cell!.AmountDiscountLbl.text = GlobalLanguageDictionary.object(forKey: "key_amounttobepaid") as! String
            
            if self.iscoupon == true {
                cell!.AppliedView.isHidden = false
                cell?.AppliedViewHeight.constant = 100
            }else{
                cell!.AppliedView.isHidden = true
                cell?.AppliedViewHeight.constant = 0
            }
            cell!.AmountDiscountValueLbl.text = self.CouponDiscountAmount
            cell!.TotalAmountValueLbl.text = self.CouponTotAmount
            cell!.AmounttobePaidValueLbl.text = self.AmounttobePaid
            
            
            cell!.CouponTxt.tag = 200
            cell!.CouponTxt.text = self.CouponCode
            
            cell!.ApplyBtn.addTarget(self, action: #selector(couponApplyAct), for: .touchUpInside)
            cell!.CancelBtn.addTarget(self, action: #selector(couponRejectAct), for: .touchUpInside)
            
            return cell!
        }else if indexPath.section == 1{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTypesTableViewCell") as? PaymentTypesTableViewCell
                cell!.selectionStyle = .none
                cell!.TypeName.text = GlobalLanguageDictionary.object(forKey: "key_cashinWallet") as! String
                if balenceWalletPrice == "0"{
                    cell?.notesLbl.isHidden = false
                }
                cell!.TypeImg.image = UIImage(named: "Image-6")
                cell!.TypeName.font = UIFont(name: SemiBoldFont, size: 16)
                cell!.notesLbl.font = UIFont(name: SemiBoldFont, size: 11)

                cell!.notesLbl.text = GlobalLanguageDictionary.object(forKey: "key_invitefrnd2getcash") as! String
                return cell!
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "WalletUsedTableViewCell") as? WalletUsedTableViewCell
            cell!.selectionStyle = .none
            cell!.NoteLbl.text = GlobalLanguageDictionary.object(forKey: "key_walletusedcantcancel") as! String
            cell!.ApplyBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_apply") as! String, for: .normal)
            cell!.CancelBtn.setTitle(GlobalLanguageDictionary.object(forKey: "Key_cancel") as! String, for: .normal)
            cell?.WalletLbl.text = GlobalLanguageDictionary.object(forKey: "key_usewallet") as! String
            cell!.WalletLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.NoteLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.ApplyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
            cell!.CancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
            if self.isCheck == true {
                cell!.CheckBtn.setImage(UIImage(named: "checkbox-2"), for: .normal)
            }else{
                cell!.CheckBtn.setImage(UIImage(named: "tick-off"), for: .normal)
            }
            
            cell!.ApplyBtn.addTarget(self, action: #selector(WalletApplyAct), for: .touchUpInside)
            cell!.CancelBtn.addTarget(self, action: #selector(WalletRejectAct), for: .touchUpInside)
             cell!.CheckBtn.addTarget(self, action: #selector(WalletCheck), for: .touchUpInside)
            
            
            
            return cell!
        }else 
        {
            
            if indexPath.row == 0 && self.choosePaymentType == "Stripe" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StripeUsedTableViewCell") as? StripeUsedTableViewCell
                cell!.selectionStyle = .none
                cell!.radioImg.setImageColor(color: AppColor)
                cell!.radioImg.image = UIImage(named: "radio-on-button")

                if self.choosePaymentType == "Stripe" {
                    cell!.SelectPaymentTypeLbl.text = GlobalLanguageDictionary.object(forKey: "key_creditDebit") as! String
                    

                }else{
                    cell!.SelectPaymentTypeLbl.text = self.choosePaymentType
                }
                cell!.SelectTypeLbl.text = GlobalLanguageDictionary.object(forKey: "key_selectCardType") as! String
                cell!.SelectedCardType.text = GlobalLanguageDictionary.object(forKey: "key_chooseyourCard") as! String
                cell!.CardNumberLbl.text = GlobalLanguageDictionary.object(forKey: "key_cardNumberstar") as! String
                cell!.CardNumberTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_cardNumber") as! String
                cell!.ExpDateLbl.text = GlobalLanguageDictionary.object(forKey: "key_expiryDateStar") as! String
                cell!.yearTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_year") as! String
                cell!.DateTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_month") as! String
                cell!.CvvLbl.text = GlobalLanguageDictionary.object(forKey: "key_cvvstar") as! String
                cell!.CVVTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_cvv") as! String
                
                
                
                cell!.SelectPaymentTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)

                cell!.SelectedCardType.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.SelectTypeLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CardNumberLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.ExpDateLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CvvLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CardNumberTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.yearTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.DateTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.CVVTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.CardNumberTxt.tag = 100
                cell!.yearTxt.tag = 101
                cell!.DateTxt.tag = 102
                cell!.CVVTxt.tag = 103
                cell!.SelectedCardType.tag = 104
                cell?.CardNumberTxt.keyboardType = .numberPad
                cell?.CVVTxt.keyboardType = .numberPad
                cell?.yearTxt.keyboardType = .numberPad
                cell?.DateTxt.keyboardType = .numberPad
                cell?.selectCardTtypeBtn.layer.borderWidth = 1
                       cell?.selectCardTtypeBtn.layer.borderColor = UIColor.lightGray.cgColor
                var cards = [String]()
                cards = cardsArr
                cardTypedropdowns.anchorView = cell!.selectCardTtypeBtn
                cardTypedropdowns.bottomOffset = CGPoint(x: 0, y: (cell!.selectCardTtypeBtn.bounds.height))
                cardTypedropdowns.dataSource = cards
                cardTypedropdowns.backgroundColor = UIColor.white
                // Action triggered on selection
                cardTypedropdowns.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.SelectedCardType.text = item
                    
                }
                
                var months = [String]()
                months = MonthsArray
                MonthDropDown.anchorView = cell!.DateTxt
                MonthDropDown.bottomOffset = CGPoint(x: 0, y: (cell!.DateTxt.bounds.height))
                MonthDropDown.dataSource = months
                MonthDropDown.backgroundColor = UIColor.white
                // Action triggered on selection
                MonthDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.DateTxt.text = item
                    
                }
                
                
                var years = [String]()
                years = YearsArray as! [String]
                YearDropDown.anchorView = cell!.yearTxt
                YearDropDown.bottomOffset = CGPoint(x: 0, y: (cell!.yearTxt.bounds.height))
                YearDropDown.dataSource = years
                YearDropDown.backgroundColor = UIColor.white
                // Action triggered on selection
                YearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.yearTxt.text = item

                }
                
                
                
                cell!.selectCardTtypeBtn.addTarget(self, action: #selector(StripeCarddropdown), for: .touchUpInside)
                return cell!
            }else if indexPath.row == 2 &&  self.choosePaymentType == "Credit Card" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "StripeUsedTableViewCell") as? StripeUsedTableViewCell
                cell!.selectionStyle = .none
               
                cell!.SelectPaymentTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell!.SelectedCardType.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.SelectTypeLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CardNumberLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.ExpDateLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CvvLbl.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.CardNumberTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.yearTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.DateTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                cell!.CVVTxt.font =  UIFont(name: SemiBoldFont, size: 14)
                
                cell!.CardNumberTxt.tag = 200
                cell!.yearTxt.tag = 201
                cell!.DateTxt.tag = 202
                cell!.CVVTxt.tag = 203
                cell!.SelectedCardType.tag = 204
                cell?.CardNumberTxt.keyboardType = .numberPad
                cell?.CVVTxt.keyboardType = .numberPad
                cell?.yearTxt.keyboardType = .numberPad
                cell?.DateTxt.keyboardType = .numberPad
                cell?.selectCardTtypeBtn.layer.borderWidth = 1
                       cell?.selectCardTtypeBtn.layer.borderColor = UIColor.lightGray.cgColor
 
                
                var cards = [String]()
                cards = cardsArr
                cardTypedropdowns.anchorView = cell!.selectCardTtypeBtn
                cardTypedropdowns.bottomOffset = CGPoint(x: 0, y: (cell!.selectCardTtypeBtn.bounds.height))
                cardTypedropdowns.dataSource = cards
                cardTypedropdowns.backgroundColor = UIColor.white
                // Action triggered on selection
                cardTypedropdowns.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.SelectedCardType.text = item
                    
                }
                
                var months = [String]()
                months = MonthsArray
                MonthDropDown.anchorView = cell!.DateTxt
                MonthDropDown.bottomOffset = CGPoint(x: 0, y: (cell!.DateTxt.bounds.height))
                MonthDropDown.dataSource = months
                MonthDropDown.backgroundColor = UIColor.white
                // Action triggered on selection
                MonthDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.DateTxt.text = item
                    
                }
                
                
                var years = [String]()
                years = YearsArray as! [String]
                YearDropDown.anchorView = cell!.yearTxt
                YearDropDown.bottomOffset = CGPoint(x: 0, y: (cell!.yearTxt.bounds.height))
                YearDropDown.dataSource = years
                YearDropDown.backgroundColor = UIColor.white
                // Action triggered on selection
                YearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    cell!.yearTxt.text = item

                }

                cell!.selectCardTtypeBtn.addTarget(self, action: #selector(StripeCarddropdown), for: .touchUpInside)
                
                return cell!
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTypesTableViewCell") as? PaymentTypesTableViewCell
                cell!.selectionStyle = .none
                cell?.notesLbl.isHidden = true
                cell!.TypeImg.image = UIImage(named: "radio-button")
                if self.PaymentsArray.object(at: indexPath.row) as? String == "Stripe" {
                    cell!.TypeName.text = GlobalLanguageDictionary.object(forKey: "key_creditDebit") as! String
                }else{
                    cell!.TypeName.text = self.PaymentsArray.object(at: indexPath.row) as? String
                }
                if self.choosePaymentType == "PayPal" && indexPath.row == 1 {
                    cell!.TypeName.textColor = AppColor
                    cell!.TypeImg.image = UIImage(named: "radio-on-button")

                }else if self.choosePaymentType == "ApplePay" && indexPath.row == 2 {
                    cell!.TypeName.textColor = AppColor
                    cell!.TypeImg.image = UIImage(named: "radio-on-button")

                } else{
                    cell!.TypeName.textColor = .black
                    cell!.TypeImg.image = UIImage(named: "radio-button")

                }
                
               
                
                cell!.TypeName.font = UIFont(name: SemiBoldFont, size: 16)
                return cell!
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.CouponShow = 2
                self.WalletShow = 1
                self.ChoosePaymentInt = 0
                self.choosePaymentType = ""

            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.CouponShow = 2
                if balenceWalletPrice == "0"{
                 self.WalletShow = 1
                    self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_dontHaveCashinWallet") as! String)
                }else{
                    self.WalletShow = 2
                }
                self.ChoosePaymentInt = 0
                self.choosePaymentType = ""
            }
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
                self.ChoosePaymentInt = 1
                self.choosePaymentType = "Stripe"
                
            }else if indexPath.row == 1 {
                self.ChoosePaymentInt = 0
                self.choosePaymentType = "PayPal"
            }else{
                self.applePayAct()
//                self.ChoosePaymentInt = 2
//                self.choosePaymentType = "ApplePay"
//                let request = PKPaymentRequest()
//                       request.merchantIdentifier = "merchant.com.closest"
//                       request.supportedNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
//                       request.merchantCapabilities = PKMerchantCapability.capability3DS
//                       request.countryCode = "US"
//                       request.currencyCode = "USD"
//
//                request.paymentSummaryItems = [
//                   PKPaymentSummaryItem(label: "Closest", amount: NSDecimalNumber(string: self.TotalAmount))]
//
//                       let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
//                applePayController?.delegate = self
//
//                       self.present(applePayController!, animated: true, completion: nil)

            }
        }
        
        self.PaymentTable.reloadData()
    }
    
    func applePayAct(){
        self.ChoosePaymentInt = 2
        self.choosePaymentType = "ApplePay"
        let request = PKPaymentRequest()
               request.merchantIdentifier = "merchant.com.closest"
               request.supportedNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex]
               request.merchantCapabilities = PKMerchantCapability.capability3DS
               request.countryCode = "US"
               request.currencyCode = "USD"
        let Amt = self.TotalAmount.replacingOccurrences(of: ",", with: "")

        request.paymentSummaryItems = [
           PKPaymentSummaryItem(label: "Closest", amount: NSDecimalNumber(string: Amt))]
               
               let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController?.delegate = self

               self.present(applePayController!, animated: true, completion: nil)

    }
    
}
@available(iOS 11.0, *)
extension NewPaymentViewController:
PKPaymentAuthorizationViewControllerDelegate{
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
//        print(payment.token.transactionIdentifier)
//        print(payment.token.paymentData)
        self.AppleData = payment.token.paymentData
     //   self.ApplePayToken = payment.token.transactionIdentifier
        
        self.ApplePayToken = String(data: payment.token.paymentData, encoding: .utf8)!
       // print(token)
        
        completion(PKPaymentAuthorizationResult(status: PKPaymentAuthorizationStatus.success, errors: []))
        self.ApplePayAct()
    }
}
extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
