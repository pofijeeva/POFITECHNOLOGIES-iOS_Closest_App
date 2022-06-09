//
//  PriceViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 02/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class PriceViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var txtCurrency: UITextField!
    @IBOutlet weak var lblCurrencySymbol: UILabel!
    @IBOutlet weak var txtPtice: UITextField!
    @IBOutlet weak var basePrice: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var selPriceperNight: UILabel!
    @IBOutlet weak var currency: UILabel!
    //MARK:- Variables
    var ListingActivityDelegate: listingActivityProtocol!
    var dropDownDelegate: DropDownProtocol!
    var dropDownCurrencyArray = [String]()
    var propertyID = Int()
    var currencyArr = [Currency]()
    var priceChange = false
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.txtCurrency.text = Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode
        if Singleton.sharedInstance.rentYourSpace.result[0].step3.price != nil {
            self.txtPtice.text = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.price)
        }
        
        currencyArr = Singleton.sharedInstance.rentYourSpace.currency
        for num in 0..<Singleton.sharedInstance.rentYourSpace.currency.count {
            dropDownCurrencyArray.append(Singleton.sharedInstance.rentYourSpace.currency[num].currencyType)
        }
        for num in 0..<currencyArr.count{
            if currencyArr[num].currencyType == Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode {
                self.lblCurrencySymbol.text = currencyArr[num].countrySymbols
                if priceChange == false {
                    Singleton.sharedInstance.listingCurrencySymb = currencyArr[num].countrySymbols
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.basePrice.font = UIFont(name: SemiBoldFont, size: 17)
         self.currency.font = UIFont(name: RegularFont, size: 15)
         self.txtPtice.font = UIFont(name: RegularFont, size: 15)
        self.txtCurrency.font = UIFont(name: RegularFont, size: 15)
        self.selPriceperNight.font = UIFont(name: RegularFont, size: 15)
        self.saveButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
               self.saveButton.backgroundColor = AppSecondColor
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.basePrice.text = LocalizeHelper().localizedStringForKey("baseprice")
            self.currency.text = LocalizeHelper().localizedStringForKey("currency")
            self.selPriceperNight.text = LocalizeHelper().localizedStringForKey("pernight")
            self.txtPtice.placeholder = LocalizeHelper().localizedStringForKey("price")
            self.saveButton.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PriceVCPopup" {
            let popViewController:PopViewController = segue.destination as! PopViewController
            popViewController.popOverDelegate = self
            switch (sender as! UITextField)
            {
            case self.txtCurrency:
                popViewController.key = self.txtCurrency
                popViewController.headerTxt = "Currency"
                popViewController.dropDownArray = dropDownCurrencyArray as NSArray
            default:
                break
            }
        }
    }
    
    @IBAction func act_Save(_ sender: UIButton) {
        if Reachability()!.isReachable {
            if self.txtPtice.text == ""
            {
                self.showInformation(title: "Closest", message: "Please enter price")

            }else if self.txtCurrency.text == ""
            {
                self.showInformation(title: "Closest", message: "Please select currency")
            }
            else
            {
            ListingActivityDelegate.showActivity()
                
                
                
                
//                var params = NSMutableDictionary()
                
//                 params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":Singleton.sharedInstance.rentYourSpace.propertyid!,"currency_code":self.txtCurrency.text!,"price":self.txtPtice.text!,"chk":"","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":Singleton.sharedInstance.selectedCategory!]
                
                var params = NSMutableDictionary()
                
//                params = ["currency_type":self.txtCurrency.text!,
//                                          "price_list":self.txtCity.text!,
//                                          "weekly_price_list":self.room_ID ,
//                                          "monthly_price_list":self.prop_ID,
//                                          "yearly_price_list":self.propertyid,
//                                          "weekly_price_status": 1,
//                                          "monthly_price_status":1,
//                                          "yearly_price_status":1]
//
//
//
//                let manager = AFHTTPSessionManager()
//                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
//                manager.post(SAVE_PRICE_LISTING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
//                    self.ListingActivityDelegate.hideActivity()
//                    let responseDict:NSDictionary = responseObject as! NSDictionary
//                    print(responseDict)
//
//                    if responseDict.value(forKey: "status") as! Int == 1 {
//
//                        let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                        Singleton.sharedInstance.rentYourSpace = mod
//                        self.txtCurrency.text = Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode
//                        self.txtPtice.text = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.price)
//                        self.showInformation(title: "Closest", message: mod.message)
//                    }
//
//                    else {
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                    }
//                }, failure: { (operation, error) -> Void in
//                    DispatchQueue.main.async {
//
//                    }
//                    print(error)
//                    self.showInformation(title: "Closest", message: error.localizedDescription)
//                })
                APIManager.apiPostWithHeaders(serviceName: SAVE_PRICE_LISTING, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error!.localizedDescription)
                        self.showInformation(title: "Closest", message: error!.localizedDescription)
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
//                        let result = responseDict.object(forKey: "result") as! NSArray
                        let result = ((responseDict.object(forKey: "data") as! NSDictionary).value(forKey: "step2") as? NSDictionary)

                        
                        
                        //                        let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                        //                        Singleton.sharedInstance.rentYourSpace = mod
                        //                        self.txtCurrency.text = Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode
                        //                        self.txtPtice.text = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.price)
                        //                        self.showInformation(title: "Closest", message: mod.message)
                     
                        
                        

                        

                  //      self.navigationController?.pushViewController(vc, animated: true)
                       
                        
                    
                
                
                
                
                
                
                
                
//            let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.rentYourSpace.propertyid!)&currency_code=\(self.txtCurrency.text!)&price=\(self.txtPtice.text!)&chk=&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(Singleton.sharedInstance.selectedCategory!)"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_PRICE_LISTING, APIKEY: "SAVE_PRICE_LISTING")
//            print(parameterStr)
          }
        }
            }
        }
        else
        {
            self.showInformation(title: "Closest", message: "Please check your internet connection")
            
        }
            
    }
}

extension PriceViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtCurrency {
            self.performSegue(withIdentifier: "PriceVCPopup", sender: textField)
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtPtice {
            self.txtPtice.resignFirstResponder()
        }
        return true
    }
}

extension PriceViewController: DropDownProtocol{
    func getValueFromDropDown(value: String, Key: Any) {
        
        
        for num in 0..<currencyArr.count {
            if currencyArr[num].currencyType == value {
                self.txtCurrency.text = value
                self.lblCurrencySymbol.text = currencyArr[num].countrySymbols
                priceChange = true
                Singleton.sharedInstance.listingCurrencySymb = currencyArr[num].countrySymbols
            }
        }
    }
}

extension PriceViewController : HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        
        if APIKEY == "SAVE_PRICE_LISTING"
        {
            if errorDict.count == 0 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                self.txtCurrency.text = Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode
                self.txtPtice.text = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.price)
                self.showInformation(title: "Closest", message: mod.message)
            }
            
        }
        ListingActivityDelegate.hideActivity()
    }
}
