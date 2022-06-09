//
//  PaymentViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 27/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CCValidator
import BraintreeDropIn
import Braintree
import AFNetworking
import DropDown
class PaymentViewController: BaseViewController,UITextFieldDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var stripeView: UIView!
    @IBOutlet weak var btnPay: UIButton!
    @IBOutlet weak var btnPaypal: UIButton!
    @IBOutlet weak var btnStripe: UIButton!
    @IBOutlet weak var btnCreditCard: UIButton!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtCvv: UITextField!
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var txtccNum: UITextField!
    @IBOutlet weak var txfYear: UITextField!
    @IBOutlet weak var txfMonth: UITextField!
    @IBOutlet weak var txfCvv: UITextField!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var creditExpirylbl: UILabel!
    @IBOutlet weak var creditpaymentcard: UILabel!
    @IBOutlet weak var creditcardType: UILabel!
    @IBOutlet weak var paypal: UILabel!
    @IBOutlet weak var stripeExpiryDatelbl: UILabel!
    @IBOutlet weak var stripeCreditCardLbl: UILabel!
    @IBOutlet weak var stripeLabel: UILabel!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var creditLine: UIView!
    
    @IBOutlet weak var backbutt: UIButton!
    @IBOutlet weak var view_StripeTitle: UIView!
    @IBOutlet weak var view_PaypaltitleView: UIView!
    @IBOutlet weak var stripelineView: UIView!
    @IBOutlet weak var lbl_NoPayment: UILabel!
    @IBOutlet weak var imgVw_stripeCardtype: UIImageView!
    @IBOutlet weak var imgvw_creditcardType: UIImageView!
    @IBOutlet weak var btn_StripecardType: UIButton!
    @IBOutlet weak var btn_CreditcardType: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var paypalBackView: UIView!
    
    ////////////////COUPON CODE///////////////////
    @IBOutlet weak var couponbtn: UIButton!
    @IBOutlet weak var couponView: UIView!
    @IBOutlet weak var textfild: UITextField!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var rejcetBtn: UIButton!
    @IBOutlet weak var couponViewHgt: NSLayoutConstraint!
    @IBOutlet weak var couponBtnght: NSLayoutConstraint!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var responseCoponLbl: UILabel!
    @IBOutlet var payView: UIView!
    @IBOutlet weak var totLAmountLbl: UILabel!
    @IBOutlet weak var discountAmountLbl: UILabel!
    @IBOutlet weak var amountTopaidLbl: UILabel!
    @IBOutlet weak var noteCouponLabel: UILabel!
    
    ////////////////WALLET///////////////////
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var walletViewHgt: NSLayoutConstraint!
    @IBOutlet weak var walletPayView: UIView!
    @IBOutlet weak var walletSubTtlLbl: UILabel!
    @IBOutlet weak var walletAmountLbl: UILabel!
    @IBOutlet weak var walletPaidAmountLbl: UILabel!
    @IBOutlet weak var walletAcceptBtn: UIButton!
    @IBOutlet weak var walletRejectBtn: UIButton!
    @IBOutlet weak var walletRejectt: UIButton!
    @IBOutlet weak var walletCheckBtn: UIButton!
    @IBOutlet weak var usealletLbl: UILabel!
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var walletLineView: UIView!
    @IBOutlet weak var walletBtnHgt: NSLayoutConstraint!
    @IBOutlet weak var noWalletLbl: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
    @IBOutlet weak var CouponRejectBtn: UIButton!
    @IBOutlet weak var StripecardLabel: UILabel!
  @IBOutlet weak var CreditcardLabel: UILabel!

    //MARK:- Validation Constants
    
    var totalwallet  = String()
    var usedwallet  = String()
    
    var balenceWalletPrice = String()
    
    var iscoupon = Bool()
    var iswalletPayment = Bool()
    var isCheck = Bool()
    var couponTotalAmount = String()
    var walletTotalAmount = String()
    
    var instaEnquiryId = Int()
    var PaymentFor = String()
    var PAYMENT_MODE = String()
    var cardtype = String()
    var cardnumber = String()
    var cc_exp_day = String()
    var cc_exp_year = String()
    var credit_card_identifier = String()
    var total_price : AnyObject!
    var currency_code = String()
    var enquiryid  = String()
    var discountAmount  = String()
    var currencycode = String()
    var user_id = String()
    var property_id = String()
    var paySuccess = String()
    var carderr = String()
    var yearexp = String()
    var monexp = String()
    var cvvexp = String()
    var cardexp = String()
    var commission = String()
    var commission_type = String()
    var hosting_price = String()
    var currency_cron_idssqq = String()
    var enquiryidssqq = String()
    var restaurant_idssqq = String()
    var AmtPaypal : AnyObject!
    var dropDownArray = NSArray()
    var cardsArr = ["Visa","American Express","Master Card","Discover"]
    var cardsImgArr = NSArray()
    let cardTypedropdowns = DropDown()
    var ListingActivityDelegate: listingActivityProtocol!
    lazy var dropDowns: [DropDown] = {
        return [
            self.cardTypedropdowns,
            ]
    }()
    
//    //MARK:- PayPal Constants
//    var environment:String = PayPalEnvironmentSandbox
//    {
//        willSet(newEnvironment) {
//            if (newEnvironment != environment) {
//                PayPalMobile.preconnect(withEnvironment: newEnvironment)
//            }
//        }
//    }
  //  var payPalConfig = PayPalConfiguration() // default

    
    var resultText = "" // empty
    var braintreeClient: BTAPIClient?
    var clientToken:String = ""
    var nonceStr = String()
    var endingStr = String()
    var paymentMethod : BTPaymentMethodNonce?
    var transaction_id: String! = ""
    var responseCode: String! = ""
    
    var totalamount : AnyObject!
    var totalserviceFee: NSDecimalNumber = NSDecimalNumber(string: "0.0")
    var totalsubtotal: NSDecimalNumber = NSDecimalNumber(string: "0.0")
    var totalDeposit: NSDecimalNumber = NSDecimalNumber(string: "0.0")
    var totalproductPrice : NSDecimalNumber = NSDecimalNumber(string: "0.0")
    var hostId : AnyObject!
    var currencySymbol = String()
    var totalserviceFees =  String()
    
    var stripe_Status = String()
    var card_Status = String()
    var paypal_status = String()
    var AmounttoPay = Int()
    
    //MARK:- Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //BRAINTREE: This below method used for testing purpose generating dummy client token, we need to get this from API
        self.fetchClientToken()

        self.payView.isHidden = true
        //self.noteCouponLabel.isHidden = true
        
        print(totalsubtotal)
        print(totalserviceFee)
        print(totalDeposit)
        print(totalserviceFees)
        
        isCheck = false
        
        let amount = NSDecimalNumber(string: "\(self.totalserviceFees)")
        let rounding1 = Double(truncating: amount)
        totalserviceFees = String(format: "%.2f",rounding1)
        print(totalserviceFees)
        
        let amount2 = NSDecimalNumber(string: "\(self.total_price!)")
        let rounding3 = Double(truncating: amount2)
        total_price = String(format: "%.2f",rounding3) as AnyObject
        print(total_price)
        
        
        ////////////////////WALLET///////
        self.walletView.isHidden = true
        self.walletCheckBtn.setImage(UIImage(named: "tick-off"), for: .normal)
        self.noWalletLbl.isHidden = true
       self.WalletApi()
        
        UserDefaults.standard.set(self.total_price, forKey: "totalAmount")
        print(self.property_id)
        self.btn_StripecardType.roundedCorner()
        self.btn_CreditcardType.roundedCorner()
        cardsImgArr = ["Visa_Card","american_Exprss","Master_card","Discover_Card"]
        self.lbl_NoPayment.isHidden = true
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        txtCardNumber.delegate = self
        txtYear.delegate = self
        txtMonth.delegate = self
        txtCvv.delegate = self
        txtccNum.delegate = self
        txfCvv.delegate = self
        txfMonth.delegate = self
        txfYear.delegate = self
        textfild.delegate = self
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        
        if PaymentFor == "Listing"
        {
            
            self.couponbtn.isHidden = true
            self.couponView.isHidden = true
            couponViewHgt.constant = 0
            couponBtnght.constant = 0
            self.lineView.isHidden = true
            
            walletViewHgt.constant = 0
            walletView.isHidden = true
            self.walletBtn.isHidden = true
            self.walletView.isHidden = true
            self.walletLineView.isHidden = true
            self.walletBtnHgt.constant = 0
            
            if Singleton.sharedInstance.PropertyListingModel.propertyListing[0].creditCardStatus == "Enable"
            {
                self.creditCardView.isHidden = true
                self.creditView.isHidden = true
                self.creditLine.isHidden = true
                
            }
            if Singleton.sharedInstance.PropertyListingModel.propertyListing[0].stripeStatus == "Enable"
            {
                self.stripeView.isHidden = false
                self.view_StripeTitle.isHidden = false
                self.stripelineView.isHidden = false
                
            }
            if Singleton.sharedInstance.PropertyListingModel.propertyListing[0].paypalStatus == "Enable"
            {
                self.view_PaypaltitleView.isHidden = false
            }
            
            if self.paypal_status == "Disable" && self.stripe_Status == "Disable"
            {
                self.stripeView.isHidden = true
                self.view_StripeTitle.isHidden = true
                self.stripelineView.isHidden = true
                self.view_PaypaltitleView.isHidden = true
                self.lbl_NoPayment.isHidden = false
            }
            
        }else
        {
            self.couponbtn.isHidden = false
            self.couponBtnght.constant = 46
            self.couponView.isHidden = true
            couponViewHgt.constant = 0
            self.payView.isHidden = true
            //self.noteCouponLabel.isHidden = true
            
            self.lineView.isHidden = false
            
            self.walletBtn.isHidden = false
            self.walletBtnHgt.constant = 46
            walletViewHgt.constant = 0
            walletView.isHidden = true
            self.walletLineView.isHidden = false
            
            
            applyBtn.layer.cornerRadius = 3
            applyBtn.layer.borderColor = UIColor.darkGray.cgColor
            applyBtn.layer.borderWidth = 1
            rejcetBtn.layer.cornerRadius = 3
            rejcetBtn.layer.borderColor = UIColor.darkGray.cgColor
            rejcetBtn.layer.borderWidth = 1
            
            
            walletAcceptBtn.layer.cornerRadius = 3
            walletAcceptBtn.layer.borderColor = UIColor.darkGray.cgColor
            walletAcceptBtn.layer.borderWidth = 1
            walletRejectBtn.layer.cornerRadius = 3
            walletRejectBtn.layer.borderColor = UIColor.darkGray.cgColor
            walletRejectBtn.layer.borderWidth = 1
            walletRejectt.layer.cornerRadius = 3
            walletRejectt.layer.borderColor = UIColor.darkGray.cgColor
            walletRejectt.layer.borderWidth = 1
            
            if stripe_Status == "Enable"
            {
                self.stripeView.isHidden = false
                self.view_StripeTitle.isHidden = false
                self.stripelineView.isHidden = false
            }
            else
            {
                self.stripeView.isHidden = true
                self.view_StripeTitle.isHidden = true
                self.stripelineView.isHidden = true
            }
            if card_Status == "Enable"
            {
                self.creditCardView.isHidden = false
                self.creditView.isHidden = false
                self.creditLine.isHidden = false
            }
            else
            {
                self.creditCardView.isHidden = true
                self.creditView.isHidden = true
                self.creditLine.isHidden = true
            }
            if paypal_status == "Enable"
            {
                self.view_PaypaltitleView.isHidden = false
            }
            else
            {
                self.view_PaypaltitleView.isHidden = true
            }
            if self.card_Status == "Disable" && self.stripe_Status == "Disable" && self.paypal_status == "Disable"
            {
                self.creditCardView.isHidden = true
                self.creditView.isHidden = true
                self.creditLine.isHidden = true
                self.stripeView.isHidden = true
                self.view_StripeTitle.isHidden = true
                self.stripelineView.isHidden = true
                self.view_PaypaltitleView.isHidden = true
                self.lbl_NoPayment.isHidden = false
            }
            
            //            self.creditView.isHidden = false
            //            self.creditLine.isHidden = false
            //            self.creditValueView.isHidden = false
        }
        
        //        if stripe_Status == "Enable" && card_Status == "Enable" && paypal_status == "Enable"
        //        {
        //            self.stripeView.isHidden = false
        //            self.creditCardView.isHidden = false
        //            self.view_PaypaltitleView.isHidden = false
        //            self.view_StripeTitle.isHidden = false
        //            self.creditCardView.isHidden = false
        //        }
        
        /*print("Pay Price is: \(UserDefaults.standard.value(forKey: "payPrice")!)")
         print("Pay serviceFee is: \(UserDefaults.standard.value(forKey: "payserviceFee")!)")
         print("Pay deposit is: \(UserDefaults.standard.value(forKey: "paydeposit")!)")
         print("Pay total is: \(UserDefaults.standard.value(forKey: "paytotal")!)")
         print("Pay NoOfNight is: \(UserDefaults.standard.value(forKey: "payNoOfNight")!)")
         print("\(self.total_price!)")
         totalserviceFee = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "payserviceFee")!)")
         totalDeposit = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "paydeposit")!)")
         totalproductPrice = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "payPrice")!)")
         totalamount = UserDefaults.standard.value(forKey: "paytotal") as! Int*/
        //print("Pay NoOfNight is: \(hostId!)")
        //print("Pay NoOfNight is: \(currencySymbol)")
        
        //payPalOldConfigure()
        self.stripeView.isHidden = true
        self.creditCardView.isHidden = true
        
        
        /*print("Pay Price is: \(UserDefaults.standard.value(forKey: "payPrice")!)")
         print("Pay serviceFee is: \(UserDefaults.standard.value(forKey: "payserviceFee")!)")
         print("Pay deposit is: \(UserDefaults.standard.value(forKey: "paydeposit")!)")
         print("Pay total is: \(UserDefaults.standard.value(forKey: "paytotal")!)")
         print("Pay NoOfNight is: \(UserDefaults.standard.value(forKey: "payNoOfNight")!)")
         print("\(self.total_price!)")
         totalserviceFee = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "payserviceFee")!)")
         totalDeposit = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "paydeposit")!)")
         totalproductPrice = NSDecimalNumber(string: "\(UserDefaults.standard.value(forKey: "payPrice")!)")
         totalamount = UserDefaults.standard.value(forKey: "paytotal") as! Int*/
        //print("Pay NoOfNight is: \(hostId!)")
        //print("Pay NoOfNight is: \(currencySymbol)")
        
        //payPalOldConfigure()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.viewTitle.font = UIFont(name: SemiBoldFont, size: 20)
        self.btnPay.titleLabel?.font = UIFont(name: SemiBoldFont, size: 20)
         self.btnPay.backgroundColor = AppColor
         self.couponbtn.titleLabel?.font = UIFont(name: RegularFont, size: 18)
        self.applyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        self.rejcetBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        self.totLAmountLbl.font = UIFont(name: RegularFont, size: 17)
          self.discountAmountLbl.font = UIFont(name: RegularFont, size: 17)
        self.amountTopaidLbl.font = UIFont(name: RegularFont, size: 17)
        self.CouponRejectBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
           self.responseCoponLbl.font = UIFont(name: RegularFont, size: 17)
        self.textfild.font = UIFont(name: RegularFont, size: 17)
        self.noteCouponLabel.font = UIFont(name: RegularFont, size: 17)
         self.walletBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        
         self.walletRejectBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.walletAcceptBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.noteLabel.font = UIFont(name: RegularFont, size: 17)
        self.usealletLbl.font = UIFont(name: RegularFont, size: 15)
        self.noWalletLbl.font = UIFont(name: RegularFont, size: 15)
        self.walletSubTtlLbl.font = UIFont(name: RegularFont, size: 15)
         self.walletRejectt.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.walletAmountLbl.font = UIFont(name: RegularFont, size: 15)
         self.walletPaidAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.stripeLabel.font = UIFont(name: RegularFont, size: 17)
        self.StripecardLabel.font = UIFont(name: RegularFont, size: 15)
        self.btn_StripecardType.titleLabel?.font = UIFont(name: RegularFont, size: 17)
        self.stripeCreditCardLbl.font = UIFont(name: RegularFont, size: 15)
         self.stripeExpiryDatelbl.font = UIFont(name: RegularFont, size: 15)
          self.txtCardNumber.font = UIFont(name: RegularFont, size: 15)
          self.txtYear.font = UIFont(name: RegularFont, size: 15)
        self.txtMonth.font = UIFont(name: RegularFont, size: 15)
          self.txtCvv.font = UIFont(name: RegularFont, size: 15)
        self.paypal.font = UIFont(name: RegularFont, size: 17)
         self.creditcardType.font = UIFont(name: RegularFont, size: 17)
        self.CreditcardLabel.font = UIFont(name: RegularFont, size: 15)
          self.btn_CreditcardType.titleLabel?.font = UIFont(name: RegularFont, size: 17)
        
        self.creditpaymentcard.font = UIFont(name: RegularFont, size: 15)
         self.txtccNum.font = UIFont(name: RegularFont, size: 15)
         self.creditExpirylbl.font = UIFont(name: RegularFont, size: 15)
         self.txfYear.font = UIFont(name: RegularFont, size: 15)
         self.txfMonth.font = UIFont(name: RegularFont, size: 15)
          self.txfCvv.font = UIFont(name: RegularFont, size: 15)
        
          self.lbl_NoPayment.font = UIFont(name: RegularFont, size: 17)
        
        
        
        
        
        
          // PayPalMobile.preconnect(withEnvironment: environment)
           let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
           if choose == "en" {
               self.btnPay.setTitle(LocalizeHelper().localizedStringForKey("pay"), for: .normal)
               self.stripeCreditCardLbl.text = LocalizeHelper().localizedStringForKey("ccnumber")
               self.stripeExpiryDatelbl.text = LocalizeHelper().localizedStringForKey("expdate")
               self.creditpaymentcard.text = LocalizeHelper().localizedStringForKey("ccnumber")
               self.creditExpirylbl.text = LocalizeHelper().localizedStringForKey("expdate")
               self.creditcardType.text = LocalizeHelper().localizedStringForKey("creditcard")
               self.viewTitle.text = LocalizeHelper().localizedStringForKey("paymentmethods")
               self.stripeLabel.text = LocalizeHelper().localizedStringForKey("stripe")
               self.paypal.text = LocalizeHelper().localizedStringForKey("paypal")
               self.txtCvv.placeholder = LocalizeHelper().localizedStringForKey("cvv")
               self.txtYear.placeholder = LocalizeHelper().localizedStringForKey("year")
               self.txtMonth.placeholder = LocalizeHelper().localizedStringForKey("month")
               self.txtccNum.placeholder = LocalizeHelper().localizedStringForKey("cardnumber")
               self.txtCardNumber.placeholder = LocalizeHelper().localizedStringForKey("cardnumber")
               self.txfCvv.placeholder = LocalizeHelper().localizedStringForKey("cvv")
               self.txfYear.placeholder = LocalizeHelper().localizedStringForKey("year")
               self.txfMonth.placeholder = LocalizeHelper().localizedStringForKey("month")
               paySuccess = LocalizeHelper().localizedStringForKey("paymentsuccess")
               carderr = LocalizeHelper().localizedStringForKey("carderror")
               monexp = LocalizeHelper().localizedStringForKey("monthinvalid")
               yearexp = LocalizeHelper().localizedStringForKey("yearinvalid")
               cvvexp = LocalizeHelper().localizedStringForKey("cvvinvalid")
               cardexp = LocalizeHelper().localizedStringForKey("cardinvalid")
           }
       }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                
                
                
                
                let totalWalletAmout = userDetails?.value(forKey: "total_wallet_amount") as! NSNumber
                self.totalwallet = String(format: "%@",totalWalletAmout)
                let balenceWalletAmout = userDetails?.value(forKey: "balance_from_wallet") as! NSNumber
                self.balenceWalletPrice = String(format: "%@",balenceWalletAmout)
                let usedWalletAmout = userDetails?.value(forKey: "used_from_wallet") as! NSNumber
                self.usedwallet = String(format: "%@",usedWalletAmout)
                
                let balenceWallet = String(format: "%@",balenceWalletAmout)
                
                let currency = userDetails?.value(forKey: "user_currency_symbol")
                self.usealletLbl.text = String(format: " %@ %@ (Use Wallet) ",currency as! CVarArg, balenceWallet)

                
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
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: UITextField Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == txtCardNumber || textField == txtccNum {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 16
            //return count <= 1056466
        }
        else if textField == txtCvv || textField == txfCvv {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 3
        }
        else if textField == txtYear || textField == txfYear {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 4
        }
        else if textField == txtMonth || textField == txfMonth {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 2
        }
        return result
    }
    
   /* // MARK: Paypal Old Configure
    func payPalOldConfigure() {
        //successView.isHidden = true
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "HoneStayEdison"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        // Setting the payPalShippingAddressOption property is optional.
        // See PayPalConfiguration.h for details.
        //payPalConfig.payPalShippingAddressOption = .none;
        //print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
    }
    
    func callPayPalMethod() {
        // Remove our last completed payment, just for demo purposes.
        resultText = ""
        
        print("serviceFee is: \(totalserviceFee)")
        print("subtotal is: \(totalsubtotal)")
        print("deposit is: \(totalDeposit)")
        print("productPrice is: \(totalproductPrice)")
        //print("totalamount is: \(totalamount)")
        
        let emptyServiceFee: NSDecimalNumber = NSDecimalNumber(string: "0.0")
        let emptyDeposit: NSDecimalNumber = NSDecimalNumber(string: "0.0")
        
        // Optional: include payment details
        print("\(self.total_price!)")
        
        let amount = NSDecimalNumber(string: "\(self.total_price!)")
        print("amount",amount)
        self.currencycode = "USD"
        //let paymentDetails = PayPalPaymentDetails(subtotal: totalsubtotal, withShipping: totalserviceFee, withTax: totalDeposit)
        let paymentDetails = PayPalPaymentDetails(subtotal: amount, withShipping: emptyServiceFee, withTax: emptyDeposit)
        let payment = PayPalPayment(amount: amount, currencyCode: self.currencycode, shortDescription: "PHAM", intent: .sale)
        
        payment.paymentDetails = paymentDetails
        print(PAY_BY_PAYPAL)
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            self.showInformation(title: "Closest", message: "Payment not processalbe")
            print("Payment not processalbe: \(payment)")
        }
    }
    
    // MARK: callPayPalForListing
    func callPayPalForListing() {
        let listingServiceFee: NSDecimalNumber = NSDecimalNumber(string: "0.0")
        let listingDeposit: NSDecimalNumber = NSDecimalNumber(string: "0.0")
        
        // Remove our last completed payment, just for demo purposes.
        resultText = ""
        
        // Optional: include payment details
        print("\(self.total_price!)")
        let amount = NSDecimalNumber(string: "\(self.total_price!)")
        print("amount",amount)
        self.currencycode = "USD"
        let paymentDetails = PayPalPaymentDetails(subtotal: amount, withShipping: listingServiceFee, withTax: listingDeposit)
        let payment = PayPalPayment(amount: amount, currencyCode: self.currencycode, shortDescription: "PHAM", intent: .sale)
        
        payment.paymentDetails = paymentDetails
        print(PAY_BY_PAYPAL)
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            self.showInformation(title: "Closest", message: "Payment not processalbe")
            print("Payment not processalbe: \(payment)")
        }
    }
    
    // PayPalPaymentDelegate
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            //print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            let paymentDict = completedPayment.confirmation as NSDictionary
            print(paymentDict)
            self.transaction_id = paymentDict.value(forKeyPath: "response.id") as? String
            print(self.transaction_id)
            self.user_id = String(describing: login_session.value(forKey: "UserId")!)
            let reachability = Reachability()!
            if reachability.isReachable {
                if self.PaymentFor == "Booking" {
                    
                    
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":self.currencycode,"txn_id":self.transaction_id!,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payer_email":login_session.value(forKey: "Email") as! String,"payment_gross":self.total_price!,"property_id":self.property_id,"enquiryid":self.enquiryid,"user_id":self.user_id]
                    
                    
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PAY_BY_PAYPAL, parameters: params, progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            isFromBookingDetails = true
                            print(responseDict)
                            let paymentSuccessArr:NSArray = responseDict.value(forKey: "payment_success") as! NSArray
                            let total_priceStr:NSNumber = ((paymentSuccessArr[0] as AnyObject).value(forKey: "total_price") as? NSNumber)!
                            print(String(describing:total_priceStr))
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing:total_priceStr)
                            let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                                let when = DispatchTime.now()
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                                    self.navigationController?.pushViewController(nav!, animated: true)
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
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
                    
                    
                    
                    
                    
                    //                    let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&currencycode=\(self.currencycode)&txn_id=\(self.transaction_id!)&device_type=IOS&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&payer_email=\(login_session.value(forKey: "Email") as! String)&payment_gross=\(self.total_price!)&property_id=\(self.property_id)&enquiryid=\(self.enquiryid)&user_id=\(self.user_id)"
                    //                    print(parameterStr)
                    //                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: PAY_BY_PAYPAL, APIKEY: "PAY_BY_PAYPAL")
                } else {
                    
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":self.currencycode,"txn_id":self.transaction_id!,"device_type":"IOS","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","payment_gross":self.total_price!,"payer_email":login_session.value(forKey: "Email") as! String,"property_id":self.property_id,"total_price":self.total_price!,"user_id":self.user_id]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(LISTING_PAY_BY_PAYPAL, parameters: params, progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            isFromPaymentSuccess = true
                            print(responseDict)
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                                let when = DispatchTime.now()
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
                                    self.navigationController?.pushViewController(nav!, animated: true)
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
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
                    
                    
                    
                    
                    
                    //                    let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&currencycode=\(self.currencycode)&txn_id=\(self.transaction_id!)&device_type=IOS&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&payment_gross=\(self.total_price!)&payer_email=\(login_session.value(forKey: "Email") as! String)&property_id=\(self.property_id)&total_price=\(self.total_price!)&user_id=\(self.user_id)"
                    //                    print(parameterStr)
                    //                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: LISTING_PAY_BY_PAYPAL, APIKEY: "LISTING_PAY_BY_PAYPAL")
                }
            }
            else {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as! String)
            }
            
            self.resultText = completedPayment.description
            self.showSuccess()
        })
    }*/
    
    // MARK: Helpers
    
    func showSuccess() {
        //successView.isHidden = false
        //successView.alpha = 1.0
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationDelay(2.0)
        //successView.alpha = 0.0
        UIView.commitAnimations()
    }
    
    //MARK: - alert
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func couponCodeBtn(_ sender: Any)
    {
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnPaypal.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnStripe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.stripeView.isHidden = true
        self.couponbtn.isHidden = false
        self.couponView.isHidden = false
        couponViewHgt.constant = 230
        self.lineView.isHidden = false
        
        self.responseCoponLbl.isHidden = true
        self.walletView.isHidden = true
        self.walletViewHgt.constant = 0
        self.walletPayView.isHidden = true
        self.noWalletLbl.isHidden = true
        self.creditCardView.isHidden = true
    }
    @IBAction func walletButton(_ sender: Any)
    {
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnPaypal.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnStripe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.creditCardView.isHidden = true
        self.stripeView.isHidden = true
        self.couponView.isHidden = true
        self.couponViewHgt.constant = 0
        self.lineView.isHidden = false
        self.walletView.isHidden = false
        self.walletViewHgt.constant = 203
        self.walletPayView.isHidden = true
        self.walletCheckBtn.setImage(UIImage(named: "tick-off"), for: .normal)
        //self.noteCouponLabel.isHidden = true
        self.noWalletLbl.isHidden = true
        self.payView.isHidden = true
        isCheck = false
        
    }
    @IBAction func walletCheckBtn(_ sender: Any)
    {
        isCheck = true
        self.walletCheckBtn.setImage(UIImage(named: "checkbox-2"), for: .normal)
        
    }
    @IBAction func act_Stripe(_ sender: UIButton) {
        PAYMENT_MODE = "STRIPE"
        self.btnStripe.setImage(UIImage(named: "checkbox-2"), for: .normal)
        self.btnPaypal.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.creditCardView.isHidden = true
        self.stripeView.isHidden = false
//        self.couponView.isHidden = true
//        self.couponViewHgt.constant = 0
//        self.walletView.isHidden = true
//        self.walletViewHgt.constant = 0
//        self.walletPayView.isHidden = true
    }
    
    @IBAction func act_Paypal(_ sender: UIButton) {
        PAYMENT_MODE = "PAYPAL"
        self.btnPaypal.setImage(UIImage(named: "checkbox-2"), for: .normal)
        self.btnStripe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.stripeView.isHidden = true
        self.creditCardView.isHidden = true
//        self.couponView.isHidden = true
//        self.couponViewHgt.constant = 0
//        self.walletView.isHidden = true
//        self.walletViewHgt.constant = 0
//        self.walletPayView.isHidden = true
    }
    
    @IBAction func act_CreditCard(_ sender: UIButton) {
        PAYMENT_MODE = "CREDITCARD"
        self.btnCreditCard.setImage(UIImage(named: "checkbox-2"), for: .normal)
        self.btnStripe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnPaypal.setImage(UIImage(named: "tick-off"), for: .normal)
        self.stripeView.isHidden = true
        self.creditCardView.isHidden = false
//        self.couponView.isHidden = true
//        self.couponViewHgt.constant = 0
//        self.walletView.isHidden = true
//        self.walletViewHgt.constant = 0
//        self.walletPayView.isHidden = true
        
    }
    @IBAction func btnPayMayaTapped(_ sender: UIButton) {
        PAYMENT_MODE = "PAYMAYA"
        self.btnPaypal.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnStripe.setImage(UIImage(named: "tick-off"), for: .normal)
        self.btnCreditCard.setImage(UIImage(named: "tick-off"), for: .normal)
        self.stripeView.isHidden = true
        self.creditCardView.isHidden = true
    }
    
    @IBAction func applyBtn_Act(_ sender: Any)
    {
        
        if self.textfild.text == ""
        {
            
            self.responseCoponLbl.isHidden = false
            self.responseCoponLbl.text = "Fill Coupon Code"
        }
            
        else
        {
             self.responseCoponLbl.isHidden = true
            Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
             params = ["coupon_code":self.textfild.text!,"product_id":self.property_id,"sub_total":totalsubtotal,"service_fee":self.totalserviceFee,"deposit_fee":self.totalDeposit,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String]
            
          
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(COPON_APPLY_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.iscoupon = true
                    self.iswalletPayment = false
                    
                    self.responseCoponLbl.isHidden = true
                    
                    let userDetailsArr = responseDict.value(forKey: "coupon_amount") as! NSArray
                    let userDetails = userDetailsArr[0] as? NSDictionary
                    let total_amount = userDetails?.value(forKey: "total_amount") as! Double
                    let doubleStr = String(format: "%.2f", total_amount as CVarArg) // "3.14"
                    let total = String(doubleStr)
                    self.couponTotalAmount  = total
                    
                    
                    
                    let disAmount = userDetails?.value(forKey: "amount_discount") as? NSNumber
                    let dissamount = NSDecimalNumber(string: "\(disAmount!)")
                    let rounding = Double(truncating: dissamount)
                    self.discountAmount = String(format: "%.2f",rounding)
                    print(self.discountAmount)
                    
                    
                    
                    
                    let subtotal = userDetails?.value(forKey: "sub_total") as AnyObject
                    let amount = NSDecimalNumber(string: "\(subtotal)")
                    let rounding1 = Double(truncating: amount)
                    let subStr = String(format: "%.2f",rounding1)
                    print(subStr)
                    
                    
                    let couponprice = userDetails?.value(forKey: "coupon_price")as AnyObject
                    
                    
                    
                    self.payView.isHidden = false
                    // self.noteCouponLabel.isHidden = false
                    
                    self.payView.layer.shadowColor = UIColor.gray.cgColor
                    self.payView.layer.shadowOpacity = 0.5
                    self.payView.layer.shadowOffset = CGSize.zero
                    self.payView.layer.shadowRadius = 10
                    
                    self.totLAmountLbl.text = String(format: "Total Amount :%@ %@","" ,subStr as CVarArg )
                    self.discountAmountLbl.text = String(format: "Amount Discount :%@ (%@)", self.discountAmount as CVarArg,couponprice as! CVarArg)
                    self.amountTopaidLbl.text = String(format: "Amount to be paid :%@ %@", "",  self.couponTotalAmount as CVarArg )
                    self.total_price = userDetails?.value(forKey: "total_amount") as! Double as AnyObject
                    self.showInformation(title: "Closest", message: "Coupon applied successfully!")
                     self.textfild.text = ""
                }
                    
                else {
                    self.textfild.text = ""
                     self.responseCoponLbl.isHidden = false
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
    @IBAction func act_StripeCardtype(_ sender: UIButton)
    {
      
        StripeCarddropdown()
        cardTypedropdowns.show()
        
        if btn_StripecardType.currentTitle == "Visa"
        {
            self.imgVw_stripeCardtype.image = UIImage(named: "Visa_Card")
        }
        else if btn_StripecardType.currentTitle == "American Express"
        {
            self.imgVw_stripeCardtype.image = UIImage(named: "american_Exprss")
        }
        else if btn_StripecardType.currentTitle == "Master Card"
        {
            self.imgVw_stripeCardtype.image = UIImage(named: "Master_card")
        }
        else if btn_StripecardType.currentTitle == "Discover"
        {
            self.imgVw_stripeCardtype.image = UIImage(named: "Discover_Card")
        }
    }
    @IBAction func act_CreditcardType(_ sender: UIButton)
    {
        
       
        Creditcardropdown()
        cardTypedropdowns.show()
        
        
        if btn_CreditcardType.currentTitle == "Visa"
        {
            self.imgvw_creditcardType.image = UIImage(named: "Visa_Card")
        }
        else if btn_CreditcardType.currentTitle == "American Express"
        {
            self.imgvw_creditcardType.image = UIImage(named: "american_Exprss")
        }
        else if btn_CreditcardType.currentTitle == "Master Card"
        {
            self.imgvw_creditcardType.image = UIImage(named: "Master_card")
        }
        else if btn_CreditcardType.currentTitle == "Discover"
        {
            self.imgvw_creditcardType.image = UIImage(named: "Discover_Card")
        }
    }
    func StripeCarddropdown()
    {
        var cards = [String]()
        cards = cardsArr as! [String]
        cardTypedropdowns.anchorView = btn_StripecardType
        cardTypedropdowns.bottomOffset = CGPoint(x: 0, y: (btn_StripecardType?.bounds.height)!)
        cardTypedropdowns.dataSource = cards
        cardTypedropdowns.backgroundColor = UIColor.white
        // Action triggered on selection
        cardTypedropdowns.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btn_StripecardType.setTitle(item, for: .normal)
            self.imgVw_stripeCardtype.image = UIImage(named: self.cardsImgArr.object(at: index) as! String)
        }
    }
    
    func Creditcardropdown()
    {
        var cards = [String]()
        cards = cardsArr as! [String]
        cardTypedropdowns.anchorView = btn_CreditcardType
        cardTypedropdowns.bottomOffset = CGPoint(x: 0, y: (btn_CreditcardType?.bounds.height)!)
        cardTypedropdowns.dataSource = cards
        cardTypedropdowns.backgroundColor = UIColor.white
        // Action triggered on selection
        cardTypedropdowns.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.btn_CreditcardType.setTitle(item, for: .normal)
            self.imgvw_creditcardType.image = UIImage(named: self.cardsImgArr.object(at: index) as! String)
        }
    }
    @IBAction func Reject_act(_ sender: Any)
        
    {
        if self.textfild.text == "" {
            self.showInformation(title: "Closest", message: "Please Enter Coupon Code")
        }else{
            iscoupon = false
            iswalletPayment = false
            
            self.couponbtn.isHidden = false
            self.couponView.isHidden = true
            self.couponViewHgt.constant = 0
            self.lineView.isHidden = false
            self.couponBtnght.constant = 46
            self.payView.isHidden = true
            self.textfild.text = ""
            self.total_price = self.totalamount
            //  self.noteCouponLabel.isHidden = true
            
            
            self.showInformation(title: "Closest", message: "Coupon Removed Successfully")
        }
        
        
       
        
        
    }
    
    @IBAction func walletAccept_Act(_ sender: Any)
    {
        if isCheck == true
        {
            
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                 params = ["sub_total":totalsubtotal,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"user_id":login_session.value(forKey: "UserId")!,"deposit_fee":self.totalDeposit,"product_id":self.property_id,"wallet_amount":self.balenceWalletPrice,"service_fee":self.totalserviceFee]
            
                
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
                        let currencySymbol = userDetails?.value(forKey: "user_currency_symbol")
                        
                        
                        
                        
                        let totalWalletAmout = userDetails?.value(forKey: "wallet_amount")
                        let walletAmountStr = String(format: "%@",totalWalletAmout as! CVarArg)
                        
                        
                        let subtotal = userDetails?.value(forKey: "sub_total")
                        let subtotalStr = String(format: "%@",subtotal as! CVarArg)
                        
                        
                        
                        let paidWalletAmout = userDetails?.value(forKey: "total_amount")
                        let paidWalletAmoutStr = String(format: "%@",paidWalletAmout as! CVarArg)
                        
                        
                        
                        self.walletPayView.isHidden = false
                        self.walletPayView.layer.shadowColor = UIColor.gray.cgColor
                        self.walletPayView.layer.shadowOpacity = 0.5
                        self.walletPayView.layer.shadowOffset = CGSize.zero
                        self.walletPayView.layer.shadowRadius = 10
                        self.walletSubTtlLbl.text = String(format: "Sub Total Amount :%@ %@",currencySymbol as! CVarArg ,subtotalStr)
                        self.walletAmountLbl.text = String(format: "Wallet Amount :%@ %@", currencySymbol as! CVarArg,walletAmountStr)
                        self.walletPaidAmountLbl.text = String(format: "Amount To be Paid :%@ %@",currencySymbol as! CVarArg,paidWalletAmoutStr)
                        self.walletTotalAmount = paidWalletAmoutStr
                         self.total_price = userDetails?.value(forKey: "total_amount") as! Double as AnyObject
                        self.showInformation(title: "Closest", message: "Wallet applied successfully!")
                    }
                        
                    else {
                        self.walletPayView.isHidden = true
                        // self.noteCouponLabel.isHidden = true
                        self.noWalletLbl.isHidden = false
                        self.noWalletLbl.text = responseDict.value(forKey: "message") as? String
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
    
    @IBAction func walletReject_Act(_ sender: Any)
    {
        iswalletPayment = false
        iscoupon = false
        self.walletCheckBtn.setImage(UIImage(named: "tick-off"), for: .normal)
        self.walletBtn.isHidden = false
        self.walletView.isHidden = true
        self.walletBtnHgt.constant = 46
        walletViewHgt.constant = 0
        walletView.isHidden = true
        self.walletLineView.isHidden = false
        self.noWalletLbl.isHidden = true
        isCheck = false
        self.total_price = self.totalamount
        self.showInformation(title: "Closest", message: "Wallet Removed Successfully")
        
    }
    
    
    @IBAction func act_Pay(_ sender: UIButton)
    {
        if self.btnPaypal.currentImage == UIImage.init(named: "tick-off") &&
            self.btnStripe.currentImage == UIImage.init(named: "tick-off") &&
            self.btnCreditCard.currentImage == UIImage.init(named: "tick-off")
        {
            self.showInformation(title: "Closest", message: "Please select the Card Type")
            
        }
        else
        {
            
            switch PAYMENT_MODE {
            case "STRIPE":
                if PaymentFor == "Booking" {
                    self.isValidCard()
                } else {
                    self.isValidCard()
                }
                break
            case "PAYPAL":
                if PaymentFor == "Booking" {
                    //callPayPalMethod()
                    self.showDropIn(clientTokenOrTokenizationKey: self.clientToken)
                }
                else {
                    //callPayPalForListing()
                    self.showDropIn(clientTokenOrTokenizationKey: self.clientToken)

                }
                break
            case "CREDITCARD":
                if PaymentFor == "Booking" {
                    self.isCreditCardValid()
                }
                else {
                    self.isCreditCardValid()
                }
            default:
                break
            }
        }
    }
    
    // MARK: payByStripe
    
    func payByStripe() {
        
        self.showActivityIndicator(uiView: self.view)
        
        if PaymentFor == "Booking"
        {
            if (Reachability()?.isReachable)!
            {
                
                
                if self.iscoupon == true
                {
                    
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    
//
//                    "card_no":"4111111111111111",
//                    "ccExpiryMonth":"12",
//                    "ccExpiryYear":"23",
//                    "cvvNumber":"123",
//                    "lang_code":"en",
//                    "currency_code":"USD",
//                    "property_id":"9",
                    
                    
                     params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":self.btn_StripecardType.currentTitle!,"cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.property_id,"total_price":self.couponTotalAmount,"base_id":"1","subtotal":self.totalsubtotal,"enquiryid":self.enquiryid,"user_id":self.user_id,"wallet_amount":"","coupon_code":self.textfild.text!,"offer_type":"coupon","coupon_discount_amt":self.discountAmount,"serviceFee":"","depositFee":""]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        
//                        APIManager.apiPostWithHeaders(serviceName: PAY_BY_STRIPE, parameters: params as? [String : Any]) { response, error in
//                            DispatchQueue.main.async {
//                                self.ListingActivityDelegate?.hideActivity()
//                            }
                        
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            self.hideActivityIndicator(uiView: self.view)
                            isFromBookingDetails = true
                            print(responseDict)
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            let alertController = UIAlertController(title: "Closest", message: amount + " " + self.paySuccess, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                                self.navigationController?.pushViewController(nav!, animated: true)
                                let when = DispatchTime.now()
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
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
                    
                    
                    
                    
                    
//                    let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&creditvalue=\("authorize")&cardtype=\(self.btn_StripecardType.currentTitle!)&cardnumber=\(self.cardnumber)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&cc_exp_day=\(self.cc_exp_day)&cc_exp_year=\(self.cc_exp_year)&property_id=\(self.property_id)&total_price=\(self.couponTotalAmount)&base_id=\("1")&subtotal=\(self.totalsubtotal)&enquiryid=\(self.enquiryid)&user_id=\(self.user_id)&wallet_amount=\("")&coupon_code=\(self.textfild.text!)&offer_type=\("coupon")&coupon_discount_amt=\(self.discountAmount)&serviceFee=\("")&depositFee=\("")"
//                    print(parameterStr)
//
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: PAY_BY_STRIPE, APIKEY: "PAY_BY_STRIPE")
                }
                else if self.iswalletPayment == true
                {
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":self.btn_StripecardType.currentTitle!,"cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.property_id,"total_price":self.total_price!,"base_id":"1","subtotal":self.totalsubtotal,"enquiryid":self.enquiryid,"user_id":self.user_id,"wallet_amount":self.balenceWalletPrice,"coupon_code":"","offer_type":"wallet","coupon_discount_amt":"","serviceFee":"","depositFee":""]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            self.hideActivityIndicator(uiView: self.view)
                            isFromBookingDetails = true
                            print(responseDict)
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                                self.navigationController?.pushViewController(nav!, animated: true)
                                let when = DispatchTime.now()
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
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
                    
                    
                    
//                    let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&creditvalue=\("authorize")&cardtype=\(self.btn_StripecardType.currentTitle!)&cardnumber=\(self.cardnumber)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&cc_exp_day=\(self.cc_exp_day)&cc_exp_year=\(self.cc_exp_year)&property_id=\(self.property_id)&total_price=\(self.walletTotalAmount)&base_id=\("1")&subtotal=\(self.totalsubtotal)&enquiryid=\(self.enquiryid)&user_id=\(self.user_id)&wallet_amount=\(self.balenceWalletPrice)&coupon_code=\("")&offer_type=\("wallet")&coupon_discount_amt=\("")&serviceFee=\("")&depositFee=\("")"
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: PAY_BY_STRIPE, APIKEY: "PAY_BY_STRIPE")
//                    print(parameterStr)
                }
                else{
                    
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                    params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"creditvalue":"authorize","cardtype":self.btn_StripecardType.currentTitle!,"cardnumber":self.cardnumber,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"property_id":self.property_id,"total_price":self.total_price!,"base_id":"1","subtotal":self.totalsubtotal,"enquiryid":self.enquiryid,"user_id":self.user_id,"wallet_amount":"","coupon_code":"","offer_type":"","coupon_discount_amt":"","serviceFee":"","depositFee":""]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            self.hideActivityIndicator(uiView: self.view)
                            isFromBookingDetails = true
                            print(responseDict)
                            let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                            let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                                self.navigationController?.pushViewController(nav!, animated: true)
                                let when = DispatchTime.now()
                                DispatchQueue.main.asyncAfter(deadline: when){
                                    
                                }
                            }))
                            self.present(alertController, animated: true, completion: nil)
                            
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
                    
//                    let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&creditvalue=\("authorize")&cardtype=\(self.btn_StripecardType.currentTitle!)&cardnumber=\(self.cardnumber)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&cc_exp_day=\(self.cc_exp_day)&cc_exp_year=\(self.cc_exp_year)&property_id=\(self.property_id)&total_price=\(self.total_price!)&base_id=\("1")&subtotal=\(self.totalsubtotal)&enquiryid=\(self.enquiryid)&user_id=\(self.user_id)&wallet_amount=\("")&coupon_code=\("")&offer_type=\("no")&coupon_discount_amt=\("")&serviceFee=\("")&depositFee=\("")"
//                    print(parameterStr)
//
//
//
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: PAY_BY_STRIPE, APIKEY: "PAY_BY_STRIPE")
                }
                  self.hideActivityIndicator(uiView: self.view)
            }
              
            else{
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        } else {
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                
//                "card_no":"4111111111111111",
//                "ccExpiryMonth":"12",
//                "ccExpiryYear":"23",
//                "cvvNumber":"123",
//                "is_coupon_used":"0",
//                "used_coupon_amount":,
//                "lang_code":"en",
//                "currency_code":"USD",
//                "property_id":"9"
                
                
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":self.currencycode,"credit_card_identifier":self.credit_card_identifier,"device_type":"IOS","cc_exp_day":self.cc_exp_day,"property_id":self.property_id,"creditvalue":"Stripe","cardnumber":self.cardnumber,"cc_exp_year":self.cc_exp_year,"enquiryid":self.enquiryid,"user_id":self.user_id,"total_price":self.total_price!,"cardtype":self.cardtype,"email":login_session.value(forKey: "Email") as! String]
                
//                APIManager.apiPostWithHeaders(serviceName: LISTING_PAY_BY_STRIPE, parameters: params as? [String : Any]) { response, error in
//                    DispatchQueue.main.async {
//                        self.ListingActivityDelegate?.hideActivity()
//                    }
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(LISTING_PAY_BY_STRIPE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        
                        isFromPaymentSuccess = true
                        let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                        let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                            let when = DispatchTime.now()
                            DispatchQueue.main.asyncAfter(deadline: when){
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
                                self.navigationController?.pushViewController(nav!, animated: true)
                            }
                        }))
                        self.present(alertController, animated: true, completion: nil)
                        
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
                
                
                //                let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&currencycode=\(self.currencycode)&credit_card_identifier=\(self.credit_card_identifier)&device_type=IOS&cc_exp_day=\(self.cc_exp_day)&property_id=\(self.property_id)&creditvalue=Stripe&cardnumber=\(self.cardnumber)&cc_exp_year=\(self.cc_exp_year)&enquiryid=\(self.enquiryid)&user_id=\(self.user_id)&total_price=\(self.total_price!)&cardtype=\(self.cardtype)&email=\(login_session.value(forKey: "Email") as! String)"
                //                print(parameterStr)
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: LISTING_PAY_BY_STRIPE, APIKEY: "LISTING_PAY_BY_STRIPE")
            }
            else{
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
            self.hideActivityIndicator(uiView: self.view)
            
            
        }
        self.hideActivityIndicator(uiView: self.view)
    }
    
    
    

    
    
    // MARK: payByCredircard
    func payByCredircard() {
        if (Reachability()?.isReachable)! {
            let id = Singleton.sharedInstance.selectedCategory!
            self.showActivityIndicator(uiView: self.view)
            if PaymentFor == "Booking" {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["cardtype":self.cardtype,"cardnumber":self.cardnumber,"cc_exp_day":self.cc_exp_day,"cc_exp_year":self.cc_exp_year,"creditvalue":"authorize","property_id":self.property_id,"credit_card_identifier":self.credit_card_identifier,"total_price":self.total_price!,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"currencycode":self.currencycode,"user_id":self.user_id,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","enquiryid":self.enquiryid]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(PAY_BY_CREDITCARD_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        isFromBookingDetails = true
                        let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as! Float)
                        let price = responseDict.value(forKey: "total_price") as? String
                        let bookingNum = responseDict.value(forKey: "booking_no") as? String
                        let alertController = UIAlertController(title: "Closest", message: amount + self.paySuccess, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                            let when = DispatchTime.now()
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                                self.navigationController?.pushViewController(nav!, animated: true)
                            }
                        }))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "Payment not successfully")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async { self.hideActivityIndicator(uiView: self.view) }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                //                let parameterStr = "cardtype=\(self.cardtype)&cardnumber=\(self.cardnumber)&cc_exp_day=\(self.cc_exp_day)&cc_exp_year=\(self.cc_exp_year)&creditvalue=authorize&property_id=\(self.property_id)&credit_card_identifier=\(self.credit_card_identifier)&total_price=\(self.total_price!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as! String)&currencycode=\(self.currencycode)&user_id=\(self.user_id)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&enquiryid=\(self.enquiryid)"
                //                print(parameterStr)
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: PAY_BY_CREDITCARD_API, APIKEY: "PAY_BY_CREDITCARD_API")
            }
        }
        else
        {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
    }
    
    // MARK: isValidCard
    func isValidCard() {
        let isvalid = CCValidator.validate(creditCardNumber: self.txtCardNumber.text!)
        let month = txtMonth.text!
        let year = txtYear.text!
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let currentyear =  components.year
        let currentmonth = components.month
        let card_type =  CCValidator.typeCheckingPrefixOnly(creditCardNumber: self.txtCardNumber.text!)
        if isvalid == false  {
            self.showInformation(title: carderr, message: cardexp)
        } else if (txtCvv.text?.count)! < 3 || (txtCvv.text?.count)! > 4 {
            self.showInformation(title: carderr, message: cvvexp)
        } else if year < String(currentyear!) {
            self.showInformation(title: carderr, message: yearexp)
        } else if year == String(currentyear!){
            if month < String(currentmonth!) || month < "12"{
                self.showInformation(title: carderr, message: monexp)
            } else {
                
                self.cardtype = self.getCardType(forId: card_type.rawValue)
                self.cardnumber = self.txtCardNumber.text!
                self.cc_exp_day = self.txtMonth.text!
                self.cc_exp_year = self.txtYear.text!
                self.credit_card_identifier = self.txtCvv.text!
                self.currencycode = "USD"
                self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
                self.user_id = String(describing: login_session.value(forKey: "UserId")!)
                payByStripe()
            }
        } else {
            self.cardtype =  self.getCardType(forId: card_type.rawValue)
            self.cardnumber = self.txtCardNumber.text!
            self.cc_exp_day = self.txtMonth.text!
            self.cc_exp_year = self.txtYear.text!
            self.credit_card_identifier = self.txtCvv.text!
            self.currencycode = "USD"
            self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
            self.user_id = String(describing: login_session.value(forKey: "UserId")!)
            payByStripe()
        }
    }
    
    // MARK: isCreditCardValid
    func isCreditCardValid()
    {
        let isvalid = CCValidator.validate(creditCardNumber: self.txtccNum.text!)
        let month = txfMonth.text!
        let year = txfYear.text!
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let currentyear =  components.year
        let currentmonth = components.month
        let card_type =  CCValidator.typeCheckingPrefixOnly(creditCardNumber: self.txtccNum.text!)
        if isvalid == false  {
            self.showInformation(title: carderr, message: cardexp)
        } else if (txfCvv.text?.count)! < 3 || (txfCvv.text?.count)! > 4 {
            self.showInformation(title: carderr, message: cvvexp)
        } else if year < String(currentyear!) {
            self.showInformation(title: carderr, message: yearexp)
        } else if year == String(currentyear!){
            if month < String(currentmonth!){
                self.showInformation(title: carderr, message: monexp)
            } else {
                self.cardtype = self.getCardType(forId: card_type.rawValue)
                self.cardnumber = self.txtccNum.text!
                self.cc_exp_day = self.txfMonth.text!
                self.cc_exp_year = self.txfYear.text!
                self.credit_card_identifier = self.txfCvv.text!
                self.currencycode = "USD"
                self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
                self.user_id = String(describing: login_session.value(forKey: "UserId")!)
                payByCredircard()
            } }
        else {
            self.cardtype =  self.getCardType(forId: card_type.rawValue)
            self.cardnumber = self.txtccNum.text!
            self.cc_exp_day = self.txfMonth.text!
            self.cc_exp_year = self.txfYear.text!
            self.credit_card_identifier = self.txfCvv.text!
            self.currencycode = "USD"
            self.currency_code = (login_session.value(forKey: "APP_CURRENCY") as! String)
            self.user_id = String(describing: login_session.value(forKey: "UserId")!)
            payByCredircard()
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
    
    // MARK: PAYPAL PAYMENT USING BRAINTREE
    
    //BRAINTREE: This below method is used for testing purpose generating dummy client token, we need to get this from API
    
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
                
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    func postNonceToServer(paymentMethodNonce: String) {
        // Update URL with your server
        
       // self.paypalTransactionIdSendToAPI(trans_id: paymentMethodNonce)
        
        
    }
}

// MARK: extension
extension PaymentViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String)
    {
        if APIKEY == "PAY_BY_STRIPE" {
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                
                
                let status = responseDict.value(forKey: "status") as? Int
                if status! == 1
                {
                    
                    
                    isFromBookingDetails = true
                    print(responseDict)
                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                    let alertController = UIAlertController(title: "Closest", message: amount + paySuccess, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                        self.navigationController?.pushViewController(nav!, animated: true)
                        // let when = DispatchTime.now()
                        //                        DispatchQueue.main.asyncAfter(deadline: when){
                        //
                        //                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else if APIKEY == "LISTING_PAY_BY_STRIPE" {
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                let status = responseDict.value(forKey: "status") as? Int
                if status! == 1{
                    isFromPaymentSuccess = true
                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                    let alertController = UIAlertController(title: "Closest", message: amount + paySuccess, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                        let when = DispatchTime.now()
                        DispatchQueue.main.asyncAfter(deadline: when){
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
                            self.navigationController?.pushViewController(nav!, animated: true)
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else if APIKEY == "PAY_BY_CREDITCARD_API"
        {
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0
            {
                print(responseDict)
                let status = responseDict.value(forKey: "status") as? Int
                if status! == 1
                {
                    isFromBookingDetails = true
                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as! Float)
                    let price = responseDict.value(forKey: "total_price") as? String
                    let bookingNum = responseDict.value(forKey: "booking_no") as? String
                    let alertController = UIAlertController(title: "Closest", message: amount + paySuccess, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                        let when = DispatchTime.now()
                        DispatchQueue.main.asyncAfter(deadline: when){
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                            
                            self.navigationController?.pushViewController(nav!, animated: true)
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        else if APIKEY == "PAY_BY_PAYPAL" {
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let status = responseDict.value(forKey: "status") as? Int
                if status! == 1 {
                    isFromBookingDetails = true
                    print(responseDict)
                    let paymentSuccessArr:NSArray = responseDict.value(forKey: "payment_success") as! NSArray
                    let total_priceStr:NSNumber = ((paymentSuccessArr[0] as AnyObject).value(forKey: "total_price") as? NSNumber)!
                    print(String(describing:total_priceStr))
                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing:total_priceStr)
                    let alertController = UIAlertController(title: "Closest", message: amount + paySuccess, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                        let when = DispatchTime.now()
                        DispatchQueue.main.asyncAfter(deadline: when){
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                            self.navigationController?.pushViewController(nav!, animated: true)
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        else if APIKEY == "LISTING_PAY_BY_PAYPAL" {
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let status = responseDict.value(forKey: "status") as? Int
                if status! == 1{
                    isFromPaymentSuccess = true
                    print(responseDict)
                    let amount = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as! String +  " " + String(describing: responseDict.value(forKey: "total_price") as AnyObject)
                    let alertController = UIAlertController(title: "Closest", message: amount + paySuccess, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
                        let when = DispatchTime.now()
                        DispatchQueue.main.asyncAfter(deadline: when){
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
                            self.navigationController?.pushViewController(nav!, animated: true)
                        }
                    }))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}


