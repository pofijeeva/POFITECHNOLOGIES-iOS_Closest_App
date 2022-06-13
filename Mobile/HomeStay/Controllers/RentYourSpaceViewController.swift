//
//  RentYourSpaceViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 24/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
import AFNetworking
import SideMenu

class RentYourSpaceViewController: BaseViewController  {
    
    //MARK:- Outlets
    @IBOutlet weak var txtPropertyType: UITextField!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var txtRoomType: UITextField!
    //@IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtAccommodates: UITextField!
    @IBOutlet weak var accomView: UIView!
    @IBOutlet weak var RoomView: UIView!
    
    @IBOutlet weak var roomTypeText: UITextView!
    @IBOutlet weak var propertyName: UITextView!
    
    @IBOutlet weak var proptypeImg: UIImageView!
    @IBOutlet weak var roomtypeImg: UIImageView!
    @IBOutlet weak var NextBtn: UIButton!
    
    @IBOutlet weak var VerifyView: UIView!
    @IBOutlet weak var VerifyLbl: UILabel!
    
    @IBOutlet weak var verifyBtn: UIButton!
    
    @IBOutlet weak var roomHeight: NSLayoutConstraint!
    var dropDownArray = NSArray()
    var placesClient: GMSPlacesClient!
    var locationManager = CLLocationManager()
    var CurrentLocation: String?
    var accomdateArray = [String]()
    var propertyArray = [String]()
    var roomArray = [String]()
    var PROP_ARR = NSArray() , CurrencyArr = [Currency]()
    var ROOM_ARR = NSArray()
    var room_ID : String = "",prop_ID : String = ""
    var Restroom_ID : String = "",Restprop_ID : String = ""
    var roomType : String = ""
    var accomodates : String = ""
    var propertyType : String = ""
    var sub_catid : String = ""
    var propertyid : String = ""
    var cusiArr : NSMutableArray = []
    var opeArr : NSMutableArray = []
    var accArr : NSMutableArray = []
    var optnArr = NSArray()
    var optnArray = NSArray()
    var optnNSArray = NSArray()
    
    var idProofVerify : String = ""
    var emailVerify : String = ""
    var phoneVerify : String = ""
    
    //MARK:- LifecycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VerifyView.isHidden = true
        //self.roomtypeImg.setImageColor(color: AppColor)
        //self.proptypeImg.setImageColor(color: AppColor)
        self.NextBtn.backgroundColor = AppColor
        dropDownArray = ["1","2","3","4","5"]
        placesClient = GMSPlacesClient.shared()
        locationManager.requestAlwaysAuthorization()
        self.lblHeader.text = GlobalLanguageDictionary.object(forKey: "key_addListing") as? String ?? ""
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.RentYourSpaceApi()
        self.VerifyLbl.text = GlobalLanguageDictionary.object(forKey: "key_AddlistingInfo") as? String ?? ""
        self.VerifyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.verifyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        self.verifyBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_verifyNow") as? String ?? "", for: .normal)
        self.txtRoomType.placeholder = GlobalLanguageDictionary.object(forKey: "key_roomType") as? String ?? ""
        self.txtPropertyType.placeholder = GlobalLanguageDictionary.object(forKey: "Key_Workspace") as? String ?? ""
        self.roomType = GlobalLanguageDictionary.object(forKey: "key_roomType") as? String ?? ""
        self.propertyType = GlobalLanguageDictionary.object(forKey: "Key_Workspace") as? String ?? ""
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
        //        self.txtCity.font = UIFont(name: RegularFont, size: 14)
        self.txtRoomType.font = UIFont(name: RegularFont, size: 14)
        //        self.txtAccommodates.font = UIFont(name: RegularFont, size: 14)
        self.txtPropertyType.font = UIFont(name: RegularFont, size: 14)
        //self.roomTypeText.font = UIFont(name: RegularFont, size: 14)
        self.propertyName.font = UIFont(name: RegularFont, size: 14)
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            txtRoomType.textAlignment = .left
            // txtAccommodates.textAlignment = .left
        }else{
            txtRoomType.textAlignment = .right
            // txtAccommodates.textAlignment = .right
        }
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            self.getUserInfo()
        }else{
            showSimpleAlert()
        }
        
        
    }
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
            let responseDict:NSDictionary = json ?? [:]
            print(responseDict)
            if (responseDict.value(forKey: "code") as? NSNumber ?? 0) == 200 {
                self.phoneVerify = "\(((responseDict.value(forKey: "data") as? NSDictionary)?.object(forKey: "user_details") as? NSDictionary)?.object(forKey: "phone_verified") as AnyObject)"
                self.emailVerify = "\(((responseDict.value(forKey: "data") as? NSDictionary)?.object(forKey: "user_details") as? NSDictionary)?.object(forKey: "email_id_verified") as AnyObject)"
                self.idProofVerify = "\(((responseDict.value(forKey: "data") as? NSDictionary)?.object(forKey: "user_details") as? NSDictionary)?.object(forKey: "u_idproof_verified_status") as AnyObject)"
                
                if self.phoneVerify == "1" && self.emailVerify == "1" && self.idProofVerify == "1" {
                    
                }else{
                    self.VerifyView.isHidden = false
                }
            }
            else
            {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
            
            
        }
    }
    func showVerifyAlert() {
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_AddlistingInfo") as? String ?? "", preferredStyle: UIAlertController.Style.alert)
        
        //        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as? String ?? "", style: UIAlertAction.Style.default, handler: { _ in
        //            //Cancel Action
        //            self.dismiss(animated: true, completion: nil)
        //        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "key_verifyNow") as? String ?? "",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            let navgt = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileViewController") as? NewProfileViewController
            navgt?.SelectedIndex = "VerifyNow"
            self.navigationController?.pushViewController(navgt!, animated: true)
            
            
            //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func RentYourSpaceApi(){
        if (Reachability()?.isReachable ?? false)
        {
            //            let id = Singleton.sharedInstance.selectedCategory
            
            let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en"
            ]
            //            "currency_code":(login_session.value(forKey: "APP_CURRENCY") ?? "USD"),
            //                         "base_id":"\(id)"
            //
            
            print(parameters)
            APIManager.apiPostWithHeaders(serviceName: REQ_RENT_YOUR_SPACE, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as? NSNumber ?? 0 == 200 {
                    if let property = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "property_type") as? NSArray {
                        if property.count != 0 {
                            self.propertyArray = [String]()
                            self.PROP_ARR = property
                            
                            for i in 0..<property.count{
                                
                                let propertyname = (property.object(at: i) as? NSDictionary)?.object(forKey: "option_name") as? String ?? ""
                                self.propertyArray.append(propertyname)
                                
                            }
                            
                            
                            //                            if let dict = property[0] as? NSDictionary{
                            //                                if let options = dict.value(forKey: "options") as? NSArray{
                            //                                    if options.count != 0 {
                            //                                        self.PROP_ARR = options
                            //                                        for opt in options {
                            //                                            let propertyname = (opt as? NSDictionary)?.value(forKey: "child_name") as? String
                            //                                            self.propertyArray.append(propertyname!)
                            //                                        }
                            //                                    }
                            //                                }
                            //                            }
                        }
                    }
                    
                    if let rooms = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "room_type") as? NSArray {
                        if rooms.count != 0 {
                            self.room_ID = "Value"
                            self.RoomView.isHidden = false
                            //self.roomHeight.constant = 50
                            self.ROOM_ARR = rooms
                            for i in 0..<rooms.count{
                                
                                let propertyname = (rooms.object(at: i) as? NSDictionary)?.object(forKey: "typval_name") as? String ?? ""
                                self.roomArray.append(propertyname)
                                
                            }
                            
                            //                            if let room = rooms[0] as? NSDictionary {
                            //                                self.roomArray = [String]()
                            //                                if let optionsArr = room.value(forKey: "options") as? NSArray {
                            //                                    self.ROOM_ARR = optionsArr
                            //                                    for opt in  optionsArr {
                            //                                        let dict = opt as? NSDictionary
                            //                                        let roomType = dict?.value(forKey: "child_name") as? String
                            //                                        self.roomArray.append(roomType!)
                            //                                    }
                            //                                } else {
                            //                                    self.roomArray = [String]()
                            //                                }
                            //                            }
                        }else{
                            self.RoomView.isHidden = true
                            self.room_ID = "Nill"
                            //self.roomHeight.constant = 0
                        }
                    }
                    
                    if let accomdation = responseDict.value(forKey: "other_attributes") as? NSArray {
                        if accomdation.count != 0 {
                            //self.txtAccommodates.text = ""
                            self.accomdateArray = [String]()
                            for accom in accomdation {
                                let dict = (accom as? NSDictionary)
                                if dict?.value(forKey: "attribute_name") as? String == "accommodates"
                                {
                                    let accomArr = dict?.value(forKey: "attribute_value") as? NSArray
                                    for acomm in accomArr!{
                                        let acom = (acomm as? NSDictionary)!.value(forKey: "attribute_child_value") as? String
                                        self.accomdateArray.append(acom!)
                                    }
                                }
                            }
                        }else{
                            //self.txtAccommodates.text = "Empty"
                            
                        }
                    }
                    
                    if let amenities = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "amen_list") as? NSArray {
                        UserDefaults.standard.set(amenities, forKey: "AmenitiesArray")
                    }
                    
                    if let amenities1 = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "addon_list") as? NSArray {
                        UserDefaults.standard.set(amenities1, forKey: "AddonArray")
                    }
                    ListingAddonsArray.removeAllObjects()
                    ListingAddonsArray.addObjects(from: (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "addon_list") as? NSArray as! [Any])
                    if let amenities = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "listings") as? NSArray {
                        UserDefaults.standard.set(amenities, forKey: "ListingsArray")
                    }
                    
                    self.hideActivityIndicator(uiView: self.view)
                    
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
                
            }}
        else{
            self.showInformation(title: GlobalLanguageDictionary.object(forKey: "key_info") as? String ?? "", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func VerifyNowAct(_ sender: UIButton) {
        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileViewController") as? NewProfileViewController
        navgt?.SelectedIndex = "VerifyNow"
        self.navigationController?.pushViewController(navgt!, animated: true)
        
    }
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton) {
        //        self.navigationController?.popViewController(animated: true)
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
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_areyousureLogin") as? String ?? "", preferredStyle: UIAlertController.Style.alert)
        
        //        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as? String ?? "", style: UIAlertAction.Style.default, handler: { _ in
        //            //Cancel Action
        //            self.dismiss(animated: true, completion: nil)
        //        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_login") as? String ?? "", style: UIAlertAction.Style.default, handler: {(_: UIAlertAction!) in
            let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
            self.navigationController?.pushViewController(navgt!, animated: true)
            
            //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func act_Done(_ sender: UIButton) {
        //|| txtAccommodates.text?.count == 0
        if self.room_ID == ""  || txtPropertyType.text?.count == 0 {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_pleasefillAllDetails") as? String ?? "")
        }else if self.txtAccommodates.text == "Empty" {
            self.showInformation(title: "Info", message: "We dont have any accommdates to list a Rental")
        }
        else {
            if (Reachability()?.isReachable ?? false) {
                self.showActivityIndicator(uiView: self.view)
                print("PropertyName",self.txtPropertyType.text!)
                for val in PROP_ARR{
                    if ((val as? NSDictionary)?.value(forKey: "option_name") as? String) == self.txtPropertyType.text ?? ""
                    {
                        self.prop_ID =  "\(((val as? NSDictionary)?.value(forKey: "option_id") as AnyObject))"
                    }
                }
                
                print("PropertyID",self.prop_ID)
                
                if  self.room_ID == "Nill" {
                    self.room_ID = ""
                }else{
                    
                    
                    for val in ROOM_ARR {
                        if ((val as? NSDictionary)?.value(forKey: "typval_name") as? String) == self.txtRoomType.text ?? ""
                        {
                            self.room_ID = "\(((val as? NSDictionary)?.value(forKey: "type_value_id") as AnyObject))"
                            //  self.propertyid = "\(((val as? NSDictionary)?.value(forKey: "pro_type_id") as AnyObject))"
                        }
                        
                        print("RoomType",self.txtRoomType.text ?? "")
                        // print("propertyid",self.txtRoomType.text!)
                    }
                }
                
                print("RoomID",self.room_ID)
                print("propertyid",self.propertyid)
                
                
                
                //                showActivityIndicator(uiView: self.view)
                //                var params = NSMutableDictionary()
                //                //   params =  ["user_id": userid,"property_type":self.prop_ID,"room_type":self.room_ID,"accommodates":self.txtAccommodates.text!,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":id,"city":self.txtCity.text!]
                //
                //                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","location":self.txtCity.text!,
                //                          "type_list[3]": "",
                //                          "subcat_id":self.prop_ID,
                //                          "room_type":self.room_ID,
                //                          "property_type":self.prop_ID,
                //                          "property_id":""]
                //
                //
                //                print(params)
                //
                //
                //
                //                let manager = AFHTTPSessionManager()
                //                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                //
                //                manager.post(REQ_RENT_YOUR_SPACE_STEP1, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                //                    DispatchQueue.main.async {
                //
                //                    }
                //
                //                    let responseDict:NSDictionary = responseObject as! NSDictionary
                //                    print(responseDict)
                //                    self.hideActivityIndicator(uiView: self.view)
                //                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                //                        let result = responseDict.object(forKey: "result") as! NSArray
                //                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as! ListingViewControllersBundle
                //                        Singleton.sharedInstance.rentYourSpace = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                //                        checkedIDArray.removeAllObjects()
                //                        AddonscheckedIDArray.removeAllObjects()
                //
                //                        UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                //
                //                        commonMaintainListDataDict.removeAllObjects()
                //                        commonMaintainListDataDict.addEntries(from: responseDict as! [AnyHashable : Any])
                //                        print("commonMaintainListDataDict count:::",commonMaintainListDataDict.count)
                //
                //                        forAddPhotoDict.removeAllObjects()
                //                        forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                //                        print("forAddPhotoDict:::::",forAddPhotoDict)
                //
                //                        self.navigationController?.pushViewController(vc, animated: true)
                //                        self.hideActivityIndicator(uiView: self.view)
                //                    }
                //
                //                    else {
                //                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                //                    }
                //                }, failure: { (operation, error) -> Void in
                //                    DispatchQueue.main.async {
                //
                //                    }
                //                    print(error)
                //                    self.showInformation(title: "Closest", mesAsage: error.localizedDescription)
                //                })
                //
                //
                var params = NSMutableDictionary()
                
                
                //                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","location":self.txtCity.text!,
                //                          "type_list[3]": "",
                //                          "subcat_id":self.prop_ID,
                //                          "room_type":self.room_ID,
                //                          "property_type":self.prop_ID,
                //                          "property_id":""]
                
                //   params =  ["user_id": userid,"property_type":self.prop_ID,"room_type":self.room_ID,"accommodates":self.txtAccommodates.text!,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":id,"city":self.txtCity.text!]
                
                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                          "location": "",
                          "room_type":self.room_ID ,
                          "property_type":self.prop_ID,
                          "property_id": ""]
                //                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                //                                          "location":self.txtCity.text!,
                //                                          "room_type":self.room_ID ,
                //                                          "property_type":self.prop_ID,
                //                                          "property_id": ""]
                
                //                "type_list[5]":self.room_ID,
                //                "subcat_id":self.sub_catid ,
                
                print(params)
                
                
                
                APIManager.apiPostWithHeaders(serviceName: REQ_RENT_YOUR_SPACE_STEP1, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if (responseDict.value(forKey: "code") as? NSNumber ?? 0) == 200 {
                        //                        let result = responseDict.object(forKey: "result") as! NSArray
                        let result = ((responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "step1") as? NSDictionary)
                        //                        let step1 = result.value(forKey: "step1")
                        
                        
                        //  ((responseDict.value(forKey: "data") as? NSDictionary)?.value(forKey: "user_details") as? NSDictionary)
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as! ListingViewControllersBundle
                        Singleton.sharedInstance.rentYourSpace = RentYourSpaceModel(fromDictionary: responseDict as? [String : Any] ?? [:])
                        checkedIDArray.removeAllObjects()
                        AddonscheckedIDArray.removeAllObjects()
                        
                        //                        UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                        
                        commonMaintainListDataDict.removeAllObjects()
                        commonMaintainListDataDict.addEntries(from: responseDict as? [AnyHashable : Any] ?? [:])
                        print("commonMaintainListDataDict count:::",commonMaintainListDataDict.count)
                        
                        forAddPhotoDict.removeAllObjects()
                        forAddPhotoDict.addEntries(from: result as? [AnyHashable : Any] ?? [:])
                        print("forAddPhotoDict:::::",forAddPhotoDict)
                        self.propertyid = "\(forAddPhotoDict.object(forKey: "propertyid") as AnyObject)"
                        //  vc.PropertyId = Int(self.propertyid)!
                        self.navigationController?.pushViewController(vc, animated: true)
                        self.hideActivityIndicator(uiView: self.view)
                        
                    }
                    else
                    {
                        
                        self.hideActivityIndicator(uiView: self.view)
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        
                    }
                    
                }
                
            }
            else {
                self.showInformation(title: GlobalLanguageDictionary.object(forKey: "key_info") as? String ?? "", message: "Please connect to internet")
            }
        }
    }
    
    func showSearch()
    {
        isFromHomePage_Search = false
        isFromRentYourSpace_search = true
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchLoctaionDelegate = self
        self.navigationController?.pushViewController(searchVC!, animated: true)
        // self.present(searchVC!, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let id = Singleton.sharedInstance.selectedCategory
        
        if segue.identifier == "RentPopOver" {
            let popViewController:PopViewController = segue.destination as! PopViewController
            popViewController.popOverDelegate = self
            switch (sender as! UITextField)
            {
            case self.txtRoomType:
                popViewController.key = self.txtRoomType
                popViewController.headerTxt = roomType
                popViewController.dropDownArray = (self.roomArray as NSArray)
            case self.txtAccommodates:
                popViewController.key = self.txtAccommodates
                popViewController.headerTxt = accomodates
                popViewController.dropDownArray = (self.accomdateArray as NSArray)
            case self.txtPropertyType:
                popViewController.key = self.txtPropertyType
                popViewController.headerTxt = propertyType
                popViewController.dropDownArray = (self.propertyArray as NSArray)
            default:
                break
            }
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("Dissmiss")
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        print("present")
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension RentYourSpaceViewController: LoctaionSearchProtocol {
    func showPlaceList(searchResult: String) {
        
    }
    
    func getLocationFromCoordinates(lat: String, long: String) {
        
    }
    
    func getLocation(SearchResult: String) {
        //self.txtCity.text = SearchResult
    }
}

extension RentYourSpaceViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.txtRoomType {
            self.txtRoomType.text = " "
            self.performSegue(withIdentifier: "RentPopOver", sender: textField)
        }
        else if textField == txtPropertyType {
            self.txtPropertyType.text = " "
            self.performSegue(withIdentifier: "RentPopOver", sender: textField)
        }else if textField == self.txtAccommodates
        {
            
            self.performSegue(withIdentifier: "RentPopOver", sender: textField)
        }
        else {
            self.showSearch()
        }
        return false
    }
}

extension RentYourSpaceViewController :  HTTP_POST_STRING_REQUEST_PROTOCOL{
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if responseDict.count != 0 {
            if APIKEY == "SAVE_RENTYOURSPACE"
            {
                print("responseDict",responseDict)
                let result = responseDict.object(forKey: "result") as! NSArray
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as! ListingViewControllersBundle
                Singleton.sharedInstance.rentYourSpace = RentYourSpaceModel(fromDictionary: responseDict as? [String : Any] ?? [:])
                checkedIDArray.removeAllObjects()
                AddonscheckedIDArray.removeAllObjects()
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                
                commonMaintainListDataDict.removeAllObjects()
                commonMaintainListDataDict.addEntries(from: responseDict as? [AnyHashable : Any] ?? [:])
                print("commonMaintainListDataDict count:::",commonMaintainListDataDict.count)
                
                forAddPhotoDict.removeAllObjects()
                forAddPhotoDict.addEntries(from: result[0] as? [AnyHashable : Any] ?? [:])
                print("forAddPhotoDict:::::",forAddPhotoDict)
                
                self.navigationController?.pushViewController(vc, animated: true)
                self.hideActivityIndicator(uiView: self.view)
            }
            else if APIKEY == "RENTYOURSPACE" {
                if let property = responseDict.value(forKey: "property") as? NSArray {
                    if property.count != 0 {
                        self.propertyArray = [String]()
                        if let dict = property[0] as? NSDictionary{
                            if let options = dict.value(forKey: "options") as? NSArray{
                                if options.count != 0 {
                                    PROP_ARR = options
                                    for opt in options {
                                        let propertyname = (opt as? NSDictionary)?.value(forKey: "child_name") as? String ?? ""
                                        self.propertyArray.append(propertyname)
                                    }
                                }
                            }
                        }
                    }
                }
                
                if let rooms = responseDict.value(forKey: "rooms") as? NSArray {
                    if rooms.count != 0 {
                        self.room_ID = "Value"
                        self.RoomView.isHidden = false
                        //self.roomHeight.constant = 50
                        if let room = rooms[0] as? NSDictionary {
                            self.roomArray = [String]()
                            if let optionsArr = room.value(forKey: "options") as? NSArray {
                                ROOM_ARR = optionsArr
                                for opt in  optionsArr {
                                    let dict = opt as? NSDictionary
                                    let roomType = dict?.value(forKey: "child_name") as? String ?? ""
                                    self.roomArray.append(roomType)
                                }
                            } else {
                                self.roomArray = [String]()
                            }
                        }
                    }else{
                        self.RoomView.isHidden = true
                        self.room_ID = "Nill"
                        //self.roomHeight.constant = 0
                    }
                }
                
                if let accomdation = responseDict.value(forKey: "other_attributes") as? NSArray {
                    if accomdation.count != 0 {
                        self.txtAccommodates.text = ""
                        self.accomdateArray = [String]()
                        for accom in accomdation {
                            let dict = (accom as? NSDictionary)
                            if (dict?.value(forKey: "attribute_name") as? String ?? "") == "accommodates" {
                                let accomArr = dict?.value(forKey: "attribute_value") as? NSArray ?? []
                                for acomm in accomArr{
                                    let acom = (acomm as? NSDictionary)?.value(forKey: "attribute_child_value") as? String ?? ""
                                    self.accomdateArray.append(acom)
                                }
                            }
                        }
                    }else{
                        self.txtAccommodates.text = "Empty"
                    }
                }
                self.hideActivityIndicator(uiView: self.view)
            }
        }
    }
}

extension RentYourSpaceViewController : DropDownProtocol {
    func getValueFromDropDown(value: String, Key: Any) {
        switch (Key as! UITextField ) {
        case self.txtRoomType:
            //self.txtRoomType.text = value
            self.txtRoomType.text = value
            //            self.txtRoomType.placeholder = ""
            print(self.txtRoomType.text as Any)
        case self.txtAccommodates:
            self.txtAccommodates.text = value
            print(self.txtAccommodates.text as Any)
        case self.txtPropertyType:
            // self.txtPropertyType.text = value
            //            self.txtPropertyType.placeholder = ""
            self.txtPropertyType.text = value
            print(self.txtPropertyType.text ?? "")
        default:
            break
        }
    }
}
