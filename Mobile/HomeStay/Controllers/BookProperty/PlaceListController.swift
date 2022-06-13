 
 //  PlaceListController.swift
 //  HomeStay
 //  Created by POFI TECHNOLOGIES on 27/08/18.
 //  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
 
 
 import UIKit
 import Kingfisher
 import CVCalendar
 import FSCalendar
 import AFNetworking
 
 class PlaceListController: BaseViewController,FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance  {
    
    //MARK:- Outlets
    @IBOutlet weak var tblPlaceList: UITableView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btnMoreFilter: UIButton!
    @IBOutlet weak var arriveDepartView: UIView!
    @IBOutlet weak var CheckInCalender: FSCalendar!
    @IBOutlet weak var viewNoPropertyFound: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btn_addWishlist: UIButton!
    @IBOutlet weak var collectnviewWishlist: UICollectionView!
    @IBOutlet weak var viewWishlisttitlePopup: UIView!
    @IBOutlet weak var txf_Wishlistitle: UITextField!
    @IBOutlet weak var btn_Okay: UIButton!
    @IBOutlet weak var arrive: UILabel!
    @IBOutlet weak var depart: UILabel!
    @IBOutlet weak var btn_Arrive: UIButton!
    @IBOutlet weak var btn_Depart: UIButton!
    @IBOutlet weak var btn_selectArriveDate: UIButton!
    @IBOutlet weak var btn_selectDepartDate: UIButton!
    @IBOutlet weak var noPropertyFoundLbl: UILabel!
    
    @IBOutlet weak var wishlistLbl: UILabel!
    @IBOutlet weak var choosewishlistLbl: UILabel!
    @IBOutlet weak var WishListCancelBtn: UIButton!


    //MARK:- Variables
    
    var isFromDate = "Arrive"
    var fromDate = Date()
    var toDate = Date()
    var minimumDate = Date()
    var noOfNights : Int = 0
    var arriveDate : String = ""
    var departDate : String = ""
    var wishlistName : String = ""
    var selectedItem : Int = 0
    var Rental_ID : Int = 0
    var base_ID : String = ""
    var f_room_type : String = ""
    var f_home_type : String = ""
    var f_list_type : String = ""
    var f_p_min  : String = ""
    var f_p_max : String = ""
    var f_guest : Int = 0
    var message : String = ""
    var wishmsg : String = ""
    var checkInternet : String = ""
    var cuisines : String = ""
    var timesof_day : String = ""
    var listvalue : String = ""
    var wishListId : Int = 0
    var homeChildIDs : String = ""
    var HiDSArrays : NSMutableArray = []
    var HomeStrings : String = ""
    var homeChiIDs : String = ""
    var HiDSArrIds : NSMutableArray = []
    var HomeStrIds : String = ""
    var wishPropertyid : Int = 0
    var isfav : String = ""
    var roomChildIDs : String = ""
    var RiDSArrays : NSMutableArray = []
    var roomChiIDs : String = ""
    var RiDSArrIds : NSMutableArray = []
    var checkinDateStr : String = ""
    var HideDates : NSMutableArray = []
    private var currentCalendar: Calendar?
    let id = Singleton.sharedInstance.selectedCategory
    var priceArray : NSMutableArray = []
    var minval : Int = 0
    var maxval : Int = 0
    var hotelPrice : NSMutableArray = []
    var headerTxt : String = ""
    var isCalledForFirstTime : Bool = false
    var wishListDict = NSMutableDictionary()
    
    var CurrencySymbol : String = ""
    var Location : String = ""

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
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
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPlaceList.tableFooterView = UIView()
        self.lblHeader.text  = self.headerTxt.uppercased()
        self.arriveDepartView.layer.borderWidth = 1.0
        self.arriveDepartView.layer.borderColor = UIColor.lightGray.cgColor
        self.arriveDepartView.layer.cornerRadius = 10.0
        self.btnMoreFilter.layer.cornerRadius = 10.0
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.tblPlaceList.isHidden = true
        self.viewNoPropertyFound.isHidden = true
        self.viewBottom.isHidden = true
        isCalledForFirstTime = true
        self.viewWishlisttitlePopup.isHidden = true
        //CheckInCalender.calendarHeaderView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        //CheckInCalender.calendarWeekdayView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        self.CheckInCalender.isHidden = true
        CheckInCalender.calendarWeekdayView.configureAppearance()
        CheckInCalender.appearance.headerMinimumDissolvedAlpha = 0.0
        calenderFilter()
        if self.checkinDateStr != "" {
            //self.btn_CheckinSelectDate.setTitle(self.checkinDateStr, for: .normal)
        }
        else {
            //self.btn_CheckinSelectDate.setTitle("Select Date", for: .normal)
        }
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        if #available(iOS 13.0, *) {
//            let app = UIApplication.shared
//            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
//
//            let statusbarView = UIView()
//            statusbarView.backgroundColor = AppColor
//            view.addSubview(statusbarView)
//
//            statusbarView.translatesAutoresizingMaskIntoConstraints = false
//            statusbarView.heightAnchor
//                .constraint(equalToConstant: statusBarHeight).isActive = true
//            statusbarView.widthAnchor
//                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
//            statusbarView.topAnchor
//                .constraint(equalTo: view.topAnchor).isActive = true
//            statusbarView.centerXAnchor
//                .constraint(equalTo: view.centerXAnchor).isActive = true
//
//        }
//        else
//        {
//            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
//            statusBar?.backgroundColor = AppColor
//        }
        
        
        self.CheckInCalender.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
        self.CheckInCalender.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
        self.CheckInCalender.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)

        self.CheckInCalender.appearance.headerTitleColor = AppColor
        
        
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 17)
         self.noPropertyFoundLbl.font = UIFont(name: RegularFont, size: 17)
              //self.okBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 20.0)
             // self.okBtn.backgroundColor = AppColor
        
        self.arrive.font = UIFont(name: SemiBoldFont, size: 15)
         self.depart.font = UIFont(name: SemiBoldFont, size: 15)
        self.btn_selectArriveDate.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
         self.btn_selectDepartDate.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
        
        self.btn_selectArriveDate.titleLabel?.textColor = AppColor
         self.btn_selectDepartDate.titleLabel?.textColor = AppColor
        self.WishListCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.btnMoreFilter.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
         self.btnMoreFilter.backgroundColor = AppColor
        self.wishlistLbl.font = UIFont(name: SemiBoldFont, size: 17)
         self.txf_Wishlistitle.font = UIFont(name: RegularFont, size: 15)
        self.btn_Okay.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
      //  self.btn_Okay.backgroundColor = AppSecondColor
        self.choosewishlistLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
            let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
            if choose == "en"
            {
                self.arrive.text = LocalizeHelper().localizedStringForKey("arrive")
                self.depart.text = LocalizeHelper().localizedStringForKey("depart")
                //            self.btn_selectArriveDate.currentTitle = LocalizeHelper().localizedStringForKey("plsselectarrivedate")
                //            self.btn_selectArriveDate.currentTitle = LocalizeHelper().localizedStringForKey("plsselectdepartdate")
                //            self.btnMoreFilter.setTitle(LocalizeHelper().localizedStringForKey("morefilters"), for: .normal)
                //            message = LocalizeHelper().localizedStringForKey("message")
                //            wishmsg = LocalizeHelper().localizedStringForKey("wishmessage")
                //            checkInternet = LocalizeHelper().localizedStringForKey("nointernet")
                
            }
            
            if applyFilterButtonClickedBool == true
            {
            applyFilterButtonClickedBool = false
                
                tblPlaceList.reloadData()
                f_list_type = filter_list_type
                f_room_type = filter_room_type
                f_home_type = filter_home_type
                arriveDate = filter_arriveDate
                departDate = filter_departDate
                f_p_min =  filter_p_min
                f_p_max = filter_p_max
                f_guest = filter_guest
    //
        calenderFilter()
            }

        }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        
        //print(arriveDate)
        //print(departDate)
        //let arrDate:Date = formatter.date(from: arriveDate)!
        //let depDate:Date = formatter.date(from: departDate)!
        //if depDate > arrDate {
            //return false
        //}
        if btn_Arrive.isSelected == false
        {
            let arrDate = Date().addingTimeInterval(-24*60*60)
            if date < arrDate{
                CheckInCalender.appearance.weekdayTextColor = UIColor.gray
                return false
            } else {
                btn_Arrive.isSelected = true
                return true
                
            }
            
        }
        else {

            let curDate = Date().addingTimeInterval(-24*60*60)
            
            if date < curDate {
                return false
            } else {
                return true
            }
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minimumDate
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if self.gregorian.isDateInToday(date)
        {
            
            if self.gregorian.isDateInToday(date)
            {
                return UIColor.orange
            }
            
            return UIColor.orange
        }
        for i in 0..<HideDates.count
        {
            let dayStr:String = HideDates[i] as? String ?? ""
            print(dayStr)
            if self.formatterNew1.string(from: date) == dayStr
            {
                return UIColor.red
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if isFromDate == "Arrive"
        {
            self.minimumDate = date
            self.btn_selectArriveDate.setTitle(self.formatter.string(from: date), for: .normal)
            self.arriveDate = self.btn_selectArriveDate.currentTitle!
            UserDefaults.standard.set(self.formatter.string(from: date), forKey: "selectedArriveDate")
            self.greyView.isHidden = true
            self.CheckInCalender.isHidden = true
            
        }
        else
        {
            self.btn_selectDepartDate.setTitle(self.formatter.string(from: date), for: .normal)
            UserDefaults.standard.set(self.formatter.string(from: date), forKey: "selectedDepartDate")
            self.departDate =  self.btn_selectDepartDate.currentTitle!
            self.greyView.isHidden = true
            self.CheckInCalender.isHidden = true
        }
        
        // Assume currentdate below as 'ARRIVE' and Server date as 'DEPARTURE' !!!
        
        let strCurrentDate = self.arriveDate
        let strServerDate = self.departDate
        let datePickerFormat = DateFormatter()
        datePickerFormat.dateFormat = "MM/dd/yyyy"
        datePickerFormat.locale = Locale(identifier: "en_US_POSIX")
        let currentDate: Date? = datePickerFormat.date(from: strCurrentDate)
        let serverDate: Date? = datePickerFormat.date(from: strServerDate)
        
        if let currentDate = currentDate {
            print("date \(currentDate)")
        }
        if let serverDate = serverDate {
            print("date \(serverDate)")
        }
        
        var result: ComparisonResult?
        
        if let serverDate = serverDate {
            result = currentDate?.compare(serverDate)
        } // comparing two dates
        
        if result == .orderedAscending {
            print("current date is less")
            calenderFilter()
        } else if result == .orderedDescending {
            print("server date is less")
            self.btn_selectDepartDate.setTitle("Select date", for: .normal)
            
        } else if result == .orderedSame {
            print("Both dates are same")
            calenderFilter()

        } else {
            print("Date cannot be compared")
        }
        calendar.reloadData()
        
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    func firstWeekday() -> Weekday {
        return Weekday.monday
    }
    func Nextmonth(date:Date)->Date
    {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
//    func calenderFilter()
//    {
//
//        let id = Singleton.sharedInstance.selectedCategory
//        self.showActivityIndicator(uiView: self.view)
//        if (Reachability()?.isReachable ?? false)
//        {
//
//            let parameterStr = "mcity_name=\(self.Location)&f_p_min=\(self.f_p_min)&f_p_max=\(self.f_p_max)&f_room_type=\(self.f_room_type)&f_home_type=\(self.f_home_type)&f_list_type=\(self.f_list_type)&f_date_arrive=\(self.arriveDate)&f_date_depart=\(self.departDate)&base_id=\(id)&f_guest=\(self.f_guest)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")!)&user_id=\(login_session.value(forKey: "UserId")!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_PROPERTY_DETAIL_PAGE, APIKEY: "REQ_PROPERTY_DETAIL_PAGE")
//            print(parameterStr)
//
//        }
//        else
//        {
//            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
//        }
//    }
    func calenderFilter() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
         params = ["mcity_name":self.Location,"f_p_min":self.f_p_min,"f_p_max":self.f_p_max,"f_room_type":self.f_room_type,"f_home_type":self.f_home_type,"f_list_type":self.f_list_type,"f_date_arrive":self.arriveDate,"f_date_depart":self.departDate,"base_id":1,"f_guest":self.f_guest,"currency_code":login_session.value(forKey: "APP_CURRENCY")!,"user_id":UserID,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
       // params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        print(params)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(REQ_PROPERTY_DETAIL_PAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                print(responseDict)
               self.viewWishlisttitlePopup.isHidden = true
                self.hideActivityIndicator(uiView: self.view)
                self.tblPlaceList.isHidden = false
                let mod = PlaceListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.PlaceList = mod
                
                
                let priceDetails = responseDict.value(forKey: "rentalList") as? NSArray
                let sortedArray = priceDetails!.sortedArray(using: [NSSortDescriptor(key: "rental_price", ascending: true)]) as NSArray
                self.hotelPrice.addObjects(from: sortedArray.value(forKey: "rental_price") as? AnyObject as! [Any])
                if mod.rentalList.count != 0
                {
                    self.tblPlaceList.isHidden = false
                    self.tblPlaceList.reloadData()
                    self.viewNoPropertyFound.isHidden = true
                }
                else
                {
                    self.tblPlaceList.isHidden = true
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any Rental list"
                }
                self.collectnviewWishlist.reloadData()
                
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func act_addWishlist(_ sender: UIButton)
    {
        self.viewWishlisttitlePopup.isHidden = false
        self.greyView.isHidden = false
    }
    @IBAction func act_wishListCancel(_ sender: UIButton)
    {
        self.viewWishlisttitlePopup.isHidden = true
        //self.greyView.isHidden = true
       // self.viewBottom.isHidden = true
    }
    func ReasturantAddWishList()
    {
        if (Reachability()?.isReachable ?? false)
        {
            showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") ?? "USD")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&wishlist_id=\(self.wishListId)&user_id=\(UserID)&restaurant_id=\(self.wishPropertyid)&notes="
            print(parameterStr)
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REASTURANT_ADD_WISHLIST, APIKEY: "REASTURANT_ADD_WISHLIST")
        }
    }
    func ReasturantRemoveWishList()
    {
        if (Reachability()?.isReachable ?? false)
        {
            showActivityIndicator(uiView: self.view)
            _ = Singleton.sharedInstance.selectedCategory
            let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&wishlist_id=\(self.wishListId)&user_id=\(UserID)&restaurant_id=\(self.wishPropertyid)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") ?? "USD")"
            print(parameterStr)
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REASTURANT_REMOVE_WISHLIST, APIKEY: "REASTURANT_REMOVE_WISHLIST")
        }
    }
//    func AddWishList()
//    {
//        if (Reachability()?.isReachable ?? false)
//        {
//            showActivityIndicator(uiView: self.view)
//            let id = Singleton.sharedInstance.selectedCategory
//            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") ?? "USD")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&wishlist_id=\(self.wishListId)&user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.wishPropertyid)"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: ADD_WISHLIST, APIKEY: "ADD_WISHLIST")
//        }
//    }
//
    func AddWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"property_id":self.wishPropertyid]
        print(params)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(ADD_WISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                
                if mod.wishlist.count != 0
                {
                    
                    self.calenderFilter()
                    self.viewBottom.isHidden = false

                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any property list"
                    
                }
                
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
    func RemoveWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
         params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"user_id":UserID,"property_id":self.wishPropertyid]
       
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(REMOVE_WISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
               
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                if mod.wishlist.count != 0
                {
                    
                    self.calenderFilter()
                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any property list"
                    
                }
                
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
    
    
    
    
//    func RemoveWishList()
//    {
//        if (Reachability()?.isReachable ?? false)
//        {
//            showActivityIndicator(uiView: self.view)
//            _ = Singleton.sharedInstance.selectedCategory
//            let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&wishlist_id=\(self.wishListId)&user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.wishPropertyid)"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REMOVE_WISHLIST, APIKEY: "REMOVE_WISHLIST")
//        }
//    }
    @IBAction func CheckInAct(_ sender: UIButton) {
        
        //self.CheckinSelect.isHidden = true
        self.greyView.isHidden = false
        self.CheckInCalender.isHidden = false
    }
    
    @IBAction func act_SelectArrDate(_ sender: UIButton) {
        
    }
    
    @IBAction func act_SelectdepartDate(_ sender: UIButton) {
    }
    
    @IBAction func btn_ArriveDate(_ sender: UIButton) {
        isFromDate = "Arrive"
        UIView.transition(with: self.CheckInCalender,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.CheckInCalender.isHidden = false
                            self.greyView.isHidden = false
        },
                          completion: nil)
    }
    
    @IBAction func act_Depart(_ sender: UIButton) {
        isFromDate = "Depart"
        if  btn_selectArriveDate.currentTitle == "Select date"
        {
            
            showInformation(title: "Closest", message: "Choose an arrival date before selecting departure date")
            
        }
        else
        {
            UIView.transition(with: self.CheckInCalender,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.CheckInCalender.isHidden = false
                                self.greyView.isHidden = false
            },
                              completion: nil)
        }
    }
    
    @IBAction func act_MoreFilter(_ sender: UIButton) {
        if hotelPrice.count == 0 {
            showInformation(title: "Closest", message: "We don't have any rentals to filter")

        }else{
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "MoreFilterViewController") as? MoreFilterViewController
//            let minAmt = hotelPrice.firstObject
//            print(minAmt!)
//            let maxAmt = hotelPrice.lastObject
//            print(maxAmt!)
//            nav!.miniAmount = (minAmt as? NSNumber ?? 0).floatValue
//            nav!.maxmAmount = (maxAmt as? NSNumber ?? 0).floatValue
//            nav!.cityName = self.headerTxt
//            nav!.arrivedDate = self.btn_selectArriveDate.currentTitle!
//            nav!.departingDate = self.btn_selectDepartDate.currentTitle!
//            self.navigationController?.pushViewController(nav!, animated: true)
        }
        
       
    }
    
    @IBAction func act_greyTapped(_ sender: UITapGestureRecognizer) {
        self.greyView.isHidden = true
        self.viewBottom.isHidden = true
        self.CheckInCalender.isHidden = true
        self.viewWishlisttitlePopup.isHidden = true
        self.txf_Wishlistitle.text = ""
    }
    
    @IBAction func act_OkayBtn(_ sender: UIButton) {
        if txf_Wishlistitle.text == "" {
            showInformation(title: "Closest", message: "Wishlist title cannot be empty")
        }
        else {
            self.viewWishlisttitlePopup.isHidden = true
            self.greyView.isHidden = false
            self.wishlistName = self.txf_Wishlistitle.text ?? ""
            if (Reachability()?.isReachable ?? false)
            {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                 params = ["base_id":1,"userid":login_session.value(forKey: "UserId")!,"wishlist_title":self.wishlistName,"property_id":Singleton.sharedInstance.PlaceList.rentalList[sender.tag].rentalId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? ""]
             
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(CREATE_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        print("GET_WISHLIST_API Response:::",responseDict)
                       
                            print(responseDict)
                            let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                            Singleton.sharedInstance.wishListModel = mod
                            
                      
                        self.calenderFilter()
                        self.viewBottom.isHidden = false

                        self.collectnviewWishlist.reloadData()
                        
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
//                let id = Singleton.sharedInstance.selectedCategory
//                let parameterStr = "base_id=\(id)&userid=\(login_session.value(forKey: "UserId")!)&wishlist_title=\(self.wishlistName!)&property_id=\(Singleton.sharedInstance.PlaceList.rentalList[sender.tag].rentalId)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")"
//                print(parameterStr)
//
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL:CREATE_WISHLIST_API , APIKEY: "CREATE_WISHLIST_API")
            }
            else {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
    }
    
    func CreateWishList() {
       
    }
    
 }
 extension PlaceListController
 {
    func isEligibleToBook() -> Bool {
        if diffBtwnDate() >= 2 {
            return true
        } else
        {
            return false
        }
    }
    func diffBtwnDate() -> Int {
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: fromDate)
        let date2 = calendar.startOfDay(for: toDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        noOfNights = components.day!
        return components.day!
    }
 }
 extension PlaceListController : UITextFieldDelegate
 {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txf_Wishlistitle
        {
            self.txf_Wishlistitle.resignFirstResponder()
            self.greyView.isHidden = true
            self.viewWishlisttitlePopup.isHidden = true
            self.viewBottom.isHidden = true
        }
        else
        {
            
        }
        return true
    }
 }
 extension PlaceListController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.PlaceList != nil {
            return Singleton.sharedInstance.PlaceList.rentalList.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlaceListCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlaceListCell
        cell.lblPlace.text = Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rentalTitle
         cell.lblPlace.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 14)
     //   cell.lblPrice.textColor = AppSecondColor
        let price = Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rentalPrice!
        let Hourlyprice = Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rental_hourly_price!
        
        let amount1 = NSDecimalNumber(string: "\(price)")
        let rounding1 = Double(truncating: amount1)
        let NetAmount = String(format: "%.2f",rounding1)
        
        let amount2 = NSDecimalNumber(string: "\(Hourlyprice)")
        let rounding2 = Double(truncating: amount2)
        let NetAmount2 = String(format: "%.2f",rounding2)
        //cell.lblPrice.text = Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].userCurrency + " " + String(describing: price)
        if !Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].userCurrency.isEmpty {
            let currStr =  Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].userCurrency
            CurrencySymbol = login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$"
            //currStr
            
            cell.lblPrice.text = currStr + " " + "\(String(describing: NetAmount))day / \(String(describing : NetAmount2))Hr"
            
            if NetAmount == "0.00" {
                cell.lblPrice.text = currStr + " " + " \(String(describing : NetAmount2))Hr"
            }
            if NetAmount2 == "0.00" {
                cell.lblPrice.text = currStr + " " + "\(String(describing: NetAmount))day "
            }
            
        }else {
            CurrencySymbol = "$"
            cell.lblPrice.text = "$" + " " + "\(String(describing: NetAmount))day / \(String(describing : NetAmount2))Hr"
        }
        
        cell.img_Host.layer.cornerRadius = cell.img_Host.frame.size.width / 2
        cell.img_Host.clipsToBounds = true
        let plcURL = URL(string: Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rentalImage)
//        let hostURL = URL(string: Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].userphoto)
        
        
        cell.imgPlace.setImageWith(plcURL!, placeholderImage: UIImage(named: "picture-frame"))
        //setImage(with: hostURL, placeholder: UIImage(named: "test"), options: nil, progressBlock: nil, completionHandler: nil)
        
//        cell.imgPlace.kf.setImage(with: plcURL)
       // cell.img_Host.kf.setImage(with: hostURL)
        
       // cell.img_Host.kf.setImage(with: hostURL, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.btnFav.isHidden = true

         if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
                {
            cell.btnFav.isHidden = false
            cell.btnLikeUnlike.isHidden = false
         }else{
            cell.btnFav.isHidden = true
            cell.btnLikeUnlike.isHidden = true
        }
        
        
        
        cell.btnFav.tag = Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rentalId
        cell.btnFav.tag = indexPath.row
        cell.btnFav.addTarget(self, action:#selector(favTapped), for: .touchUpInside)
        let isfav = String(Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].isFavourite)
        
        if (isfav == "1")
        {
            cell.btnLikeUnlike.image = UIImage(named: "like")
            
        }
        else
        {
            cell.btnLikeUnlike.image = UIImage(named: "unlike")
            
        }
        cell.btnFav.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 200
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        add_on_amount = 0
        Bundle_amount = 0
        bundle_checkindate = ""
        bundle_checkoutdate = ""
        BundleSelectedDictValues.removeAllObjects()
        AddonsSelectedDictValues.removeAllObjects()
        BUndleSelectedArray.removeAllObjects()
        BundleArray.removeAllObjects()
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
       nav!.PropertyID = String(Singleton.sharedInstance.PlaceList.rentalList[indexPath.row].rentalId)
//        nav!.startinDate = self.btn_selectArriveDate.currentTitle!
//        nav!.endinDate = self.btn_selectDepartDate.currentTitle!
      //  nav!.titleText = self.headerTxt
        nav!.currencySymbol = self.CurrencySymbol
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
    @objc func favTapped(sender: UIButton)
    {
        let btnRow = sender.tag
        print("btnRow is :", btnRow)
        if sender.isSelected == true {
            print("btnRow is :", btnRow)
        }
        else {
            print("btnRow is :", btnRow)
        }
        print("ID is :", Singleton.sharedInstance.PlaceList.rentalList[btnRow].rentalId)
        self.wishPropertyid = Singleton.sharedInstance.PlaceList.rentalList[btnRow].rentalId
        let fav = sender.tag
        let favid = String(Singleton.sharedInstance.PlaceList.rentalList[fav].isFavourite)
        if favid == "1"  {
            RemoveWishList()
            
        }else {
//            self.greyView.isHidden = false
//            self.viewBottom.isHidden = false
            UIView.transition(with: self.viewBottom,
                              duration:1.0,
                              options: .transitionCrossDissolve,
                              animations: {
                                
            },
                              completion: nil)
            
            if (Reachability()?.isReachable ?? false)
            {
                 WishListApiCall()
//                let id = Singleton.sharedInstance.selectedCategory
//                showActivityIndicator(uiView: self.view)
//                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") ?? "USD")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: GET_WISHLIST_API, APIKEY: "GET_WISHLIST_API")
//                print(parameterStr)
            }
            else
            {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
    }
    
    func WishListApiCall() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(GET_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                print("GET_WISHLIST_API Response:::",responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                
                if (responseDict.object(forKey: "wishlist") as! NSArray).count == 0{
                    self.viewWishlisttitlePopup.isHidden = false
                    self.greyView.isHidden = false
                }else{
                    self.viewBottom.isHidden = false
                    self.greyView.isHidden = false
                }
                    
                
                
                Singleton.sharedInstance.wishListModel = mod
                self.collectnviewWishlist.reloadData()
                
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
    
 }
 
 extension PlaceListController: UICollectionViewDelegate,UICollectionViewDataSource
 {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Singleton.sharedInstance.wishListModel != nil
        {
            return Singleton.sharedInstance.wishListModel.wishlist.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
        cell.lbl_WishlistName.text = Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistTitle
          cell.lbl_WishlistName.font = UIFont(name: SemiBoldFont, size: 13)
        cell.lbl_wishlistcount.font = UIFont(name: SemiBoldFont, size: 13)
        let wishlistImgUrl = URL(string: Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistImage)
        if wishlistImgUrl != nil {
            //cell.img_Wishlist.kf.setImage(with: wishlistImgUrl!)
            cell.img_Wishlist.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
        selectedItem = indexPath.row
        self.wishListId = Int(Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistId)
        AddWishList()
        self.viewBottom.isHidden = true
        self.greyView.isHidden = true
        self.collectnviewWishlist.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 20
    }
 }
 
 extension PlaceListController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        
        DispatchQueue.main.async
            {
        self.hideActivityIndicator(uiView: self.view)
        }
        if APIKEY == "REQ_PROPERTY_DETAIL_PAGE" {
            if errorDict.count == 0 {
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                self.tblPlaceList.isHidden = false
                let mod = PlaceListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.PlaceList = mod

                
                let priceDetails = responseDict.value(forKey: "rentalList") as? NSArray
                let sortedArray = priceDetails!.sortedArray(using: [NSSortDescriptor(key: "rental_price", ascending: true)]) as NSArray
                self.hotelPrice.addObjects(from: sortedArray.value(forKey: "rental_price") as? AnyObject as! [Any])
                print(hotelPrice)
                if mod.rentalList.count != 0
                {
                    self.tblPlaceList.isHidden = false
                    self.tblPlaceList.reloadData()
                    self.viewNoPropertyFound.isHidden = true
                }
                else
                {
                    self.tblPlaceList.isHidden = true
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any property list"
                }
            }
        }
        else if APIKEY == "ADD_WISHLIST"
        {
            print(responseDict)
            
            if errorDict.count == 0
            {
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                
                if mod.wishlist.count != 0
                {
                    
                    calenderFilter()
                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any property list"

                }
            }
            else
            {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
        else if APIKEY == "GET_WISHLIST_API"
        {
            print(responseDict)
            hideActivityIndicator(uiView: self.view)
            if responseDict.count != 0
            {
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1
                {
                    let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.wishListModel = mod
                    collectnviewWishlist.reloadData()
                    
                }
                else
                {
                    showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
                }
                
            }
        }
            
        else if APIKEY == "CREATE_WISHLIST_API"
        {
            if errorDict.count == 0
            {
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
            
            }
            else
            {
                print("No wishlist Available")
            }
            calenderFilter()
            self.collectnviewWishlist.reloadData()
        }
        else if APIKEY == "REMOVE_WISHLIST"
        {
            if errorDict.count == 0
            {
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                if mod.wishlist.count != 0
                {
                    
                    calenderFilter()
                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    self.viewNoPropertyFound.isHidden = false
                    self.noPropertyFoundLbl.text = "City " + self.headerTxt + " does not have any property list"

                }
            }
            else
            {
                print("Removed unsuccessfully")
            }
            self.collectnviewWishlist.reloadData()
        }
        else
        {
            print("No data")
        }
    }
 }
 
