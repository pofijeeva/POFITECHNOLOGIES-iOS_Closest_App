//
//  AddressViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CoreLocation
import AFNetworking

class AddressViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblAddressHeader: UILabel!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtStreett: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var lblDisc: UILabel!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var conTopSpace: NSLayoutConstraint!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var changeLocation: UILabel!
    
    @IBOutlet weak var txtFlat: UITextField!

    
    //MARK:- Variables
    var loctaionManager = CLLocationManager()
    var ListingActivityDelegate: listingActivityProtocol?
    var PropertyID = Int()
    var AddressLocation = String()
    var Lat = String()
    var Lng = String()
    
    //MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.lblDisc.isHidden = true
        self.txtFlat.isHidden = true

        self.txtStreett.isHidden = true
        self.txtCity.isHidden = true
        self.txtState.isHidden = true
        self.txtCountry.isHidden = true
        self.txtZipcode.isHidden = true
        setData()
        
        
        self.txtStreet.layer.borderWidth = 1
        self.txtStreet.layer.borderColor = BorderColor.cgColor
        self.txtCity.layer.borderWidth = 1
        self.txtCity.layer.borderColor = BorderColor.cgColor
        self.txtStreet.layer.borderWidth = 1
        self.txtStreett.layer.borderColor = BorderColor.cgColor
        self.txtState.layer.borderWidth = 1
        self.txtState.layer.borderColor = BorderColor.cgColor
        self.txtCountry.layer.borderWidth = 1
        self.txtCountry.layer.borderColor = BorderColor.cgColor
        self.txtZipcode.layer.borderWidth = 1
        self.txtZipcode.layer.borderColor = BorderColor.cgColor
        
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
   //     self.btnLocation.layer.cornerRadius = self.btnLocation.frame.width / 2
        self.btnView.layer.cornerRadius = self.btnView.frame.width / 2
//        self.PropertyID = Singleton.sharedInstance.rentYourSpace.result[0].step8.propertyid
        
//        if Singleton.sharedInstance.rentYourSpace.result[0].step2 != nil {
//                   self.txtStreet.text =  Singleton.sharedInstance.rentYourSpace.result[0].step8.street ?? ""
//                   self.txtCity.text =  Singleton.sharedInstance.rentYourSpace.result[0].step8.city
//                   self.txtState.text =  Singleton.sharedInstance.rentYourSpace.result[0].step8.state
//                   self.txtCountry.text =  Singleton.sharedInstance.rentYourSpace.result[0].step8.country
//                   self.txtZipcode.text =  Singleton.sharedInstance.rentYourSpace.result[0].step8.zip
//               }
    }
    func setData()
    {
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step8 = result.step8 {
            self.txtStreet.text = step8.address
            self.txtCity.text = step8.city
            self.txtStreett.text = step8.street_address
            self.txtState.text = step8.state
            self.txtZipcode.text = step8.country
            self.txtCountry.text = step8.zip_code
//            self.lblDisc.isHidden = false
//            self.txtStreett.isHidden = false
//            self.txtCity.isHidden = false
//            self.txtState.isHidden = false
//            self.txtCountry.isHidden = false
//            self.txtZipcode.isHidden = false
//            self.txtFlat.isHidden = false
//            self.btnLocation.textInputMode = step8.address
        }
        
    }
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
      //  self.conTopSpace.constant = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.lblAddressHeader.text = GlobalLanguageDictionary.object(forKey: "key_selectAddress") as! String
        self.txtStreet.placeholder = GlobalLanguageDictionary.object(forKey: "key_street") as! String
        self.lblDisc.text = GlobalLanguageDictionary.object(forKey: "key_addressDesc") as! String
        self.txtStreett.placeholder = GlobalLanguageDictionary.object(forKey: "key_street") as! String
        self.txtCity.placeholder = GlobalLanguageDictionary.object(forKey: "key_city") as! String
        self.txtState.placeholder = GlobalLanguageDictionary.object(forKey: "key_state") as! String
        self.txtCountry.placeholder = GlobalLanguageDictionary.object(forKey: "key_country") as! String
        self.txtZipcode.placeholder = GlobalLanguageDictionary.object(forKey: "key_zipcode") as! String
        self.btnSave.setTitle(GlobalLanguageDictionary.object(forKey: "key_next") as! String, for: .normal)
        self.txtFlat.placeholder = GlobalLanguageDictionary.object(forKey: "key_flatPlaceholder") as! String

        
        self.lblAddressHeader.font = UIFont(name: SemiBoldFont, size: 17)
         self.lblDisc.font = UIFont(name: RegularFont, size: 14)
        self.changeLocation.font = UIFont(name: RegularFont, size: 13)
      //  self.btnLocation.backgroundColor = AppSecondColor
         self.btnSave.backgroundColor = AppColor
          self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        
        self.txtStreet.font = UIFont(name: RegularFont, size: 15)
                   self.txtCity.font = UIFont(name: RegularFont, size: 15)
                   self.txtState.font = UIFont(name: RegularFont, size: 15)
                   self.txtStreett.font = UIFont(name: RegularFont, size: 15)
                   self.txtCountry.font = UIFont(name: RegularFont, size: 15)
                   self.txtZipcode.font = UIFont(name: RegularFont, size: 15)
        
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.lblAddressHeader.text = LocalizeHelper().localizedStringForKey("addressHead")
            self.lblDisc.text = LocalizeHelper().localizedStringForKey("addresscnt")
            self.changeLocation.text = LocalizeHelper().localizedStringForKey("changelocation")
            self.btnSave.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
            self.txtStreet.placeholder = LocalizeHelper().localizedStringForKey("street")
            self.txtCity.placeholder = LocalizeHelper().localizedStringForKey("city")
            self.txtStreett.placeholder = LocalizeHelper().localizedStringForKey("streetaddress")
            self.txtState.placeholder = LocalizeHelper().localizedStringForKey("state")
            self.txtCountry.placeholder = LocalizeHelper().localizedStringForKey("country")
            self.txtZipcode.placeholder = LocalizeHelper().localizedStringForKey("zipcode")
        }
        print("Address: for",Lat)
         print("Address: For",Lng)
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    @IBAction func act_Save(_ sender: UIButton) {
        if txtStreet.text == nil {
            self.showInformation(title: "Closest", message: "Please enter the street name")
        } else if (txtStreet.text?.count)! < 5 {
            self.showInformation(title: "Closest", message: "Please enter the valid street name")
        } else if txtCity.text == nil {
            self.showInformation(title: "Closest", message: "Please enter the city name")
        } else if txtCity.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the valid city name")
        } else if txtState.text == nil {
            self.showInformation(title: "Closest", message: "Please enter the state name")
        } else if txtState.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the valid state name")
        } else if txtCountry.text  == nil {
            self.showInformation(title: "Closest", message: "Please enter the country name")
        } else if txtCountry.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the valid country name")
        } else if txtZipcode.text == nil {
            self.showInformation(title: "Closest", message: "Please enter the zip code")
        } else if txtZipcode.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter the valid zip code")
        } else {
            ListingActivityDelegate?.showActivity()
            
            if Reachability()!.isReachable {
                
                var params = NSMutableDictionary()
             

                params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                              "location":self.AddressLocation,
                              "country":self.txtStreet.text!,
                              "state":self.txtState.text!,
                              "city":self.txtCity.text!,
                               "zip_code":self.txtZipcode.text!,
                                 "property_id": self.PropertyID,
                                "latitude":self.Lat,
                               "longitude":self.Lng,
                                "old_city":"",
                                "old_state":"",
                                "old_country":"",
                          "street_address":self.txtStreett.text!]
                

                
                
                APIManager.apiPostWithHeaders(serviceName: SAVE_ADDRESS_LISTING, parameters: params as? [String : Any]) { response, error in
                    DispatchQueue.main.async {
                        self.ListingActivityDelegate?.hideActivity()
                    }
                    
                    if error != nil {
                        self.showInformation(title: "Closest", message: error!.localizedDescription)
                    } else {
                        let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                        Singleton.sharedInstance.rentYourSpace = mod
                        sharedInstanceListing.gotoStepEight()
                    }
                }
                

            } else {
                showInformation(title: "Network Error", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as! String)
            }
        }
    }
    
    @IBAction func act_ChangeLocation(_ sender: UIButton) {
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchLoctaionDelegate = self
        self.navigationController?.pushViewController(searchVC!, animated: true)
        //self.present(searchVC!, animated: true, completion: nil)
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    
    func updateLocation(Latitude: String,Longitude: String ) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(Latitude)")!
        //21.228124
        let lon: Double = Double("\(Longitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        self.Lat = String(lat)
        self.Lng = String(lon)
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if pm.administrativeArea != nil {
                        self.txtState.text = pm.administrativeArea
                    } else {
                        self.txtState.text = ""
                    }
                    if pm.thoroughfare != nil {
                        self.txtStreett.text = pm.thoroughfare
                    } else {
                        self.txtStreett.text = ""
                    }
                    if pm.locality != nil {
                        self.txtCity.text = pm.locality!
                    }else {
                        self.txtCity.text = ""
                    }
                    if pm.country != nil {
                        self.txtZipcode.text = pm.country!
                    } else {
                        self.txtZipcode.text = ""
                    }
                    if pm.postalCode != nil {
                        self.txtCountry.text = pm.postalCode!
                    } else {
                        self.txtCountry.text = ""
                    }
                    self.lblDisc.isHidden = false
                    self.txtStreett.isHidden = false
                    self.txtCity.isHidden = false
                    self.txtState.isHidden = false
                    self.txtCountry.isHidden = false
                    self.txtZipcode.isHidden = false
                    self.txtFlat.isHidden = false

                }
        })
    }
}

extension AddressViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        self.conTopSpace.constant = -256
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     //   self.conTopSpace.constant = 20
        textField.resignFirstResponder()
        return true
    }
}

extension AddressViewController: LoctaionSearchProtocol {
    func showPlaceList(searchResult: String) {
        
    }
    
    func getLocationFromCoordinates(lat: String, long: String) {
        self.updateLocation(Latitude: lat, Longitude: long)
    }
    
    func getLocation(SearchResult: String) {
        AddressLocation = SearchResult
        self.txtStreet.text = SearchResult
        print(SearchResult)
    }
}

extension AddressViewController : HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "SAVE_ADDRESS_LISTING"
        {
            if errorDict.count == 0 {
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                Singleton.sharedInstance.rentYourSpace = mod
                self.showInformation(title: "Closest", message: mod.message)
                ListingActivityDelegate?.hideActivity()
            }
        }
        else
        {
            print("No Data")
        }
    }
}

