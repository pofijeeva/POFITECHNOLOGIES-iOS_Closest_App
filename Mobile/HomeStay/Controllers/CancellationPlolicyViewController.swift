//
//  CancellationPlolicyViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown

class CancellationPlolicyViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var txtPolicy: UITextField!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var txtLang: UITextField!
    @IBOutlet weak var txtPercentage: UITextField!
    @IBOutlet weak var txtDeposit: UITextField!
    @IBOutlet weak var txtTax: UITextField!
    @IBOutlet weak var txtTaxPercentage: UITextField!
    @IBOutlet weak var txtSecurityDepositInfo: UITextField!
    
    @IBOutlet weak var metaDiscription: UITextView!
    @IBOutlet weak var txtViewKeywords: UITextView!
    @IBOutlet weak var txtMetaTitle: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var conTopSpace: NSLayoutConstraint!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cancelationPolicy: UILabel!
    @IBOutlet weak var pleaseSelect: UILabel!
    @IBOutlet weak var cancelPolicy: UILabel!
    @IBOutlet weak var securityDeposit: UILabel!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var lblDeposit: UILabel!
    @IBOutlet weak var lbltax: UILabel!
    @IBOutlet weak var lbltaxPercentage: UILabel!
    @IBOutlet weak var lblsecurityDepositInfo: UILabel!
    
    
    
    @IBOutlet weak var metaTitle: UILabel!
    @IBOutlet weak var keyboards: UILabel!
    @IBOutlet weak var metaDescription: UILabel!
    @IBOutlet weak var cencelDescriptionEnTxt: UITextView!
    @IBOutlet weak var cancelDescriptionLbl: UILabel!
    @IBOutlet weak var cancelPercentTxt: UITextField!
    @IBOutlet weak var cancelPercentage: UILabel!
    
    var DropData = ["English","Arabic"]
    let dropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDown
        ]
    }()
    
    
    //MARK:- Variables
    var ListingActivityDelegate: listingActivityProtocol?
    var PropertyID = Int()
    var policySelected = Bool()
    var veh_ID = Int()
    var currencyArr = [Currency]()

    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
//        self.lblCurrencySymbol.text = login_session.value(forKey: "APP_CURRENCY") as! String
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        
//        self.metaDiscription.text = step9.metaDescription
//        self.txtViewKeywords.text = step9.metaKeyword
//        self.txtMetaTitle.text = step9.metaTitle
//        self.txtSecurityDepositInfo.text = step9.securityDeposit
//        self.cencelDescriptionEnTxt.text = step9.cancelDescription
////            self.txtPercentage.text = step9.ren_tax_percent
////            self.txtTax.text = step9.
////            self.txtDeposit.text = step9.sec_dep
//        self.cancelPercentTxt.text = step9.cancelPercentage
//        self.txtPolicy.text = step9.cancellationPolicyTitle
        
        self.cencelDescriptionEnTxt.layer.borderWidth = 1.0
        self.updateTextView(textView: self.cencelDescriptionEnTxt)
        self.updateTextView(textView: self.metaDiscription)
        self.updateTextView(textView: self.txtViewKeywords)
        self.txtDeposit.layer.borderWidth = 1
        self.txtDeposit.layer.borderColor = BorderColor.cgColor
        
        self.cancelPercentTxt.layer.borderWidth = 1
        self.cancelPercentTxt.layer.borderColor = BorderColor.cgColor
        
        self.txtMetaTitle.layer.borderWidth = 1
        self.txtMetaTitle.layer.borderColor = BorderColor.cgColor
        

        self.txtPolicy.layer.borderWidth = 1
        self.txtPolicy.layer.borderColor = BorderColor.cgColor
        
        self.lblLang.font = UIFont(name: SemiBoldFont, size: 17)
        self.txtLang.font = UIFont(name: SemiBoldFont, size: 17)
        self.cancelPolicy.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtPolicy.font = UIFont(name: SemiBoldFont, size: 14)
        self.cancelPercentage.font = UIFont(name: SemiBoldFont, size: 14)
        self.cancelPercentTxt.font = UIFont(name: SemiBoldFont, size: 14)
        self.lblDeposit.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtDeposit.font = UIFont(name: SemiBoldFont, size: 14)
        self.lbltax.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtTax.font = UIFont(name: SemiBoldFont, size: 14)
        self.lbltaxPercentage.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtPercentage.font = UIFont(name: SemiBoldFont, size: 14)
        self.cancelDescriptionLbl.font = UIFont(name: SemiBoldFont, size: 14)
//        self..font = UIFont(name: SemiBoldFont, size: 14)
        self.lblsecurityDepositInfo.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtSecurityDepositInfo.font = UIFont(name: SemiBoldFont, size: 14)
        self.metaTitle.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtMetaTitle.font = UIFont(name: SemiBoldFont, size: 14)
        self.keyboards.font = UIFont(name: SemiBoldFont, size: 14)
//        self.txtMetaTitle.font = UIFont(name: SemiBoldFont, size: 14)
        self.metaDescription.font = UIFont(name: SemiBoldFont, size: 14)
//        self..font = UIFont(name: SemiBoldFont, size: 14)
        
        
        
        
        
        txtDeposit.keyboardType = UIKeyboardType.numberPad
        txtPercentage.keyboardType = UIKeyboardType.numberPad
        }
    
    func setData()
    {
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step9 = result.step9 {
            
//            self.txtLang.text = step9.seo_tags
            
            self.metaDiscription.text = step9.metaDescription
            self.txtViewKeywords.text = step9.metaKeyword
            self.txtMetaTitle.text = step9.metaTitle
            self.txtSecurityDepositInfo.text = step9.securityDeposit
            self.cencelDescriptionEnTxt.text = step9.cancelDescription
            self.txtPercentage.text = "\(step9.ren_tax_percent!)"

//            self.txtLang.text = step9.
//            self.txtTax.text = step9.
//            self.txtDeposit.text = step9.sec_dep
//            self.cancelPercentTxt.text = String(step9.ren_tax_percent)
            self.txtPolicy.text = step9.cancel_policy_type
            self.txtDeposit.text = String(step9.sec_dep)
//            let stepNine = Singleton.sharedInstance.rentYourSpace.result[0].step9!
            let dict = step9.seo_tags
            let dict1 = step9.ren_details
            if (txtLang.text == "English"){
                txtMetaTitle.text =  dict?.en.ren_meta_title
                txtViewKeywords.text = dict?.en.ren_meta_keyword
                metaDiscription.text = dict?.en.ren_meta_desc
                txtTax.text = dict1?.en.ren_tax
                cencelDescriptionEnTxt.text = dict1?.en.cancel_policy_desc
                txtSecurityDepositInfo.text = dict1?.en.sec_dep_desc

            }else{
                txtMetaTitle.text =  dict?.ar.ren_meta_title
                txtViewKeywords.text = dict?.ar.ren_meta_keyword
                metaDiscription.text = dict?.ar.ren_meta_desc
                txtTax.text = dict1?.ar.ren_tax
                cencelDescriptionEnTxt.text = dict1?.ar.cancel_policy_desc
                txtSecurityDepositInfo.text = dict1?.ar.sec_dep_desc
            }
            }
            
          
            
        }
        
    
    func updateTextView(textView: UITextView) {
      
        textView.textColor = UIColor.black
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = BorderColor.cgColor//UIColor(hex: 0xBFBFC2).cgColor
        textView.layer.shadowColor = BorderColor.cgColor//UIColor(hex: 0xBFBFC2).cgColor
        textView.layer.cornerRadius = 5
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowOpacity = 0.6
        textView.delegate = self
        textView.keyboardType = .default
        textView.returnKeyType = .done
    }
    
    func DropDownTypes() {
        
        dropDown.anchorView = self.txtLang
        dropDown.bottomOffset = CGPoint(x: 0, y: (self.txtLang?.bounds.height)!)
        dropDown.dataSource = DropData
        dropDown.backgroundColor = UIColor.white
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txtLang.text = item
            let stepNine = Singleton.sharedInstance.rentYourSpace.result[0].step9!
            let dict = stepNine.seo_tags
            let dict1 = stepNine.ren_details
            if (index == 0){
                txtMetaTitle.text =  dict?.en.ren_meta_title
                txtViewKeywords.text = dict?.en.ren_meta_keyword
                metaDiscription.text = dict?.en.ren_meta_desc
                txtTax.text = dict1?.en.ren_tax
                txtPercentage.text = dict1?.en.ren_meta_title
                cencelDescriptionEnTxt.text = dict1?.en.cancel_policy_desc
                txtSecurityDepositInfo.text = dict1?.en.sec_dep_desc
                
                
            }else{
                txtMetaTitle.text =  dict?.ar.ren_meta_title
                txtViewKeywords.text = dict?.ar.ren_meta_keyword
                metaDiscription.text = dict?.ar.ren_meta_desc
                txtTax.text = dict1?.ar.ren_tax
                txtPercentage.text = dict1?.ar.ren_meta_title
                cencelDescriptionEnTxt.text = dict1?.ar.cancel_policy_desc
                txtSecurityDepositInfo.text = dict1?.ar.sec_dep_desc
            }
            }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.policySelected = Singleton.sharedInstance.rentYourSpace.result[0].step9.stepCompleted!

        if policySelected != false
        {
            self.txtPolicy.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancellationPolicy
        }else{
            self.txtPolicy.text = ""
        }

        if self.txtPolicy.text == "Strict"
        {
            self.cancelPercentTxt.text = "0"
        }
        else if self.txtPolicy.text == "Moderate"
        {
            self.cancelPercentTxt.text = "50"
        }
        else if self.txtPolicy.text == "Flexible"
        {
            self.cancelPercentTxt.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelPercentage!
//            if let cancelPercentageStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelPercentage {
//                self.cancelPercentTxt.text = cancelPercentageStr
//            }
        }else{

        }
        
        //if self.txtPolicy.text == "Flexible"
        //self.cancelPercentTxt.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelPercentage!
        /*self.lblCurrencySymbol.text = Singleton.sharedInstance.listingCurrencySymb
        self.txtPrice.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.securityDeposit!
        self.txtMetaTitle.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaTitle!
        
        self.txtViewKeywords.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaKeyword!
        self.keyboardspn.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaKeywordPh!
        self.metaDiscription.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaDescription!
        self.metadespn.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaDescriptionPh!
        self.cencelDescriptionEnTxt.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelDescription!
        self.cancelDescriptionFnTxt.text = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelDescriptionPh!*/
        
//        if let listingCurrencySymbStr:String = Singleton.sharedInstance.listingCurrencySymb {
//            self.lblCurrencySymbol.text = listingCurrencySymbStr
//        }
        
        if let securityDepositStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.securityDeposit {
//            self.txtPrice.text = securityDepositStr
            self.txtDeposit.text = securityDepositStr
        }
        
        if let metaTitleStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaTitle {
            self.txtMetaTitle.text = metaTitleStr
        }
        
        if let metaKeywordStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaKeyword {
            self.txtViewKeywords.text = metaKeywordStr
        }
        
        if let metaDescriptionStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.metaDescription {
            self.metaDiscription.text = metaDescriptionStr
        }
        
        if let cancelDescriptionStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step9.cancelDescription {
            self.cencelDescriptionEnTxt.text = cancelDescriptionStr
        }
//        self.lblCurrencySymbol.text = Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode!
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        setData()
        self.cancelPolicy.font = UIFont(name: SemiBoldFont, size: 17)
        self.pleaseSelect.font = UIFont(name: RegularFont, size: 15)
        self.cancelPolicy.font = UIFont(name: RegularFont, size: 15)
        self.txtPolicy.font = UIFont(name: RegularFont, size: 14)
//         self.securityDeposit.font = UIFont(name: RegularFont, size: 15)
         self.txtDeposit.font = UIFont(name: RegularFont, size: 14)
        self.cancelPercentage.font = UIFont(name: RegularFont, size: 15)
        self.cancelPercentTxt.font = UIFont(name: RegularFont, size: 14)
          self.metaTitle.font = UIFont(name: RegularFont, size: 15)
        self.txtMetaTitle.font = UIFont(name: RegularFont, size: 14)
         self.keyboards.font = UIFont(name: RegularFont, size: 15)
         self.txtViewKeywords.font = UIFont(name: RegularFont, size: 14)
         self.metaDescription.font = UIFont(name: RegularFont, size: 15)
          self.metaDiscription.font = UIFont(name: RegularFont, size: 14)
        self.cancelDescriptionLbl.font = UIFont(name: RegularFont, size: 15)
          self.cencelDescriptionEnTxt.font = UIFont(name: RegularFont, size: 15)
        
        self.btnSave.backgroundColor = AppColor
                self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        
        
        //        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        //        if choose == "en"
        //        {
        //            self.cancelationPolicy.text = LocalizeHelper().localizedStringForKey("canpolicy")
        //            self.pleaseSelect.text = LocalizeHelper().localizedStringForKey("readmorecanpolicy")
        //            self.cancelPolicy.text = LocalizeHelper().localizedStringForKey("selectpolicy")
        //            self.securityDeposit.text = LocalizeHelper().localizedStringForKey("entersecdeposit")
        //            self.metaTitle.text = LocalizeHelper().localizedStringForKey("metatitle")
        //            self.keyboards.text = LocalizeHelper().localizedStringForKey("keywordsEN")
        //            self.metaDescription.text = LocalizeHelper().localizedStringForKey("metadescEN")
        //            self.btnSave.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
        //            self.txtPrice.placeholder = LocalizeHelper().localizedStringForKey("price")
        //            self.txtMetaTitle.placeholder = LocalizeHelper().localizedStringForKey("metatitle")
        //            self.metatitlepn.placeholder = LocalizeHelper().localizedStringForKey("metatitleph")
        //            self.metaDiscription.set(placeHolder: LocalizeHelper().localizedStringForKey("metadescen"))
        //            self.metadespn.set(placeHolder: LocalizeHelper().localizedStringForKey("metadescph"))
        //            self.txtViewKeywords.set(placeHolder: LocalizeHelper().localizedStringForKey("keywords"))
        //            self.keyboardspn.set(placeHolder: LocalizeHelper().localizedStringForKey("keywordsph"))
        //        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.conTopSpace.constant = 20
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCancelPolicy" {
            let popViewController:PopViewController = segue.destination as! PopViewController
            popViewController.popOverDelegate = self
            popViewController.headerTxt = "cancellation type".uppercased()
            popViewController.dropDownArray  = ["Strict","Flexible","Moderate"]
        }
    }
    
    
    
    //MARK:- Button Actions
    
    @IBAction func actBgViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func showdropDownOverview(_ sender: Any) {
        self.dropDown.show()
        self.DropDownTypes()
    }
    
    @IBAction func act_Save(_ sender: UIButton) {
//        self.conTopSpace.constant = 20
        self.view.endEditing(true)
        if txtPolicy.text == nil  || self.txtPolicy.text?.count == 0{
            self.showInformation(title: "Closest", message: "Please select cancellation policy")
        }
//        else if self.txtPrice.text == nil || self.txtPrice.text?.count == 0 {
//            self.showInformation(title: "Closest", message: "Please enter security deposit")
//        }
        else if cancelPercentTxt.text == nil || self.cancelPercentTxt.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter return amount in percent")
        }
        else if self.cencelDescriptionEnTxt.text == nil || self.cencelDescriptionEnTxt.text?.count == 0
        {
            self.showInformation(title: "Closest", message: "Description should not be empty")
            
        }
            
        else {
            ListingActivityDelegate?.showActivity()
            if Reachability()!.isReachable {
                var params = NSMutableDictionary()
                
                
//                "lang_code":"en",
//                "property_id":"41884",
//                "ren_tax_percent":"12",
//                "cancel_policy_type":"Flexible",  //Flexible,Strict,Moderate
//                "sec_dep":"10",
//                "return_amt":"60",
//                "cancel_policy_desc":"test",
//                "sec_dep_desc":"Test SEcurity desction",
//                "ren_tax":"GST",
//                "ren_meta_title":"Rental meta title",
//                "ren_meta_keyword":"Rental meta  keword",
//                "ren_meta_desc":"Rental meta  desc",
//
                
//                params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":self.PropertyID,"cancellation_policy":self.txtPolicy.text!,"security_deposit":self.txtPrice.text!,"meta_title":self.txtMetaTitle.text!,"meta_keyword":self.txtViewKeywords.text!,"meta_description":self.metaDiscription.text!,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as! String,"base_id":Singleton.sharedInstance.selectedCategory!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"cancel_percentage":self.cancelPercentTxt.text!,"cancel_description":self.cencelDescriptionEnTxt.text!]
                
                
                
                
                params   =      [ "lang_code":login_session.value(forKey: "APP_LANGUAGE") as! String,
                                  "property_id":self.PropertyID,
                                  "ren_tax_percent":self.cancelPercentTxt.text!,
                                  "cancel_policy_type":self.txtPolicy.text!,  //Flexible,Strict,Moderate
                "sec_dep":self.txtDeposit.text!,
                "return_amt":self.cancelPercentage.text!,
                "cancel_policy_desc":self.cencelDescriptionEnTxt.text!,
                "sec_dep_desc":self.txtSecurityDepositInfo.text!,
                "ren_tax":self.txtTax.text!,
                "ren_meta_title":self.txtMetaTitle.text!,
                "ren_meta_keyword":self.txtViewKeywords.text!,
                "ren_meta_desc":self.metaDiscription.text!]
                
                
                
                print(params)
                
                
                APIManager.apiPostWithHeaders(serviceName: SAVE_CANCELLATION_LISTING, parameters: params as? [String : Any]) { response, error in
                    DispatchQueue.main.async {
                        self.ListingActivityDelegate?.hideActivity()
                    }

                    if error != nil {
                        self.showInformation(title: "Closest", message: error!.localizedDescription)
                    } else {
                        let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                        Singleton.sharedInstance.rentYourSpace = mod
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let nav = mainStoryboard.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
//                        let nav = mainStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                        self.navigationController?.pushViewController(nav!, animated: true)

                    }
                }
//
//
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
//                manager.post(SAVE_CANCELLATION_LISTING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//                    self.ListingActivityDelegate?.hideActivity()
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//
//                        let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                        Singleton.sharedInstance.rentYourSpace = mod
//
//                        self.showInformation(title: "Closest", message: mod.message)
//
//                        let AppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//                        AppDelegate.RentalLstingCompleted()
////                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
////                      //  self.navigationController?.pushViewController(nav!, animated: true)
////                        self.present(nav!, animated: true, completion: nil)
//                    }
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                },
//                failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
                
                
                
                
                
//                let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.PropertyID)&cancellation_policy=\(self.txtPolicy.text!)&security_deposit=\(self.txtPrice.text!)&meta_title=\(self.txtMetaTitle.text!)&meta_keyword=\(self.txtViewKeywords.text!)&meta_description=\(self.metaDiscription.text!)&lang_code=\(login_session.value(forKey: "APP_LANGUAGE") as! String)&base_id=\(Singleton.sharedInstance.selectedCategory!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&cancel_percentage=\(self.cancelPercentTxt.text!)&cancel_description=\(self.cencelDescriptionEnTxt.text!)"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_CANCELLATION_LISTING, APIKEY: "SAVE_CANCELLATION_LISTING")
//                print(parameterStr)
            } else {
                showInformation(title: "Network Error", message: "Please check your internet connection")
            }
        }
    }
}

extension CancellationPlolicyViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtPolicy {
            self.performSegue(withIdentifier: "SelectCancelPolicy", sender: textField)
            return false
        } else if textField == txtMetaTitle {
            return true
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == txtLang {
               self.dropDown.show()
               self.DropDownTypes()
               textField.resignFirstResponder()
           }
       }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtMetaTitle{
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}

extension CancellationPlolicyViewController: DropDownProtocol {
    func getValueFromDropDown(value: String, Key: Any) {
        policySelected = true
        self.txtPolicy.text = value
        if self.txtPolicy.text == "Strict"
        {
            self.cancelPercentTxt.text = "99"
            self.cancelPercentTxt.isUserInteractionEnabled = false
            self.cancelPercentTxt.isEnabled = false
        }
        else if self.txtPolicy.text == "Moderate"
        {
            self.cancelPercentTxt.text = "50"
            self.cancelPercentTxt.isUserInteractionEnabled = false
            self.cancelPercentTxt.isEnabled = false
        }else{
            self.cancelPercentTxt.text = ""
            self.cancelPercentTxt.isUserInteractionEnabled = true
            self.cancelPercentTxt.isEnabled = true
        }
        
    }
}

extension CancellationPlolicyViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.btnSave.frame.maxY + 300)
        return true
    }
}

extension CancellationPlolicyViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        print(responseDict)
        if APIKEY == "SAVE_CANCELLATION_LISTING" {
            if errorDict.count == 0 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                
                self.showInformation(title: "Closest", message: mod.message)
            } else {
                self.showInformation(title: "Closest", message: errorDict)
            }
            ListingActivityDelegate?.hideActivity()
        }
        else
        {
            
        }
    }
}



