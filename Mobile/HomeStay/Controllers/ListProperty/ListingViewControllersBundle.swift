

//  ListingViewControllersBundle.swift
//  HomeStay
//  Created by POFI TECHNOLOGIES on 02/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import AFNetworking

class ListingViewControllersBundle: UIViewController,HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    //MARK:- Variables
    
    var ListingSection = NSArray()
    var BasicsArray = NSArray()
    var descriptionArray = NSArray()
    var settingArray = NSArray()
    var SelectedRow = 0
    var BasicImgArr = NSArray()
    var descriptionImgArr = NSArray()
    var settingImgArr = NSArray()
    var canHideTable = false
    var currentIndexPath = IndexPath()
    var PropertyId : Int = 0
    var ListingBundleFrom = ""
    var backAct : String = ""
    
    //MARK:- Outlets
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var conParentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var conPropeertyTblWidth: NSLayoutConstraint!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var tblPropertyListing: UITableView!
    
    
    @IBOutlet weak var CollectionPropertyListing: UICollectionView!
    
    //MARK:- Variables
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var ListingActivityDelegate: listingActivityProtocol?
    var isCalenderSelected = false
    var window: UIWindow?
    
    
    //MARK:- Lifecycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        RentYourSpaceApi()
        
        sharedInstanceListing = self
        ListingActivityDelegate = self
        tblPropertyListing.layer.borderWidth = 1.0
        tblPropertyListing.layer.borderColor = UIColor.black.cgColor
        parentView.layer.borderWidth = 0
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.lblHeader.font = UIFont(name: SemiBoldFont , size: 18)
        
        if ListingBundleFrom == "PropertyListing" {
            ListingBundleFrom = ""
            self.backAct = "PropertyListing"
            if Reachability()!.isReachable {
                ListingActivityDelegate?.showActivity()
                PropertyStatus()
                
            } else {
                showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
                
            }
        } else {
            self.backAct = "Listing"
            ListingActivityDelegate?.showActivity()
            let bpStoryboard = UIStoryboard(name: "BasicPrice", bundle: nil)
            let childViewController = bpStoryboard.instantiateInitialViewController() as? BasicPriceViewController
            isCalenderSelected = true
            childViewController?.ListingActivityDelegate = self
            
            childViewController?.PropertyID = Singleton.sharedInstance.rentYourSpace.propertyid
            self.PropertyId  = Singleton.sharedInstance.rentYourSpace.propertyid
            childViewController?.view.frame = self.parentView.bounds
            add(childViewController!, parent: self)
            self.tblPropertyListing.reloadData()
            self.ListingActivityDelegate?.hideActivity()
        }
    }
    
    
    func RentYourSpaceApi(){
        if (Reachability()?.isReachable ?? false)
        {
            let id = Singleton.sharedInstance.selectedCategory
            
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "currency_code":(login_session.value(forKey: "APP_CURRENCY") ?? "USD"),
                 "base_id":"\(id)"
                ]
            
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
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    if let property = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "property_type") as? NSArray {
                        if property.count != 0 {
                            //                            self.propertyArray = [String]()
                            //                            self.PROP_ARR = property
                            
                            for i in 0..<property.count{
                                
                                let propertyname = (property.object(at: i) as? NSDictionary)?.object(forKey: "option_name") as? String ?? ""
                                
                            }
                            
                            
                        }
                    }
                    
                    if let rooms = (responseDict.object(forKey: "data") as? NSDictionary)?.value(forKey: "room_type") as? NSArray {
                        if rooms.count != 0 {
                            
                            for i in 0..<rooms.count{
                                
                                let propertyname = (rooms.object(at: i) as? NSDictionary)?.object(forKey: "typval_name") as? String ?? ""
                                
                            }
                            
                            
                        }else{
                            
                        }
                    }
                    
                    if let accomdation = responseDict.value(forKey: "other_attributes") as? NSArray {
                        if accomdation.count != 0 {
                            
                            for accom in accomdation {
                                let dict = (accom as? NSDictionary)
                                if dict?.value(forKey: "attribute_name") as? String == "accommodates"
                                {
                                    let accomArr = dict?.value(forKey: "attribute_value") as? NSArray
                                    for acomm in accomArr!{
                                        let acom = (acomm as? NSDictionary)!.value(forKey: "attribute_child_value") as? String
                                    }
                                }
                            }
                        }else{
                            
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
                    
                    //                    self.hideActivityIndicator(uiView: self.view)
                    
                }
                else
                {
                    
                    //                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
                
            }}
        else{
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            
        }
    }
    
    
    
    func PropertyStatus() {
        ListingActivityDelegate?.showActivity()
        var params = NSMutableDictionary()
        
        
        params = ["lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en",
                  "property_id":self.PropertyId]
        
        
        APIManager.apiPostWithHeaders(serviceName: CREATED_PROPERTY_STATUS, parameters: params as? [String : Any]) { response, error in
            DispatchQueue.main.async {
                self.ListingActivityDelegate?.hideActivity()
            }
            let responseDict:NSDictionary = response as! NSDictionary
            print(responseDict)
            
            if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                let result = responseDict.object(forKey: "data") as! NSDictionary
                
                commonMaintainListDataDict.removeAllObjects()
                commonMaintainListDataDict.addEntries(from: responseDict as! [AnyHashable : Any])
                
                self.AddCalender()
                
            }
            
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
        }
        
    }
    
    
    func AddCalender(){
        let bpStoryboard = UIStoryboard(name: "BasicPrice", bundle: nil)
        let childViewController = bpStoryboard.instantiateInitialViewController() as? BasicPriceViewController
        self.isCalenderSelected = true
        childViewController?.ListingActivityDelegate = self
        
        childViewController?.PropertyID = Singleton.sharedInstance.rentYourSpace.propertyid
        self.PropertyId  = Singleton.sharedInstance.rentYourSpace.propertyid
        childViewController?.view.frame = self.parentView.bounds
        add(childViewController!, parent: self)
        self.tblPropertyListing.reloadData()
        self.ListingActivityDelegate?.hideActivity()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        settingImgArr = ["Amenities","dashboard","city","cancellation"]
        BasicImgArr = ["Calender","Pricing"]
        descriptionImgArr = ["Overview","propertyType"]
        ListingSection =   ["Basics","Description","Settings"]
        BasicsArray = ["calender","Pricing"]
        descriptionArray =  ["Overview","Photos"]
        settingArray = ["Amenities","Listing","Location","Cancellation"]
        
        BasicsArray = ["PRICING","CALENDER"," PROPERTY INFO "," ADD PHOTOS ","AMENITIES"," LISTING INFO ","ADDRESS"," CANCELLATION POLICY  "]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Swipe Method
    @objc func viewSwipedLeft(sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations:
                        {
                            self.conParentViewWidth.constant = 75
                            self.conPropeertyTblWidth.constant = -75
                            self.canHideTable = true
                            self.view.layoutIfNeeded()
                            self.tblPropertyListing.reloadData()
                        }
        )
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
    
    @objc func viewSwipedRight(sender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.3, animations:
                        {
                            self.conParentViewWidth.constant = 0
                            self.conPropeertyTblWidth.constant = 0
                            self.canHideTable = false
                            self.view.layoutIfNeeded()
                            self.tblPropertyListing.reloadData()
                        }
        )
    }
    
    //MARK:- Button Actions
    
    @IBAction func act_Back(_ sender: UIButton) {
        
        
        if self.backAct == "PropertyListing" {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
            
            self.window?.rootViewController = mainViewController
            
            self.window?.makeKeyAndVisible()
        }
    }
    
    //MARK:- Response method
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        print(responseDict)
        if APIKEY == "CREATED_PROPERTY_STATUS" {
            if errorDict.count == 0 {
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                let result = responseDict.object(forKey: "result") as! NSArray
                
                commonMaintainListDataDict.removeAllObjects()
                commonMaintainListDataDict.addEntries(from: responseDict as! [AnyHashable : Any])
                print("commonMaintainListDataDict count:::",commonMaintainListDataDict.count)
                let attributeArray:NSArray = responseDict.value(forKey: "attribute") as! NSArray
                print("attribute array : ", attributeArray)
                forAddPhotoDict.removeAllObjects()
                forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                print("forAddPhotoDict:::",forAddPhotoDict)
                
                UserDefaults.standard.set(attributeArray, forKey: "AmenitiesArray")
                
                seasonalDatesArray.removeAllObjects()
                let stepsTwoDict:NSDictionary = ((responseDict.value(forKey: "result") as AnyObject)[0] as AnyObject).value(forKey: "step2") as! NSDictionary
                print("stepsTwoDict : ", stepsTwoDict)
                let seasonalDateArr:NSArray = stepsTwoDict.value(forKey: "seasonal_calendar_price") as! NSArray
                print("seasonalDateArr : ", seasonalDateArr)
                if seasonalDateArr.count != 0 {
                    seasonalDatesArray = NSMutableArray(array:seasonalDateArr)
                    print("seasonalDatesArray : ", seasonalDatesArray)
                }
                
                let childViewController = self.storyboard?.instantiateViewController(withIdentifier: "CalenderViewController") as? CalenderViewController
                isCalenderSelected = true
                childViewController?.ListingActivityDelegate = self
                childViewController?.calenderDelegate = self
                childViewController?.PropertyID = mod.propertyid
                self.PropertyId  = mod.propertyid
                childViewController?.view.frame = self.parentView.bounds
                add(childViewController!, parent: self)
                self.tblPropertyListing.reloadData()
            }
        }
    }
    
    
    
    func getCategory() -> String {
        switch Int(Singleton.sharedInstance.selectedCategory) {
        case 1:
            return "HOTEL"
        case 2:
            return "OFFICE"
        case 3:
            return "RESORT"
        case 4:
            return "CAR"
        case 5:
            return "VAN"
        case 6:
            return "RESTAURANT"
        case 7:
            return "FLIGHT"
        case 8:
            return "EXPERIENCE"
        default:
            return " "
        }
    }
    
    
    public func gotoStepTwo() {
        self.SelectedRow = 1
        
        let kpStoryboard = UIStoryboard(name: "PopCalender", bundle: nil)
        let childViewController = kpStoryboard.instantiateViewController(withIdentifier: "PopCalendarViewController") as! PopCalendarViewController
        self.addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        childViewController.PropertyID = self.PropertyId
        
        childViewController.ListingActivityDelegate = self
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 0.5)
    }
    
    public func gotoStepThree() {
        self.SelectedRow = 2
        
        
        let mnStoryboard = UIStoryboard(name: "OverviewVC", bundle: nil)
        let childViewController = mnStoryboard.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController
        addChildViewController(childViewController!)
        childViewController?.view.frame = self.parentView.bounds
        childViewController!.ListingActivityDelegate = self
        self.parentView.addSubview(childViewController!.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
        
    }
    public func gotoStepfour() {
        self.SelectedRow = 3
        
        let msStoryboard = UIStoryboard(name: "AddPhoto", bundle: nil)
        //        let childViewController = bpStoryboard.instantiateInitialViewController() as? BasicPriceViewController
        let childViewController = msStoryboard.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
        addChildViewController(childViewController!)
        childViewController?.view.frame = self.parentView.bounds
        childViewController!.ListingActivityDelegate = self
        childViewController!.PropertyID = self.PropertyId
        self.parentView.addSubview(childViewController!.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
    }
    public func gotoStepfive() {
        self.SelectedRow = 4
        let amenitiesStoryboard = UIStoryboard(name: "Amenities", bundle: nil)
        let childViewController = amenitiesStoryboard.instantiateViewController(withIdentifier: "AmenitiesViewController") as! AmenitiesViewController
        addChildViewController(childViewController)
        //            childViewController!.id = self.PropertyId
        childViewController.view.frame = self.parentView.bounds
        childViewController.ListingActivityDelegate = self
        childViewController.PropertyId = self.PropertyId
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
    }
    public func gotoStepSix() {
        self.SelectedRow = 5
        
        let rrStoryboard = UIStoryboard(name: "Listinginfo", bundle: nil)
        let childViewController = rrStoryboard.instantiateViewController(withIdentifier: "ListingInfoViewController") as! ListingInfoViewController
        addChildViewController(childViewController)
        childViewController.PropertyId = self.PropertyId
        childViewController.view.frame = self.parentView.bounds
        childViewController.ListingActivityDelegate = self
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
    }
    public func gotoStepSeven() {
        self.SelectedRow = 6
        let srStoryboard = UIStoryboard(name: "Address", bundle: nil)
        let childViewController = srStoryboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController
        addChildViewController(childViewController!)
        childViewController?.PropertyID = self.PropertyId
        childViewController?.view.frame = self.parentView.bounds
        
        childViewController!.ListingActivityDelegate = self
        self.parentView.addSubview(childViewController!.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
    }
    public func gotoStepEight() {
        self.SelectedRow = 7
        let cskStoryboard = UIStoryboard(name: "CancellationVC", bundle: nil)
        let childViewController = cskStoryboard.instantiateViewController(withIdentifier: "CancellationPlolicyViewController") as? CancellationPlolicyViewController
        addChildViewController(childViewController!)
        childViewController?.PropertyID = self.PropertyId
        childViewController?.view.frame = self.parentView.bounds
        childViewController!.ListingActivityDelegate = self
        self.parentView.addSubview(childViewController!.view)
        self.didMove(toParentViewController: self)
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
    }
}

extension ListingViewControllersBundle: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ListingSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.BasicsArray.count
        case 1:
            return self.descriptionArray.count
        case 2:
            return self.settingArray.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListingCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListingCell
        cell.lblName.font = UIFont(name: RegularFont, size: 14)
        
        if  self.currentIndexPath == indexPath {
            cell.backgroundColor = UIColor(red: 248/255.0, green: 188/255.0, blue: 5/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.clear
        }
        switch indexPath.section {
        case 0:
            if  indexPath.row == 0 {
                if isCalenderSelected == true {
                    cell.backgroundColor = UIColor(red: 248/255.0, green: 188/255.0, blue: 5/255.0, alpha: 1.0)
                } else {
                    cell.backgroundColor = UIColor.clear
                }
            }
            cell.lblName.text = BasicsArray[indexPath.row] as? String
            cell.imgIcon.image = UIImage(named: self.BasicImgArr[indexPath.row] as? String ?? "")
        case 1:
            cell.lblName.text = descriptionArray[indexPath.row] as? String
            cell.imgIcon.image = UIImage(named: self.descriptionImgArr[indexPath.row] as? String ?? "")
        case 2:
            cell.lblName.text = settingArray[indexPath.row] as? String
            cell.imgIcon.image = UIImage(named: self.settingImgArr[indexPath.row] as? String ?? "")
        default:
            break
        }
        if canHideTable == false {
            cell.lblName.isHidden = false
        } else {
            cell.lblName.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 5, y: 0, width: tableView.bounds.width, height: 50))
        let label = UILabel(frame: CGRect(x: 5, y: -5, width: tableView.bounds.width, height: 40))
        headerView.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.text = self.ListingSection[section] as? String
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
        
        if canHideTable == false {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var childViewController: UIViewController?
        self.currentIndexPath = indexPath
        isCalenderSelected = false
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                // removeChild(parentCon: self)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalenderViewController") as? CalenderViewController
                childViewController = vc
                isCalenderSelected = true
                vc!.ListingActivityDelegate = self
                
            case 1:
                // removeChild(parentCon: self)
                let bpStoryboard = UIStoryboard(name: "BasicPrice", bundle: nil)
                let vc = bpStoryboard.instantiateInitialViewController() as? BasicPriceViewController
                childViewController = vc
                vc!.ListingActivityDelegate = self
                
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let mnStoryboard = UIStoryboard(name: "OverviewVC", bundle: nil)
                let vc = mnStoryboard.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController
                childViewController = vc
                vc!.ListingActivityDelegate = self
                vc!.propertyID = self.PropertyId
                
            case 1:
                
                
                let msStoryboard = UIStoryboard(name: "AddPhoto", bundle: nil)
                
                let vc = msStoryboard.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
                childViewController = vc
                vc!.PropertyID = self.PropertyId
                vc!.ListingActivityDelegate = self
                
                
            default:
                break
            }
        case 2:
            switch indexPath.row {
            case 0:
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesViewController") as? AmenitiesViewController
                childViewController = vc
                //                vc!.PropertyId = self.PropertyId
                vc!.ListingActivityDelegate = self
                
            case 1:
                let rrStoryboard = UIStoryboard(name: "Listinginfo", bundle: nil)
                let vc = rrStoryboard.instantiateViewController(withIdentifier: "ListingInfoViewController") as? ListingInfoViewController
                childViewController = vc
                vc!.ListingActivityDelegate = self
                vc!.PropertyId = self.PropertyId
            case 2:
                
                let srStoryboard = UIStoryboard(name: "Amenities", bundle: nil)
                let vc = srStoryboard.instantiateViewController(withIdentifier: "AmenitiesViewController") as? AmenitiesViewController
                childViewController = vc
                vc!.ListingActivityDelegate = self
            case 3:
                let cskStoryboard = UIStoryboard(name: "CancellationVC", bundle: nil)
                let vc = cskStoryboard.instantiateViewController(withIdentifier: "CancellationPlolicyViewController") as? CancellationPlolicyViewController
                childViewController = vc
                vc!.PropertyID = self.PropertyId
                vc!.ListingActivityDelegate = self
            default:
                break
            }
        default:
            break
        }
        self.tblPropertyListing.reloadData()
        add(childViewController!,parent: self)
        childViewController?.view.frame = self.parentView.bounds
    }
}

extension ListingViewControllersBundle: listingActivityProtocol {
    
    func showActivity() {
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColorFromHex(rgbValue:0xffffff, alpha: 0.3)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}

extension ListingViewControllersBundle : CalenderProtocol {
    
    func showCalender() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalenderPresentViewController") as? CalenderPresentViewController
        self.present(vc!, animated: false, completion: nil)
    }
    
    func hideCalender() {
        print("hide")
    }
}

extension UIViewController {
    func add(_ child: UIViewController,parent: ListingViewControllersBundle) {
        addChildViewController(child)
        parent.parentView.addSubview(child.view)
        child.didMove(toParentViewController: self)
    }
    
    func removeChild(parentCon: ListingViewControllersBundle) {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        parentCon.parentView.removeFromSuperview()
    }
}
extension ListingViewControllersBundle: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCollectionViewCell", for: indexPath) as? ListingCollectionViewCell else { return UICollectionViewCell() }

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListingCollectionViewCell", for: indexPath) as? ListingCollectionViewCell
        
        cell.NameLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        cell.NameLbl.text = BasicsArray.object(at: indexPath.row)  as? String
        
        if SelectedRow == indexPath.row {
            cell.NameLbl.backgroundColor = AppColor
            cell.NameLbl.textColor = .white
            cell.ShowImg.isHidden = false
        }else{
            cell.ShowImg.isHidden = true
            cell.NameLbl.textColor = .black
            cell.NameLbl.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        }
        cell.ShowImg.setImageColor(color: AppColor)
        // cell.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
        cell.ShowImg.addDiamondMask()
        cell.ShowImg.backgroundColor = AppColor
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        var childViewController: UIViewController?
        self.SelectedRow = indexPath.row
        if indexPath.row == 0 {
            let bpStoryboard = UIStoryboard(name: "BasicPrice", bundle: nil)
            let vc = bpStoryboard.instantiateViewController(withIdentifier: "BasicPriceViewController") as? BasicPriceViewController
            childViewController = vc
            vc!.PropertyID = self.PropertyId
            isCalenderSelected = true
            vc!.ListingActivityDelegate = self
        }
        
        else if indexPath.row == 1 {
            
            let kpStoryboard = UIStoryboard(name: "PopCalender", bundle: nil)
            let vc = kpStoryboard.instantiateViewController(withIdentifier: "PopCalendarViewController") as? PopCalendarViewController
            childViewController = vc
            vc!.PropertyID = self.PropertyId
            vc!.ListingActivityDelegate = self
            
            
        }
        else if indexPath.row == 2 {
            
            let mnStoryboard = UIStoryboard(name: "OverviewVC", bundle: nil)
            let vc = mnStoryboard.instantiateViewController(withIdentifier: "OverviewViewController") as? OverviewViewController
            childViewController = vc
            vc!.ListingActivityDelegate = self
            vc!.propertyID = self.PropertyId
        }
        
        else if indexPath.row == 3 {
            
            let msStoryboard = UIStoryboard(name: "AddPhoto", bundle: nil)
            let vc = msStoryboard.instantiateViewController(withIdentifier: "AddPhotoViewController") as? AddPhotoViewController
            childViewController = vc
            vc!.PropertyID = self.PropertyId
            vc!.ListingActivityDelegate = self
            
            
            
        }
        else if indexPath.row == 4 {
            let srStoryboard = UIStoryboard(name: "Amenities", bundle: nil)
            let vc = srStoryboard.instantiateViewController(withIdentifier: "AmenitiesViewController") as? AmenitiesViewController
            childViewController = vc
            vc!.PropertyId = self.PropertyId
            vc!.ListingActivityDelegate = self
        }else if indexPath.row == 5 {
            let rrStoryboard = UIStoryboard(name: "Listinginfo", bundle: nil)
            let vc = rrStoryboard.instantiateViewController(withIdentifier: "ListingInfoViewController") as? ListingInfoViewController
            childViewController = vc
            vc!.ListingActivityDelegate = self
            vc!.PropertyId = self.PropertyId
        }else if indexPath.row == 6 {
            let srStoryboard = UIStoryboard(name: "Address", bundle: nil)
            let vc = srStoryboard.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController
            childViewController = vc
            vc!.ListingActivityDelegate = self
        }else if indexPath.row == 7 {
            
            let cskStoryboard = UIStoryboard(name: "CancellationVC", bundle: nil)
            let vc = cskStoryboard.instantiateViewController(withIdentifier: "CancellationPlolicyViewController") as? CancellationPlolicyViewController
            childViewController = vc
            vc!.PropertyID = self.PropertyId
            vc!.ListingActivityDelegate = self
            
        }
        
        self.tblPropertyListing.reloadData()
        add(childViewController!,parent: self)
        childViewController?.view.frame = self.parentView.bounds
        self.CollectionPropertyListing.reloadData()
        
        
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 1.0)
        
        
        
    }
    @objc func updateStepsRemaining() {
        
        self.CollectionPropertyListing.scrollToItem(at: IndexPath(row: self.SelectedRow, section: 0), at: .centeredHorizontally, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
}
extension UIView {
    func addDiamondMask(cornerRadius: CGFloat = 0) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + cornerRadius))
        path.addLine(to: CGPoint(x: bounds.maxX - cornerRadius, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - cornerRadius))
        path.addLine(to: CGPoint(x: bounds.minX + cornerRadius, y: bounds.midY))
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = cornerRadius * 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        
        layer.mask = shapeLayer
    }
}


