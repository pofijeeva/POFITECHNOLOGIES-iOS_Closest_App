//
//  BookingDetailViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import CVCalendar
import Kingfisher
import FSCalendar
import AFNetworking
enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}
class BookingDetailViewController: BaseViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    //MARK:- Outlets
    
    @IBOutlet weak var calenderViewFSC: FSCalendar!
    @IBOutlet weak var checkInView: UIView!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var btnSendToHost: UIButton!
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var lblPropertyName: UILabel!
    @IBOutlet weak var viewGuestCount: UIView!
    @IBOutlet weak var viewArriveDepart: UIView!
    @IBOutlet weak var viewPriceDetails: UIView!
    @IBOutlet weak var viewNight: UIView!
    @IBOutlet weak var viewServiceFee: UIView!
    @IBOutlet weak var viewTotalPrice: UIView!
    @IBOutlet weak var viewSecurityDeposit: UIView!
    @IBOutlet weak var lblTotalPricePrice: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblGuestCount: UILabel!
    @IBOutlet weak var lblServiceFeePrice: UILabel!
    @IBOutlet weak var lblSeviceFees: UILabel!
    @IBOutlet weak var lblNoOfNight: UILabel!
    @IBOutlet weak var lblNightPrice: UILabel!
    @IBOutlet weak var lblSecurityDepositPrice: UILabel!
    @IBOutlet weak var lblSecurityDeposit: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var guestLbl: UILabel!
    @IBOutlet weak var arriveLabel: UILabel!
    @IBOutlet weak var departLbl: UILabel!
    @IBOutlet weak var checkinArrive: UILabel!
    @IBOutlet weak var btn_SelectDate: UIButton!
    @IBOutlet weak var btn_SelectArrDate: UIButton!
    @IBOutlet weak var btn_SelectDepartDate: UIButton!
    @IBOutlet weak var requestToBook2Btn: UIButton!
    @IBOutlet weak var instantPay2Btn: UIButton!
    @IBOutlet weak var bottomRequestView: UIView!
    
    
    
    var tableTimeDetail : String = ""
    
    //MARK:- Variables
    var guestCount = 1
    var isFromDate = "Arrive"
    var fromDate = Date()
    var toDate = Date()
    var minimumDate = Date()
    var noOfNights : Int = 0
    var app_Currency_Symbol : String = ""
    var friLeaveStatus : Bool = false
    var monLeaveStatus : Bool = false
    var satLeaveStatus : Bool = false
    var sunLeaveStatus : Bool = false
    var thuLeaveStatus : Bool = false
    var tueLeaveStatus : Bool = false
    var wedLeaveStatus : Bool = false
    var timeStr : String = ""
    var checkinStr:String = ""
    var arriveDate : String = ""
    var departDate : String = ""
    var message = ""
    var guest : String = ""
    var guests : String = ""
    var sendmessage : String = ""
    var cancel : String = ""
    var submit : String = ""
    var enteryourMsg : String = ""
    var dayString  : String = ""
    var serviceFee : AnyObject!
    var hotelServTyp : String = ""
    var hotelServVal : Float = 0
    var cancel_percentage : AnyObject!
    var totalAmt : AnyObject!
    var subTotal : AnyObject!
    var secDeposit : AnyObject!
    var rest_currencycode : String = ""
    var Bookingno : String = ""
    var currency_cron_id : String = ""
    var enquiryid : String = ""
    var restaurant_id : String = ""
    var selectedDate : String = ""
    var HideDates : NSMutableArray = []
    var hideStr : String = ""
    var arrSelectedDate : String = ""
    var departSelectdDate : String = ""
    var BookingPrice : String = ""
    var currentStartDate : String = ""
    var currentEndingDate : String = ""
    var minStay : Int = 0
    var instantPay : Bool = false
    var reqtoBook : Bool = false
    var hotelcancelPercentage : String = ""
    var hotelTotalPrice : String = ""
    var hotelServfee : String = ""
    var hotlTotalAmt : String = ""
    var hotelsecDeposit : Float = 0
    var updatedGuestCountfromAPI : Int = 0

    var DatesMutable : NSMutableArray = []
    var avaliableDates : NSMutableArray = []
    var BookindDates : NSMutableArray = []
    var UnavaliableDates : NSMutableArray = []
    var paypal_Stat : String = ""
    var creditcard_Stat : String = ""
    var Stripe_status : String = ""
    
    var bookedDays : NSMutableArray = []
    var mydates : [String] = []
    var bookedDates : [String] = []
    var seasonalPrices = NSArray()
    var bookedcnt : Int = 0
    var normaldayCnt : Int = 0
    var seasonalCnt:Int = 0
    var seasonalPrice : AnyObject!
    var seasonalPriceCheck:Int = 0
    
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
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderViewFSC.appearance.headerMinimumDissolvedAlpha = 0.0
        bottomRequestView.isHidden = true
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        // Calender
        self.updateGuestCount()
        
        if Singleton.sharedInstance.PropertyDetail.productImage.count != 0{
            let url = URL(string: Singleton.sharedInstance.PropertyDetail.productImage[0].productImage)
            self.imgProperty.kf.setImage(with: url)
        }else{
            
           // self.imgProperty.image = UIImage(named:"slider_one")
        }
        
     
        self.lblPropertyName.text = Singleton.sharedInstance.PropertyDetail.defaultproducttitle + "," + Singleton.sharedInstance.PropertyDetail.city + "," + Singleton.sharedInstance.PropertyDetail.country
        self.viewPriceDetails.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewGuestCount.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        
        
        self.viewNight.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewServiceFee.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewTotalPrice.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewArriveDepart.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewSecurityDeposit.setBorder(withColor: UIColor.groupTableViewBackground, width: 1.0, cornerRadius: 5.0)
        self.viewPriceDetails.isHidden = true
        
        if Singleton.sharedInstance.PropertyDetail.listingInfo.count != 0
        {

        for i in 0 ... Singleton.sharedInstance.PropertyDetail.listingInfo.count-1
        {
          if Singleton.sharedInstance.PropertyDetail.listingInfo[i].label == "Accommodates"
          {
            if (Singleton.sharedInstance.PropertyDetail.listingInfo[i].value) == nil
            {
            self.updatedGuestCountfromAPI = 1
            }
            else
            {
                self.updatedGuestCountfromAPI = Int(Singleton.sharedInstance.PropertyDetail.listingInfo[i].value)!
            }
          }
        }
        }else
        {
            self.updatedGuestCountfromAPI = 1
        }
        
    }
    
    
        override func viewWillAppear(_ animated: Bool) {
            
            self.calenderViewFSC.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
                         self.calenderViewFSC.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
                         self.calenderViewFSC.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)

                         self.calenderViewFSC.appearance.headerTitleColor = AppColor
            
            self.calenderViewFSC.appearance.weekdayTextColor = AppColor
            
            self.viewTitle.font = UIFont(name: SemiBoldFont, size: 20)
            
            self.instantPay2Btn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
             self.requestToBook2Btn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
            self.btnSendToHost.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
              self.instantPay2Btn.backgroundColor = AppColor
              self.requestToBook2Btn.backgroundColor = AppColor
              self.btnSendToHost.backgroundColor = AppColor
            self.lblPropertyName.font = UIFont(name: RegularFont, size: 17)
            self.dateLbl.font =  UIFont(name: SemiBoldFont, size: 17)
            self.checkinArrive.font = UIFont(name: SemiBoldFont, size: 17)
            self.btn_SelectDate.titleLabel?.font =  UIFont(name: RegularFont, size: 16)
            self.btn_SelectDate.titleLabel?.textColor = AppColor
            self.arriveLabel.font = UIFont(name: SemiBoldFont, size: 16)
             self.departLbl.font = UIFont(name: SemiBoldFont, size: 16)
            
              self.btn_SelectArrDate.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
              self.btn_SelectDepartDate.titleLabel?.font =  UIFont(name: RegularFont, size: 15)
            self.guestLbl.font = UIFont(name: SemiBoldFont, size: 18)
            self.lblGuestCount.font = UIFont(name: RegularFont, size: 16)
            self.lblNoOfNight.font = UIFont(name: SemiBoldFont, size: 15)
            self.lblNightPrice.font = UIFont(name: SemiBoldFont, size: 15)
            
            self.lblSeviceFees.font = UIFont(name: SemiBoldFont, size: 15)
            self.lblServiceFeePrice.font = UIFont(name: SemiBoldFont, size: 15)
            
            self.lblSecurityDeposit.font = UIFont(name: SemiBoldFont, size: 15)
            self.lblSecurityDepositPrice.font = UIFont(name: SemiBoldFont, size: 15)
            
            self.lblTotalPricePrice.font = UIFont(name: SemiBoldFont, size: 15)
            self.lblTotalPrice.font = UIFont(name: SemiBoldFont, size: 15)
            
            
            Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
           // self.viewPriceDetails.isHidden = true
            self.calenderViewFSC.isHidden = true
            self.checkInView.isHidden = true
            self.viewArriveDepart.isHidden = false
            //print(DatesMutable)
            if self.DatesMutable.count != 0 {

                let cnt = self.DatesMutable.count
                for i in 0..<cnt{
                    if ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateStatus") as? Int == 1 {
                        let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                        self.avaliableDates.add(date!)
                    }else if ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateStatus") as? Int == 2 {
                        let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                        self.BookindDates.add(date!)
                    }else {
                        let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                        self.UnavaliableDates.add(date!)
                    }
                }


            }else {
            
            }
            print(BookindDates)
            print(UnavaliableDates)
            
    //        if UserDefaults.standard.value(forKey: "isRequestToBook") != nil && UserDefaults.standard.value(forKey: "isInstantPay") != nil
    //        {
    //            if UserDefaults.standard.value(forKey: "isRequestToBook") as? String ?? "" == "Yes" &&  UserDefaults.standard.value(forKey: "isInstantPay") as? String ?? "" == "Yes" {
    //                print(UserDefaults.standard.value(forKey: "isRequestToBook") as? String ?? "" )
    //                print(UserDefaults.standard.value(forKey: "isInstantPay") as? String ?? "" )
    //                btnSendToHost.isHidden = true
    //                bottomRequestView.isHidden = false
    //            }
    //            else {
    //                print(UserDefaults.standard.value(forKey: "isRequestToBook") as? String ?? "" )
    //                print(UserDefaults.standard.value(forKey: "isInstantPay") as? String ?? "" )
    //                btnSendToHost.isHidden = false
    //                bottomRequestView.isHidden = true
    //            }
    //        }
    //        else if UserDefaults.standard.value(forKey: "isRequestToBook") != nil || UserDefaults.standard.value(forKey: "isInstantPay") != nil {
    //            if UserDefaults.standard.value(forKey: "isRequestToBook") != nil {
    //                if UserDefaults.standard.value(forKey: "isRequestToBook") as? String ?? "" == "Yes" {
    //                    btnSendToHost.isHidden = false
    //                    bottomRequestView.isHidden = true
    //                    btnSendToHost.setTitle("REQUEST TO BOOK", for: .normal)
    //                }
    //            }
    //            else if UserDefaults.standard.value(forKey: "isInstantPay") != nil {
    //                if UserDefaults.standard.value(forKey: "isInstantPay") as? String ?? "" == "Yes" {
    //                    btnSendToHost.isHidden = false
    //                    bottomRequestView.isHidden = true
    //                    btnSendToHost.setTitle("INSTANT PAY", for: .normal)
    //                }
    //            }
    //        }
    //        else
    //        {
            
            
                if instantPay == true
                {
                    btnSendToHost.setTitle("INSTANT PAY TO HOST", for: .normal)
                    btnSendToHost.isHidden = false

                }
                else
                {
                    btnSendToHost.setTitle("REQUEST HOST TO BOOK", for: .normal)
                    btnSendToHost.isHidden = false

                }
                if reqtoBook == true
                {
                    btnSendToHost.setTitle("REQUEST HOST TO BOOK", for: .normal)
                    btnSendToHost.isHidden = false

                }
                else {
                    btnSendToHost.setTitle("INSTANT PAY TO HOST", for: .normal)
                    btnSendToHost.isHidden = false

                }
                if instantPay == true && reqtoBook == true
                {
                    //btnSendToHost.setTitle("BOOK NOW", for: .normal)
                    btnSendToHost.isHidden = true
                    bottomRequestView.isHidden = false
                }
                else
                {
                    print("NOT AVAILABLE")
                }
            
            
           // }
            
            
            let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
            if choose == "en"
            {
                self.viewTitle.text = LocalizeHelper().localizedStringForKey("bookingdetails")
                self.arriveLabel.text = LocalizeHelper().localizedStringForKey("arrive")
                self.departLbl.text = LocalizeHelper().localizedStringForKey("depart")
                //            self.departSeldate.text = LocalizeHelper().localizedStringForKey("plsselectdepartdate")
                //            self.arriveSeldate.text = LocalizeHelper().localizedStringForKey("plsselectarrivedate")
                self.dateLbl.text = LocalizeHelper().localizedStringForKey("dates")
                self.guestLbl.text = LocalizeHelper().localizedStringForKey("guests")
                //        self.btnSendToHost.setTitle(LocalizeHelper().localizedStringForKey("sendtohost"), for: .normal)
                guest = LocalizeHelper().localizedStringForKey("guest")
                guests = LocalizeHelper().localizedStringForKey("guests")
                sendmessage = LocalizeHelper().localizedStringForKey("sendmsgcap")
                cancel = LocalizeHelper().localizedStringForKey("cancel")
                submit = LocalizeHelper().localizedStringForKey("submit")
                enteryourMsg = LocalizeHelper().localizedStringForKey("enteryourmsg")
            }
        }
    @IBAction func checkInAct(_ sender: UIButton) {
        let id = Singleton.sharedInstance.selectedCategory
        if id  == "6" {
            self.title = "FSCalendar"
            
            // self.btn_SelectDate.isHidden = true
            self.greyView.isHidden = false
            self.calenderViewFSC.isHidden = false
            
        }
            
        else
        {
            self.isFromDate = "Arrive"
            
            UIView.transition(with: self.calenderViewFSC,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                
                                self.calenderViewFSC.isHidden = false
                                self.greyView.isHidden = false
            },
                              completion: nil)
            
            
            UIView.transition(with: self.calenderViewFSC,
                              duration:0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                
                                self.calenderViewFSC.isHidden = false
                                self.greyView.isHidden = false
            },
                              completion: nil)
            
        }
        
    }
    

    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.monday
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    
    
    
   
    // MARK:- FSCalendarDataSource
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calenderViewFSC.frame.size.height = bounds.height
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor(red: 234/255.0, green: 61/255.0, blue: 62/255.0, alpha: 1.0)
    }
  
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // let dateString = self.formatters.string(from: date)
        //        if self.hidedates.contains(dateString) {
        //            return 1
        //        }
        //        if self.bookedDates.contains(dateString) {
        //            return 1
        //        }
        //
        return 0
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    {
        //let key = self.formatter.string(from: date)
        if self.gregorian.isDateInToday(date)
        {
            return UIColor.orange
        }
        
        for i in 0..<self.bookedDates.count
        {
            let dayStr:String = self.bookedDates[i]
            print(dayStr)
            if self.formatter.string(from: date) == dayStr
            {
                return UIColor.red
            }
        }
        for i in 0..<self.UnavaliableDates.count
        {
            let dayStr:String = self.UnavaliableDates[i] as? String ?? ""
            print(dayStr)
            if self.formatter.string(from: date) == dayStr
            {
                return UIColor.gray
            }
        }
        for i in 0..<self.avaliableDates.count
        {
            let dayStr:String = self.avaliableDates[i] as? String ?? ""
            print(dayStr)
            if self.formatter.string(from: date) == dayStr
            {
                return UIColor.clear
            }
        }
        
        
        return nil
    }
    
    
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        
        if isFromDate == "Arrive"
        {
            self.minimumDate = date
            print("did select date \(self.formatter.string(from: date))")
            self.btn_SelectArrDate.setTitle(self.formatter.string(from: date), for: .normal)
            self.arriveDate = self.formatterNew.string(from: date)
            self.greyView.isHidden = true
            self.calenderViewFSC.isHidden = true
            
        }
        else
        {
            if btn_SelectArrDate.currentTitle == "Select date"
            {
                self.showInformation(title: "Closest", message: "Please select Arrival date")
            }
            else
            {
            print("did select date \(self.formatter.string(from: date))")
            self.btn_SelectDepartDate.setTitle(self.formatter.string(from: date), for: .normal)
            self.departDate =  self.formatterNew.string(from: date)
            CalculateNumOfDays()
            self.greyView.isHidden = true
            self.calenderViewFSC.isHidden = true
            self.viewPriceDetails.isHidden = true
                datesBtnDates()
            showPriceDetails()
            }
        }
         calendar.reloadData()
    }
    
    //    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        // both are selected:
    //        if firstDate != nil && lastDate != nil {
    //            for d in calendar.selectedDates {
    //                calendar.deselect(d)
    //            }
    //
    //            lastDate = nil
    //            firstDate = nil
    //
    //            datesRange = []
    //            print("datesRange contains: \(datesRange!)")
    //        }
    //    }
    
    @IBAction func TimeTableAct(_ sender: UIButton)
    {
        
    }
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_SendToHost(_ sender: UIButton) {
        
        if btnSendToHost.currentTitle == "REQUEST HOST TO BOOK"
        {
            if isEligibleToBook() {
                self.showTextAlert()
            } else {
                showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
            }
        }
        else if btnSendToHost.currentTitle == "INSTANT PAY TO HOST"
        {
            if isEligibleToBook() {
                self.showTextAlert()
            }
            else {
                showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
                
            }
        }
        else if btnSendToHost.currentTitle == "BOOK NOW"
        {
            if isEligibleToBook() {
                self.showTextAlert()
            }
            else {
                showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
                
            }
        }
            
        else
        {
            print("No req to book or instant pay available")
        }
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.minimumDate
    }
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//        //let key = self.formatter.string(from: date)
//        if self.gregorian.isDateInToday(date) {
//            return UIColor.orange
//        }
//
//        for i in 0..<HideDates.count {
//            let dayStr:String = HideDates[i] as? String ?? ""
//            print(dayStr)
//            if self.formatterNew1.string(from: date) == dayStr  {
//                return UIColor.red
//            }
//        }
//        return nil
//    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        
        let curDate = Date().addingTimeInterval(-24*60*60)
        
        for i in 0..<BookindDates.count {
            let dayStr:String = BookindDates[i] as? String ?? ""
            print(dayStr)
            if self.formatter.string(from: date) == dayStr {
                return false
            }
            
        }
        for i in 0..<UnavaliableDates.count {
            let dayStr:String = UnavaliableDates[i] as? String ?? ""
            print(dayStr)
            if self.formatter.string(from: date) == dayStr {
                return false
            }
            
        }
        for i in 0..<bookedDates.count {
            let dayStr:String = bookedDates[i]
            print(dayStr)
            if self.formatter.string(from: date) == dayStr {
                return false
            }
            
        }
//        for i in 0..<avaliableDates.count {
//            let dayStr:String = avaliableDates[i] as? String ?? ""
//            print(dayStr)
//            if self.formatter.string(from: date) == dayStr {
//                return false
//            }
//
//        }
//
        
        if date < curDate {
            return false
        } else {
            return true
        }
        
        self.greyView.isHidden = false
        // let curDate = Date().addingTimeInterval(-24*60*60)
        
        if date < curDate {
            return false
        } else {
            return true
        }
        
        self.greyView.isHidden = false
        for i in 0..<HideDates.count {
            let dayStr:String = HideDates[i] as? String ?? ""
            print(dayStr)
            if self.formatterNew1.string(from: date) == dayStr {
                return false
            }
            
        }
        return true
        
    }
    
    
    func hideDate() {
        if(sunLeaveStatus == true){
            dayString = "Sun"
        }
        else if(monLeaveStatus == true){
            dayString = "Mon"
        }
        else if(tueLeaveStatus == true){
            dayString = "Tue"
        }
        else if(wedLeaveStatus == true){
            dayString = "Wed"
        }
        else if(thuLeaveStatus == true){
            dayString = "Thu"
        }
        else if(friLeaveStatus == true){
            dayString = "Fri"
        }
        else if(satLeaveStatus == true){
            dayString = "Sat"
        }
        else if(satLeaveStatus == true) && (sunLeaveStatus == true) && (monLeaveStatus == true) && (tueLeaveStatus == true) && (wedLeaveStatus == true) && (friLeaveStatus == true) && (thuLeaveStatus == true){
            dayString = "Sat"
        }
        
    }
    
    @IBAction func act_Arrive_Date(_ sender: UIButton) {
        isFromDate = "Arrive"
        UIView.transition(with: self.calenderViewFSC,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.calenderViewFSC.isHidden = false
                            self.greyView.isHidden = false
        },
                          completion: nil)
    }
    
    @IBAction func act_Depart_Date(_ sender: UIButton) {
        isFromDate = "Depart"
        UIView.transition(with: self.calenderViewFSC,
                          duration:0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.calenderViewFSC.isHidden = false
                            self.greyView.isHidden = false
        },
                          completion: nil)
        showPriceDetails()
    }
    
    @IBAction func act_Minus(_ sender: UIButton) {
        if guestCount == 1 {
            guestCount = 1
        } else {
            guestCount = guestCount - 1
        }
        
        updateGuestCount()
    }
    
    @IBAction func act_Plus(_ sender: UIButton) {
        
       /* if guestCount == Int(Singleton.sharedInstance.PropertyDetail.accommodates)
        {
            showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("morethannumberofspecified"))
            guestCount = (Int(Singleton.sharedInstance.PropertyDetail.accommodates))!
        }
        else
        {
            guestCount = guestCount + 1
            updateGuestCount()
        }*/
        
        
        if guestCount == self.updatedGuestCountfromAPI
        {
            showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("morethannumberofspecified"))
            guestCount = self.updatedGuestCountfromAPI
        }
        else
        {
            guestCount = guestCount + 1
            updateGuestCount()
        }
        
    }
    @IBAction func act_GreyView(_ sender: UITapGestureRecognizer) {
        
        self.greyView.isHidden = true
        self.calenderViewFSC.isHidden = true
    }
    @IBAction func instantPay2Tapped(_ sender: UIButton) {
        if isEligibleToBook() {
            self.showTextAlertForInstantPay2()
        }
        else {
            showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
            
        }
    }
    @IBAction func requestToBook2Tapped(_ sender: UIButton) {
        if isEligibleToBook() {
            self.showTextAlertForRequestToBook2()
        } else {
            showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
        }
    }
    
    
    func showTextAlertForRequestToBook2(){
        let alertController = UIAlertController(title: sendmessage, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: submit, style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.message = textField.text!
            self.requestToBookAPICall()
        }))
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = self.enteryourMsg
        })
        self.present(alertController, animated: true, completion: nil)
    }
    func showTextAlertForInstantPay2(){
        let alertController = UIAlertController(title: sendmessage, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: submit, style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.message = textField.text!
            self.instantPayAPICall()
        }))
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = self.enteryourMsg
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    func requestToBookAPICall() {
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            print(guestCount)
            let user = String(login_session.value(forKey: "UserId") as? Int ?? 0)
            print(user)
            let host = String(Singleton.sharedInstance.PropertyDetail.hostId)
            print(host)
            if user == host
            {
                self.showInformation(title: "Closest", message: "You dont have permission to book your own Rental!")
                hideActivityIndicator(uiView: self.view)
            }
            else{
                
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                 params = ["email":login_session.value(forKey: "Email") as? String ?? "","P_Id":Singleton.sharedInstance.PropertyDetail.rentalId,"guests":guestCount,"s_date":self.btn_SelectArrDate.currentTitle!,"e_date":self.btn_SelectDepartDate.currentTitle!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","message":message,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
               
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(REQ_HOST_REQUEST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        print("GET_WISHLIST_API Response:::",responseDict)
                        isFromBookingDetails = true
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                        
                        self.navigationController?.pushViewController(nav!, animated: true)
                        
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
                
                
//                let parameterStr = "email=\(login_session.value(forKey: "Email") as? String ?? "")&P_Id=\(Singleton.sharedInstance.PropertyDetail.rentalId)&guests=\(guestCount)&s_date=\(self.btn_SelectArrDate.currentTitle!)&e_date=\(self.btn_SelectDepartDate.currentTitle!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&message=\(message)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_HOST_REQUEST, APIKEY: "REQ_HOST_REQUEST")
//                print(parameterStr)
            }
        }
        else
        {
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
    }
    func instantPayAPICall() {
        
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            print(guestCount)
            let user = String(login_session.value(forKey: "UserId") as? Int ?? 0)
            print(user)
            let host = String(Singleton.sharedInstance.PropertyDetail.hostId)
            print(host)
            if user == host
            {
                self.showInformation(title: "Closest", message: "You dont have permission to book your own Rental!")
                self.hideActivityIndicator(uiView: self.view)
            }
            else
            {
                
                
                let id = Singleton.sharedInstance.selectedCategory
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                 params = ["base_id":id,"P_Id":Singleton.sharedInstance.PropertyDetail.rentalId,"s_date":self.btn_SelectArrDate.currentTitle!,"e_date":self.btn_SelectDepartDate.currentTitle!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","numofdates":self.noOfNights,"user_id":login_session.value(forKey: "UserId")!,"renter_id":Singleton.sharedInstance.PropertyDetail.hostId,"totalAmt":self.hotelTotalPrice,"guests":guestCount,"cancel_percentage":self.hotelcancelPercentage,"secDeposit":self.hotelsecDeposit,"serviceFee":self.hotelServfee,"subTotal":self.hotlTotalAmt,"email":login_session.value(forKey: "Email") as? String ?? "","message":message,"property_currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? ""]
                
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(HOST_REQ_INSTANT_PAY_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        print(responseDict)
                        self.Stripe_status = responseDict.value(forKey: "Stripe_status") as? String ?? ""
                        print(self.Stripe_status)
                        self.creditcard_Stat = responseDict.value(forKey: "Credit_Card_status") as? String ?? ""
                        print(self.creditcard_Stat)
                        self.paypal_Stat = responseDict.value(forKey: "paypal_status") as? String ?? ""
                        print(self.paypal_Stat)
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
                        nav!.property_id = String(Singleton.sharedInstance.PropertyDetail.rentalId)
                        nav!.total_price = self.hotelTotalPrice as AnyObject
                        
                        nav!.totalDeposit = NSDecimalNumber(string: "\(self.hotelsecDeposit)")
                        nav!.totalserviceFee = NSDecimalNumber(string: "\(self.hotelServfee)")
                        nav!.totalsubtotal = NSDecimalNumber(string: "\(self.hotlTotalAmt)")
                        nav!.totalamount = self.hotelTotalPrice as AnyObject
                        nav!.PaymentFor = "Booking"
                        nav!.stripe_Status = self.Stripe_status
                        nav!.paypal_status = self.paypal_Stat
                        nav!.card_Status = self.creditcard_Stat
                        let enquiryID = responseDict.value(forKey: "enquiryId") as? Int
                        nav!.enquiryid = String(enquiryID!)
                        self.navigationController?.pushViewController(nav!, animated: true)
                        
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
//                let parameterStr = "base_id=\(id)&P_Id=\(Singleton.sharedInstance.PropertyDetail.rentalId)&s_date=\(self.btn_SelectArrDate.currentTitle!)&e_date=\(self.btn_SelectDepartDate.currentTitle!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&numofdates=\(self.noOfNights)&user_id=\(login_session.value(forKey: "UserId")!)&renter_id=\(Singleton.sharedInstance.PropertyDetail.hostId)&totalAmt=\(self.hotelTotalPrice)&guests=\(guestCount)&cancel_percentage=\(self.hotelcancelPercentage)&secDeposit=\(self.hotelsecDeposit)&serviceFee=\(self.hotelServfee)&subTotal=\(self.hotlTotalAmt)&email=\(login_session.value(forKey: "Email") as? String ?? "")&message=\(message)&property_currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOST_REQ_INSTANT_PAY_API , APIKEY: "HOST_REQ_INSTANT_PAY_API")
//                print(parameterStr)
                
            }
        }
        else
        {
            
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
          self.hideActivityIndicator(uiView: self.view)
    }
    
    func updateGuestCount() {
        if self.guestCount == 1 {
            self.lblGuestCount.text = "1 Guest"
        }
        else
        {
            self.lblGuestCount.text = String(guestCount) + " " + guests
        }
        self.showPriceDetails()
    }
    
    func mess(){
        let id = Singleton.sharedInstance.selectedCategory
        let parameters = "base_id=\(id)&message=\(self.message)&Bookingno=\(self.Bookingno)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")"
        
        Network.shared.POSTRequest(withParameterString: parameters, serviceURL: REASTURANT_BOOKING_CONFIRM, APIKEY: "REASTURANT_BOOKING_CONFIRM")
    }
    
    func showTextAlert(){
        let alertController = UIAlertController(title: sendmessage, message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: submit, style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.message = textField.text!
            self.bookingAPI()
        }))
        alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = self.enteryourMsg
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func CalculateNumOfDays()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let startingDate = dateFormatter.date(from: btn_SelectArrDate.currentTitle!)
        print(startingDate!)
        let reachingDate = dateFormatter.date(from: btn_SelectDepartDate.currentTitle!)
        print(reachingDate!)
        
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let calender = Calendar.current
        let components = calender.dateComponents([.year, .month, .day, .hour], from: startingDate!)
        let distanceBetweenDates: TimeInterval? = reachingDate!.timeIntervalSince(startingDate!)
        let secondsInDays: Double = 86400
        noOfNights = Int((distanceBetweenDates! / secondsInDays))
        print(noOfNights)
    }
    func  BookingApi(){
          
          if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory

            
            var params = NSMutableDictionary()
            
            params =  ["base_id": id,"P_Id":Singleton.sharedInstance.PropertyDetail.rentalId,"s_date":self.btn_SelectArrDate.currentTitle!,"e_date":self.btn_SelectDepartDate.currentTitle!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","numofdates":self.noOfNights,"user_id":login_session.value(forKey: "UserId")!,"renter_id":Singleton.sharedInstance.PropertyDetail.hostId,"totalAmt":self.hotelTotalPrice,"guests":guestCount,"cancel_percentage":self.hotelcancelPercentage,"secDeposit":self.hotelsecDeposit,"serviceFee":self.hotelServfee,"subTotal":self.hotlTotalAmt,"email":login_session.value(forKey: "Email") as? String ?? "","message":message,"property_currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? ""]
            
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(HOST_REQ_INSTANT_PAY_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    print(responseDict)
                    self.Stripe_status = responseDict.value(forKey: "Stripe_status") as? String ?? ""
                    print(self.Stripe_status)
                    self.creditcard_Stat = responseDict.value(forKey: "Credit_Card_status") as? String ?? ""
                    print(self.creditcard_Stat)
                    self.paypal_Stat = responseDict.value(forKey: "paypal_status") as? String ?? ""
                    print(self.paypal_Stat)
                
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
                    nav!.property_id = String(Singleton.sharedInstance.PropertyDetail.rentalId)
                    nav!.total_price = self.hotelTotalPrice as AnyObject

                    nav!.totalDeposit = NSDecimalNumber(string: "\(self.hotelsecDeposit)")
                    nav!.totalserviceFee = NSDecimalNumber(string: "\(self.hotelServfee)")
                    nav!.totalsubtotal = NSDecimalNumber(string: "\(self.hotlTotalAmt)")
                    nav!.totalamount = self.hotelTotalPrice as AnyObject
                    nav!.PaymentFor = "Booking"
                    nav!.stripe_Status = self.Stripe_status
                    nav!.paypal_status = self.paypal_Stat
                    nav!.card_Status = self.creditcard_Stat
                    let enquiryID = responseDict.value(forKey: "enquiryId") as? Int
                    nav!.enquiryid = String(enquiryID!)
                    self.navigationController?.pushViewController(nav!, animated: true)
                    
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
            
            
            
//
//        self.showActivityIndicator(uiView: self.view)
//       let id = Singleton.sharedInstance.selectedCategory
//
//        let params =  ["base_id": id,"P_Id":Singleton.sharedInstance.PropertyDetail.rentalId,"s_date":self.btn_SelectArrDate.currentTitle!,"e_date":self.btn_SelectDepartDate.currentTitle!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","numofdates":self.noOfNights,"user_id":login_session.value(forKey: "UserId")!,"renter_id":Singleton.sharedInstance.PropertyDetail.hostId,"totalAmt":self.hotelTotalPrice,"guests":guestCount,"cancel_percentage":self.hotelcancelPercentage,"secDeposit":self.hotelsecDeposit,"serviceFee":self.hotelServfee,"subTotal":self.hotlTotalAmt,"email":login_session.value(forKey: "Email") as? String ?? "","message":message,"property_currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? ""]
//
//        print(params)
//        APIManager.apiPost(serviceName: HOST_REQ_INSTANT_PAY_API, parameters: params) { (json:NSDictionary?, error:NSError?) in
//            // DispatchQueue.main.async { self.dismiss(animated: true) }
//            if error != nil
//            {
//                print(error?.localizedDescription ?? "")
//                return
//            }
//            print(json!)
//            if json?.value(forKey: "status") as! NSNumber == 1
//            {
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
//            nav!.property_id = String(Singleton.sharedInstance.PropertyDetail.rentalId)
//            nav!.total_price = self.hotelTotalPrice as AnyObject
//
//            nav!.totalDeposit = NSDecimalNumber(string: "\(self.hotelsecDeposit)")
//            nav!.totalserviceFee = NSDecimalNumber(string: "\(self.hotelServfee)")
//            nav!.totalsubtotal = NSDecimalNumber(string: "\(self.hotlTotalAmt)")
//            nav!.totalamount = self.hotelTotalPrice as AnyObject
//            nav!.PaymentFor = "Booking"
//
//            let enquiryID = json!.value(forKey: "enquiryId") as? Int
//            nav!.enquiryid = String(enquiryID!)
//            self.navigationController?.pushViewController(nav!, animated: true)
//            }else{
//                self.showInformation(title: "Closest", message: (json?.value(forKey: "message") as? String)!)
//            }
//
//        }
          }else{
             self.showInformation(title: "Closest", message: "Please check your internet")
        }
        
    }
    func bookingAPI(){
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            if btnSendToHost.currentTitle == "REQUEST HOST TO BOOK"
            {
                print(guestCount)
                //let user = String(login_session.value(forKey: "UserId") as? Int ?? 0)
                
                let user = String(describing: login_session.value(forKey: "UserId")!)

                print(user)
                let host = String(Singleton.sharedInstance.PropertyDetail.hostId)
                print(host)
                if user == host
                {
                    self.showInformation(title: "Closest", message: "You dont have permission to book your own Rental!")
                    hideActivityIndicator(uiView: self.view)
                }
                else{
                    
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                     params = ["email":login_session.value(forKey: "Email") as? String ?? "","P_Id":Singleton.sharedInstance.PropertyDetail.rentalId,"guests":guestCount,"s_date":self.btn_SelectArrDate.currentTitle!,"e_date":self.btn_SelectDepartDate.currentTitle!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","message":message,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
                    
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(REQ_HOST_REQUEST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            print("GET_WISHLIST_API Response:::",responseDict)
                            isFromBookingDetails = true
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                            
                            self.navigationController?.pushViewController(nav!, animated: true)
                            
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
                    
                    
                    
//                    let parameterStr = "email=\(login_session.value(forKey: "Email") as? String ?? "")&P_Id=\(Singleton.sharedInstance.PropertyDetail.rentalId)&guests=\(guestCount)&s_date=\(self.btn_SelectArrDate.currentTitle!)&e_date=\(self.btn_SelectDepartDate.currentTitle!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&message=\(message)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: REQ_HOST_REQUEST, APIKEY: "REQ_HOST_REQUEST")
//                    print(parameterStr)
                }
            }
            else
            {
               // let user = String(login_session.value(forKey: "UserId") as? Int ?? 0)
                let user = String(describing: login_session.value(forKey: "UserId")!)
                print(user)
                let host = String(Singleton.sharedInstance.PropertyDetail.hostId)
                print(host)
                if user == host
                {
                    self.showInformation(title: "Closest", message: "You dont have permission to book your own Rental!")
                    self.hideActivityIndicator(uiView: self.view)
                }
                else
                {
                     self.showActivityIndicator(uiView: self.view)
                    BookingApi()
//                    let id = Singleton.sharedInstance.selectedCategory
//                    let parameterStr = "base_id=\(id)&P_Id=\(Singleton.sharedInstance.PropertyDetail.rentalId)&s_date=\(self.btn_SelectArrDate.currentTitle!)&e_date=\(self.btn_SelectDepartDate.currentTitle!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&numofdates=\(self.noOfNights)&user_id=\(login_session.value(forKey: "UserId")!)&renter_id=\(Singleton.sharedInstance.PropertyDetail.hostId)&totalAmt=\(self.hotelTotalPrice)&guests=\(guestCount)&cancel_percentage=\(self.hotelcancelPercentage)&secDeposit=\(self.hotelsecDeposit)&serviceFee=\(self.hotelServfee)&subTotal=\(self.hotlTotalAmt)&email=\(login_session.value(forKey: "Email") as? String ?? "")&message=\(message)&property_currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")"
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOST_REQ_INSTANT_PAY_API , APIKEY: "HOST_REQ_INSTANT_PAY_API")
//                    print(parameterStr)
                    
                }
            }
        }
        else
        {
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
    }
}

extension BookingDetailViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        
        
        if APIKEY == "REQ_HOST_REQUEST"{
            
            if errorDict.count == 0
            {
                isFromBookingDetails = true
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                
                self.navigationController?.pushViewController(nav!, animated: true)
            }
        }
        else if APIKEY == "HOST_REQ_INSTANT_PAY_API"
        {
            if errorDict.count == 0
            {
                let status = responseDict.value(forKey: "status") as? Int ?? 0
                if status == 1
                {
                    print(responseDict)
                    self.Stripe_status = responseDict.value(forKey: "Stripe_status") as? String ?? ""
                    print(Stripe_status)
                    self.creditcard_Stat = responseDict.value(forKey: "Credit_Card_status") as? String ?? ""
                    print(creditcard_Stat)
                    self.paypal_Stat = responseDict.value(forKey: "paypal_status") as? String ?? ""
                    print(paypal_Stat)
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
                    nav!.property_id = String(Singleton.sharedInstance.PropertyDetail.rentalId)
                    nav!.total_price = self.hotelTotalPrice as AnyObject
                    
                    nav!.totalDeposit = NSDecimalNumber(string: "\(hotelsecDeposit)")
                    nav!.totalserviceFee = NSDecimalNumber(string: "\(hotelServfee)")
                    nav!.totalsubtotal = NSDecimalNumber(string: "\(hotlTotalAmt)")
                    nav!.totalamount = self.hotelTotalPrice as AnyObject
                    nav!.PaymentFor = "Booking"
                    nav!.stripe_Status = self.Stripe_status
                    nav!.paypal_status = self.paypal_Stat
                    nav!.card_Status = self.creditcard_Stat
                    let enquiryID = responseDict.value(forKey: "enquiryId") as? Int
                    nav!.enquiryid = String(enquiryID!)
                    self.navigationController?.pushViewController(nav!, animated: true)
                    
                }
                else{
                    showInformation(title: "Closest", message: "Rental date already booked")
                }
                
            }
            else{
                showInformation(title: "Closest", message: "Check your input datas")
            }
        }
        else
        {
            print("No Data")
        }
    }
}
extension BookingDetailViewController {
    
    
    //    func datesRange(from: Date, to: Date) -> [Date] {
    //        // in case of the "from" date is more than "to" date,
    //        // it should returns an empty array:
    //        if from > to { return [Date]() }
    //
    //        var tempDate = from
    //        var array = [tempDate]
    //
    //        while tempDate < to {
    //            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
    //            array.append(tempDate)
    //
    //            RangeOfDays = array.count
    //            print(RangeOfDays)
    //        }
    //        print(array)
    //
    //        return array
    //    }
    
    
    func isEligibleToBook() -> Bool {
        print(Int(minStay))
        
        if btn_SelectArrDate.currentTitle == "Select date"
        {
            self.showInformation(title: "Closest", message: "Please select Arrival date")
            return false

        }
        else if btn_SelectDepartDate.currentTitle == "Select date"
        {
            self.showInformation(title: "Closest", message: "Please select departure date")
            return false

        }
        else
        {
        
        if noOfNights >= Int(minStay)
        {
            return true
        }
        else
        {
            self.showInformation(title: "Closest", message: "Minimum stay is \(minStay) days, So Please book minimum \(minStay) days")
            return false
        }
        }
    }
    
    func datesBtnDates()
    {
        seasonalCnt = 0
        self.bookedDays.removeAllObjects()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        var dateFrom = Date()
        var dateTo = Date()
        dateFrom = dateFormatter.date(from: self.arriveDate)!
        dateTo = dateFormatter.date(from: self.departDate)!
      
        
        let dateFormatternw = DateFormatter()
        dateFormatternw.dateFormat = "yyyy-MM-dd"
        dateFormatternw.locale = Locale(identifier: "en_US_POSIX")
        dateFormatternw.string(from: dateFrom)
        dateFormatternw.string(from: dateTo)
        
        
        while dateFrom <= dateTo
        {
            mydates.append(dateFormatternw.string(from: dateFrom))
            bookedDays.add(dateFormatternw.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
        print(bookedDays)
          self.bookedDays.removeLastObject()
        if seasonalPrices.count != 0
        {
            for i in 0..<self.seasonalPrices.count
            {
                let seasonalDate:String = (((seasonalPrices.object(at: i)) as AnyObject).value(forKey: "date") as? String)!
                if bookedDays.contains(seasonalDate)
                {
                    seasonalCnt = seasonalCnt + 1
                    let price = (((seasonalPrices.object(at: i)) as AnyObject).value(forKey: "price") as AnyObject)
                    self.seasonalPrice = String(describing: price) as AnyObject
                    self.seasonalPriceCheck = seasonalCnt * Int(price as! NSNumber)
                    
                }
                
            }
            
        }
        self.bookedcnt = bookedDays.count - 1
        self.normaldayCnt = bookedDays.count - seasonalCnt
    }
    
    func showPriceDetails()
    {
        print(Int(minStay))
        print(Int(noOfNights))
        if noOfNights >= minStay
        {
            self.viewPriceDetails.isHidden = false
            let Price = Float(truncating: Singleton.sharedInstance.PropertyDetail.productprice! as! NSNumber) * Float(self.normaldayCnt)
            let check = Double(Price) + Double(self.seasonalPriceCheck)
            print(check)
            self.hotlTotalAmt = String(check)
            self.viewPriceDetails.isHidden = false
            UserDefaults.standard.set(Price, forKey: "payPrice")
            let servFee = (self.hotelServVal) * Float(check)/100
            self.hotelServfee = String(servFee)
            print(servFee)
            //                let servicesFee = Float(String(describing: Singleton.sharedInstance.PropertyDetail.productprice!))
            //
            //                UserDefaults.standard.set(serviceFee, forKey: "payserviceFee")
            //
            //let deposit = Float(String(describing: Singleton.sharedInstance.PropertyDetail.securityDeposit!))
            //self.hotelsecDeposit = Float(deposit!)
            //UserDefaults.standard.set(deposit, forKey: "paydeposit")
            var deposit : Float = 0
            if let depositCheck = Float(String(describing:Singleton.sharedInstance.PropertyDetail.securityDeposit!)) {
                //self.lblPriceDetailSecurityDepo.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: secuDeposit)
                self.hotelsecDeposit = Float(depositCheck)
                deposit = depositCheck
                UserDefaults.standard.set(depositCheck, forKey: "paydeposit")
            }
            
            let total = Double(check) + Double(truncating: servFee as NSNumber) + Double(deposit)
            self.hotelTotalPrice = String(total)
            UserDefaults.standard.set(total, forKey: "paytotal")
            self.lblNoOfNight.text = " " + "\(app_Currency_Symbol) \(String(describing: Singleton.sharedInstance.PropertyDetail.productprice!)) * \(noOfNights) nights"
            UserDefaults.standard.set("\(String(describing: Singleton.sharedInstance.PropertyDetail.productprice!)) * \(noOfNights)", forKey: "payNoOfNight")
            self.lblNightPrice.text = ": " + app_Currency_Symbol + " " + String(format: "%.2f", check)
            //": \(Usercurrency) \(Int(check))"
            self.lblSeviceFees.text = " Service Fees"
            self.lblServiceFeePrice.text = ": \(app_Currency_Symbol) \(String(servFee))"
            self.lblSecurityDeposit.text = " Security Deposit"
            self.lblSecurityDepositPrice.text = ": \(app_Currency_Symbol) \(Int(deposit))"
            self.lblTotalPrice.text = ": " + app_Currency_Symbol + " " + String(format: "%.2f", total)
            
            //": \(Usercurrency) \(Int(total))"
            self.lblTotalPricePrice.text = " Total Price"
        }
        else
        {
            self.viewPriceDetails.isHidden = false
            let Price = Float(truncating: Singleton.sharedInstance.PropertyDetail.productprice! as! NSNumber) * Float(noOfNights)
            self.hotlTotalAmt = String(Price)
            self.viewPriceDetails.isHidden = false
            UserDefaults.standard.set(Price, forKey: "payPrice")
            let servFee = (self.hotelServVal) * Float(Price)/100
            self.hotelServfee = String(servFee)
            var deposit : Float = 0
            if let depositCheck = Float(String(describing:Singleton.sharedInstance.PropertyDetail.securityDeposit!)) {
                //self.lblPriceDetailSecurityDepo.text = "  " + Singleton.sharedInstance.PropertyDetail.userCurrency + " " + String(describing: secuDeposit)
                self.hotelsecDeposit = Float(depositCheck)
                deposit = depositCheck
                UserDefaults.standard.set(depositCheck, forKey: "paydeposit")
            }
            
            let total = Double(Price) + Double(truncating: servFee as NSNumber) + Double(deposit)
            self.hotelTotalPrice = String(total)
            UserDefaults.standard.set(total, forKey: "paytotal")
            self.lblNoOfNight.text = " " + "\(app_Currency_Symbol) \(String(describing: Singleton.sharedInstance.PropertyDetail.productprice!)) * \(noOfNights) nights"
            UserDefaults.standard.set("\(String(describing: Singleton.sharedInstance.PropertyDetail.productprice!)) * \(noOfNights)", forKey: "payNoOfNight")
            self.lblNightPrice.text =  ": " + app_Currency_Symbol + " " + String(format: "%.2f", Price)
            //": \(Usercurrency) \(Float(Price))"
            self.lblSeviceFees.text = " Service Fees"
            self.lblServiceFeePrice.text = ": \(app_Currency_Symbol) \(Int(servFee))"
            self.lblSecurityDeposit.text = " Security Deposit"
            self.lblSecurityDepositPrice.text = ": \(app_Currency_Symbol) \(Int(deposit))"
            self.lblTotalPrice.text = ": " + app_Currency_Symbol + " " + String(format: "%.2f", total)
            //": \(Usercurrency) \(Int(total))"
            
            self.lblTotalPricePrice.text = " Total Price"
            
            
        }
    }
    
}
extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
