//
//  ExperienceAddPriceViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown


class ExperienceAddPriceViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var CurrencyTxt: UITextField!
    @IBOutlet weak var PriceTxt: UITextField!
    
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var SelectCurrencyLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var CuyyencySymLbl: UILabel!
    @IBOutlet weak var NextBtn: UIButton!
    
    let currencyDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.currencyDropdown
            ]
    }()
    
    var ListingActivityDelegate: listingActivityProtocol!
    var currncyNamearray = [String]()
    var currencyDetails = [String:AnyObject]()
    var arrayCurrencySymbol : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SelectCurrencyLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.SelectCurrencyLbl.textColor = .darkGray
        self.CuyyencySymLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.CuyyencySymLbl.textColor = .black
        self.CuyyencySymLbl.layer.cornerRadius = 5
        self.DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.PriceLbl.font = UIFont(name: RegularFont, size: 15.0)
        self.DescLbl.textColor = .darkGray
        self.PriceLbl.textColor = .darkGray
        self.NextBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.NextBtn.layer.cornerRadius = 5
        self.CurrencyTxt.delegate = self
        Helper.sharedInstance.UpdateTextfield(self.CurrencyTxt)
        Helper.sharedInstance.UpdateTextfield(self.PriceTxt)

//        for item in arrayOfCurrency {
//            self.currncyNamearray.append(item["currency_type"] as? String ?? "")
//        }
        
        
        for i in 0..<arrayOfCurrency.count {
            let name = (arrayOfCurrency.object(at: i) as? NSDictionary)?.object(forKey: "currency_type") as? String ?? ""
            let symbol = (arrayOfCurrency.object(at: i) as? NSDictionary)?.object(forKey: "country_symbols") as? String ?? ""
            self.arrayCurrencySymbol.add(symbol)
            self.currncyNamearray.append(name)
        }
        
//        arrayOfCurrency.forEach { (dict) in
//            self.currncyNamearray.append(dict["currency_type"] as? String ?? "")
//            self.arrayCurrencySymbol.append(dict["country_symbols"] as? String ?? "")
//            self.arrayCurrencySymbol.addObjects(from: arrayOfCurrency.objects(at: dict))
//
//
//            let index =  self.currncyNamearray.index(of: self.CurrencyTxt.text!)
//            CuyyencySymLbl.text = self.arrayCurrencySymbol.fi
//        }
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        

        if arrayOfResult.count > 0 {
            let PreviousCurrency = ((arrayOfResult[0] as? NSDictionary)?.object(forKey: "price") as? NSDictionary)?.object(forKey: "currency_code") as? String ?? ""
            if PreviousCurrency == "" {
                
            }else{
                self.CurrencyTxt.text = ((arrayOfResult[0] as? NSDictionary)?.object(forKey: "price") as? NSDictionary)?.object(forKey: "currency_code") as? String ?? ""
                self.PriceTxt.text =  "\(((arrayOfResult[0] as? NSDictionary)?.object(forKey: "price") as? NSDictionary)?.object(forKey: "price") as! AnyObject)"
                let index =  self.currncyNamearray.index(of: self.CurrencyTxt.text!)
                self.CuyyencySymLbl.text = self.arrayCurrencySymbol.object(at: index!) as? String
                ExperiencySelectedCurrency = self.arrayCurrencySymbol.object(at: index!) as? String ?? ""
            }
            
            
           
            
            if self.currncyNamearray.count > 0 {
                
            }
            
        }
        
        
    }
    
    @IBAction func act_AddPrice(_ sender: UIButton) {
       // if currencyDetails.count > 0 {
            if self.CurrencyTxt.text! == "" {
                self.showInformation(title: "Closest", message: "Select CurrencyCode")
            }else if self.PriceTxt.text! == "" {
                self.showInformation(title: "Closest", message: "Enter Price")
            }
            else{
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","price":self.PriceTxt.text!,"device_type":"ios","currency" : self.CurrencyTxt.text!]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                manager.post(ExperienceAddPrice, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                    }
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        //let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                        //   Singleton.sharedInstance.rentYourSpace = mod
                      //  self.showInformation(title: "Closest", message: mod.message)
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepSeventeen()
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
            }
       // }
//        else {
//            self.showInformation(title: "Closest", message: "Please select currency")
//        }
    }


    func dropDownForTextField() {
        let hours = currncyNamearray
        currencyDropdown.anchorView = self.CurrencyTxt
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.CurrencyTxt?.bounds.height)!)
        currencyDropdown.dataSource = hours
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.currencyDetails = arrayOfCurrency.object(at: index) as! [String : AnyObject]
            self.CurrencyTxt.text = item
            self.CuyyencySymLbl.text = self.currencyDetails["country_symbols"] as? String ?? ""
            ExperiencySelectedCurrency = self.currencyDetails["country_symbols"] as? String ?? ""
          }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.CurrencyTxt {
            self.CurrencyTxt.resignFirstResponder()
            self.dropDownForTextField()
            currencyDropdown.show()
            return false
        }
        return true
    }
}
