
//  HomeViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 18/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import GooglePlaces
import Kingfisher
import AFNetworking
import DropDown
import SideMenu
import FSCalendar


//protocol delegateForHomeFeatured {
//    func updateToList(indexPath: IndexPath)
//}

class HomeViewController: BaseViewController, UITextFieldDelegate,delegateForHomeFeatured, delegateForHomeProperty {
    func wishlist(StoreId: String) {
        WishListApiCall(propertyID: StoreId)
    }
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var buttonCreateExperience: UIButton!
    @IBOutlet weak var img_Menu: UIImageView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var btnRentYourSpace: UIButton!
    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var viewMenu: UIView! // 1
    @IBOutlet weak var tblMenu: UITableView! //2
    @IBOutlet weak var viewWhereToGo: UIView!
    @IBOutlet weak var lblWhereToGo: UILabel!
    @IBOutlet weak var lblHomeTrip: UILabel!
    @IBOutlet weak var imgHomeStatic: UIImageView!
    @IBOutlet weak var lblHomeHeader: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var tblViewHome: UITableView!
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var searchImg: UIImageView!

    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var menuLeadingConstant: NSLayoutConstraint!
    @IBOutlet weak var lblEmail: UILabel! //5
    @IBOutlet weak var lblProfileName: UILabel! //5
    @IBOutlet weak var profileImg: UIImageView! //4
    @IBOutlet weak var btn_SelectProfile: UIButton! //6
    @IBOutlet weak var view_Profile: UIView! //3
    
    @IBOutlet weak var LoginView: UIView!
    let listDropDown = DropDown()
    var tempArray = NSMutableArray()
    
    @IBOutlet weak var checkInCalenderView: FSCalendar!

//@IBOutlet weak var message: UILabel!
//    @IBOutlet weak var messagetxt: UILabel!
    

    @IBOutlet weak var okBtn: UIButton!
    
    var featuredPropertyList = [[String:Any]]()
    var featuredCityList = [[String:Any]]()
    var favDestinationModel = [[String:Any]]()
    
    //MARK:- Variables
    var Home_Arr = [HomeModel]()
    var current_menu = Menu.MYPROFILE
    var selected_Currency = String()
    var menu = NSArray()
    let id = Singleton.sharedInstance.selectedCategory!
    var activeRentalsArr = NSArray()
    var itemdetailArr = [String]()
    var isDropDown = Bool()
    var Dropmenu = NSArray()
    var selectedRow = Int()
    var Homepagedata = NSMutableDictionary()
    var Fcm_Token = String()
    var menuArray = NSArray()
    var menuImageArray = NSArray()
    var ListingActivityDelegate: listingActivityProtocol!
    
    
    @IBOutlet weak var viewNewSideMenu: UIView!
    @IBOutlet weak var viewtopAccountDetails: UIView!
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var tableViewSideMenu: UITableView!
    
   
    var isFromDate = "Arrive"
    var fromDate = Date()
    var toDate = Date()
    var minimumDate = Date()
    var PropertyTypes = NSMutableArray()
    var PropertyTypeIds = NSMutableArray()
    var PropertyTypeName = String()
    var PropertyTypeId = String()

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    fileprivate let formatterNew: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    fileprivate let formatterNew1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    fileprivate lazy var hideformatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter: DateFormatter =
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-M-dd"
        return formatter
    }()
    
    
    //    fileprivate weak var calendar: FSCalendar!
    //    fileprivate weak var eventLabel: UILabel!
    private var firstDate: Date?
    private var lastDate: Date?
    var dateSingleSelection = Bool()
    var fromDateStr = String()
    var toDateStr = String()
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblViewHome.tableFooterView = UIView()
        self.searchImg.setImageColor(color: AppColor)
        self.textfieldSearch.font = UIFont(name: SemiBoldFont, size: 14)
        
         self.menuImageArray = ["mailboxNew","journalText","journalText","journalText","journalText", "journalText","journalText","journalText","journalText","cardListNew","GiftNew","journalText","journalText","logoutNew"]
        self.tableViewSideMenu.separatorStyle = .none
        self.imageViewUserProfile.layer.cornerRadius = self.imageViewUserProfile.frame.size.width / 2
        self.searchView.layer.cornerRadius = 5.0
        self.searchButton.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
         Network.shared.HTTP_GET_STRING_REQUEST_DELEGATE = self
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
         self.labelUserName.text  = login_session.string(forKey: "Firstname")
        self.labelUserEmail.text = login_session.string(forKey: "Email")
         self.profileImg.layer.masksToBounds = true

        login_session.synchronize()
    //    discoverApiCall()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatterGet.date(from: "2019-05-12 12:24:26") {
            print(dateFormatterPrint.string(from: date))
        } else {
            print("There was an error decoding the string")
        }
 
           self.lblProfileName.font = UIFont(name: SemiBoldFont, size: 17)
          self.lblEmail.font = UIFont(name: RegularFont, size: 15)
         self.lblEmail.textColor = AppSecondColor
        
 
        
        let dateFormtter = DateFormatter()
            dateFormtter.dateFormat = "yyyy-MM-dd"

            let startDate = dateFormtter.date(from: "2021-02-10")
            let endDate = dateFormtter.date(from: "2021-01-10")

        var mydates : [String] = []
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date

        // Formatter for printing the date, adjust it according to your needs:
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        dateFrom = fmt.date(from: "2021-02-10")! // "2018-03-01"
        dateTo = fmt.date(from: "2021-01-10")! // "2018-03-05"


        while dateFrom <= dateTo {
            mydates.append(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!

        }
        
        checkInCalenderView.calendarHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        checkInCalenderView.calendarWeekdayView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.checkInCalenderView.isHidden = true
        checkInCalenderView.calendarWeekdayView.configureAppearance()
        checkInCalenderView.appearance.headerMinimumDissolvedAlpha = 0.0
        self.checkInCalenderView.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
              self.checkInCalenderView.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
              self.checkInCalenderView.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)

              self.checkInCalenderView.appearance.headerTitleColor = AppColor
        self.checkInCalenderView.appearance.weekdayTextColor = AppColor
 

    
    }
    
    func WishListApiCall(propertyID:String) {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","property_id":propertyID]
        
        print(params)
        APIManager.apiPostWithHeaders(serviceName: ADD_WISHLIST, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error!.localizedDescription)
                self.showInformation(title: "Closest", message: error!.localizedDescription)
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
            
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                
                self.getNotificationListApiCall()
                self.hideActivityIndicator(uiView: self.view)

            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
              
            }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
        
 
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }

        var tempDate = from
        var array = [tempDate]

        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }

        return array
    }
    
    func discoverApiCall() {
        showActivityIndicator(uiView: self.view)
        
         let params =  ["email_id": UserEmail,"page_Id":"1","lang_code":"en"]
        print(params)
        APIManager.apiPost(serviceName: DISCOVER_API, parameters: params) { (json:NSDictionary?, error:NSError?) in
            // DispatchQueue.main.async { self.dismiss(animated: true) }
            if error != nil
            {
                print(error!.localizedDescription)
                return
            }
            print(json!)
            
            if (json!.value(forKey: "status")  as? Int) == 1 {
                let mod = UserDetailModel(fromDictionary: json as! [String : Any])
                Singleton.sharedInstance.userDetailModel = mod
                print(mod)
                let baseIdString:String = "1"
                Singleton.sharedInstance.selectedCategory = baseIdString
                for item in self.activeRentalsArr {
                    let itemDict = item as! NSDictionary
                    let itemid = itemDict.value(forKey: "base_id") as? String
                    print(self.itemdetailArr)
                    self.itemdetailArr.append(itemid!)
                }
            }
        }
        hideActivityIndicator(uiView: self.view)
       
    }
    
    func getNotificationListApiCall() {
            //self.showHUD(progressLabel: "")
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "currency_code":(login_session.value(forKey: "APP_CURRENCY") ?? "USD")
            ]
            print(parameters)
            APIManager.apiPostWithHeaders(serviceName: REQ_HOMEPAGE, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Closest", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                    
                    let resData = responseDict["data"] as! [String:Any]
                    self.featuredPropertyList = resData["featured_property"] as! [[String:Any]]
                    self.featuredCityList = resData["feature_city_list"] as! [[String:Any]]
                    self.favDestinationModel = resData["fav_destination_list"] as! [[String:Any]]
                    self.PropertyTypes.removeAllObjects()
                    self.PropertyTypeIds.removeAllObjects()
                    for i in 0..<(resData["property_types"] as! NSArray).count {
                        let name = ((resData["property_types"] as! NSArray).object(at: i) as! NSDictionary).object(forKey: "type_name") as! String
                        let Id = "\(((resData["property_types"] as! NSArray).object(at: i) as! NSDictionary).object(forKey: "type_master_id") as AnyObject)"
                        self.PropertyTypes.add(name)
                        self.PropertyTypeIds.add(Id)
                    }
                    
                    let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.homeModel = mod
                    
                    self.tblViewHome.reloadData()
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as! String)
                }
                
            }
        }

    
    func addingSearchData(sender:UIButton){
        listDropDown.dataSource = self.PropertyTypes as! [String]
        listDropDown.textFont = UIFont(name: SemiBoldFont, size: 15)!
        listDropDown.anchorView = sender
        listDropDown.direction = .bottom
        listDropDown.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        listDropDown.selectionAction = { [weak self] (index, item) in
            print("@@@@@@@@",index,item)
            self?.PropertyTypeName = item
            self?.PropertyTypeId = "\(self?.PropertyTypeIds.object(at: index) as AnyObject)"
            self?.listDropDown.hide()
            self?.tblViewHome.reloadData()
 }
    }
    

    @IBAction func buttonSearch(_ sender: Any) {
        
    }
    
 
    
    
    @objc func typingName(textField:UITextField){
        self.tempArray.removeAllObjects()
        if let typedText = textField.text {
            searchRestaurantByName(input: typedText)
        }
    }
    func searchRestaurantByName(input: String) {
        
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "location":input
        ]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: LOCATIONLIST, parameters: parameters) { responseDict, error in
            guard let result = responseDict, error == nil else {
                return
            }
            print (result)
 
             if result.object(forKey: "code") as! Int == 200{
                  var arr =  (result.value(forKey: "data")as! NSDictionary).value(forKey: "location_list") as! NSArray
                for item in arr {
                    let dict = item as! NSDictionary
                    self.tempArray.add(dict.value(forKey: "location_name") as! String)
                }
              //  self.addingSearchData(dict: result)
            }else if result.object(forKey: "code") as! Int == 400{
                if result.object(forKey: "message")as! String == "Token is Expired"{
                  }else if result.object(forKey: "message")as! String == "user_blocked" {
                 }
                else{
                 }
             }
            else if result.object(forKey: "message")as! String == "user_blocked" {
             }
        }
    }
 
    func passFeatureData(storeName: String, restId: String) {
        if #available(iOS 11.0, *) {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nav = storyBoard.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
            nav.Location = storeName
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    func passFeatureProperty(storeName: String, restId: String, currency: String) {
        if #available(iOS 11.0, *) {
            add_on_amount = 0
            Bundle_amount = 0
            bundle_checkindate = ""
            bundle_checkoutdate = ""
            BundleSelectedDictValues.removeAllObjects()
            AddonsSelectedDictValues.removeAllObjects()
            BUndleSelectedArray.removeAllObjects()
            BundleArray.removeAllObjects()
           
           
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
           nav!.PropertyID = restId
            nav!.prop_slug = storeName
            nav!.currencySymbol = currency
            //self.present(nav!, animated: true, completion: nil)
            self.navigationController?.pushViewController(nav!, animated: true)

        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
  
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.perform(#selector(updateTextfield), with: nil, afterDelay: 0.5)
         return true
    }
    
    @objc func updateTextfield() {
        if textfieldSearch.text?.count == 0 {
            self.tempArray.removeAllObjects()
            self.listDropDown.hide()
        }
        else {
            self.listDropDown.show()
        }
    }
    
    func LogoutApi()  {
            //self.showHUD(progressLabel: "")
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "type":"ios"
                 
            ]
 
        
            print(parameters)
            APIManager.apiPostWithHeaders(serviceName: REQ_LOGOUT, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async {  }
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Closest", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                
                if let code = responseDict.value(forKey: "code") as? NSNumber {
                
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    
                    
                    login_session.set(false, forKey: "IS_USER_LOGGEDIN")
                    let Currency = "\(login_session.value(forKey: "APP_CURRENCY"))"
                    let CurrencySymbol = "\(login_session.value(forKey: "APP_CURRENCY_SYMBOL"))"

                    let isRemembred =  UserDefaults.standard.bool(forKey: "isRememberPassword")
                    if UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") != nil{
                        let UserName = UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") as! String
                        let Password = UserDefaults.standard.value(forKey: "APP_LOGIN_PASSWORD") as! String
                        let Fcmkey = UserDefaults.standard.value(forKey: "fcmToken") as! String


                                   clearUserSession()
                        login_session.setValue(Currency, forKey: "APP_CURRENCY")
                        login_session.setValue(CurrencySymbol , forKey: "APP_CURRENCY_SYMBOL")
                        UserDefaults.standard.setValue(isRemembred, forKey: "isRememberPassword")
                        UserDefaults.standard.set(UserName, forKey: "APP_LOGIN_EMAIL")
                        UserDefaults.standard.set(Password, forKey: "APP_LOGIN_PASSWORD")
                        UserDefaults.standard.set(Fcmkey, forKey: "fcmToken")
                        
                    }else{
                        clearUserSession()
                    }
                    
                    
                    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                    
                    
                    
                    
                  //  let resData = responseDict["data"] as! [String:Any]
                    let AppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    AppDelegate.LogOut()
                    
                   // let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                   // Singleton.sharedInstance.homeModel = mod
                    
                    
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as! String)
                }
                }else{
                    self.showInformation(title: "Closest", message: "something went wrong")
                }
            }
        }
    
    
    
    
    func HomePageApi(){
          showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)!
        {
            let id = Singleton.sharedInstance.selectedCategory!
          
            
            
            
           
            var params = NSMutableDictionary()
            params = ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "currency_code":"USD"]
            print(params)
//            "currency_code":login_session.value(forKey: "APP_CURRENCY")as! String
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(REQ_HOMEPAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    self.hideActivityIndicator(uiView: self.view)
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int == 1 {
                    let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.homeModel = mod
                    
                    self.tblViewHome.reloadData()
                    
                }
                    
                else {
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
       
            
        } else {
              hideActivityIndicator(uiView: self.view)
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
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
    override func viewWillDisappear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.btnMenu.tag  = 0
       
        UIView.animate(withDuration: 0.3) {
//            self.menuLeadingConstant.constant = -500
           // self.img_Menu.image = UIImage(named: "Menu-3")
//            self.greyView.isHidden = true
            self.view.layoutIfNeeded()
        }
        print(MenuIconArray)
        print(menuArray)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.LoginView.isHidden = true
        isFromBookingDetails = false
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            LocalizeHelper().LocalizationSetLanguage("en")
 
            menu = ["My Profile","Home","Your Messages","Rental Listing","Trip History", "Your Wish List","Credit's & Coupon","Account Section","Manage Currency", "Logout"]
            
          //  menuArray = ["My Profile","Inbox","Add Listing","My Listing","My Property Reservtion","Report/Cancel","My Review","Payment Details","Coupons","Logout"]
            menuArray = ["My Profile","Inbox","Add Listing","My Listing","My Bookings", "My Property Reservtion","Wishlist","Report/Cancel","My Review","Payment Details"
                         ,"Coupons","Language","Currency","Logout"]
            self.tableViewSideMenu.reloadData()
        }
        
        if (login_session.value(forKey: "ProfilePic") as? String) != nil
        {
            let url = URL(string: (login_session.value(forKey: "ProfilePic") as! String))
            self.profileImg.kf.setImage(with: url, placeholder:UIImage(named:"user"))
            
            //self.profileImg.imageFromURL(urlString: (login_session.value(forKey: "ProfilePic") as? String)!)
        }else{
            self.profileImg.image = UIImage(named: "user")
        }
        
        
        //        Network.shared.HTTP_GET_STRING_REQUEST_DELEGATE = self
        //        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        if UserDefaults.standard.value(forKey: "ProfileImage") != nil {
            if UserDefaults.standard.value(forKey: "ProfileImage") as? String != nil {
                
                let url = URL(string: (UserDefaults.standard.value(forKey: "ProfileImage") as? String)!)
                self.profileImg.kf.setImage(with: url, placeholder:UIImage(named:"user"))
                
                // profileImg.imageFromURL(urlString:  UserDefaults.standard.value(forKey: "ProfileImage") as! String)
            }else{
                self.profileImg.image = UIImage(named: "user")
            }
        }else{
            self.profileImg.image = UIImage(named: "user")
        }
        self.viewMenu.isHidden = true
        getNotificationListApiCall()
        self.checkInCalenderView.isHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    @IBAction func act_SelectProfile(_ sender: UIButton)
    {
        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController
        self.navigationController?.pushViewController(navgt!, animated: true)
    }
    
    @IBAction func LoginView_Cancel(_ sender: UIButton)
       {
        self.LoginView.isHidden = true
       }
    @IBAction func LoginView_OkAct(_ sender: UIButton)
          {
           let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
           self.navigationController?.pushViewController(navgt!, animated: true)
          }
    
    @IBAction func act_WhereToGo(_ sender: UITapGestureRecognizer) {
        isFromHomePage_Search = true
        isFromRentYourSpace_search = false
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchLoctaionDelegate = self
        self.navigationController?.pushViewController(searchVC!, animated: true)
        // self.present(searchVC!, animated: true, completion: nil)
    }
    
    @IBAction func act_Search(_ sender: UIButton) {
        isFromHomePage_Search = true
        isFromRentYourSpace_search = false
        self.viewMenu.isHidden = true
        //self.navigationController?.popViewController(animated: true)
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchLoctaionDelegate = self
        self.navigationController?.pushViewController(searchVC!, animated: true)
        
      
        
        
        
    }
    
    @IBAction func act_RentYourSpace(_ sender: UIButton) {
        let rentSpaceVC = self.storyboard?.instantiateViewController(withIdentifier: "RentYourSpaceViewController") as? RentYourSpaceViewController
        self.navigationController?.pushViewController(rentSpaceVC!, animated: true)
    }
    
    @IBAction func act_Menu(_ sender: UIButton) {
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenu") as! SideMenuNavigationController
            menu.menuWidth = self.view.bounds.width - 100
           // menu.delegate = self
            present(menu, animated: true, completion: nil)
          
        }else{
            
            showSimpleAlert()
            // self.LoginView.isHidden = false
        }
       
    }
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Closest", message: "Are you sure want to login ?",         preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { _ in
            //Cancel Action
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Login",
                                      style: UIAlertActionStyle.default,
                                      handler: {(_: UIAlertAction!) in
                                        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
                                        self.navigationController?.pushViewController(navgt!, animated: true)
                                        
                                        
                                        //Sign out action
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func ButtonCreateExperience(_ sender: Any) {
        self.getBaseDetails()
    }
    
    
    //MARK:- Gesture Method
    @IBAction func tapOnGreyView(_ sender: UITapGestureRecognizer) {
        self.view.layoutIfNeeded()
        self.btnMenu.tag  = 0
        rotateMenuButton()
        UIView.animate(withDuration: 0.3) {
//            self.menuLeadingConstant.constant = -500
//            self.img_Menu.image = UIImage(named: "Menu-3")
//            self.greyView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
    
    func getBaseDetails() {
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                currentExpId = ""
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":""]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print(responseDict)
    //                if responseDict.value(forKey: "status") as! Int == 1 {
                    dictOfExperience = responseDict
                    arrayOfCurrency.removeAllObjects()
                    arrayOfCurrency.addObjects(from: (dictOfExperience["Currency"] as! NSArray) as! [Any])
                    arrayOfBoolValues.removeAllObjects()
                    isFromManage = false
                        let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceBaseViewController") as! ExperienceBaseViewController
                  //        let VC = storyBoardHome.instantiateViewController(withIdentifier: "ExperienceBookingViewController") as! ExperienceBookingViewController
                          self.navigationController?.pushViewController(VC, animated: true)
    //                }
    //                else {
                        //self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
    //                }
                }, failure: { (operation, error) in
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })

            }
            else {
                self.showInformation(title: "Closest", message: "Check your internet connection")
            }
        }
    
    func rotateMenuButton(){
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.img_Menu.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.img_Menu.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        })
    }
 
    
    
    func didSelectedMenu(at: Menu){

        switch (at)
        {
 
        case .LOGOUT:

 


            let refreshAlert = UIAlertController(title: "Closest", message: "Logged out Successfully", preferredStyle: UIAlertControllerStyle.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
               // LogoutApi()

            }))

            self.present(refreshAlert, animated: true, completion: nil)

 
        case .HOME:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
            self.navigationController?.pushViewController(nav!, animated: true)
           // nav?.SelectedId = 1
            break
            
            
        case .MYPROFILE:
                    let npStoryboard = UIStoryboard(name: "NewProfile", bundle: nil)
                    guard let nav = npStoryboard.instantiateInitialViewController() as? NewProfileViewController else { return  }
                    self.navigationController?.pushViewController(nav, animated: true)
//                   nav?.SelectedId = 1
                   break
        
        
        case .INBOX:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "InboxMessagesVC") as? InboxMessagesVC
            self.navigationController?.pushViewController(nav!, animated: true)
           // nav?.SelectedId = 1
            break
            
        case .ADDLISTING:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "RentYourSpaceViewController") as? RentYourSpaceViewController
            self.navigationController?.pushViewController(nav!, animated: true)
//            nav?.SelectedId = 1
            break
            
         case .MYLISTING:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
            self.navigationController?.pushViewController(nav!, animated: true)
//            nav?.SelectedId = 1
            break
            
        case .MYBOOKINGS:
           let nav = self.storyboard?.instantiateViewController(withIdentifier: "MyBookingsVC") as? MyBookingsVC
           self.navigationController?.pushViewController(nav!, animated: true)
           //nav?.SelectedId = 1
           break
            
         case .MYPROPERTYRES:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyReservationVC") as? PropertyReservationVC
            self.navigationController?.pushViewController(nav!, animated: true)
            //nav?.SelectedId = 1
            break
        
        case .WISHLIST:
           let nav = self.storyboard?.instantiateViewController(withIdentifier: "WishlistVC") as? WishlistVC
           self.navigationController?.pushViewController(nav!, animated: true)
           //nav?.SelectedId = 1
           break
            
         case .REPORTORCANCEL:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "Report_CancelVC") as? Report_CancelVC
            self.navigationController?.pushViewController(nav!, animated: true)
            //nav?.SelectedId = 1
            break
         case .MYREVIEW:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "MyReviewVC") as? MyReviewVC
            self.navigationController?.pushViewController(nav!, animated: true)
            //nav?.SelectedId = 1
            break
         case .PAYMENTDETAILS:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsVC") as? PaymentDetailsVC
            self.navigationController?.pushViewController(nav!, animated: true)
          //  nav?.SelectedId = 1
            break
         case .COUPONS:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "CouponsViewController") as? CouponsViewController
            self.navigationController?.pushViewController(nav!, animated: true)
           // nav?.SelectedId = 1
             break
        case .LANGUAGE:
            
            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {
              
                    self.img_Menu.image = UIImage(named: "Menu_PR")
                    self.greyView.isHidden = true
                   self.viewMenu.isHidden = true
                    self.view.layoutIfNeeded()
                
                nav.modalPresentationStyle = .overCurrentContext
                nav.modalTransitionStyle = .crossDissolve
                nav.type = .language
                present(nav, animated: true, completion: nil)
              
                self.view.layoutIfNeeded()
                rotateMenuButton()
               
            }
          // nav?.SelectedId = 1
            break
            
        case .CURRENCY:
            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {
                self.img_Menu.image = UIImage(named: "Menu_PR")
                self.greyView.isHidden = true
               self.viewMenu.isHidden = true
                self.view.layoutIfNeeded()
                nav.type = .currency
                nav.modalPresentationStyle = .overCurrentContext
                nav.modalTransitionStyle = .crossDissolve
                present(nav, animated: true, completion: nil)
            }
            break
         }


      
    }
    
   
    func Type(sender:UIButton) {
        let color1 = UIColor.lightGray
        sender.layer.cornerRadius = 5
        sender.layer.masksToBounds = true
        
        sender.layer.borderColor = color1.cgColor
        
        sender.layer.borderWidth = 1
    }
    func getSelectedMenu(index: Int) -> Menu {
        //        if isDropDown == false
        //        {
                    switch (index)
                    {
                    case 0:
                        return Menu.MYPROFILE
                    case 1:
                        return Menu.INBOX
                    case 2:
                        return Menu.ADDLISTING
                    case 3:
                        return Menu.MYLISTING
                    case 4:
                        return Menu.MYBOOKINGS
                    case 5:
                        return Menu.MYPROPERTYRES
                    case 6:
                        return Menu.WISHLIST
                    case 7:
                        return Menu.REPORTORCANCEL
                     case 8:
                        return Menu.MYREVIEW
                    case 9:
                        return Menu.PAYMENTDETAILS
                    case 10:
                        return Menu.COUPONS
                    case 11:
                        return Menu.LANGUAGE
                    case 12:
                        return Menu.CURRENCY
                   
                    case 13:
                        return Menu.LOGOUT
         
                    default:
                        return Menu.MYPROFILE
                    }
       
                }
       
    
    
    @objc func CheckInBtnTaped(sender: UIButton)
    {
        self.greyView.isHidden = false
        isFromDate = "Arrive"
        self.checkInCalenderView.isHidden = false
    }
    @objc func SearchBtnTaped(sender: UIButton)
    {
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
    vc.Location = LocationName
        vc.CheckOutDate = CheckOutDate
        vc.CheckInDate = checkinDate
        vc.PropertyType = self.PropertyTypeName
     self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func CheckOutBtnTaped(sender: UIButton)
    {
        self.greyView.isHidden = false
        isFromDate = "Depart"
        self.checkInCalenderView.isHidden = false
    }
    @objc func PropertyTypeBtnTaped(sender: UIButton)
    {
        self.listDropDown.show()
        self.addingSearchData(sender: sender)
    }

    @objc func LocationBtnTaped(sender: UIButton)
    {
    let sb = UIStoryboard(name: "Main", bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
    self.navigationController?.pushViewController(vc, animated: true)
    }
    }


//MARK:- TableView Delegates

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.tableViewSideMenu {
            return 1
        }else{
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        
        if tableView == self.tableViewSideMenu
        {
            if isDropDown == false{
                return menuArray.count
            }
            else{
                return menuArray.count
            }
            
        }
        else
        {
            return 1
            
            if Singleton.sharedInstance.homeModel != nil
            {
                return Singleton.sharedInstance.homeModel.homePageDetails.count
            }
            else
            {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            if tableView == self.tableViewSideMenu {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellList",for: indexPath)
                //  cell?.lblMenu.text = MenuArray[indexPath.row]
//                cell?.lblMenu.text = Dropmenu[indexPath.row] as? String
                let imgView = cell.viewWithTag(10) as! UIImageView
                let labelMenu = cell.viewWithTag(11) as! UILabel
                let countLbl = cell.viewWithTag(12) as! UILabel
                 labelMenu.font = UIFont(name: SemiBoldFont, size: 16)

                imgView.image = UIImage(named: menuImageArray[indexPath.row] as! String)
                labelMenu.textColor = UIColor.black
                labelMenu.text = self.menuArray[indexPath.row] as? String
                
                if self.selectedRow == indexPath.row {

                                   }
                if indexPath.row == 0 {
                    countLbl.isHidden = true
                }
                if indexPath.row == 1
                {

                }
                else
                    
                {
                }
                
                if indexPath.row == 2 || indexPath.row == 3  || indexPath.row == 4  || indexPath.row == 5  || indexPath.row == 6
                {
                }
                else

                {
                }
                if indexPath.row == 2
                {
                    

                        
                        
                        countLbl.isHidden = true
                        let color1 = AppSecondColor //hexStringToUIColor(hex: "#F8BC05")
                        
                        
                        countLbl.text = "10"
                     
                        countLbl.layer.cornerRadius = countLbl.frame.size.width / 2
                        countLbl.layer.masksToBounds = true
                        
                        countLbl.layer.borderColor = color1.cgColor
                        
                        countLbl.layer.borderWidth = 1
//                    }
                }
                else
                
                {
                    countLbl.isHidden = true
                }
                
                return cell
            }else {
                
                if indexPath.section == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "HomeNewTableViewCell", for: indexPath) as!
                        HomeNewTableViewCell
                    
                    self.Type(sender: cell.CheckInBtn)
                    self.Type(sender: cell.CheckOutBtn)
                    self.Type(sender: cell.LocationBtn)
                    self.Type(sender: cell.PropertTypeBtn)
                    cell.CheckInLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.CheckOutLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.LocationLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.PropertTypeLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.SearchBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.CheckInBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
                    cell.CheckOutBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
                    cell.LocationBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 12)
                    cell.PropertTypeBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
                    cell.SearchBtn.cornerRadius = 5
                    cell.CheckInBtn.setTitle(checkinDate, for: .normal)
                    cell.LocationBtn.setTitle(LocationName, for: .normal)
                    cell.PropertTypeBtn.setTitle(self.PropertyTypeName, for: .normal)

                    cell.CheckInBtn.titleLabel?.textColor = AppColor
                    cell.LocationBtn.titleLabel?.textColor = AppColor
                    cell.CheckOutBtn.titleLabel?.textColor = AppColor
                    cell.PropertTypeBtn.titleLabel?.textColor = AppColor
                    cell.CheckInLbl.text = GlobalLanguageDictionary.object(forKey: "Key_checkIndate") as? String
                    cell.CheckOutLbl.text = GlobalLanguageDictionary.object(forKey: "Key_checkOutdate") as? String
                    
                    cell.LocationLbl.text = GlobalLanguageDictionary.object(forKey: "Key_location") as? String
                    cell.PropertTypeLbl.text = GlobalLanguageDictionary.object(forKey: "Key_Workspace") as? String

                    
                    
                    cell.CheckOutBtn.setTitle(CheckOutDate, for: .normal)
                    
                     cell.CheckInBtn.addTarget(self, action: #selector(CheckInBtnTaped), for: .touchUpInside)
                    cell.CheckOutBtn.addTarget(self, action: #selector(CheckOutBtnTaped), for: .touchUpInside)
                    cell.LocationBtn.addTarget(self, action: #selector(LocationBtnTaped), for: .touchUpInside)
                    cell.SearchBtn.addTarget(self, action: #selector(SearchBtnTaped), for: .touchUpInside)
                    cell.PropertTypeBtn.addTarget(self, action: #selector(PropertyTypeBtnTaped), for: .touchUpInside)
                    
                    return cell
                }else{
                    switch indexPath.section {
                    case 0:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath) as!
                            ListingTableViewCell
                        cell.featuredProperty = self.featuredPropertyList
                        cell.sectionIndex = indexPath.section
                        cell.delegate = self

                        cell.collectionVW.reloadData()
                        return cell

                        
                 case 1 :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedCitiesTableViewCell", for: indexPath) as!
                        FeaturedCitiesTableViewCell
                        cell.feature_city_list = self.featuredCityList
                    cell.delegate = self
                        cell.collectionVW.reloadData()
                        return cell
            //
                    case 2 :
                        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
                            FavouriteDestinationTableViewCell
                        cell.favDesArray = self.favDestinationModel
                        
                        cell.collectionVW.reloadData()
                        return cell

                    default :
                        return UITableViewCell()

                    }
                }
                

            }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 10, width: 320, height: 20)
        myLabel.font = UIFont(name: SemiBoldFont, size: 19)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)
        headerView.backgroundColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.tblViewHome {
            
            
            
            
            if section == 0 {
                return GlobalLanguageDictionary.object(forKey: "Key_FeaturedListing") as! String
            } else if section == 1 {
                return GlobalLanguageDictionary.object(forKey: "Key_OurFeaturedCities") as! String
            } else if section == 2 {
                return GlobalLanguageDictionary.object(forKey: "Key_FavouriteDestinations") as! String
            }
        }else{
            return ""
        }
        return ""
       
    }
    
    private func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: SemiBoldFont, size: 19)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
        header.backgroundColor = .white
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableViewSideMenu {
            return 65
        } else {
//            if (indexPath.section == 1) {
//                if self.featuredPropertyList.count == 0 {
//                    return 0
//                }else{
//                    return 200
//                }
//            }
//
//            else {
                return UITableViewAutomaticDimension
//            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableViewSideMenu {
           return 0
        }else{
            if (section == 0) {
                if self.featuredPropertyList.count == 0 {
                    return 0
                }else{
                    return 0
                }
            }else if (section == 1) {
                return 40
            }else {
                return 40
            }
        }    }
    
    @objc func buttonPressed(_ sender: UIButton)
    {
        let button = sender
        let cell = button.superview?.superview as? MenuCell
        cell?.dropDownBtn.setImage(UIImage(named: "dropdownarrow(32)"), for: .normal)
        isDropDown = true
      
        Dropmenu = ["Home","Your Messages","Starred","UnRead","Reservations","Pending Requests","Archived","Property Listing","Trip History","Account Section","Credit's & Coupon","Manage Currency","Your Wishlist","Logout"]
         self.tblViewHome.reloadData()
      self.self.tableViewSideMenu.reloadData()
    }
    @objc func buttonPressed1(_ sender: UIButton)
    {
        isDropDown = false
        let button = sender
        let cell = button.superview?.superview as? MenuCell
        cell?.dropDownBtn.setImage(UIImage(named: "dropdownarrowcopy"), for: .normal)
        // self.tblViewHome.reloadData()
          Dropmenu = ["Home","Your Messages","Starred","UnRead","Reservations","Pending Requests","Archived","Rental Listing","Trip History","Experience Now","Experience History","Experience Listing","Your Wishlist","Credit's & Coupon","Account Section","Manage Currency","Logout"]
 
        
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        
        
        switch (tableView) {
        case self.tableViewSideMenu:
            current_menu = getSelectedMenu(index: indexPath.row)
            didSelectedMenu(at: current_menu)
        case self.tblViewHome:
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as? PlaceListController
//            nav!.Location = Singleton.sharedInstance.homeModel.homePageDetails[indexPath.row].name!
//            nav!.headerTxt =  Singleton.sharedInstance.homeModel.homePageDetails[indexPath.row].name!.uppercased()
//            //             UserDefaults.standard.setValue("", forKey: "checkdate")
//            //            nav!.base_ID = Singleton.sharedInstance.selectedCategory
//            self.navigationController?.pushViewController(nav!, animated: true)
            break
        default:
            break

        }
    }
}

// MARK:- HTTP Delegates

extension HomeViewController: HTTP_GET_STRING_REQUEST_PROTOCOL
{
    func httpGetRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorStr: String) {
        if APIKEY == "HOME_API" {
            print(responseDict)
            if (responseDict.value(forKey: "status")  as? Int) == 1{
                let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.homeModel = mod
                //let baseid = mod.baseId!
                //print(baseid)
                self.tblViewHome.reloadData()
            } else {
                
            }
            self.hideActivityIndicator(uiView: self.view)
        }
        else if APIKEY == "DISCOVER_API" {
            print(responseDict)
            if (responseDict.value(forKey: "status")  as? Int) == 1 {
                let mod = UserDetailModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.userDetailModel = mod
                print(mod)
                let baseIdString:String = "1"
                Singleton.sharedInstance.selectedCategory = baseIdString
                for item in activeRentalsArr {
                    let itemDict = item as! NSDictionary
                    let itemid = itemDict.value(forKey: "base_id") as? String
                    print(itemdetailArr)
                    itemdetailArr.append(itemid!)
                }
            }
            else {
                print("No data")
            }
            self.hideActivityIndicator(uiView: self.view)
        }
    }
}

extension HomeViewController : HTTP_POST_STRING_REQUEST_PROTOCOL{
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "UPDATE_MOBILE_CURRENCY"{
            if errorDict.count == 0 {
                let currency_list = responseDict.value(forKey: "currency_list") as? NSArray
                for num in 0..<currency_list!.count {
                    let dict = currency_list![num] as! NSDictionary
                    if selected_Currency == dict.value(forKey: "currency_code") as? String {
                        login_session.setValue(selected_Currency , forKey: "APP_CURRENCY")
                        login_session.setValue(dict.value(forKey: "currency_symbol") as! String , forKey: "APP_CURRENCY_SYMBOL")
                        login_session.synchronize()
                    }
                }
            }
        }
        self.hideActivityIndicator(uiView: self.view)
    }
}

extension HomeViewController: DropDownProtocol {
    func getValueFromDropDown(value: String, Key: Any) {
       
    }
}

extension HomeViewController: LoctaionSearchProtocol {
    func showPlaceList(searchResult: String)
    {
        self.showActivityIndicator(uiView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.hideActivityIndicator(uiView: self.view)
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as? PlaceListController
            nav!.headerTxt = searchResult
            nav!.Location = searchResult
            self.navigationController?.pushViewController(nav!, animated: true)
        })
    }
    
    func getLocationFromCoordinates(lat: String, long: String) {
    }
    
    func getLocation(SearchResult: String) {
        
    }
}
extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize.zero,
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

 


extension HomeViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance
{
    func minimumDate(for calendar: FSCalendar) -> Date
    {
         return minimumDate
    }
    
    
    func getNextMonth(date:Date)->Date
    {
        return Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date
    {
        return Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
        
          func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
              
              let curDate = Date().addingTimeInterval(-24*60*60)
                if date < curDate {
                  return false
              } else {
                  return true
              }
              return true
              
          }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if isFromDate == "Arrive"
        {
            self.minimumDate = date
            checkinDate = self.formatter.string(from: date)
             self.greyView.isHidden = true
            self.checkInCalenderView.isHidden = true
        }
        else
        {
            CheckOutDate =  self.formatter.string(from: date)
             self.greyView.isHidden = true
            self.checkInCalenderView.isHidden = true
        }
        self.checkInCalenderView.reloadData()
        self.tblViewHome.reloadData()
    }
}
