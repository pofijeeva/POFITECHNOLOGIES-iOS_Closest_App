
//
//  PropertyDetailViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 28/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import FSCalendar
import AFNetworking

class PropertyDetailViewController: BaseViewController,FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance,UIGestureRecognizerDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var viewPriceDetails: UIView!
    @IBOutlet weak var view_grey: UIView!
    @IBOutlet weak var lblPriceDetailSecurityDepo: UILabel!
    @IBOutlet weak var lblPriceDetailPrice: UILabel!
    @IBOutlet weak var collImageSlider: UICollectionView!
    @IBOutlet weak var lblPricetxtfield: UITextField!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var lblPropertyName2: UILabel!
    @IBOutlet weak var imgHost: UIImageView!
    @IBOutlet weak var lblHostName: UILabel!
    @IBOutlet weak var btnAboutTheHost: UIButton!
    @IBOutlet weak var imgHost2: UIImageView!
    @IBOutlet weak var btnAmenitiesViewAll: UIButton!
    @IBOutlet weak var btnPriceDetails: UIButton!
    @IBOutlet weak var btnViewCalender: UIButton!
    @IBOutlet weak var btnCancellationPolicy: UIButton!
    @IBOutlet weak var btnMinStay: UIButton!
    @IBOutlet weak var tblHomeDetails: UITableView!
    @IBOutlet weak var mapLocation: MKMapView!
    @IBOutlet weak var lblBeds: UILabel!
    @IBOutlet weak var llblBedroom: UILabel!
    @IBOutlet weak var lblNoofGuest: UILabel!
    @IBOutlet weak var btnViewAllReview: UIButton!
    @IBOutlet weak var collReview: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var viewPropReview: UIView!
    @IBOutlet weak var view_AllAmenities: UIView!
    @IBOutlet weak var tbl_AllAmenities: UITableView!
    @IBOutlet weak var listingLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var minimumStay: UILabel!
    @IBOutlet weak var cancellationpolicy: UILabel!
    @IBOutlet weak var avaliability: UILabel!
    @IBOutlet weak var priceDetails: UILabel!
    @IBOutlet weak var amenitiesLabel: UILabel!
    @IBOutlet weak var aboutHostLabel: UILabel!
    @IBOutlet weak var requesttoBook: UIButton!
    @IBOutlet weak var priceDetailLabel: UILabel!
    @IBOutlet weak var securityLbl: UILabel!
    @IBOutlet weak var inpriceLbl: UILabel!
    @IBOutlet weak var menuDetails: UILabel!
    @IBOutlet weak var pricedetailsssAct: UIButton!
    @IBOutlet weak var pricedetailsss: UILabel!
    @IBOutlet weak var menuDetailAct: UIButton!
    @IBOutlet weak var sunDayTime: UITextField!
    @IBOutlet weak var lineview5: UIView!
    @IBOutlet weak var livew6: UIView!
    @IBOutlet weak var view_Calendar: FSCalendar!
    var CancelString : String = ""
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var navTitle: UILabel!
    
    @IBOutlet weak var img_cuisineType: UIImageView!
    @IBOutlet weak var img_foodType: UIImageView!
    @IBOutlet weak var img_Guest: UIImageView!
    @IBOutlet weak var Un_UsedView: UIView!
    
    @IBOutlet weak var View1 : UIView!
    @IBOutlet weak var View2 : UIView!
    @IBOutlet weak var reqToBookBtnFromView1 : UIButton!
    @IBOutlet weak var instantPayBtnFromView1 : UIButton!
    @IBOutlet weak var commonPayBtnFromView2 : UIButton!
    
    
    @IBOutlet weak var rulesBGGrayView: UIView!
    @IBOutlet weak var rulesBGPopUpView: UIView!
    @IBOutlet weak var rulesTextValueLbl: UILabel!
    @IBOutlet weak var rulesHeaderLbl: UILabel!
    @IBOutlet weak var rulesOkayButton: UIButton!
    
    
    @IBOutlet weak var amentiesTableViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var amentiesPopUpViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var view1HeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var view2HeightConstraints: NSLayoutConstraint!
    
    
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var LoginMessageLbl: UILabel!
     @IBOutlet weak var LoginMessagetxtLbl: UILabel!
     @IBOutlet weak var LoginOkBtn: UIButton!
    
    var DatesMutable : NSMutableArray = []
    var navString : String = ""
    var time : NSMutableArray = []
    var checkinDateStr : String = ""
    var sunLeaveStatus : Bool = false
    var monLeaveStatus : Bool = false
    var tueLeaveStatus : Bool = false
    var wedLeaveStatus : Bool = false
    var thuLeaveStatus : Bool = false
    var friLeaveStatus : Bool = false
    var satLeaveStatus : Bool = false
    var aminityNames : NSMutableArray = []
    var aminityTitle : NSMutableArray = []
    var ServiceTYPE : Int = 0
    var hotelServiceType : String = ""
    var hotelServiceVal : Float = 0
    var startinDate : String = ""
    var endinDate : String = ""
    var selctdDates = NSArray()
    var cancelPercent : String = ""
    //MARK:- Variables
    var PropertyID: String = ""
    var BTN_FRAME_COLOR = UIColor(red: 234/255.0, green: 61/255.0, blue: 62/255.0, alpha: 1.0).cgColor
    let newPin = MKPointAnnotation()
    var stringFromDate : String?
    var AmenitiesArr = [Attribute]()
    var restAminity = [Attribute]()
    var optionsArr = [Option]()
    // var aminitsArr = [Amenty]()
    var hostedby : String = ""
    var sunCheck : Bool = false
    var monCheck : Bool = false
    var tueCheck : Bool = false
    var wedCheck : Bool = false
    var thuCheck : Bool = false
    var friCheck : Bool = false
    var satCheck : Bool = false
    var nobeds : String = ""
    var bed : String = ""
    var bedss : String = ""
    var nobedrooms : String = ""
    var bedroomss : String = ""
    var bedroom : String = ""
    var noguest : String = ""
    var guest : String = ""
    var guests : String = ""
    var notAvaliable : String = ""
    var nights : String = ""
    var minimum_Stay : Int = 0
    var firstDate = Date()
    var lastDate = Date()
    var daysRange : Int = 0
    var datesUsedArr : NSMutableArray = []
    var instantPaycheck : Bool = false
    var reqToBookcheck : Bool = false
    var aminitiesDisplay : NSMutableArray = []
    var detailsleftSideNamesArr : NSMutableArray = []
    var PROP_ID : Int = 0
    var headerTxt : String = ""
    var base_ID : String = ""
    var titleText : String = ""
    
    var instantPayStatusValue : Int = 0
    var reqToBookStatusValue : Int = 0
    
    var host_Status_Str : String = ""
    var guest_Capacity : Int = 0
    
    
    var currencySymbol : String = ""
    var bookedDays : NSMutableArray = []
    var mydates : [String] = []
    var checkedIndate : String = ""
    var checkedOutdate : String = ""
    var seasonalCalendar = NSArray()
    
    var timeEnd : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Un_UsedView.frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
        print(instantPaycheck)
        self.view_Calendar.delegate = self
        //self.navTitle.text = self.navString
        self.navTitle.text = self.titleText
        //  UserDefaults.standard.set(CancelString, forKey: "cancellationKey")
        self.tblHomeDetails.isHidden = true
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        self.btnAmenitiesViewAll.layer.borderWidth = 1.0
        self.btnAmenitiesViewAll.layer.borderColor = UIColor.purple.cgColor
        self.btnAmenitiesViewAll.layer.cornerRadius = 5.0
        
        self.btnAboutTheHost.layer.borderWidth = 1.0
        self.btnAboutTheHost.layer.borderColor = UIColor.purple.cgColor
        self.btnAboutTheHost.layer.cornerRadius = 5.0
        
        self.imgHost2.layer.cornerRadius = self.imgHost2.frame.size.width / 2
        self.imgHost.layer.cornerRadius = self.imgHost.frame.size.width / 2
        self.imgHost2.clipsToBounds = true
        self.imgHost.clipsToBounds = true
        
        view_Calendar.calendarHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view_Calendar.calendarWeekdayView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.view_Calendar.isHidden = true
        view_Calendar.calendarWeekdayView.configureAppearance()
        view_Calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        
        rulesBGGrayView.isHidden = true
        rulesBGPopUpView.layer.cornerRadius = 5.0
        rulesBGPopUpView.layer.masksToBounds = true
        
        detailsleftSideNamesArr = ["Minimum Stay","Cancellation Policy","Other things to note","House Rules","Guest Access","The Space","Iteration with guest","Neighbourhood","Availability","Price details"]
        
        
        // Calender
        self.view_AllAmenities.isHidden = true
        //        if (Reachability()?.isReachable ?? false)
        //        {
        //
        //            showActivityIndicator(uiView: self.view)
        //            let parameterStr = "prod_id=\(PropertyID!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&email=\(login_session.value(forKey: "Email") as? String ?? "")&userid=\(login_session.value(forKey: "UserId")!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
        //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SHOW_PROPERTY_DETAIL, APIKEY: "SHOW_PROPERTY_DETAIL")
        //           //
        //            print(parameterStr)
        //        }
        //        else
        //        {
        //            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        //        }
        PropertyDetail()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickView(_:)))
        rulesBGGrayView.addGestureRecognizer(tapGesture)
        self.view.addSubview(rulesBGGrayView)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        self.view_Calendar.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
        self.view_Calendar.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
        self.view_Calendar.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)

        self.view_Calendar.appearance.headerTitleColor = AppColor
         self.view_Calendar.appearance.weekdayTextColor = AppColor
        
         self.navTitle.font = UIFont(name: SemiBoldFont, size: 18)
         self.priceDetailLabel.font = UIFont(name: SemiBoldFont, size: 18)
        self.inpriceLbl.font = UIFont(name: RegularFont, size: 15)
         self.lblPriceDetailPrice.font = UIFont(name: RegularFont, size: 15)
         self.lblPriceDetailSecurityDepo.font = UIFont(name: RegularFont, size: 15)
         self.securityLbl.font = UIFont(name: RegularFont, size: 15)
        
        self.reqToBookBtnFromView1.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.instantPayBtnFromView1.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.commonPayBtnFromView2.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        
         self.reqToBookBtnFromView1.backgroundColor = AppColor
         self.instantPayBtnFromView1.backgroundColor = AppColor
         self.commonPayBtnFromView2.backgroundColor = AppColor
         self.rulesHeaderLbl.font = UIFont(name: SemiBoldFont, size: 18)
         self.rulesTextValueLbl.font = UIFont(name: RegularFont, size: 15)
          self.rulesOkayButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 12)
        
          self.rulesOkayButton.titleLabel?.textColor = AppSecondColor
        self.LoginMessageLbl.font = UIFont(name: SemiBoldFont, size: 20)
         self.LoginMessagetxtLbl.font = UIFont(name: RegularFont, size: 20)
         self.LoginOkBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.LoginOkBtn.backgroundColor = AppColor
        self.lblPropertyName.font = UIFont(name: SemiBoldFont, size: 15)
        
         self.lblPricetxtfield.font = UIFont(name: SemiBoldFont, size: 15)
        self.lblHostName.font = UIFont(name: RegularFont, size: 15)
         self.lblPropertyName2.font = UIFont(name: RegularFont, size: 15)
        self.lblPricetxtfield.backgroundColor = AppColor
        self.lblNoofGuest.font = UIFont(name: RegularFont, size: 13)
        self.lblBeds.font = UIFont(name: RegularFont, size: 15)
        self.llblBedroom.font = UIFont(name: RegularFont, size: 15)
        
        self.hideActivityIndicator(uiView: self.view)
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.hostedby = LocalizeHelper().localizedStringForKey("hostedby")
            self.nobeds = LocalizeHelper().localizedStringForKey("nobed")
            self.nobedrooms = LocalizeHelper().localizedStringForKey("nobedroom")
            self.noguest = LocalizeHelper().localizedStringForKey("noguest")
            self.guest = LocalizeHelper().localizedStringForKey("guest")
            self.guests = LocalizeHelper().localizedStringForKey("guests")
            self.bed = LocalizeHelper().localizedStringForKey("bed")
            self.bedss = LocalizeHelper().localizedStringForKey("beds")
            self.bedroomss = LocalizeHelper().localizedStringForKey("bedrooms")
            self.bedroom = LocalizeHelper().localizedStringForKey("bedroom")
            self.notAvaliable = LocalizeHelper().localizedStringForKey("notavailable")
            self.nights = LocalizeHelper().localizedStringForKey("nightscap")
            //self.listingLabel.text = LocalizeHelper().localizedStringForKey("listingsmall")
            self.detailsLabel.text = LocalizeHelper().localizedStringForKey("details")
            self.amenitiesLabel.text = LocalizeHelper().localizedStringForKey("amenities")
            self.aboutHostLabel.text = LocalizeHelper().localizedStringForKey("about")
            self.btnAmenitiesViewAll.setTitle(LocalizeHelper().localizedStringForKey("viewall"), for: .normal)
            self.btnAboutTheHost.setTitle(LocalizeHelper().localizedStringForKey("moreabouthost"), for: .normal)
            self.minimumStay.text = LocalizeHelper().localizedStringForKey("minstay")
            self.cancellationpolicy.text = LocalizeHelper().localizedStringForKey("canpolicy")
            self.avaliability.text = LocalizeHelper().localizedStringForKey("availability")
            self.priceDetails.text = LocalizeHelper().localizedStringForKey("pricedetails")
            self.requesttoBook.setTitle(LocalizeHelper().localizedStringForKey("requesttobook"), for: .normal)
            self.priceDetailLabel.text = LocalizeHelper().localizedStringForKey("pricedetails")
            self.inpriceLbl.text = LocalizeHelper().localizedStringForKey("price")
            self.securityLbl.text = LocalizeHelper().localizedStringForKey("securitydeposit")
            self.btnPriceDetails.setTitle(LocalizeHelper().localizedStringForKey("view"), for: .normal)
            self.btnViewCalender.setTitle(LocalizeHelper().localizedStringForKey("viewcalender"), for: .normal)
        }
        
        
    }
    @objc func printTime(){
        self.tblHomeDetails.reloadData()
    }
    
    func PropertyDetail() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params =  ["prod_id": PropertyID,"page_Id":"1","lang_code":"en","user_id":UserID]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(SHOW_PROPERTY_DETAIL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                let mod = PropertyDetails(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.PropertyDetail = mod
                print(responseDict)
//                Int(mod.minimumStay) ?? 1
                let checkdatesArr = responseDict.value(forKey: "check") as! NSArray
                if (responseDict.value(forKey: "host_status") as? String) != nil
                {
                    self.host_Status_Str = (responseDict.value(forKey: "host_status") as? String)!
                }
                else
                {
                    self.host_Status_Str = ""
                }
                print("host_Status_Str", self.host_Status_Str)
                
                if (responseDict.value(forKey: "guest_capacity") as? String) != nil
                {
                    self.guest_Capacity = Int((responseDict.value(forKey: "guest_capacity") as? String)!)!
                }
                else
                {
                    self.guest_Capacity = 0
                }
                
                Singleton.sharedInstance.PropertyDetail = mod
                
                if mod.minimumStay == ""
                {
                    self.minimum_Stay = 0
                }
                else
                {
                    self.minimum_Stay = Int(mod.minimumStay)!
                }
                
                let instantPayResponse = responseDict.value(forKey: "instant_pay_status") as? Int ?? 0
                
                if instantPayResponse == 1
                {
                    self.instantPayStatusValue = 1
                }
                else
                {
                    self.instantPayStatusValue = 0
                }
                
                
                let requesttoBookResponse = responseDict.value(forKey: "request_to_book_status") as? Int ?? 0
                
                if requesttoBookResponse == 1
                {
                    self.reqToBookStatusValue = 1
                }
                else
                {
                    self.reqToBookStatusValue = 0
                }
                
                
                if self.instantPayStatusValue == 1 && self.reqToBookStatusValue == 1
                {
                    self.View1.isHidden = false
                    self.View2.isHidden = true
                }
                else
                {
                    self.View2.isHidden = false
                    self.View1.isHidden = true
                    
                    if self.instantPayStatusValue == 1
                    {
                        self.commonPayBtnFromView2.setTitle("INSTANT PAY", for: .normal)
                    }
                    else
                    {
                        self.commonPayBtnFromView2.setTitle("REQUEST TO BOOK", for: .normal)
                    }
                    
                }
                
                if self.instantPayStatusValue == 0 && self.reqToBookStatusValue == 0
                {
                    self.View1.isHidden = true
                    self.View2.isHidden = true
                }
                
                let user1 = UserID //(login_session.value(forKey: "UserId")!) as AnyObject
                let user2 = (Singleton.sharedInstance.PropertyDetail.hostId)
                
                
                if String(describing: user1) == String(describing: user2)
                {
                    self.View1.isHidden = true
                    self.View2.isHidden = true
                    self.requesttoBook.isHidden = true
                    self.view1HeightConstraints.constant = 0
                    self.view2HeightConstraints.constant = 0
                }
                else
                {
                    self.view1HeightConstraints.constant = 52
                    self.view2HeightConstraints.constant = 52
                }
                
                for i in 0..<checkdatesArr.count
                {
                    self.checkedIndate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkin") as? String ?? ""
                    
                    self.checkedOutdate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkout") as? String ?? ""
                    
                    self.datesBtnDates()
                }
                
                
                self.DatesMutable.removeAllObjects()
                let Dates = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice.count
                
                for i in 0..<Dates{
                    let dateString = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].date
                    let dateStatus = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].status
                    let datePrice = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].price
                    let datesArray = NSMutableDictionary()
                    datesArray.setValue(dateString, forKey: "DateString")
                    datesArray.setValue(dateStatus, forKey: "DateStatus")
                    datesArray.setValue(datePrice, forKey: "DatePrice")
                    self.DatesMutable.add(datesArray)
                }
                print(self.DatesMutable)
                
                
                let ServiceDetail:NSDictionary = responseDict.value(forKey: "services") as! NSDictionary
                
                if ServiceDetail.value(forKey: "service_type") != nil
                {
                    self.hotelServiceType = ServiceDetail.value(forKey: "service_type") as? String ?? ""
                }
                else
                {
                    self.hotelServiceType = ""
                }
                print(self.hotelServiceType)
                
                if ServiceDetail.value(forKey: "service_value") as? Float != nil
                {
                    self.hotelServiceVal = ServiceDetail.value(forKey: "service_value") as! Float
                }
                else
                {
                    self.hotelServiceVal = 0.0
                }
                if let cancelPercentStr:String = responseDict.value(forKey: "cancel_percentage") as? String
                {
                    self.cancelPercent = cancelPercentStr
                    print(self.cancelPercent)
                }
                print(self.cancelPercent)
                self.tbl_AllAmenities.reloadData()
                self.tblHomeDetails.reloadData()
                self.collImageSlider.reloadData()
                self.collReview.reloadData()
                self.setMapLocation()
                self.setData()
                self.tblHomeDetails.isHidden = false
                
                print(Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice)
                
                
                let seasonalArr = responseDict.value(forKey: "seasonal_calendar_price") as! NSArray
                self.seasonalCalendar = seasonalArr
                if self.seasonalCalendar.count != 0
                {
                    for i in 0..<self.seasonalCalendar.count
                    {
                        let seasonalDate:String = (((self.seasonalCalendar.object(at: i)) as AnyObject).value(forKey: "date") as? String)!
                        print(seasonalDate)
                    }
                }
                
                if Singleton.sharedInstance.PropertyDetail.productImage.count > 1
                {
                    self.startTimer()
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
    
    @IBAction func LoginView_CancelAct(_ sender: UIButton)
    {
        self.LoginView.isHidden = true
    }
    @IBAction func LoginView_OkAct(_ sender: UIButton)
    {
        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
        self.navigationController?.pushViewController(navgt!, animated: true)
    }
    
    
    //    func PropertyDetail(){
    //        let params =  ["prod_id": PropertyID!,"page_Id":"1","lang_code":"en"]
    //        print(params)
    //        APIManager.apiPost(serviceName: SHOW_PROPERTY_DETAIL, parameters: params) { (json:NSDictionary?, error:NSError?) in
    //
    //            if error != nil
    //            {
    //                print(error?.localizedDescription ?? "")
    //                return
    //            }
    //            print(json!)
    //
    //            if (json!.value(forKey: "status")  as? Int) == 1{
    //
    //                let mod = PropertyDetails(fromDictionary: json as! [String : Any])
    //                Singleton.sharedInstance.PropertyDetail = mod
    //                print(json)
    //                Int(mod.minimumStay!) ?? 1
    //                let checkdatesArr = json!.value(forKey: "check") as! NSArray
    //                if (json!.value(forKey: "host_status") as? String) != nil
    //                {
    //                    self.host_Status_Str = (json!.value(forKey: "host_status") as? String)!
    //                }
    //                else
    //                {
    //                    self.host_Status_Str = ""
    //                }
    //                print("host_Status_Str", self.host_Status_Str)
    //
    //                if (json!.value(forKey: "guest_capacity") as? String) != nil
    //                {
    //                    self.guest_Capacity = Int((json!.value(forKey: "guest_capacity") as? String)!)!
    //                }
    //                else
    //                {
    //                    self.guest_Capacity = 0
    //                }
    //
    //                Singleton.sharedInstance.PropertyDetail = mod
    //
    //                if mod.minimumStay == ""
    //                {
    //                    self.minimum_Stay = 0
    //                }
    //                else
    //                {
    //                    self.minimum_Stay = Int(mod.minimumStay)!
    //                }
    //
    //                let instantPayResponse = json!.value(forKey: "instant_pay_status") as? Int ?? 0
    //
    //                if instantPayResponse == 1
    //                {
    //                    self.instantPayStatusValue = 1
    //                }
    //                else
    //                {
    //                    self.instantPayStatusValue = 0
    //                }
    //
    //
    //                let requesttoBookResponse = json!.value(forKey: "request_to_book_status") as? Int ?? 0
    //
    //                if requesttoBookResponse == 1
    //                {
    //                    self.reqToBookStatusValue = 1
    //                }
    //                else
    //                {
    //                    self.reqToBookStatusValue = 0
    //                }
    //
    //
    //                if self.instantPayStatusValue == 1 && self.reqToBookStatusValue == 1
    //                {
    //                    self.View1.isHidden = false
    //                    self.View2.isHidden = true
    //                }
    //                else
    //                {
    //                    self.View2.isHidden = false
    //                    self.View1.isHidden = true
    //
    //                    if self.instantPayStatusValue == 1
    //                    {
    //                        self.commonPayBtnFromView2.setTitle("INSTANT PAY", for: .normal)
    //                    }
    //                    else
    //                    {
    //                        self.commonPayBtnFromView2.setTitle("REQUEST TO BOOK", for: .normal)
    //                    }
    //
    //                }
    //
    //                if self.instantPayStatusValue == 0 && self.reqToBookStatusValue == 0
    //                {
    //                    self.View1.isHidden = true
    //                    self.View2.isHidden = true
    //                }
    //
    //                let user1 = (login_session.value(forKey: "UserId")!) as AnyObject
    //                let user2 = (Singleton.sharedInstance.PropertyDetail.hostId)
    //
    //
    //                if String(describing: user1) == String(describing: user2)
    //                {
    //                    self.View1.isHidden = true
    //                    self.View2.isHidden = true
    //                    self.requesttoBook.isHidden = true
    //                    self.view1HeightConstraints.constant = 0
    //                    self.view2HeightConstraints.constant = 0
    //                }
    //                else
    //                {
    //                    self.view1HeightConstraints.constant = 52
    //                    self.view2HeightConstraints.constant = 52
    //                }
    //
    //                for i in 0..<checkdatesArr.count
    //                {
    //                    self.checkedIndate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkin") as? String ?? ""
    //
    //                    self.checkedOutdate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkout") as? String ?? ""
    //
    //                    self.datesBtnDates()
    //                }
    //
    //
    //                self.DatesMutable.removeAllObjects()
    //                let Dates = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice.count
    //
    //                for i in 0..<Dates{
    //                    let dateString = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].date!
    //                    let dateStatus = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].status!
    //                    let datePrice = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].price!
    //                    let datesArray = NSMutableDictionary()
    //                    datesArray.setValue(dateString, forKey: "DateString")
    //                    datesArray.setValue(dateStatus, forKey: "DateStatus")
    //                    datesArray.setValue(datePrice, forKey: "DatePrice")
    //                    self.DatesMutable.add(datesArray)
    //                }
    //                print(self.DatesMutable)
    //                //AmenitiesArr = Singleton.sharedInstance.PropertyDetail.listDetails[0].listName
    //                //                let imgURL = URL(string: Singleton.sharedInstance.PropertyDetail.hostimg!)
    //                //                self.imgHost.kf.setImage(with: imgURL!)
    //                //                self.imgHost2.kf.setImage(with: imgURL!)
    //                //let instantPayStat = Singleton.sharedInstance.PropertyDetail.instantPayStatus!
    //                //self.instantPaycheck = instantPayStat
    //                //print(instantPaycheck)
    //
    //                //let reqToBookStat = Singleton.sharedInstance.PropertyDetail.requestToBookStatus!
    //                //self.reqToBookcheck = reqToBookStat
    //
    //                let ServiceDetail:NSDictionary = json!.value(forKey: "services") as! NSDictionary
    //
    //                if ServiceDetail.value(forKey: "service_type") != nil
    //                {
    //                    self.hotelServiceType = ServiceDetail.value(forKey: "service_type") as? String ?? ""
    //                }
    //                else
    //                {
    //                    self.hotelServiceType = ""
    //                }
    //                print(self.hotelServiceType)
    //
    //                if ServiceDetail.value(forKey: "service_value") as? Float != nil
    //                {
    //                    self.hotelServiceVal = ServiceDetail.value(forKey: "service_value") as! Float
    //                }
    //                else
    //                {
    //                    self.hotelServiceVal = 0.0
    //                }
    //                if let cancelPercentStr:String = json!.value(forKey: "cancel_percentage") as? String
    //                {
    //                    self.cancelPercent = cancelPercentStr
    //                    print(self.cancelPercent)
    //                }
    //                print(self.cancelPercent)
    //                self.tbl_AllAmenities.reloadData()
    //                self.tblHomeDetails.reloadData()
    //                self.collImageSlider.reloadData()
    //                self.collReview.reloadData()
    //                self.setMapLocation()
    //                self.setData()
    //                self.tblHomeDetails.isHidden = false
    //
    //
    //                if Singleton.sharedInstance.PropertyDetail.productImage.count > 1
    //                {
    //                    self.startTimer()
    //                }
    //            }
    //            }
    //        }
    
    
    
    @objc func clickView(_ sender: UIView)
    {
        rulesBGGrayView.isHidden = true
    }
    
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        return _shouldAllowSelectionOf(date)
    }
    
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    //    {
    //         if date == firstDate && date == lastDate
    //         {
    //           return UIColor.purple
    //         }
    //        return UIColor.cyan
    //    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func act_requestToBookBtnTappedfromView1(_ sender: UIButton)
    {
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = Singleton.sharedInstance.PropertyDetail.hostId
            
            if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "Host is unable to book own Property")
            }else{
                if host_Status_Str == "Active"
                {
                    self.reqToBookcheck = true
                    self.instantPaycheck = false
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailViewController") as? BookingDetailViewController
                    nav!.minStay = self.minimum_Stay
                    nav!.hotelServTyp = self.hotelServiceType
                    nav!.hotelServVal = self.hotelServiceVal
                    nav!.instantPay = self.instantPaycheck
                    nav!.reqtoBook = self.reqToBookcheck
                    nav!.DatesMutable = self.DatesMutable
                    nav!.app_Currency_Symbol = self.currencySymbol
                    nav!.hotelcancelPercentage = self.cancelPercent
                    nav!.seasonalPrices = self.seasonalCalendar
                    nav!.bookedDates = self.bookedDays as! [String]
                    self.navigationController?.pushViewController(nav!, animated: true)
                }
                else
                {
                    self.showInformation(title: "Closest", message: "Host is not available now")
                    
                }
            }
        }else{
            self.LoginView.isHidden = false
        }
        
        
        
        
        
    }
    
    @IBAction func act_InstantPayBtnTappedFromView1(_ sender: UIButton)
    {
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = Singleton.sharedInstance.PropertyDetail.hostId
            
            if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "Host is unable to book own Property")
            }else{
                
                if host_Status_Str == "Active"
                {
                    
                    self.reqToBookcheck = false
                    self.instantPaycheck = true
                    
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailViewController") as? BookingDetailViewController
                    nav!.minStay = self.minimum_Stay
                    nav!.hotelServTyp = self.hotelServiceType
                    nav!.hotelServVal = self.hotelServiceVal
                    nav!.instantPay = self.instantPaycheck
                    nav!.reqtoBook = self.reqToBookcheck
                    nav!.DatesMutable = self.DatesMutable
                    nav!.app_Currency_Symbol = self.currencySymbol
                    nav!.hotelcancelPercentage = self.cancelPercent
                    nav!.seasonalPrices = self.seasonalCalendar
                    nav!.bookedDates = self.bookedDays as! [String]
                    self.navigationController?.pushViewController(nav!, animated: true)
                }else
                {
                    self.showInformation(title: "Closest", message: "Host is not available now")
                    
                }
            }
        }else{
            self.LoginView.isHidden = false
        }
        
        
        
        
    }
    
    @IBAction func act_PayBtnTappedFromView2(_ sender: UIButton)
    {
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = Singleton.sharedInstance.PropertyDetail.hostId
            
            if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "Host is unable to book own Property")
            }else{
                
                
                if host_Status_Str == "Active"
                {
                    
                    if sender.currentTitle == "INSTANT PAY"
                    {
                        self.reqToBookcheck = false
                        self.instantPaycheck = true
                        
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailViewController") as? BookingDetailViewController
                        nav!.minStay = self.minimum_Stay
                        nav!.hotelServTyp = self.hotelServiceType
                        nav!.hotelServVal = self.hotelServiceVal
                        nav!.instantPay = self.instantPaycheck
                        nav!.reqtoBook = self.reqToBookcheck
                        nav!.DatesMutable = self.DatesMutable
                        nav!.app_Currency_Symbol = self.currencySymbol
                        nav!.hotelcancelPercentage = self.cancelPercent
                        nav!.seasonalPrices = self.seasonalCalendar
                        nav!.bookedDates = self.bookedDays as! [String]
                        self.navigationController?.pushViewController(nav!, animated: true)
                        
                    }
                    else
                    {
                        self.reqToBookcheck = true
                        self.instantPaycheck = false
                        
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailViewController") as? BookingDetailViewController
                        nav!.minStay = self.minimum_Stay
                        nav!.hotelServTyp = self.hotelServiceType
                        nav!.hotelServVal = self.hotelServiceVal
                        nav!.instantPay = self.instantPaycheck
                        nav!.reqtoBook = self.reqToBookcheck
                        nav!.DatesMutable = self.DatesMutable
                        nav!.app_Currency_Symbol = self.currencySymbol
                        nav!.hotelcancelPercentage = self.cancelPercent
                        self.navigationController?.pushViewController(nav!, animated: true)
                    }
                }
                else
                {
                    self.showInformation(title: "Closest", message: "Host is not available now")
                    
                }
            }
        }else{
            self.LoginView.isHidden = false
        }
        
        
        
        
    }
    
    
    func leaveCheck(){
        
    }
    @IBAction func btnPriceForHotelAct(_ sender: UIButton) {
        UIView.transition(with: self.viewPriceDetails,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.viewPriceDetails.isHidden = false
                            self.view_grey.isHidden = false
        },
                          completion: nil)
        
    }
    
    @IBAction func act_viewAllAmenities(_ sender: UIButton)
    {
        self.tbl_AllAmenities.isHidden = false
        self.view_AllAmenities.isHidden = false
        self.view_grey.isHidden = false
        if (Reachability()?.isReachable ?? false)
        {
            showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_RENT_YOUR_SPACE, APIKEY: "REQ_RENT_YOUR_SPACE")
        }
        else
        {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    @IBAction func act_MoreabtHost(_ sender: UIButton)
    {
        showActivityIndicator(uiView: self.view)
        let navgtn = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
       // navgtn!.hostID = Singleton.sharedInstance.PropertyDetail.hostId
        self.navigationController?.pushViewController(navgtn!, animated: true)
    }
    
    
    @IBAction func act_PriceDetails(_ sender: UIButton) {
        
        UIView.transition(with: self.viewPriceDetails,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.viewPriceDetails.isHidden = false
                            self.view_grey.isHidden = false
        },
                          completion: nil)
    }
    
    @IBAction func act_viewAllReview(_ sender: UIButton)
    {
        
    }
    
    @objc func detailsBtnClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("buttonRow is:",buttonRow)
        
        if buttonRow == 2
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "Other things to note"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.otherThingsToNote
            
        }
        else if buttonRow == 3
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "House Rules"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.houseRules
            
            
        }
        else if buttonRow == 4
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "Guest Access"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.guestAccess
            
            
        }
            
        else if buttonRow == 5
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "The Space"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.productSpace
            
            
        }
            
        else if buttonRow == 6
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "Interation with guest"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.interactGuest
            
            
        }
        else if buttonRow == 7
        {
            rulesBGGrayView.isHidden = false
            rulesHeaderLbl.text = "Neighbourhood"
            rulesTextValueLbl.text = Singleton.sharedInstance.PropertyDetail.neighborOverview
            
            
        }
        else if buttonRow == 8
        {
            UIView.transition(with: self.view_Calendar,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.view_Calendar.isHidden = false
                                self.view_grey.isHidden = false
            },
                              completion: nil)
            print(startinDate)
            print(endinDate)
            
        }
        else if buttonRow == 9
        {
            UIView.transition(with: self.viewPriceDetails,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.viewPriceDetails.isHidden = false
                                self.view_grey.isHidden = false
            },
                              completion: nil)
        }
        
    }
    
    
    @objc func viewAllAmentiesBtnClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("buttonRow is:",buttonRow)
        
        DispatchQueue.main.async(execute: {
            //This code will run in the main thread:
            var frame: CGRect = self.tbl_AllAmenities.frame
            frame.size.height = self.tbl_AllAmenities.contentSize.height
            if self.tbl_AllAmenities.contentSize.height <= 200
            {
                self.tbl_AllAmenities.frame = frame
                self.amentiesTableViewHeightConstraints.constant = self.tbl_AllAmenities.contentSize.height + 30
                self.amentiesPopUpViewHeightConstraints.constant = self.tbl_AllAmenities.contentSize.height + 30
            }else
            {
                self.amentiesTableViewHeightConstraints.constant = 200
                self.amentiesPopUpViewHeightConstraints.constant = 200
            }
        })
        self.tbl_AllAmenities.isHidden = false
        self.view_AllAmenities.isHidden = false
        self.view_grey.isHidden = false
        self.tbl_AllAmenities.reloadData()
        
        //        if (Reachability()?.isReachable ?? false)
        //        {
        //            showActivityIndicator(uiView: self.view)
        //            let id = Singleton.sharedInstance.selectedCategory
        //            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
        //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_RENT_YOUR_SPACE, APIKEY: "REQ_RENT_YOUR_SPACE")
        //        }
        //        else
        //        {
        //            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        //        }
        
        
    }
    
    @objc func MoreAboutHostBtnClicked(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("buttonRow is:",buttonRow)
        showActivityIndicator(uiView: self.view)
        let navgtn = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
       // navgtn!.hostID = Singleton.sharedInstance.PropertyDetail.hostId
        self.navigationController?.pushViewController(navgtn!, animated: true)
        
    }
    @objc func ViewAllReviews(sender:UIButton) {
        
        let buttonRow = sender.tag
        print("buttonRow is:",buttonRow)
        showActivityIndicator(uiView: self.view)
        let navgtn = self.storyboard?.instantiateViewController(withIdentifier: "ReviewsShowViewController") as? ReviewsShowViewController
        // navgtn!.hostID = Singleton.sharedInstance.PropertyDetail.hostId
        self.navigationController?.pushViewController(navgtn!, animated: true)
        
    }
    
    
    @IBAction func act_RequestToBook(_ sender: UIButton) {
        //UserDefaults.standard.setValue("", forKey: "checkdate")
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
               {
        
        
        let userId = login_session.value(forKey: "UserId") as? AnyObject
        let hostId = Singleton.sharedInstance.PropertyDetail.hostId
        
        if String(describing: userId!) == String(describing: hostId) {
            self.showInformation(title: "Closest", message: "Host is unable to book own Property")
        }else{
            print(instantPaycheck)
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailViewController") as? BookingDetailViewController
            nav!.minStay = self.minimum_Stay
            nav!.hotelServTyp = self.hotelServiceType
            nav!.hotelServVal = self.hotelServiceVal
            nav!.instantPay = self.instantPaycheck
            nav!.reqtoBook = self.reqToBookcheck
            nav!.DatesMutable = self.DatesMutable
            nav!.app_Currency_Symbol = self.currencySymbol
            nav!.hotelcancelPercentage = self.cancelPercent
            nav!.seasonalPrices = self.seasonalCalendar
            nav!.bookedDates = self.bookedDays as! [String]
            self.navigationController?.pushViewController(nav!, animated: true)
        }
        }else{
             self.LoginView.isHidden = false
        }
    }
    @IBAction func timeTableAct(_ sender: UIButton) {
        
    }
    
    @IBAction func act_TapGreyView(_ sender: UITapGestureRecognizer) {
        self.viewPriceDetails.isHidden = true
        self.view_grey.isHidden = true
        self.view_AllAmenities.isHidden = true
        self.tbl_AllAmenities.isHidden = true
        self.view_Calendar.isHidden = true
    }
    
    
    
    @IBAction func act_rulesOkayButtonTapped(_ sender: UIButton)
    {
        rulesBGGrayView.isHidden = true
    }
    
    @IBAction func act_CalendarView(_ sender: UIButton) {
        UIView.transition(with: self.view_Calendar,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.view_Calendar.isHidden = false
                            self.view_grey.isHidden = false
        },
                          completion: nil)
        print(startinDate)
        print(endinDate)
    }
    func _shouldAllowSelectionOf(_ date: Date?) -> Bool
    {
        if date?.compare(firstDate) == .orderedDescending && date?.compare(lastDate) == .orderedAscending {
            return true
        }
        return false
    }
    
    func setMapLocation() {
        
        
        let lat = Singleton.sharedInstance.PropertyDetail.latitude
        let long = Singleton.sharedInstance.PropertyDetail.longitude
        let center = CLLocationCoordinate2D(latitude: Double(lat)! , longitude: Double(long)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapLocation.setRegion(region, animated: true)
        newPin.coordinate =  center
        mapLocation.addAnnotation(newPin)
    }
    
    
    func CalculateNumOfDays()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let firstDate = dateFormatter.date(from: startinDate)
        let lastDate = dateFormatter.date(from: endinDate)
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour], from: firstDate!)
        let distanceBetweenDates: TimeInterval? = lastDate!.timeIntervalSince(firstDate!)
        let secondsInDays: Double = 86400
        daysRange = Int((distanceBetweenDates! / secondsInDays))
        print(daysRange)
        
    }
    
    
    
    //        func datesRange()
    //        {
    //            if firstDate > lastDate {
    //
    //            var tempDate = firstDate
    //            var arrayDates = [tempDate]
    //
    //            while tempDate < lastDate {
    //                tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
    //                arrayDates.append(tempDate)
    //
    //            }
    //            print(arrayDates)
    //
    //        }
    //    }
    
    //set region on the map
    
    
    func startTimer() {
        
        let timer =  Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  =  collImageSlider
        {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < Singleton.sharedInstance.PropertyDetail.productImage.count - 1)
                {
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
    }
    
    
    func setData(){
        
        if Singleton.sharedInstance.PropertyDetail.couponDetails.count == 0 {
            
        }else{
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(printTime), userInfo: nil, repeats: true)
            timer.fire()
        }
        
        
        
        
        
        self.img_cuisineType.image = UIImage(named: "ic_rooms")
        self.img_Guest.image = UIImage(named: "ic_guests")
        self.img_foodType.image = UIImage(named: "ic_beds")
        self.menuDetails.isHidden = true
        self.menuDetailAct.isHidden = true
        self.pricedetailsss.isHidden = true
        self.pricedetailsssAct.isHidden = true
        //self.lineview5.isHidden = true
        self.livew6.isHidden = true
        self.view7.isHidden = true
        //self.lblPricetxtfield.layer.cornerRadius = 5.0
        //self.lblPricetxtfield.layer.masksToBounds = true
        if let price = Singleton.sharedInstance.PropertyDetail.productprice
        {
            let amount1 = NSDecimalNumber(string: "\(price)")
            let rounding1 = Double(truncating: amount1)
            let NetAmount = String(format: "%.2f",rounding1)
            //self.lblPrice.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: price)
            //self.lblPriceDetailPrice.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: price)
//            if let userCurrencyStr:String = Singleton.sharedInstance.PropertyDetail.userCurrency{
                self.lblPricetxtfield.text = "" + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: NetAmount)
                self.lblPriceDetailPrice.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: NetAmount)
//            }else{
//                self.lblPricetxtfield.text = "" + currencySymbol + " " + String(describing: NetAmount)
//                self.lblPriceDetailPrice.text = "  " + currencySymbol + " " + String(describing: NetAmount)
//
//            }
        }
//        if let proName = Singleton.sharedInstance.PropertyDetail.defaultproducttitle {
            self.lblPropertyName.text = Singleton.sharedInstance.PropertyDetail.defaultproducttitle
            self.lblPropertyName2.text = Singleton.sharedInstance.PropertyDetail.defaultproducttitle
//        }
//        if let hostName = Singleton.sharedInstance.PropertyDetail.hostname {
            self.lblHostName.text = hostedby + " " + String(describing: Singleton.sharedInstance.PropertyDetail.hostname)
//        }
//        if let hostID = Singleton.sharedInstance.PropertyDetail.hostId
//        {
//            print(hostID)
//        }
        if Singleton.sharedInstance.PropertyDetail.hostimg != nil
        {
            let imgUpdated = URL(string:Singleton.sharedInstance.PropertyDetail.hostimg)
            
            self.imgHost.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
            //self.imgHost2.imageFromURL(urlString: img)
            self.imgHost2.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
            
            
        }
        if !Singleton.sharedInstance.PropertyDetail.beds.isEmpty {
            let beds = Singleton.sharedInstance.PropertyDetail.beds
            if beds == "0" || beds == ""{
                self.lblBeds.text = nobeds
            } else if beds == "1" {
                self.lblBeds.text = beds + bed
            } else {
                self.lblBeds.text = beds + bedss
            }
        } else {
            self.lblBeds.text =  nobeds
        }
        if !Singleton.sharedInstance.PropertyDetail.bedrooms.isEmpty {
            let bedrooms = Singleton.sharedInstance.PropertyDetail.bedrooms
            if bedrooms == "0" || bedrooms == ""{
                self.llblBedroom.text = nobedrooms
            } else if bedrooms == "1" {
                self.llblBedroom.text = bedrooms + bedroom
            } else {
                self.llblBedroom.text = bedrooms + bedroomss
            }
        } else {
            self.llblBedroom.text =  nobedrooms
        }
        //        if let accommodates = guest_Capacity
        //        {
        
        if guest_Capacity == Int(0) || guest_Capacity == Int("")
        {
            self.lblNoofGuest.text = noguest
        }
        else if guest_Capacity == Int(1)
        {
            self.lblNoofGuest.text = "\(guest_Capacity)\(" ")\(guest)"
        }
        else
        {
            self.lblNoofGuest.text = "\(guest_Capacity)\(" ")\(guests)"
        }
        //}
        //        else
        //        {
        //            self.lblNoofGuest.text = noguest
        //        }
        if Singleton.sharedInstance.PropertyDetail.propertyReviews == nil || Singleton.sharedInstance.PropertyDetail.propertyReviews.count == 0  {
            self.collReview.isHidden = true
            self.btnViewAllReview.isHidden = true
            self.lblReview.isHidden = true
            self.viewPropReview.isHidden = true
        } else {
            self.collReview.isHidden = false
            self.btnViewAllReview.isHidden = false
            self.lblReview.isHidden = false
            self.viewPropReview.isHidden = false
        }
        
        if !Singleton.sharedInstance.PropertyDetail.minimumStay.isEmpty{
            
            let minimumStay = Singleton.sharedInstance.PropertyDetail.minimumStay
            if minimumStay == "0" || minimumStay == ""{
                self.btnMinStay.setTitle(notAvaliable, for: .normal)
            } else if minimumStay == "1" {
                self.btnMinStay.setTitle("1 Night", for: .normal)
            } else {
                self.btnMinStay.setTitle(minimumStay + " Nights", for: .normal)
            }
        } else {
            self.btnMinStay.setTitle(notAvaliable, for: .normal)
        }
        
        if Singleton.sharedInstance.PropertyDetail.cancellation.isEmpty
        {
            let cancellation = Singleton.sharedInstance.PropertyDetail.cancellation
            self.btnCancellationPolicy.setTitle(cancellation, for: .normal)
        }
        else
        {
            self.btnCancellationPolicy.setTitle(notAvaliable, for: .normal)
        }
        
        if let secuDeposit = Singleton.sharedInstance.PropertyDetail.securityDeposit {
            //self.lblPriceDetailSecurityDepo.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: secuDeposit)
//            if let userCurrencyStr:String = Singleton.sharedInstance.PropertyDetail.userCurrency{
                self.lblPriceDetailSecurityDepo.text = " " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: secuDeposit)
//            }
//            else {
//                self.lblPriceDetailSecurityDepo.text = " " + "" + " " + "0.0"
//            }
        } else {
            self.lblPriceDetailSecurityDepo.text = " " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + "0.0"
        }
    }
    func datesBtnDates()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //    var mydates : [String] = []
        var dateFrom =  Date() // First date
        var dateTo = Date()   // Last date
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        fmt.locale = Locale(identifier: "en_US_POSIX")
        dateFrom = dateFormatter.date(from: self.checkedIndate)!
        dateTo = dateFormatter.date(from: self.checkedOutdate)!
        while dateFrom <= dateTo
        {
            mydates.append(fmt.string(from: dateFrom))
            bookedDays.add(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
    }
}

extension PropertyDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tbl_AllAmenities {
            return 1
            //AmenitiesArr.count
        }
        else {
            return 6
        }
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return ""
    //    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblHomeDetails {
            if Singleton.sharedInstance.PropertyDetail != nil {
                if section == 0
                {
                    return 1
                }else if section == 1 {
                    if Singleton.sharedInstance.PropertyDetail.couponDetails.count == 0 {
                        return 0
                    }else{
                        return 1
                    }
                }
                else if section == 2
                {
                    return Singleton.sharedInstance.PropertyDetail.listingInfo.count
                }
                else if section == 3
                {
                    return detailsleftSideNamesArr.count
                }else if section == 4 {
                    return 1
                }
                else
                {
                    if Singleton.sharedInstance.PropertyDetail.propertyReviews.count == 0 {
                        return 0
                    }else{
                        return 1
                    }
                    
                    
                }
            }
            else
            {
                return 0
            }
        }
        else if tableView == tbl_AllAmenities {
            if Singleton.sharedInstance.PropertyDetail != nil
            {
                return Singleton.sharedInstance.PropertyDetail.listDetails.count
                //AmenitiesArr[section].options.count
            }
            else {
                return 0
            }
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblHomeDetails {
            
            if indexPath.section == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyDescriptionTableViewCell") as? PropertyDescriptionTableViewCell
                cell!.selectionStyle = .none
                cell!.propertyDesc_Lbl.text = Singleton.sharedInstance.PropertyDetail.productdesc
                cell!.Desc_Lbl.font = UIFont(name: SemiBoldFont, size: 15)
                cell!.propertyDesc_Lbl.font = UIFont(name: RegularFont, size: 15)
                return cell!
            }else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell") as? CouponTableViewCell
                cell!.selectionStyle = .none
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd"
                dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
                cell!.couponName.text =  String(format: " Coupon offer : %@ %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponPriceValue,"%")
                cell!.couponCodeLbl.text =  String(format: " Coupon code : %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponCode)
                UIPasteboard.general.string = cell!.couponCodeLbl.text
                cell!.couponTimeLimit.text =  String(format: "Time Limit : %@ - %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDatefrom,Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDateto)
                
                let fromdate = Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDatefrom
                let todate = Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDateto
                //  let FromdateObj = dateFormatter1.date(from: fromdate)
                let TodateObj = dateFormatter1.date(from: todate)
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
                //according to date format your date string
                guard let FromdateObj = dateFormatter.date(from: fromdate) else {
                    fatalError()
                }
                print(FromdateObj) //Convert String to Date
                
                
                let dateFo : DateFormatter = DateFormatter()
                dateFo.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFo.locale = Locale(identifier: "en_US_POSIX")
                let dateString = dateFo.string(from: TodateObj!)
                
                
                
                
                timeEnd = Date(timeInterval: dateString.toDate(format: "yyyy-MM-dd HH:mm:ss").timeIntervalSince(Date()), since: Date())
                
                let timeNow = Date()
                let timeNoww = FromdateObj
                if timeEnd?.compare(timeNow) == ComparisonResult.orderedDescending {
                    
                    
                    
                    let interval = timeEnd?.timeIntervalSince(timeNow)
                    let interval1 = timeEnd?.timeIntervalSince(timeNoww)
                    
                    let days =  (interval! / (60*60*24)).rounded(.down)
                    
                    let daysRemainder = interval?.truncatingRemainder(dividingBy: 60*60*24)
                    
                    let hours = (daysRemainder! / (60 * 60)).rounded(.down)
                    
                    let hoursRemainder = daysRemainder?.truncatingRemainder(dividingBy: 60 * 60).rounded(.down)
                    
                    let minites  = (hoursRemainder! / 60).rounded(.down)
                    
                    let minitesRemainder = hoursRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
                    
                    let scondes = minitesRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
                    
                    
                    let formatter = NumberFormatter()
                    formatter.minimumIntegerDigits = 2
                    
                    
                    
                    cell!.daysLbl.text = formatter.string(from: NSNumber(value:days + 1))
                    cell!.hoursLbl.text =  formatter.string(from: NSNumber(value:hours))
                    cell!.minLbl.text =  formatter.string(from: NSNumber(value:minites))
                    cell!.secLbl.text =  formatter.string(from: NSNumber(value:scondes!))
                }
                else
                {
                    cell!.daysLbl.text = "00"
                    cell!.hoursLbl.text =  "00"
                    cell!.minLbl.text =  "00"
                    cell!.secLbl.text =  "00"
                }
                
                return cell!
            }
            else if indexPath.section == 2
            {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PropertyDetailAmenitiesCell
                cell!.selectionStyle = .none
                cell!.lblAmenitiesName.font = UIFont(name: RegularFont, size: 14)
                cell!.lblAmenitiesValue.font = UIFont(name: RegularFont, size: 14)
//                if let lab = Singleton.sharedInstance.PropertyDetail.listingInfo[indexPath.row].label {
                    cell!.lblAmenitiesName.text = Singleton.sharedInstance.PropertyDetail.listingInfo[indexPath.row].label
//                }
                if !Singleton.sharedInstance.PropertyDetail.listingInfo[indexPath.row].value.isEmpty{
                    cell!.lblAmenitiesValue.text = Singleton.sharedInstance.PropertyDetail.listingInfo[indexPath.row].value
                } else {
                    cell!.lblAmenitiesValue.text = "Not Available"
                }
                return cell!
            }
            else if indexPath.section == 3
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyDetailsTableViewCell") as? PropertyDetailsTableViewCell
                cell!.selectionStyle = .none
                 cell!.detailsNameTxtLabel.font = UIFont(name: RegularFont, size: 14)
                cell!.detailsValueButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.detailsValueButton.titleLabel?.textColor = AppColor
                cell!.detailsNameTxtLabel.text = (detailsleftSideNamesArr[indexPath.row] as? String ?? "")
                if indexPath.row == 0
                {
                    if !Singleton.sharedInstance.PropertyDetail.minimumStay.isEmpty {
                        let minimumStay = Singleton.sharedInstance.PropertyDetail.minimumStay
                        if minimumStay == "0" || minimumStay == ""{
                            cell!.detailsValueButton.setTitle(notAvaliable, for: .normal)
                        } else if minimumStay == "1" {
                            cell!.detailsValueButton.setTitle("1 Night", for: .normal)
                        } else {
                            cell!.detailsValueButton.setTitle(minimumStay + " Nights", for: .normal)
                        }
                    } else {
                        cell!.detailsValueButton.setTitle(notAvaliable, for: .normal)
                    }
                    
                }else if indexPath.row == 1
                {
                    if !Singleton.sharedInstance.PropertyDetail.cancellation.isEmpty
                    {
                        cell!.detailsValueButton.setTitle(Singleton.sharedInstance.PropertyDetail.cancellation, for: .normal)
                    }
                    else
                    {
                        cell!.detailsValueButton.setTitle(notAvaliable, for: .normal)
                    }
                    
                }
                else if indexPath.row == 8
                {
                    cell!.detailsValueButton.setTitle("Select Date", for: .normal)
                    
                }
                else
                {
                    cell!.detailsValueButton.setTitle("View", for: .normal)
                    
                }
                cell!.detailsValueButton.tag = indexPath.row
                cell!.detailsValueButton.addTarget(self,action:#selector(detailsBtnClicked(sender:)), for: .touchUpInside)
                return cell!
            }
            else if indexPath.section == 4
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyHostDetailsTableViewCell") as? PropertyHostDetailsTableViewCell
                cell!.selectionStyle = .none
                cell!.AminitiesLbl.font = UIFont(name: SemiBoldFont, size: 17)
                cell!.viewAllAmentiesBtn.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
                 cell!.MoreAboutHostBtn.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
                               cell!.viewAllAmentiesBtn.titleLabel?.textColor = AppColor
                if Singleton.sharedInstance.PropertyDetail.hostimg != nil
                {
                    let imgUpdated = URL(string:Singleton.sharedInstance.PropertyDetail.hostimg)
                    cell!.hostImageView.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                    cell!.hostImageView.layer.cornerRadius = 50.0
                    cell!.hostImageView.layer.masksToBounds = true
                }
                
                cell!.viewAllAmentiesBtn.tag = indexPath.row
                cell!.viewAllAmentiesBtn.layer.borderWidth = 0.5
                cell!.viewAllAmentiesBtn.layer.cornerRadius = 5.0
                cell!.viewAllAmentiesBtn.layer.borderColor = UIColor.purple.cgColor
                cell!.viewAllAmentiesBtn.addTarget(self,action:#selector(viewAllAmentiesBtnClicked(sender:)), for: .touchUpInside)
                
                cell!.MoreAboutHostBtn.tag = indexPath.row
                cell!.MoreAboutHostBtn.layer.borderWidth = 0.5
                cell!.MoreAboutHostBtn.layer.cornerRadius = 5.0
                cell!.MoreAboutHostBtn.layer.borderColor = UIColor.purple.cgColor
                cell!.MoreAboutHostBtn.addTarget(self,action:#selector(MoreAboutHostBtnClicked(sender:)), for: .touchUpInside)
                
                return cell!
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyReviewDetailsTableViewCell") as? PropertyReviewDetailsTableViewCell
                cell!.selectionStyle = .none
                 cell!.btnAllReviews.titleLabel?.font =  UIFont(name: RegularFont, size: 14)
                cell!.btnAllReviews.addTarget(self,action:#selector(ViewAllReviews(sender:)), for: .touchUpInside)
                cell!.reviewCollection.reloadData()
                return cell!
                
            }
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AllAmenitiesTableViewCell
            cell!.selectionStyle = .none
            cell!.lbl_AmenityName.font =  UIFont(name: RegularFont, size: 14)
            cell!.lbl_AmenityName.text = Singleton.sharedInstance.PropertyDetail.listDetails[indexPath.row].listName
            //AmenitiesArr[indexPath.section].options[indexPath.row].childName!
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tblHomeDetails
        {
            
            if indexPath.section == 5
            {
                return 150
            }
            else if indexPath.section == 2
            {
                if indexPath.row == 2
                {
                    if Singleton.sharedInstance.PropertyDetail.otherThingsToNote == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                }
                else if indexPath.row == 3
                {
                    if Singleton.sharedInstance.PropertyDetail.houseRules == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                    
                }
                else if indexPath.row == 4
                {
                    if Singleton.sharedInstance.PropertyDetail.guestAccess == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                    
                }else if indexPath.row == 5 {
                    if Singleton.sharedInstance.PropertyDetail.interactGuest == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                }
                else if indexPath.row == 6
                {
                    if Singleton.sharedInstance.PropertyDetail.interactGuest == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                    
                }
                else if indexPath.row == 6
                {
                    if Singleton.sharedInstance.PropertyDetail.neighborOverview == ""
                    {
                        return 0
                    }
                    else
                    {
                        return UITableView.automaticDimension
                        
                    }
                    
                }
                else
                {
                    return UITableView.automaticDimension
                }
            }
            else
            {
                return UITableView.automaticDimension
            }
        }
            
        else
        {
            return UITableView.automaticDimension
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 45))
        headerView.autoresizingMask = []
        //let headerView1 = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let Line1 = UIView(frame: CGRect(x: 0, y: 1, width: tableView.frame.size.width, height: 1))
        let Line2 = UIView(frame: CGRect(x: 0, y: 44, width: tableView.frame.size.width, height: 1))
        let lblTilte = UILabel(frame: CGRect(x: 20, y: 3.5, width: tableView.frame.size.width-40, height: 37))
        
        Line1.backgroundColor = UIColor.groupTableViewBackground
        Line2.backgroundColor = UIColor.groupTableViewBackground
        lblTilte.textColor = UIColor.black
        lblTilte.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
        lblTilte.textAlignment = .center
        lblTilte.numberOfLines = 0
        headerView.backgroundColor = UIColor.white
        headerView.addSubview(lblTilte)
        headerView.addSubview(Line1)
        headerView.addSubview(Line2)
        
        if section == 2
        {
            lblTilte.text = "Listings"
            Line1.isHidden = false
            return headerView
            
        }
        else if section == 3
        {
            lblTilte.text = "Details"
            Line1.isHidden = true
            return headerView
            
        }
        else
        {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 3 || section == 2
        {
            return 60.0
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.clipsToBounds = true
    }
    
}

extension String{
    func toDate(format : String) -> Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
}



extension PropertyDetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.PropertyDetail != nil
        {
            if collectionView == self.collImageSlider
            {
                return Singleton.sharedInstance.PropertyDetail.productImage.count
            }
            else
            {
                return Singleton.sharedInstance.PropertyDetail.propertyReviews.count
            }
        } else {
            return  0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView == self.collImageSlider {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as?
            PropertyDetailSliderCell
            let url = URL(string:Singleton.sharedInstance.PropertyDetail.productImage[indexPath.row].productImage)
            //cell!.imgSlider.kf.setImage(with: url)
            cell!.imgSlider.kf.setImage(with: url, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
            return cell!
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PropertyDetailReviewCell
            cell!.bgView.layer.cornerRadius = 5.0
            cell!.bgView.layer.borderColor = UIColor.darkGray.cgColor
            cell!.bgView.layer.borderWidth = 1.0
            cell!.imgReviewUser.imageFromURL(urlString: Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userImage)
            cell!.lblReviewComment.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userName
            cell!.ratingView.rating = Float(Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].starRating as? NSNumber ?? 0)
            return cell!
        }
    }
}

extension PropertyDetailViewController : HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        hideActivityIndicator(uiView: self.view)
        if APIKEY == "SHOW_PROPERTY_DETAIL"
        {
            if errorDict.count == 0 {
                
                if (responseDict.value(forKey: "status")  as? Int) == 1{
                    let mod = PropertyDetails(fromDictionary: responseDict as! [String : Any])
                    print(responseDict)
                    Int(mod.minimumStay) ?? 1
                    let checkdatesArr = responseDict.value(forKey: "check") as! NSArray
                    if (responseDict.value(forKey: "host_status") as? String) != nil
                    {
                        host_Status_Str = (responseDict.value(forKey: "host_status") as? String)!
                    }
                    else
                    {
                        host_Status_Str = ""
                    }
                    print("host_Status_Str", host_Status_Str)
                    
                    if (responseDict.value(forKey: "guest_capacity") as? String) != nil
                    {
                        guest_Capacity = Int((responseDict.value(forKey: "guest_capacity") as? String)!)!
                    }
                    else
                    {
                        guest_Capacity = 0
                    }
                    
                    Singleton.sharedInstance.PropertyDetail = mod
                    
                    if mod.minimumStay == ""
                    {
                        self.minimum_Stay = 0
                    }
                    else
                    {
                        self.minimum_Stay = Int(mod.minimumStay)!
                    }
                    
                    let instantPayResponse = responseDict.value(forKey: "instant_pay_status") as? Int ?? 0
                    
                    if instantPayResponse == 1
                    {
                        instantPayStatusValue = 1
                    }
                    else
                    {
                        instantPayStatusValue = 0
                    }
                    
                    
                    let requesttoBookResponse = responseDict.value(forKey: "request_to_book_status") as? Int ?? 0
                    
                    if requesttoBookResponse == 1
                    {
                        reqToBookStatusValue = 1
                    }
                    else
                    {
                        reqToBookStatusValue = 0
                    }
                    
                    
                    if instantPayStatusValue == 1 && reqToBookStatusValue == 1
                    {
                        self.View1.isHidden = false
                        self.View2.isHidden = true
                    }
                    else
                    {
                        self.View2.isHidden = false
                        self.View1.isHidden = true
                        
                        if instantPayStatusValue == 1
                        {
                            self.commonPayBtnFromView2.setTitle("INSTANT PAY", for: .normal)
                        }
                        else
                        {
                            self.commonPayBtnFromView2.setTitle("REQUEST TO BOOK", for: .normal)
                        }
                        
                    }
                    
                    if instantPayStatusValue == 0 && reqToBookStatusValue == 0
                    {
                        self.View1.isHidden = true
                        self.View2.isHidden = true
                    }
                    
                    let user1 = (login_session.value(forKey: "UserId")!) as AnyObject
                    let user2 = (Singleton.sharedInstance.PropertyDetail.hostId)
                    
                    
                    if String(describing: user1) == String(describing: user2)
                    {
                        self.View1.isHidden = true
                        self.View2.isHidden = true
                        self.requesttoBook.isHidden = true
                        view1HeightConstraints.constant = 0
                        view2HeightConstraints.constant = 0
                    }
                    else
                    {
                        view1HeightConstraints.constant = 52
                        view2HeightConstraints.constant = 52
                    }
                    
                    for i in 0..<checkdatesArr.count
                    {
                        checkedIndate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkin") as? String ?? ""
                        
                        checkedOutdate = ((checkdatesArr.object(at: i)) as AnyObject).value(forKey: "checkout") as? String ?? ""
                        
                        datesBtnDates()
                    }
                    
                    
                    self.DatesMutable.removeAllObjects()
                    let Dates = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice.count
                    
                    for i in 0..<Dates{
                        let dateString = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].date
                        let dateStatus = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].status
                        let datePrice = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].price
                        let datesArray = NSMutableDictionary()
                        datesArray.setValue(dateString, forKey: "DateString")
                        datesArray.setValue(dateStatus, forKey: "DateStatus")
                        datesArray.setValue(datePrice, forKey: "DatePrice")
                        DatesMutable.add(datesArray)
                    }
                    print(DatesMutable)
                    //AmenitiesArr = Singleton.sharedInstance.PropertyDetail.listDetails[0].listName
                    //                let imgURL = URL(string: Singleton.sharedInstance.PropertyDetail.hostimg!)
                    //                self.imgHost.kf.setImage(with: imgURL!)
                    //                self.imgHost2.kf.setImage(with: imgURL!)
                    //let instantPayStat = Singleton.sharedInstance.PropertyDetail.instantPayStatus!
                    //self.instantPaycheck = instantPayStat
                    //print(instantPaycheck)
                    
                    //let reqToBookStat = Singleton.sharedInstance.PropertyDetail.requestToBookStatus!
                    //self.reqToBookcheck = reqToBookStat
                    
                    let ServiceDetail:NSDictionary = responseDict.value(forKey: "services") as! NSDictionary
                    
                    if ServiceDetail.value(forKey: "service_type") != nil
                    {
                        hotelServiceType = ServiceDetail.value(forKey: "service_type") as? String ?? ""
                    }
                    else
                    {
                        hotelServiceType = ""
                    }
                    print(hotelServiceType)
                    
                    if ServiceDetail.value(forKey: "service_value") as? Float != nil
                    {
                        hotelServiceVal = ServiceDetail.value(forKey: "service_value") as! Float
                    }
                    else
                    {
                        hotelServiceVal = 0.0
                    }
                    if let cancelPercentStr:String = responseDict.value(forKey: "cancel_percentage") as? String
                    {
                        cancelPercent = cancelPercentStr
                        print(cancelPercent)
                    }
                    print(cancelPercent)
                    self.tbl_AllAmenities.reloadData()
                    self.tblHomeDetails.reloadData()
                    self.collImageSlider.reloadData()
                    self.collReview.reloadData()
                    setMapLocation()
                    setData()
                    self.tblHomeDetails.isHidden = false
                    
                    
                    if Singleton.sharedInstance.PropertyDetail.productImage.count > 1
                    {
                        startTimer()
                    }
                }
            }
        }
        else if APIKEY == "REQ_RENT_YOUR_SPACE"
        {
            if errorDict.count == 0
            {  self.hideActivityIndicator(uiView: self.view)
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                Singleton.sharedInstance.rentYourSpace = mod
                //AmenitiesArr = Singleton.sharedInstance.rentYourSpace.attribute
                print(AmenitiesArr)
                self.tbl_AllAmenities.reloadData()
            }
        }
        else if APIKEY == "USER_INFO_API"
        {
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
        }
    }
}
