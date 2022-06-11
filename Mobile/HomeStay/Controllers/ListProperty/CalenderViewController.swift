//
//  CalenderViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 31/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import MIBlurPopup
import AFNetworking

class CalenderViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblSeasonalPricing: UILabel!
    @IBOutlet weak var lblSomeTimes: UILabel!
    @IBOutlet weak var lblFixedPriceForAll: UILabel!
    @IBOutlet weak var lblAlways: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgSometimes: UIImageView!
    @IBOutlet weak var imgAlways: UIImageView!
    @IBOutlet weak var btnSomeTimes: UIButton!
    @IBOutlet weak var btnAlways: UIButton!
    @IBOutlet weak var priceTypeLabel: UILabel!
    @IBOutlet weak var manageCalendarBtn: UIButton!
    @IBOutlet weak var backScrollView: UIScrollView!
    
    //MARK:- Variables
    var rentYourSpace: RentYourSpaceModel!
    var PropertyID : Int = 0
    var DateFrom : String = ""
    var DateTo : String = ""
    var calenderChecked : String = ""
    var ListingActivityDelegate: listingActivityProtocol!
    var calenderDelegate: CalenderProtocol!
    
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSomeTimes.layer.cornerRadius = 50.0
        self.btnAlways.layer.cornerRadius = 50.0
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if UserDefaults.standard.value(forKey: "Listed") != nil {
            if UserDefaults.standard.value(forKey: "Listed") as? String ?? "" == "YES" {
                manageCalendarBtn.isHidden = false
            }
            else {
                manageCalendarBtn.isHidden = true
            }
        }
        else {
            manageCalendarBtn.isHidden = true
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.priceTypeLabel.font = UIFont(name: SemiBoldFont, size: 17)
         self.lblAlways.font = UIFont(name: SemiBoldFont, size: 16)
         self.lblFixedPriceForAll.font = UIFont(name: RegularFont, size: 14)
          self.lblSomeTimes.font = UIFont(name: SemiBoldFont, size: 16)
         self.lblSeasonalPricing.font = UIFont(name: RegularFont, size: 14)
         self.manageCalendarBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
        self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.btnSave.backgroundColor = AppSecondColor
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.priceTypeLabel.text = LocalizeHelper().localizedStringForKey("whenlistingavailable")
            self.lblAlways.text = LocalizeHelper().localizedStringForKey("always")
            self.lblSomeTimes.text = LocalizeHelper().localizedStringForKey("sometimes")
            self.lblSeasonalPricing.text = LocalizeHelper().localizedStringForKey("listsomedatesavailable")
            self.lblFixedPriceForAll.text = LocalizeHelper().localizedStringForKey("listdatesavailable")
            self.btnSave.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
        }
        
        self.DateFrom = Singleton.sharedInstance.rentYourSpace.result[0].step2.datefrom
        self.DateTo = Singleton.sharedInstance.rentYourSpace.result[0].step2.dateto
        self.calenderChecked = Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked
        if Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked == "always" {
            self.act_Always(self.btnAlways)
        } else {
            self.act_Sometimes(self.btnSomeTimes)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func act_Save(_ sender: UIButton) {
        if Reachability()!.isReachable {
            ListingActivityDelegate.showActivity()
            
            
           
            
            
            var params = NSMutableDictionary()
            
            params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","prop_status":"","check_in":"","check_out":"","price":"","property_id":Singleton.sharedInstance.rentYourSpace.propertyid]
            
//
//
//            params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":Singleton.sharedInstance.rentYourSpace.propertyid,"datefrom":DateFrom,"dateto":DateTo,"calendar_checked":calenderChecked,"base_id":Singleton.sharedInstance.selectedCategory,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
            
//            "lang_code":"en",
//            "property_id":"41884",
//            "price_list":"2,"
//            "weekly_price_list":"5",
//            "monthly_price_list":"10",
//            "yearly_price_list":"20",
//            "weekly_price_status":"1",
//            "monthly_price_status":"1",
//            "yearly_price_status":"1"
            
//            APIManager.apiPostWithHeaders(serviceName: SAVE_CALENDER_LISTING, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
//                DispatchQueue.main.async {  }
//                if error != nil {
//                    print(error?.localizedDescription ?? "")
//                    self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
//                    return
//                }
//                let responseDict:NSDictionary = json!
//                print(responseDict)
//                if responseDict.value(forKey: "code") as! NSNumber == 200 {
////                        let result = responseDict.object(forKey: "result") as! NSArray
//                    let result = ((responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "step3") as? NSDictionary)
////                        let step1 = result.value(forKey: "step1")
//
//
//
//
//
//
//
//                }
            
            
            
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(SAVE_CALENDER_LISTING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {

                }
                self.ListingActivityDelegate.hideActivity()
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
               if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                Singleton.sharedInstance.rentYourSpace = mod
                self.PropertyID = mod.propertyid
                self.DateFrom = Singleton.sharedInstance.rentYourSpace.result[0].step2.datefrom
                self.DateTo = Singleton.sharedInstance.rentYourSpace.result[0].step2.dateto
                self.calenderChecked = Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked
                if Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked == "always" {
                    self.act_Always(self.btnAlways)
                } else {
                    self.act_Sometimes(self.btnSomeTimes)
                }
               // self.showInformation(title: "Closest", message: mod.message)
                sharedInstanceListing.gotoStepThree()
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
            
            
            
            

        }else {
            showInformation(title: "Network Error", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
    }
    
    @IBAction func act_Sometimes(_ sender: UIButton) {
        calenderChecked = "sometimes"
        self.imgSometimes.image = UIImage(named: "calWhite")
        self.imgAlways.image = UIImage(named:"calBlack")
        //calenderDelegate.showCalender()
        //manageCalendarBtn.isHidden = false
        if UserDefaults.standard.value(forKey: "Listed") != nil {
            if UserDefaults.standard.value(forKey: "Listed") as? String ?? "" == "YES" {
                manageCalendarBtn.isHidden = false
            }
            else {
                manageCalendarBtn.isHidden = true
            }
        }
        else {
            manageCalendarBtn.isHidden = true
        }
    }
    
    @IBAction func act_Always(_ sender: UIButton) {
        calenderChecked = "always"
        self.imgSometimes.image = UIImage(named:"calBlack")
        self.imgAlways.image = UIImage(named: "calWhite")
        manageCalendarBtn.isHidden = true
    }
    
    @IBAction func manageCalendarBtnTapped(_ sender: UIButton) {
        
//        let bpStoryboard = UIStoryboard(name: "BasicPrice", bundle: nil)
//        let childViewController = bpStoryboard.instantiateInitialViewController() as? BasicPriceViewController
        let kpStoryboard = UIStoryboard(name: "PopCalender", bundle: nil)
        let PopMapVC = kpStoryboard.instantiateViewController(withIdentifier: "PopCalendarViewController") as? PopCalendarViewController
        PopMapVC?.modalPresentationStyle = .overFullScreen
        PopMapVC?.modalTransitionStyle = .crossDissolve
        //self.present(PopMapVC!, animated: true, completion: nil)
        MIBlurPopup.show(PopMapVC!, on: self);
    }
    
}

extension CalenderViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        ListingActivityDelegate.hideActivity()
        if APIKEY == "SAVE_CALENDER_LISTING" {
            if errorDict.count == 0 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                Singleton.sharedInstance.rentYourSpace = mod
                self.PropertyID = mod.propertyid
                self.DateFrom = Singleton.sharedInstance.rentYourSpace.result[0].step2.datefrom
                self.DateTo = Singleton.sharedInstance.rentYourSpace.result[0].step2.dateto
                self.calenderChecked = Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked
                if Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked == "always" {
                    self.act_Always(self.btnAlways)
                } else {
                    self.act_Sometimes(self.btnSomeTimes)
                }
                showInformation(title: "Closest", message: mod.message)
            }
        }
    }
}
