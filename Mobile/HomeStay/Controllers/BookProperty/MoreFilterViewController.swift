////
////  MoreFilterViewController.swift
////  HomeStay
////
////  Created by POFI TECHNOLOGIES on 30/08/18.
////  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
////
//
//import UIKit
//import FSCalendar
//
//class MoreFilterViewController: BaseViewController,RangeSeekSliderDelegate ,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
//    
//    //MARK:- Outlets
//    
//    @IBOutlet weak var secView: UIView!
//    @IBOutlet weak var tblMoreFilterAminities: UITableView!
//    @IBOutlet weak var tblMoreFilterList: UITableView!
//    @IBOutlet weak var priceView: UIView!
//    @IBOutlet weak var guestCountView: UIView!
//    @IBOutlet weak var arrivrDepartView: UIView!
//    @IBOutlet weak var rangeSlider: RangeSeekSlider!
//    @IBOutlet weak var lblPriceTo: UILabel!
//    @IBOutlet weak var lblPriceFrom: UILabel!
//    @IBOutlet weak var greyView: UIView!
//    @IBOutlet weak var lblGuestCount: UILabel!
//    @IBOutlet weak var checkinButton: UIButton!
//    @IBOutlet weak var checkinArrive: UILabel!
//    @IBOutlet weak var btn_selectDepartDate: UIButton!
//    @IBOutlet weak var btn_selectArrivalDate: UIButton!
//    
//    @IBOutlet weak var NavigationTitle: UILabel!
//    
//    
//    
//    @IBOutlet weak var DurationLbl: UILabel!
//                 @IBOutlet weak var GuestLbl: UILabel!
//               @IBOutlet weak var PriceLbl: UILabel!
//            @IBOutlet weak var GuestValueLbl: UILabel!
//                  @IBOutlet weak var FromDateLbl: UILabel!
//                @IBOutlet weak var ToDateLbl: UILabel!
//         @IBOutlet weak var InstantPay: UILabel!
//
//          @IBOutlet weak var PlusBtn: UIButton!
//          @IBOutlet weak var minusBtn: UIButton!
//     @IBOutlet weak var InsPaySltBtn: UIButton!
//    
//    //    open var numberFormatter: NumberFormatter = {
//    //        let numformatter: NumberFormatter = NumberFormatter()
//    //        numformatter.numberStyle = .currency
//    //        numformatter.maximumFractionDigits = 0
//    //        return numformatter
//    //    }()
//    struct homeID {
//        var  homeId :  String
//    }
//    var guestCount = 1
//    //var TotalSection = Singleton.sharedInstance.PlaceList.attribute.count + 2
//    var sec = 0
//    var tempSec = 0
//    var rommARR = [Option]()
//    var amenitieARR = [Option]()
//    var propertyARR = [Option]()
//    var app_Currency = login_session.value(forKey: "APP_CURRENCY_SYMBOL") as? String ?? ""
//    var isFromDate = "Arrive"
//    var fromDate = Date()
//    var toDate = Date()
//    var minimumDate = Date()
//    var arriveDate : String = ""
//    var departDate : String = ""
//    var noOfNights : Int = 0
//    var RoomType : String = ""
//    var HomeType : String = ""
//    var cityName:String!
//    var FilterArr = [Room]()
//    var filterId : String = ""
//    var roomChildID : Int = 0
//    var homeChildID : Int = 0
//    var listChildID : Int = 0
//    var HiDSArray : NSMutableArray = []
//    var RiDSArray : NSMutableArray = []
//    var AttriDSArray : NSMutableArray = []
//    var HomeString : String = ""
//    var RoomString : String = ""
//    var AttributeString : String = ""
//    var guest : String = ""
//    var guests : String = ""
//    var moreFilterId : NSMutableArray = []
//    var moreFilterIDS : NSMutableArray = []
//    var moreFilterIDSA : NSMutableArray = []
//    var FilterId : String = ""
//    var FilterIDS : String = ""
//    var FilterIDSA : String = ""
//    var minPrice : String = ""
//    var maxPrice : String = ""
//    var moreOpenId : NSMutableArray = []
//    var moreCusinId : NSMutableArray = []
//    var openIDS : String = ""
//    var CusinIDS : String = ""
//    var arrivedDate : String = ""
//    var departingDate : String = ""
//
//    @IBOutlet weak var applyfilteers: UIButton!
//    @IBOutlet weak var checkInCalenderView: FSCalendar!
//    @IBOutlet weak var listingtype: UILabel!
//    @IBOutlet weak var pricelbl: UILabel!
//    @IBOutlet weak var guestCn: UILabel!
//    @IBOutlet weak var depart: UILabel!
//    @IBOutlet weak var arrive: UILabel!
//    @IBOutlet weak var btn_SelectDate: UIButton!
//    
//     @IBOutlet weak var InstantPayLbl: UILabel!
//    
//    var cd = NSArray()
//    var ids = NSArray()
//    var cds = NSArray()
//    var idss = NSArray()
//    var idsMutableArray : NSMutableArray = []
//    var CheckinDateString : String = ""
//    var maxval : Float = 0
//    var minVal : Float = 0
//    var miniAmount : Float = 0
//    var maxmAmount : Float = 0
//    var InstantPaySelect = false
//
//    fileprivate let gregorian = Calendar(identifier: .gregorian)
//    fileprivate let formatter: DateFormatter = {
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter
//    }()
//    
//    fileprivate let formatterNew: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter
//    }()
//    fileprivate let formatterNew1: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEE"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter
//    }()
//    fileprivate weak var calendar: FSCalendar!
//    fileprivate weak var eventLabel: UILabel!
//    
//    var selectedIDArray : NSMutableArray = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        applyFilterButtonClickedBool = false
//        tblMoreFilterList.contentInset = UIEdgeInsetsMake(0, 0, 250, 0)
//        self.priceView.layer.cornerRadius  = 5.0
//        self.guestCountView.layer.cornerRadius = 5.0
//        self.arrivrDepartView.layer.cornerRadius = 5.0
//        self.priceView.layer.borderColor = UIColor.lightGray.cgColor
//        self.guestCountView.layer.borderColor = UIColor.lightGray.cgColor
//        self.arrivrDepartView.layer.borderColor = UIColor.lightGray.cgColor
//        self.priceView.layer.borderWidth = 1.0
//        self.guestCountView.layer.borderWidth = 1.0
//        self.arrivrDepartView.layer.borderWidth = 1.0
//        self.lblGuestCount.text = "1 Guest"
//        
//        
//        filter_header_text = ""
//        filter_list_type = ""
//        filter_room_type = ""
//        filter_home_type = ""
//        filter_arriveDate = ""
//        filter_departDate = ""
//        filter_p_min =  ""
//        filter_p_max = ""
//        filter_guest = 0
//
//        
////        rangeSlider.selectedMinValue = CGFloat(miniAmount)
////        rangeSlider.minValue = CGFloat(miniAmount)
////        rangeSlider.selectedMaxValue = CGFloat(maxmAmount)
////        rangeSlider.maxValue = CGFloat(maxmAmount)
//        
//       // tblMoreFilterAminities.isHidden = true
//        rangeSlider.selectedMinValue = CGFloat(miniAmount.rounded())
//        rangeSlider.minValue = CGFloat(miniAmount.rounded())
//        rangeSlider.selectedMaxValue = CGFloat(maxmAmount.rounded())
//        rangeSlider.maxValue = CGFloat(maxmAmount.rounded())
//
//        
//        self.lblPriceTo.text = app_Currency  + " " + String(describing: self.rangeSlider.maxValue)
//        self.lblPriceFrom.text = app_Currency + " " + String(describing: self.rangeSlider.minValue)
//        self.minPrice = self.lblPriceFrom.text!
//        self.rangeSlider.minLabelAccessibilityLabel = app_Currency + " " + String(describing: self.rangeSlider.minValue)
//        self.rangeSlider.delegate = self
//        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
//        updateGuestCount()
//        
//        checkInCalenderView.calendarHeaderView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        checkInCalenderView.calendarWeekdayView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
//        self.checkInCalenderView.isHidden = true
//        checkInCalenderView.calendarWeekdayView.configureAppearance()
//        checkInCalenderView.appearance.headerMinimumDissolvedAlpha = 0.0
//        self.checkInCalenderView.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
//              self.checkInCalenderView.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
//              self.checkInCalenderView.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)
//
//              self.checkInCalenderView.appearance.headerTitleColor = AppColor
//        self.checkInCalenderView.appearance.weekdayTextColor = AppColor
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        //self.secView.frame.size.height = 1000
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        
//      
//        
//         self.DurationLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.GuestLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.PriceLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.GuestValueLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.FromDateLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.ToDateLbl.font = UIFont(name: SemiBoldFont, size: 15)
//         self.pricelbl.font = UIFont(name: SemiBoldFont, size: 15)
//        
//        self.InstantPay.font = UIFont(name: SemiBoldFont, size: 15)
//        
//        
//        
//        self.NavigationTitle.font = UIFont(name: SemiBoldFont, size: 16)
//        self.arrive.font = UIFont(name: SemiBoldFont, size: 15)
//         self.depart.font = UIFont(name: SemiBoldFont, size: 15)
////        self.btn_selectArrivalDate.titleLabel?.font = UIFont(name: RegularFont, size: 15)
////        self.btn_selectDepartDate.titleLabel?.font = UIFont(name: RegularFont, size: 15)
////        self.btn_selectDepartDate.titleLabel?.textColor = AppColor
////         self.btn_selectArrivalDate.titleLabel?.textColor = AppColor
//        self.lblGuestCount.font = UIFont(name: SemiBoldFont, size: 15)
//        self.pricelbl.font = UIFont(name: SemiBoldFont, size: 15)
//        self.lblPriceFrom.font = UIFont(name: SemiBoldFont, size: 15)
//         self.lblPriceTo.font = UIFont(name: SemiBoldFont, size: 14)
//        self.listingtype.font = UIFont(name: SemiBoldFont, size: 15)
//          self.applyfilteers.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
//        
//        
////        self.btn_selectArrivalDate.setTitle(self.arrivedDate, for: .normal)
////        self.btn_selectDepartDate.setTitle(self.departingDate, for: .normal)
////
//             self.FromDateLbl.text = "From Date"
//         self.ToDateLbl.text = "To Date"
//        
//        
//        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
//        if choose == "en"
//        {
//            self.arrive.text = LocalizeHelper().localizedStringForKey("arrive")
//            self.depart.text = LocalizeHelper().localizedStringForKey("depart")
//            //                self.arriveSel.text = LocalizeHelper().localizedStringForKey("plsselectarrivedate")
//            //                self.departsel.text = LocalizeHelper().localizedStringForKey("plsselectdepartdate")
//            self.pricelbl.text = LocalizeHelper().localizedStringForKey("propertyprice")
//            self.listingtype.text = LocalizeHelper().localizedStringForKey("viewalllistings")
//            self.applyfilteers.setTitle(LocalizeHelper().localizedStringForKey("applyfilters"), for: .normal)
//            self.guest = LocalizeHelper().localizedStringForKey("guest")
//            self.guests = LocalizeHelper().localizedStringForKey("guests")
//            self.InstantPay.text = LocalizeHelper().localizedStringForKey("instantpaySmall")
//        }
//        
//        self.arrivrDepartView.isHidden = false
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    //MARK:- Button Action
//    func getNextMonth(date:Date)->Date {
//        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
//    }
//    
//    func getPreviousMonth(date:Date)->Date {
//        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
//    }
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        //let key = self.formatter.string(from: date)
//        if self.gregorian.isDateInToday(date) {
//            return UIColor.orange
//        }
//        //        let curDate = Date().addingTimeInterval(-24*60*60)
//        //
//        //        if date < curDate {
//        //
//        //            // calenderViewFSC.appearance.we = UIColor.lightGray
//        //
//        //
//        //            return UIColor.lightGray
//        //        }
//        //        //        for i in 0..<HideDates.count {
//        //        //            let dayStr:String = HideDates[i] as? String ?? ""
//        //        //            print(dayStr)
//        //        //            if self.formatterNew1.string(from: date) == dayStr  {
//        //        //                return UIColor.red
//        //        //            }
//        //        //        }
//        return nil
//    }
//    func minimumDate(for calendar: FSCalendar) -> Date {
//        return self.minimumDate
//    }
//    //    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
//    //        let curDate = Date().addingTimeInterval(-24*60*60)
//    //
//    //        if date < curDate {
//    //            return false
//    //        } else {
//    //            return true
//    //        }
//    //    }
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        if isFromDate == "Arrive"
//        {
//            self.minimumDate = date
//          //  self.btn_selectArrivalDate.setTitle(self.formatter.string(from: date), for: .normal)
//            self.FromDateLbl.text = self.formatter.string(from: date)
//            self.arriveDate = self.formatter.string(from: date)
//            self.greyView.isHidden = true
//            self.checkInCalenderView.isHidden = true
//        }
//        else
//        {
//          //  self.btn_selectDepartDate.setTitle(self.formatter.string(from: date), for: .normal)
//            self.departDate =  self.formatter.string(from: date)
//            self.ToDateLbl.text = self.formatter.string(from: date)
//            self.greyView.isHidden = true
//            self.checkInCalenderView.isHidden = true
//            
//        }
//          calendar.reloadData()
//    }
//    @IBAction func act_GeryTaped(_ sender: UITapGestureRecognizer) {
//        self.greyView.isHidden = true
//        self.checkInCalenderView.isHidden = true
//    }
//    @IBAction func act_Back(_ sender: UIButton) {
//        // self.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//    
//    @IBAction func act_SelectInstPay(_ sender: UIButton)
//    {
//        if InstantPaySelect == false{
//            InstantPaySelect = true
//            self.InsPaySltBtn.setImage(UIImage(named: "checkbox-2"), for: .normal)
//        }else{
//             InstantPaySelect = false
//            self.InsPaySltBtn.setImage(UIImage(named: "tick-off"), for: .normal)
//        }
//    }
//    
//    @IBAction func act_ApplyFilter(_ sender: UIButton)
//    {
//        applyFilterButtonClickedBool = true
//        ApplyFilters(tag_value: sender)
//    }
//    
//    @IBAction func act_Depart(_ sender: UIButton) {
//        isFromDate = "Depart"
//        UIView.transition(with: self.checkInCalenderView,
//                          duration:0.5,
//                          options: .transitionCrossDissolve,
//                          animations: {
//                            self.checkInCalenderView.isHidden = false
//                            self.greyView.isHidden = false
//        },
//                          completion: nil)
//    }
//    
//    @IBAction func act_AriveDate(_ sender: UIButton){
//        isFromDate = "Arrive"
//        UIView.transition(with: self.checkInCalenderView,
//                          duration:0.5,
//                          options: .transitionCrossDissolve,
//                          animations: {
//                            self.checkInCalenderView.isHidden = false
//                            self.greyView.isHidden = false
//        },
//                          completion: nil)
//    }
//    
//    @IBAction func act_Minus(_ sender: UIButton) {
//        if guestCount == 1 {
//            guestCount = 1
//        } else {
//            guestCount = guestCount - 1
//        }
//        updateGuestCount()
//    }
//    
//    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
//        
//       rangeSlider.numberFormatter.numberStyle = .currency
//        rangeSlider.numberFormatter.currencySymbol = app_Currency
////        self.lblPriceTo.text = app_Currency + String(describing: Int(maxValue))
////        self.lblPriceFrom.text = app_Currency + String(describing: Int(minValue))
//        self.maxPrice = self.lblPriceTo.text!
//        self.minPrice = self.lblPriceFrom.text!
//        
//    }
//    
//    func ApplyFilters(tag_value : UIButton)
//    {
//        let id = Singleton.sharedInstance.selectedCategory
//        
//        if (Reachability()?.isReachable ?? false)
//        {
//            showActivityIndicator(uiView: self.view)
//            var InstantStatus = ""
//            if InstantPaySelect == true {
//                InstantStatus = "yes"
//            }else{
//                InstantStatus = "no"
//            }
//            
//            print(self.propertyARR)
//            print(self.rommARR)
//            print(self.amenitieARR)
//            
//            
//            let propertyIds : NSMutableArray = []
//            propertyIds.addObjects(from: self.propertyARR)
//            print(FilterIDSA)
//            print(filterId)
//            print(FilterIDS)
//            //FilterIDSA FilterIDS filterId
//            
//            let parameterStr = "mcity_name=\(cityName!)&f_p_min=\(self.minPrice)&f_p_max=\(self.maxPrice)&f_room_type=\(FilterIDS)&f_home_type=\(filterId)&f_list_type=\(self.FilterIDSA)&f_date_arrive=\(self.arriveDate)&f_date_depart=\(self.departDate)&base_id=\(id)&f_guest=\(self.guestCount)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&user_id=\(UserID)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&instant_pay=\(InstantStatus)"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_PROPERTY_DETAIL_PAGE, APIKEY: "REQ_PROPERTY_DETAIL_PAGE")
//            print("ApplyFilters", parameterStr)
//            
////            https://www.bensonboat.pofirentals.in//json/rental-list
////            D: Params: {f_home_type=, mcity_name=Coimbatore, f_p_max=100.0, f_room_type=, f_p_min=14.76, f_guest=3, f_date_depart=02/24/2021, f_list_type=36,57,59,100,103,114,117, instant_pay=Yes, f_date_arrive=02/16/2021, device_type=android, currency_code=USD}
//        }
//        else
//        {
//            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
//        }
//    }
//    
//    @IBAction func checkInAction(_ sender: UIButton) {
//        self.greyView.isHidden = false
//        self.checkInCalenderView.isHidden = false
//    }
//    @IBAction func act_Plus(_ sender: UIButton) {
//        guestCount = guestCount + 1
//        updateGuestCount()
//    }
//    
//    func updateGuestCount() {
//        if self.guestCount == 1 {
//            self.GuestValueLbl.text = "1"
//        } else {
//            self.GuestValueLbl.text =  String(guestCount) //+ " " + guests
//        }
//    }
//    
//    @objc func listingSelected(sender: UIButton) {
//        print("Button Clicked")
//        print(sender.tag)
//        if (Reachability()?.isReachable ?? false)
//        {
//            showActivityIndicator(uiView: self.view)
//            let id = Singleton.sharedInstance.selectedCategory
//            let parameterStr = "mcity_name=\(cityName!)&f_p_min=&f_p_max=&f_room_type=\(roomChildID)&f_home_type=\(HomeString)&f_list_type=\(listChildID)&f_date_arrive=\(self.arriveDate)&f_date_depart=\(self.departDate)&base_id=\(id)&f_guest=&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&user_id=\(login_session.value(forKey: "UserId")!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_PROPERTY_DETAIL_PAGE, APIKEY: "REQ_PROPERTY_DETAIL_PAGE")
//        }
//        else
//        {
//            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
//        }
//    }
//    @objc func aminitiesSelected(sender: UIButton)
//    {
//        print("Button Clicked")
//        print(sender.tag)
//        if (Reachability()?.isReachable ?? false)
//        {
//            showActivityIndicator(uiView: self.view)
//            let id = Singleton.sharedInstance.selectedCategory
//            let parameterStr = "mcity_name=\(cityName!)&f_p_min=&f_p_max=&f_room_type=\(roomChildID)&f_home_type=\(HomeString)&f_list_type=\(listChildID)&f_date_arrive=\(self.arriveDate)&f_date_depart=\(self.departDate)&base_id=\(id)&f_guest=&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&user_id=\(login_session.value(forKey: "UserId")!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_PROPERTY_DETAIL_PAGE, APIKEY: "REQ_PROPERTY_DETAIL_PAGE")
//            
//        }
//        else
//        {
//            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
//        }
//    }
//}
//extension MoreFilterViewController
//{
//    func isEligibleToBook() -> Bool {
//        if diffBtwnDate() >= 2 {
//            return true
//        } else
//        {
//            return false
//        }
//    }
//    func diffBtwnDate() -> Int {
//        let calendar = NSCalendar.current
//        let date1 = calendar.startOfDay(for: fromDate)
//        let date2 = calendar.startOfDay(for: toDate)
//        let components = calendar.dateComponents([.day], from: date1, to: date2)
//        noOfNights = components.day!
//        return components.day!
//    }
//}
//
//extension MoreFilterViewController: UITableViewDelegate ,UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        switch tableView {
//        case self.tblMoreFilterList:
//            return Singleton.sharedInstance.PlaceList.attribute.count + 2
////        case self.tblMoreFilterAminities:
////            return Singleton.sharedInstance.PlaceList.attribute.count
//        default:
//            return 0
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//            if  section == 0
//            {
//                return Singleton.sharedInstance.PlaceList.property[0].options.count
//            }
//            else if section == 1
//            {
//                if Singleton.sharedInstance.PlaceList.rooms.count != 0
//                {
//                return Singleton.sharedInstance.PlaceList.rooms[0].options.count
//                }
//                else
//                {
//                   return 0
//                }
//            }
//            else
//            {
//            return Singleton.sharedInstance.PlaceList.attribute[section-2].options.count
//            }
//     return 0
////        case self.tblMoreFilterAminities:
////            return Singleton.sharedInstance.PlaceList.attribute[section].options.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if tableView == self.tblMoreFilterList {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? MoreFilterCell
//             cell!.lblName.font = UIFont(name: RegularFont, size: 14)
//            if indexPath.section == 0 {
//                cell!.lblName.text = Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childName!
//               
//                //cell!.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)!
//                cell!.btnCheck.tag = indexPath.row
//                cell!.btnCheck.addTarget(self, action: #selector(listingSelected), for: .touchUpInside)
//                return cell!
//            }
//            else if indexPath.section == 1
//            {
//                cell!.lblName.text = Singleton.sharedInstance.PlaceList.rooms[0].options[indexPath.row].childName!
//                //cell!.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)!
//                cell!.btnCheck.tag = indexPath.row
//                cell!.btnCheck.addTarget(self, action: #selector(listingSelected), for: .touchUpInside)
//                return cell!
//            }
//                
//            else
//            {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as? MoreFilterAmintiesCell
//                  cell!.lblName.font = UIFont(name: RegularFont, size: 14)
//                cell!.lblName.text = Singleton.sharedInstance.PlaceList.attribute[indexPath.section-2].options[indexPath.row].childName!
//                //cell!.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)!
//                cell!.btnCheck.tag = indexPath.row
//                cell!.btnCheck.addTarget(self, action: #selector(aminitiesSelected), for: .touchUpInside)
//                return cell!
//            }
//        }
//        else
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MoreFilterAmintiesCell
//             cell!.lblName.font = UIFont(name: RegularFont, size: 14)
//            cell!.lblName.text = Singleton.sharedInstance.PlaceList.attribute[indexPath.section].options[indexPath.row].childName!
//            //cell!.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)!
//            cell!.btnCheck.tag = indexPath.row
//            cell!.btnCheck.addTarget(self, action: #selector(aminitiesSelected), for: .touchUpInside)
//            return cell!
//        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MoreFilterCell
//        if tableView == self.tblMoreFilterList
//        {
//            if indexPath.section == 0 {
//                cell?.btnCheck.tag = indexPath.row
//                //cell?.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)!
//                let id = Int(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId)
//                
//                if self.moreFilterId.contains(id) {
//                    self.moreFilterId.remove(id)
//                }else{
//                    self.moreFilterId.add(id)
//                }
//                
//                filterId = moreFilterId.componentsJoined(by: ",")
//                self.propertyARR.append(Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row])
//                (tableView.cellForRow(at: indexPath) as! MoreFilterCell).btnCheck.setImage(UIImage(named: "checkbox-2"), for: .normal)
//                
//                
//            }
//            else if indexPath.section == 1
//            {
//                cell?.btnCheck.tag = indexPath.row
//                //cell?.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.rooms[0].options[indexPath.row].childId)!
//                // self.moreFilterIDS = cell?.btnCheck.tag
//                let id = Int(Singleton.sharedInstance.PlaceList.rooms[0].options[indexPath.row].childId)
//                if self.moreFilterIDS.contains(id) {
//                    self.moreFilterIDS.remove(id)
//                }else{
//                    self.moreFilterIDS.add(id)
//                }
//                FilterIDS = moreFilterIDS.componentsJoined(by: ",")
//                self.rommARR.append(Singleton.sharedInstance.PlaceList.rooms[0].options[indexPath.row])
//                (tableView.cellForRow(at: indexPath) as! MoreFilterCell).btnCheck.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            }
//            else
//            {
//                let id = Int(Singleton.sharedInstance.PlaceList.attribute[indexPath.section-2].options[indexPath.row].childId)
//                if self.moreFilterIDSA.contains(id) {
//                    self.moreFilterIDSA.remove(id)
//                }else{
//                    self.moreFilterIDSA.add(id)
//                }
//                FilterIDSA = moreFilterIDSA.componentsJoined(by: ",")
//                self.amenitieARR.append(Singleton.sharedInstance.PlaceList.attribute[indexPath.section-2].options[indexPath.row])
//                (tableView.cellForRow(at: indexPath) as! MoreFilterAmintiesCell).btnCheck.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            }
//        } else {
//            //let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MoreFilterAmintiesCell
//            //cell?.btnCheck.tag = Int(Singleton.sharedInstance.PlaceList.attribute[indexPath.section].options[indexPath.row].childId)
//            // self.moreFilterIDSA = cell?.btnCheck.tag
//            let id = Int(Singleton.sharedInstance.PlaceList.attribute[indexPath.section].options[indexPath.row].childId)
//            self.moreFilterIDSA.add(id)
//            FilterIDSA = moreFilterIDSA.componentsJoined(by: ",")
//            self.amenitieARR.append(Singleton.sharedInstance.PlaceList.attribute[indexPath.section].options[indexPath.row])
//            (tableView.cellForRow(at: indexPath) as! MoreFilterAmintiesCell).btnCheck.setImage(UIImage(named: "checkbox-2"), for: .normal)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        if tableView == self.tblMoreFilterList {
//            if indexPath.section == 0 {
//                if propertyARR.count != 0{
//                    for index in 0..<propertyARR.count {
//                        if propertyARR[index].childId == Singleton.sharedInstance.PlaceList.property[0].options[indexPath.row].childId {
//                            propertyARR.remove(at: index)
//                            (tableView.cellForRow(at: indexPath) as! MoreFilterCell).btnCheck.setImage(UIImage(named: "tick-off"), for: .normal)
//                            break
//                        } else {
//                            
//                        }
//                    }
//                }
//            }
//            else if indexPath.section == 1
//            {
//                if rommARR.count != 0{
//                    for index in 0..<rommARR.count {
//                        if rommARR[index].childId == Singleton.sharedInstance.PlaceList.rooms[0].options[indexPath.row].childId {
//                            rommARR.remove(at: index)
//                            (tableView.cellForRow(at: indexPath) as! MoreFilterCell).btnCheck.setImage(UIImage(named: "tick-off"), for: .normal)
//                            break
//                        } else {
//                            
//                        }
//                    }
//                }
//            }
//            else
//            {
//                if amenitieARR.count != 0{
//                    for index in 0..<amenitieARR.count {
//                        if amenitieARR[index].childId == Singleton.sharedInstance.PlaceList.attribute[indexPath.section-2].options[indexPath.row].childId
//                        {
//                            amenitieARR.remove(at: index)
//                            (tableView.cellForRow(at: indexPath) as! MoreFilterAmintiesCell).btnCheck.setImage(UIImage(named: "tick-off"), for: .normal)
//                            break
//                        } else {
//                            
//                        }
//                    }
//                }
//            }
//        } else {
//            if amenitieARR.count != 0{
//                for index in 0..<amenitieARR.count {
//                    if amenitieARR[index].childId == Singleton.sharedInstance.PlaceList.attribute[indexPath.section].options[indexPath.row].childId
//                    {
//                        amenitieARR.remove(at: index)
//                        (tableView.cellForRow(at: indexPath) as! MoreFilterAmintiesCell).btnCheck.setImage(UIImage(named: "tick-off"), for: .normal)
//                        break
//                    } else {
//                        
//                    }
//                }
//            }
//            
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
//        let Line1 = UIView(frame: CGRect(x: 0, y: 1, width: tableView.frame.size.width, height: 0))
//        let Line2 = UIView(frame: CGRect(x: 0, y: 49, width: tableView.frame.size.width, height: 0))
//        let lblTilte = UILabel(frame: CGRect(x: 15, y: 1, width: tableView.frame.size.width-40, height: 47))
//        if tableView == self.tblMoreFilterList {
//            if section == 0 {
//                lblTilte.text = Singleton.sharedInstance.PlaceList.property[0].optionName!
//            }
//            else if section == 1
//            {
//                if Singleton.sharedInstance.PlaceList.rooms.count != 0
//                {
//                lblTilte.text = Singleton.sharedInstance.PlaceList.rooms[0].optionName!
//                }
//                
//            }
//            else
//            {
//                lblTilte.text = Singleton.sharedInstance.PlaceList.attribute[section-2].optionName!
//            }
//        }
//        else
//        {
//            lblTilte.text = Singleton.sharedInstance.PlaceList.attribute[section].optionName!
//        }
//        Line1.backgroundColor = UIColor.groupTableViewBackground
//        Line2.backgroundColor = UIColor.groupTableViewBackground
//        lblTilte.textColor = UIColor.black
//        lblTilte.font = UIFont(name:BoldFont, size: 16)
//        lblTilte.numberOfLines = 0
//        headerView.backgroundColor = .white
//        headerView.addSubview(lblTilte)
//        headerView.addSubview(Line1)
//        headerView.addSubview(Line2)
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 1
//        {
//            if Singleton.sharedInstance.PlaceList.rooms.count != 0
//            {
//                return 40
//            }
//            else
//            {
//                return 0
//            }
//
//        }
//        else
//        {
//        return 40
//        }
//    }
//    
//}
//
//extension MoreFilterViewController: HTTP_POST_STRING_REQUEST_PROTOCOL
//{
//    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
//        if APIKEY == "REQ_PROPERTY_DETAIL_PAGE"
//        {
//            if errorDict.count == 0
//            {
//                hideActivityIndicator(uiView: self.view)
//                print(responseDict)
//                let mod = PlaceListModel(fromDictionary: responseDict as! [String : Any])
//                Singleton.sharedInstance.PlaceList = mod
//
//                //let mod1 = MoreFilter(fromDictionary: responseDict as! [String : Any])
//                //Singleton.sharedInstance.MoreFilterModel = mod1
//                //                if mod.rentalList.count != 0
//                //                {
//                //                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as? PlaceListController
//                //                nav!.Rental_ID = mod.rentalList[0].rentalId
//                
//                let propDetails = responseDict.value(forKey: "property") as? NSArray
//                let roomDetails = responseDict.value(forKey: "rooms") as? NSArray
//                let Attributes = responseDict.value(forKey: "attribute") as? NSArray
//                for details in 0..<propDetails!.count
//                {
//                    let propdict = propDetails![details] as! NSDictionary
//                    let optnArr = propdict.value(forKey: "options") as? NSArray
//                    for items in 0..<optnArr!.count
//                    {
//                        let propdict = optnArr![items] as! NSDictionary
//                        let propertyID = propdict.value(forKey: "child_id") as? Int
//                        homeChildID = propertyID!
//                        HiDSArray.add(homeChildID)
//                        HomeString = HiDSArray.componentsJoined(by: ",")
//                        print(HomeString)
//                    }
//                }
//                for  items in 0..<roomDetails!.count
//                {
//                    let roomDict = roomDetails![items] as! NSDictionary
//                    let OptionsArr = roomDict.value(forKey: "options") as? NSArray
//                    for identifiers in 0..<OptionsArr!.count
//                    {
//                        let roomsdict = OptionsArr![identifiers] as! NSDictionary
//                        let RoomoptionsID = roomsdict.value(forKey: "child_id") as? Int
//                        roomChildID = RoomoptionsID!
//                        RiDSArray.add(roomChildID)
//                        RoomString = RiDSArray.componentsJoined(by: ",")
//                        print(roomChildID)
//                    }
//                    
//                }
//                for membrs in 0..<Attributes!.count
//                {
//                    let attrDict = Attributes![membrs] as! NSDictionary
//                    let OptnsArr = attrDict.value(forKey: "options") as? NSArray
//                    for items in 0..<OptnsArr!.count
//                    {
//                        let aattrDict = OptnsArr![items] as! NSDictionary
//                        let AttrOptnID = aattrDict.value(forKey: "child_id") as? Int
//                        listChildID = AttrOptnID!
//                        AttriDSArray.add(listChildID)
//                        AttributeString = AttriDSArray.componentsJoined(by: ",")
//                        print(listChildID)
//                    }
//                }
//                
////                if mod.rentalList.count != 0
////                {
////
//                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as? PlaceListController
//                    
//                    nav?.headerTxt = self.cityName
//                    
//                    nav?.f_list_type = self.FilterIDSA
//                    nav?.f_room_type = self.FilterIDS
//                    nav?.f_home_type = self.filterId
//                    nav?.arriveDate = self.arriveDate
//                    nav?.departDate = self.departDate
//                    nav?.f_p_min =  self.minPrice
//                    nav?.f_p_max = self.maxPrice
//                    nav?.f_guest = self.guestCount
//                    
//                    filter_header_text = self.cityName
//                    filter_list_type = self.FilterIDSA
//                    filter_room_type = self.FilterIDS
//                    filter_home_type = self.filterId
//                    filter_arriveDate = self.arriveDate
//                    filter_departDate = self.departDate
//                    filter_p_min =  self.minPrice
//                    filter_p_max = self.maxPrice
//                    filter_guest = self.guestCount
//
//                    self.navigationController?.popViewController(animated: true)
//
//             //   }
//                //              else
//                //                {
//                //                   let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
//                //                   self.navigationController?.pushViewController(nav!, animated: true)
//                //                }
//            }
//                
//            else
//            {
//                print("No Data")
//            }
//            
//            tblMoreFilterList.reloadData()
//            
//
//        }
//        
//
//    }
//}
