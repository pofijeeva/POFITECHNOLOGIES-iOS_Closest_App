//
//  NewBookingViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 30/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import AFNetworking
import DateTimePicker



class NewBookingViewController: BaseViewController,DateTimePickerDelegate,SambagTimePickerViewControllerDelegate {
    
    
   
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        
    }
    
    
    
    @IBOutlet weak var BookingTable: UITableView!
    @IBOutlet weak var GrayView: UIView!
    @IBOutlet weak var SendToHost: UIButton!
    
    @IBOutlet weak var TimtPicker: UIView!
    
    @IBOutlet weak var ChooseTimeLbl: UILabel!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var HeaderLbl: UILabel!
    
    
     @IBOutlet weak var SendMessage: UIView!
     @IBOutlet weak var confirmLbl: UILabel!
    @IBOutlet weak var MessagestaticLbl: UILabel!
    @IBOutlet weak var MessageLbl: UITextView!
    @IBOutlet weak var MessageCancelBtn: UIButton!
       @IBOutlet weak var OkayBtn: UIButton!
    
    var ProperdyDetails = NSMutableDictionary()

    var isFromDate = "Arrive"
    var currencySymbol = String()
    var PriceShow = 0
    var TableCount = 0
    var hourPick = String()
    var isSelectTime = "PickUpTime"
    
    var avaliableDates = NSMutableArray()
    var BookindDates = NSMutableArray()
    var UnavaliableDates = NSMutableArray()
    var bookedDates : [String] = []
    
    var DatesMutable = NSMutableArray()
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
    var GuestCnt = 1
    
    var unavailableDatesArr = NSArray()
    
    var hPickDate = String()
    var hDropDate = String()
    var checkinDate = String()
    var checkoutDate = String()
    var fromDate = Date()
    var toDate = Date()
    var minimumDate = Date()
    var datesRange: [Date]?
    var isRangeSelection = false
    let datesMutArray = NSMutableArray()
    let datesFormatMutArray = NSMutableArray()
    var selectedDateStr = String()
    var startDate = String()
    var startTime = String()
    var endTime = String()
    var endDate = String()
    var firstTimeNotAllowed = Bool()
    var hpickUpDate = Date()
    var hdropDate = Date()
    var SelectedDate = String()
    var diffDates = Int()
    var startArr = NSMutableArray()
    var endArr = NSMutableArray()
    var DayStr = String()
    var DateStr = String()
    var arriveDate = String()
    var MonthStr = String()
    var pickup = String()
    var dropoff = String()
    var pricetype = String()
    var hourlyStart:String = "00:00"
    var hourlyEnd:String = "00:00"
    var PropertyId = String()
    var showimgPriceStatus = String()
    var minStay = Int()
    var vehBookstatus = String()
    var message = ""
    var TimeARR = ["am","pm"]
    var TimingsArr = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    var hourStr = String()
    var Timeformat = String()
    var hourDrop = String()
    var diffHrs = String()
    var pickUpTime = String()
    var PickUPTime = Int()
    var BookingDays = String()
    var ServiceFee = String()
    var SecurityDeposit = String()
    var TotalAmount = String()
    var SubTotal = String()
    var ProPrice = String()

    var BookingPrice = String()
    var numDates = String()
    var DateShow = String()
    var cancel_percentage = String()
    var bookedDays = Int()
    var no_of_weeks = String()
    var no_of_hours = String()
    var no_of_days = String()
    var no_of_months = String()
    var CurrencySym = String()
    
    
    var PaymentType = String()
    
    var BundleAmount = String()
    var AddonsAmount = String()
    var TaxName = String()
    var TaxPercentage = String()
    var TaxAmount = String()
    var InfoMessageStr = String()

    var payLaterAmount = String()
    var PayBalanceAMount = String()
    
    var pay_balance = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideActivityIndicator(uiView: self.view)
        self.SendToHost.setTitle(GlobalLanguageDictionary.object(forKey: "key_send2Host") as! String, for: .normal)
        
        self.GrayView.isHidden = true
        self.SendMessage.isHidden = true
        self.pricetype = "daily"
        showimgPriceStatus = "day"
        self.SendToHost.backgroundColor = AppColor
        self.ChooseTimeLbl.font = UIFont(name: RegularFont, size: 17)
        self.CancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.SubmitBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.SendToHost.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.MessageLbl.font = UIFont(name: RegularFont, size: 15)
        self.OkayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.MessageCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
//        self.vehBookstatus = Singleton.sharedInstance.PropertyDetail.booking_type
//        if self.vehBookstatus == "1,2"
//        {
//            self.pricetype = "daily"
//            showimgPriceStatus = "day"
//
//
//        }
//        else if self.vehBookstatus == "1"
//        {
//            self.pricetype = "daily"
//            showimgPriceStatus = "day"
//
//        }else if self.vehBookstatus == "2"
//        {
//            self.pricetype = "hourly"
//            showimgPriceStatus = "hour"
//
//
//        }
        
        self.pricetype = "daily"
        showimgPriceStatus = "day"
        self.DateShow = ""
        self.HeaderLbl.text = "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "ren_title") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.defaultproducttitle!
self.minStay = Int("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "minimum_stay") as AnyObject)") ?? 1
     //   self.minStay = 2 //Singleton.sharedInstance.PropertyDetail.min_days!

        self.MessageLbl.layer.borderWidth = 1
        self.MessageLbl.layer.borderColor = UIColor.lightGray.cgColor
        print(self.DatesMutable)
        if self.DatesMutable.count != 0 {

                      let cnt = self.DatesMutable.count
            
                      for i in 0..<cnt{
                        print(((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateStatus") as! Int)
                          if ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateStatus") as? Int == 1 {
                              let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                              self.avaliableDates.add(date!)
                          }else if ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateStatus") as! Int == 2 {
                              let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                              self.BookindDates.add(date!)
                          }else {
                              let date = ((self.DatesMutable.object(at: i)) as AnyObject).value(forKey: "DateString") as? String
                              self.UnavaliableDates.add(date!)
                          }
                      }

                  }else {
                  
                  }
//         print("BookindDates")
//                  print(BookindDates)
//                  print(UnavaliableDates)
         self.BookingTable.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.GrayView.isHidden = true
                  self.SendMessage.isHidden = true
        self.hideActivityIndicator(uiView: self.view)

    }
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func act_SendMessageCancel(_ sender: UIButton)
       {
           
           self.GrayView.isHidden = true
           self.SendMessage.isHidden = true
           
       }
       
       @IBAction func act_SendMessageSubmit(_ sender: UIButton)
       {
        
        if self.MessageLbl.text.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter a private mesage to host")
        }else{
            self.message = self.MessageLbl.text!
                       
            if self.PaymentType == "instant_pay" || self.PaymentType == "pay_later"{
                            self.instantPayAPICall()
                       }else{
                           self.requestToBookAPICall()
                       }
        }
        
        
    }
    func isEligibleToBook() -> Bool {
        
        if self.startDate == ""
        {
            self.showInformation(title: "Closest", message: "Please select Arrival date")
            return false

        }
        else if self.endDate == ""
        {
            self.showInformation(title: "Closest", message: "Please select departure date")
            return false

        }
        else
        {
print(minStay)
            print(bookedDays)
            if self.bookedDays >= Int(minStay)
        {
            return true
        }
        else
        {
            self.showInformation(title: "Closest", message: "Minimum stay is \(minStay) \(showimgPriceStatus)s, So Please book minimum \(minStay) \(showimgPriceStatus)s")
            return false
        }
        }
    }
    
    func showTextAlert(){
           let alertController = UIAlertController(title: "Send Message", message: "", preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { alert -> Void in
               let textField = alertController.textFields![0] as UITextField
               self.message = textField.text!
            
            if self.PaymentType == "InstantPay" {
                 self.instantPayAPICall()
            }else{
                self.requestToBookAPICall()
            }
            
              
           }))
           alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
               textField.placeholder = "Please enter your message"
           })
           self.present(alertController, animated: true, completion: nil)
       }
    
           func requestToBookAPICall() {
               if Reachability()!.isReachable {
                   self.showActivityIndicator(uiView: self.view)
                   let id = Singleton.sharedInstance.selectedCategory!
                   print(GuestCnt)
                let user = "\(login_session.value(forKey: "UserId") as AnyObject)"
                   print(user)
                   let host = String(Singleton.sharedInstance.PropertyDetail.hostId ?? 0)
                   print(host)
                   if user == host
                   {
                       self.showInformation(title: "Closest", message: "You dont have permission to book your own rental!")
                       hideActivityIndicator(uiView: self.view)
                   }
                   else{
                    var BundleString = String()
                    var AddonString = String()

                    do {
                        //Convert to Data
                        let BundleData = try JSONSerialization.data(withJSONObject: BundleSelectedDictValues, options: [])
                        let AddonData = try JSONSerialization.data(withJSONObject: AddonsSelectedValuesDict, options: [])
                        //Convert back to string. Usually only do this for debugging
                        if let BundleStr = String(data: BundleData, encoding: String.Encoding.utf8) {
                            BundleString = BundleStr
                        }
                        
                        if let AddonStr = String(data: AddonData, encoding: String.Encoding.utf8) {
                            AddonString = AddonStr
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    print(BundleString)
                    print(AddonString)
                       
                       showActivityIndicator(uiView: self.view)
                       var params = NSMutableDictionary()
                       params = ["email":login_session.value(forKey: "Email") as! String,"P_Id":Singleton.sharedInstance.PropertyDetail.rentalId!,"guests":GuestCnt,"s_date":self.checkinDate,"e_date":self.checkoutDate,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"message":self.message,"base_id":id,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","no_of_weeks" : self.no_of_weeks,"no_of_hours" : self.no_of_hours,"no_of_days" : self.no_of_days,"no_of_months" : self.no_of_months,"numofdates"  : self.no_of_days,"device_type":"ios","bundle_checkindate":bundle_checkindate,"bundle_checkoutdate":bundle_checkoutdate,"bundle_amount":Bundle_amount ,"choosed_option":"","bundle_details":BundleString,"add_on_amount":add_on_amount,"add_on_details":AddonString,"serviceFee":self.ServiceFee,"subTotal":self.SubTotal,"price" : Singleton.sharedInstance.PropertyDetail.productprice!,"booking_type" : self.pricetype]
                    
                    
                    
//                    Params: {serviceFee=1030.0, add_on_amount=400, add_on_details=[{"id":"124","name":"Bently-1997","amount":"100.00"},{"id":"123","name":"Closet","amount":"300.00"}], device_type=android, e_date=05/05/2021 18:00:00, subTotal=10300.0, message=duu, no_of_weeks=0, numofdates=, currency_code=USD, P_Id=201, no_of_hours=52.0, bundle_checkindate=May 04 21, bundle_checkoutdate=May 06 21, price=13343, no_of_days=, guests=1, bundle_amount=1600, booking_type=hourly, s_date=05/03/2021 14:00:00, bundle_details=[{"bundle_id":"1","bundle_name":"bundle 1","No_of_Guests":"2","total_amount":"600"},{"bundle_id":"2","bundle_name":"bundle 4","No_of_Guests":"2","total_amount":"1000"}], email=sathyapriya@pofitec.com, no_of_months=0}
                      
                       print(params)
                       let manager = AFHTTPSessionManager()
                       manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                       
                       manager.post(REQ_HOST_REQUEST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                           DispatchQueue.main.async {
                               
                           }
                           let responseDict:NSDictionary = responseObject as! NSDictionary
                           print(responseDict)
                           self.hideActivityIndicator(uiView: self.view)
                           if responseDict.value(forKey: "status") as! Int == 1 {
                               print("GET_WISHLIST_API Response:::",responseDict)
                               isFromBookingDetails = true
                               let nav = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                               
                               self.navigationController?.pushViewController(nav!, animated: true)
                               
                           }
                               
                           else {
                               self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                           }
                       }, failure: { (operation, error) -> Void in
                           DispatchQueue.main.async {
                               
                           }
                           print(error)
                           self.showInformation(title: "Closest", message: error.localizedDescription)
                       })
                       
    
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
                print(self.GuestCnt)
                let user = "\(login_session.value(forKey: "UserId") as AnyObject)"
                print(user)
                let hostId = "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "host_id") as AnyObject)"
                print(hostId)
                if user == hostId
                {
                    self.showInformation(title: "Closest", message: "You dont have permission to book your own rental!")
                    self.hideActivityIndicator(uiView: self.view)
                }
                else
                {
                    
                    var BundleString = String()
                    var AddonString = String()

                    do {
                        //Convert to Data
                        let BundleData = try JSONSerialization.data(withJSONObject: BundleSelectedDictValues, options: [])
                        let AddonData = try JSONSerialization.data(withJSONObject: AddonsSelectedValuesDict, options: [])
                        //Convert back to string. Usually only do this for debugging
                               if let BundleStr = String(data: BundleData, encoding: String.Encoding.utf8) {
                            BundleString = BundleStr
                         }
                        
                        if let AddonStr = String(data: AddonData, encoding: String.Encoding.utf8) {
                            AddonString = AddonStr
                        }
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    print(BundleString)
                    print(AddonString)

                    let id = Singleton.sharedInstance.selectedCategory!
                     self.showActivityIndicator(uiView: self.view)
                    showActivityIndicator(uiView: self.view)
                    
                    var GetIn = String()
                    var GetOut = String()
                    var Types = String()
                    var URL = String()
                  
                    if self.pricetype == "hourly" {
                        Types = "2"
                        GetIn = self.hourPick
                        GetOut = self.hourDrop
                        URL = HOURLY_INSTANT_PAY
                    }else{
                        Types = "1"
                        GetIn = self.checkinDate
                        GetOut = self.checkoutDate
                        URL = HOST_REQ_INSTANT_PAY_API

                    }
                    
                    let params = ["check_in":GetIn,"check_out":GetOut,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"property_id":self.PropertyId,"type":Types,"lang_code":"en","add_on_total":self.AddonsAmount,"add_on_detail":AddonString] as [String : Any]
                    
                    print(params)
                    APIManager.apiPostWithHeaders(serviceName: URL, parameters: params) { (json:NSDictionary?, error:NSError?) in
                        DispatchQueue.main.async {  }
                        if error != nil {
                            print(error!.localizedDescription)
                            self.showInformation(title: "Closest", message: error!.localizedDescription)
                            return
                        }
                        let responseDict:NSDictionary = json!
                        print(responseDict)
                        if responseDict.value(forKey: "code") as! NSNumber == 200 {
                            print(responseDict)
                            
                            var PaymentMethodsArr = NSMutableArray()
//
//                            let StripeStatus = responseDict.value(forKey: "Stripe_status") as! String
//                             let PaypalStatus = responseDict.value(forKey: "paypal_status") as! String
//                             let CreditCardStatus = responseDict.value(forKey: "Credit_Card_status") as! String(
                            let Enquiry = "\((responseDict.value(forKey: "data") as! NSDictionary).object(forKey: "book_id") as AnyObject)"
//
//                            if StripeStatus == "Enable" {
//                                PaymentMethodsArr.add("Stripe")
//                            }else{
//                            }
//                            if PaypalStatus == "Enable" {
//                                                           PaymentMethodsArr.add("PayPal")
//                                                       }else{
//                                                       }
//                            if CreditCardStatus == "Enable" {
//                                                           PaymentMethodsArr.add("Credit Card")
//                                                       }else{
//                                                       }
                            PaymentMethodsArr.add("Stripe")
//                            PaymentMethodsArr.add("Credit Card")
                            PaymentMethodsArr.add("PayPal")
                            PaymentMethodsArr.add("ApplePay")

                            print(PaymentMethodsArr)
                          
                            let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as? NewPaymentViewController
                            nav!.paymentComingType = "RentalBooking"
                            nav!.PaymentFor = "RentalBooking"
                            nav!.PaymentsArray = PaymentMethodsArr
                            nav!.subTotal = self.SubTotal
                            
                            nav!.booking_type = Types
                                nav!.TotalAmount = self.TotalAmount
                                nav!.enquiryid = "\(Enquiry)"
                            nav!.ServiceFee = self.ServiceFee
                            nav!.SecurityDeposit = self.SecurityDeposit
                            nav!.choosed_option = self.PaymentType
                            nav!.pay_balance = self.pay_balance
                            nav!.PropertId = self.PropertyId
                            nav!.GuestCount = self.GuestCnt
                            self.navigationController?.pushViewController(nav!, animated: true)
                        }
                        else
                        {
                            
                            self.hideActivityIndicator(uiView: self.view)
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                             
                        }
                        
                    }
                    
 
                }
            }
            else
            {
                self.showInformation(title: "Closest", message: "Please check your internet")
            }
             
        }
    
    
    @IBAction func act_sendtoHost(_ sender: UIButton)
      {
        if self.PaymentType == "instant_pay" || self.PaymentType == "pay_later"{
                        self.instantPayAPICall()
                   }else{
                       self.requestToBookAPICall()
                   }
        
//        if isEligibleToBook() {
//
////            self.GrayView.isHidden = false
////                      self.SendMessage.isHidden = false
//                       //self.showTextAlert()
//
//            if self.PaymentType == "instant_pay" || self.PaymentType == "pay_later"{
//                            self.instantPayAPICall()
//                       }else{
//                           self.requestToBookAPICall()
//                       }
//                   }
//                   else {
//                       showInformation(title: "Closest", message: LocalizeHelper().localizedStringForKey("message"))
//
//
//      }
    }
    
    @IBAction func act_TimeCancel(_ sender: UIButton)
    {
        
        self.GrayView.isHidden = true
        self.TimtPicker.isHidden = true
        
    }
   
    
    @IBAction func act_TimeSubmit(_ sender: UIButton)
    {
        
        print ("\(checkinDate)   \(checkoutDate)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        let hpickdate = dateFormatter.date(from: self.startDate)
        let hdropdate = dateFormatter.date(from:self.endDate)
        
        let newformat1 = DateFormatter()
        newformat1.dateFormat = "MM/dd/yyyy"
        self.hPickDate = newformat1.string(from: hpickdate!)
        self.hDropDate = newformat1.string(from: hdropdate!)
        let today = Date()
        let timestamp = today.timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let timerformatter = DateFormatter()
        timerformatter.dateFormat = "MM/dd/yyyy HH:mm"
        let myString = timerformatter.string(from: time as Date)
        let DateTimeArray = myString.components(separatedBy: " ")
        let tempTimeStr = DateTimeArray[1]
        let tempArray = tempTimeStr.components(separatedBy: ":")
        let selectedTime = Int(self.hourStr)!
        var currentTime = Int(tempArray[0])!
        print("myString",currentTime)
        
        let tempCheckInStr = DateTimeArray[0]
        print(myString)
        
        //let timeArray = tim
        if isSelectTime == "PickUpTime"
        {
            if Timeformat == "am"
            {
                //            if currentTime > 12{
                //                currentTime = currentTime - 12
                //            }
                self.hourPick = self.hPickDate + " " + String(self.hourStr) + ":" +  "00:00"
                if self.hourStr == ""
                {
                    showInformation(title: "Closest", message: "Please select a time before clicking on Done")
                    return
                }
                else if tempCheckInStr == hPickDate && currentTime >= selectedTime{
                    showInformation(title: "Closest", message: "Please select your booking time as before 24 hours from your current time.")
                    return
                }else{
                    self.hourlyStart = String(self.hourStr) + "" + ":00 AM"
                    self.PickUPTime = Int(self.hourStr)!
                }
            }else{
                let time = Int(self.hourStr)! + 12
                self.PickUPTime = Int(self.hourStr)! + 12
                
                if tempCheckInStr == hPickDate && currentTime >= time{
                    showInformation(title: "Closest", message: "Please select your booking time as before 24 hours from your current time.")
                    return
                }else{
                    self.hourPick = self.hPickDate + " " + String(time) + ":" + "00:00"
                    self.hourlyStart = String(self.hourStr) + "" + ":00 PM"
                }
            }
            self.GrayView.isHidden = true
            self.TimtPicker.isHidden = true
            let contentOffset = self.BookingTable.contentOffset
            self.BookingTable.reloadData()
            self.BookingTable.layoutIfNeeded()
            self.BookingTable.setContentOffset(contentOffset, animated: false)
            //self.basetbl.reloadData()
            
        }
        else
        {
            
            
            if Timeformat == "am"
            {
                self.hourDrop = self.hDropDate + " " + String(self.hourStr) + ":" + "00:00"
                self.hourlyEnd = String(self.hourStr) + "" + ":00 AM"
            }
            else
            {
                let time = Int(self.hourStr)! + 12
                self.hourDrop = self.hDropDate + " " + String(time) + ":" + "00:00"
                self.hourlyEnd = String(self.hourStr) + "" + ":00 PM"
            }
            self.GrayView.isHidden = true
            self.TimtPicker.isHidden = true
            print("\( self.checkoutDate )")
            print("SelectTime",self.PickUPTime)
            print("SelectTime",self.hourlyEnd)
            print("SelectTime",self.checkoutDate)
            print("SelectTime",self.hourStr)
            if self.checkinDate == self.checkoutDate {
                if self.hourlyEnd == "12:00 AM" {
                    showInformation(title: "Closest", message: "Please choose different time")
                    
                }
                else if self.PickUPTime >= Int(self.hourStr)! {
                    showInformation(title: "Closest", message: "Please choose different time")
                }
                else{
                    HourCalcAPI()
                }
            }else{
                HourCalcAPI()
            }
      }
  }
    
    func HourCalcAPI()
    {
        self.showActivityIndicator(uiView: self.view)
        var BundleString = String()
        var AddonString = String()

        do {
            //Convert to Data
            let BundleData = try JSONSerialization.data(withJSONObject: BundleSelectedDictValues, options: [])
            let AddonData = try JSONSerialization.data(withJSONObject: AddonsSelectedValuesDict, options: [])
            //Convert back to string. Usually only do this for debugging
            if let BundleStr = String(data: BundleData, encoding: String.Encoding.utf8) {
                BundleString = BundleStr
            }
            
            if let AddonStr = String(data: AddonData, encoding: String.Encoding.utf8) {
                AddonString = AddonStr
            }
            
        } catch {
            print(error.localizedDescription)
        }
        print(BundleString)
        print(AddonString)
      
        
        let params = ["lang_code": "en","check_in": self.hourPick,"property_id": self.PropertyId,"currency_code": login_session.value(forKey: "APP_CURRENCY") as? String ?? "USD","check_out": self.hourDrop,"device_type":"ios","add_on_details":AddonString,"add_on_amount":add_on_amount,"add_on_total":add_on_amount,"qty":GuestCnt] as [String : Any]
         APIManager.apiPostWithHeaders(serviceName: HOUR_CALC_API, parameters: params) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error!.localizedDescription)
                self.showInformation(title: "Closest", message: error!.localizedDescription)
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                                self.PriceShow = 1
              //  self.cancel_percentage = String(describing: responseDict.value(forKey: "cancel_percentage") as AnyObject)
                self.CurrencySym = login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "USD"

                let Data = (responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "prop_details") as! NSDictionary
                self.ServiceFee = String(describing: Data.value(forKey: "service_fee_amount") as AnyObject)
                self.SecurityDeposit = String(describing: Data.value(forKey: "security_deposit") as AnyObject)
                self.ProPrice = String(describing: Data.value(forKey: "originalamount") as AnyObject)

                self.SubTotal = String(describing: Data.value(forKey: "prop_amount") as AnyObject)
                self.AddonsAmount = String(describing: Data.value(forKey: "add_on_amount") as AnyObject)
                self.TaxName = String(describing: Data.value(forKey: "tax_name") as AnyObject)
                self.InfoMessageStr = String(describing: Data.value(forKey: "info") as AnyObject)
                self.TaxAmount = String(describing: Data.value(forKey: "tax_amount") as AnyObject)
                self.TaxPercentage = String(describing: Data.value(forKey: "tax_percent") as AnyObject)

 
                    self.TotalAmount = "\(Data.value(forKey: "total_amount") as AnyObject)"
                self.no_of_weeks = "\(responseDict.value(forKey: "no_of_weeks") as AnyObject)"
                self.no_of_hours = "\(responseDict.value(forKey: "no_of_hours") as AnyObject)"
                self.no_of_days = "\(responseDict.value(forKey: "no_of_days") as AnyObject)"
                self.no_of_months = "\(responseDict.value(forKey: "no_of_months") as AnyObject)"
               
                 self.hideActivityIndicator(uiView: self.view)

                let contentOffset = self.BookingTable.contentOffset
                self.BookingTable.reloadData()
                 self.BookingTable.setContentOffset(contentOffset, animated: false)
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                 
            }
            
        }
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        //manager.requestSerializer.setValue(tokenString, forHTTPHeaderField: "Authorization")
//        manager.post(HOUR_CALC_API, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
//            DispatchQueue.main.async {
//                self.hideActivityIndicator(uiView: self.view)
//            }
//            let responseDict:NSDictionary = responseObject as! NSDictionary
//            print(responseDict)
//            if responseDict.value(forKey: "status") as! NSNumber == 1 {
//
//
//                 self.PriceShow = 1
//                self.ServiceFee = String(describing: responseDict.value(forKey: "service_fee") as AnyObject)
//                self.SecurityDeposit = String(describing: responseDict.value(forKey: "secDeposite") as AnyObject)
//
//
//                    self.TotalAmount = "\(responseDict.value(forKey: "total_amount") as! AnyObject)"
//
//
//
//                self.payLaterAmount = "\(responseDict.value(forKey: "paylater_payable_amount") as AnyObject)"
//                self.PayBalanceAMount = "\(responseDict.value(forKey: "paylater_balance_amount") as AnyObject)"
//
//                let BookingHours = responseDict.value(forKey: "no_of_hours") as AnyObject
//                 let BookedDays = responseDict.value(forKey: "no_of_hours") as AnyObject
//                let token = BookedDays.components(separatedBy: ".")
//                self.BookingDays = "\(BookingHours) Hours"
//                self.CurrencySym = responseDict.value(forKey: "currency_symbols") as! String
//                 self.SubTotal = "\(responseDict.value(forKey: "subTotal") as AnyObject)"
//                self.bookedDays = Int(token[0])!
//
//                self.BundleAmount = "\(responseDict.value(forKey: "bundle_amount") as AnyObject)"
//                self.AddonsAmount = "\(responseDict.value(forKey: "add_on_amount") as AnyObject)"
//
//                self.no_of_weeks = "\(responseDict.value(forKey: "no_of_weeks") as AnyObject)"
//                             self.no_of_hours = "\(responseDict.value(forKey: "no_of_hours") as AnyObject)"
//                             self.no_of_days = "\(responseDict.value(forKey: "no_of_days") as AnyObject)"
////                             self.no_of_months = "\(responseDict.value(forKey: "no_of_months") as AnyObject)"
//              //  self.numDates = responseDict.value(forKey: "numberofdates") as! String
//                let contentOffset = self.BookingTable.contentOffset
//                self.BookingTable.reloadData()
//                self.BookingTable.layoutIfNeeded()
//                self.BookingTable.setContentOffset(contentOffset, animated: false)
//
//
//
//            }
//            else {
//
//                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//            }
//
//
//        }, failure: { (operation, error) -> Void in
//            DispatchQueue.main.async {
//                self.hideActivityIndicator(uiView: self.view)
//            }
//            print(error)
//            self.showInformation(title: "Closest", message: error.localizedDescription)
//        })
        
    
    }
    
    @IBAction func GaryViewAct(_ sender: UITapGestureRecognizer) {
        self.GrayView.isHidden = true
         self.SendMessage.isHidden = true
        
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
    
    
   
    
    
    func DayCalcAPI()
    {
        self.showActivityIndicator(uiView: self.view)
        var BundleString = String()
        var AddonString = String()

        do {
            //Convert to Data
            let BundleData = try JSONSerialization.data(withJSONObject: BundleSelectedDictValues, options: [])
            let AddonData = try JSONSerialization.data(withJSONObject: AddonsSelectedValuesDict, options: [])
            //Convert back to string. Usually only do this for debugging
            if let BundleStr = String(data: BundleData, encoding: String.Encoding.utf8) {
                BundleString = BundleStr
            }
            
            if let AddonStr = String(data: AddonData, encoding: String.Encoding.utf8) {
                AddonString = AddonStr
            }
            
        } catch {
            print(error.localizedDescription)
        }
        print(BundleString)
        print(AddonString)
        let params = ["lang_code": "en","check_in": self.checkinDate,"property_id": self.PropertyId,"currency_code": login_session.value(forKey: "APP_CURRENCY") as? String ?? "USD","check_out": self.checkoutDate,"device_type":"ios","add_on_details":AddonString,"add_on_amount":add_on_amount,"add_on_total":add_on_amount,"qty":GuestCnt] as [String : Any]
        
        
 
        print(params)
        APIManager.apiPostWithHeaders(serviceName: DAY_CALC_API, parameters: params) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error!.localizedDescription)
                self.showInformation(title: "Closest", message: error!.localizedDescription)
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                                self.PriceShow = 1
              //  self.cancel_percentage = String(describing: responseDict.value(forKey: "cancel_percentage") as AnyObject)
                self.CurrencySym = login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "USD"

                let Data = (responseDict.object(forKey: "data") as! NSDictionary).object(forKey: "prop_details") as! NSDictionary
                self.ServiceFee = String(describing: Data.value(forKey: "service_fee_amount") as AnyObject)
                self.SecurityDeposit = String(describing: Data.value(forKey: "security_deposit") as AnyObject)
                self.ProPrice = String(describing: Data.value(forKey: "originalamount") as AnyObject)

                self.SubTotal = String(describing: Data.value(forKey: "prop_amount") as AnyObject)
                self.AddonsAmount = String(describing: Data.value(forKey: "add_on_amount") as AnyObject)
                self.TaxName = String(describing: Data.value(forKey: "tax_name") as AnyObject)
                self.InfoMessageStr = String(describing: Data.value(forKey: "info") as AnyObject)
                self.TaxAmount = String(describing: Data.value(forKey: "tax_amount") as AnyObject)
                self.TaxPercentage = String(describing: Data.value(forKey: "tax_percent") as AnyObject)

                self.TotalAmount = Data.value(forKey: "total_amount") as! String
               
                    self.TotalAmount = "\(Data.value(forKey: "total_amount") as AnyObject)"

                
              //  self.payLaterAmount = "\(responseDict.value(forKey: "paylater_payable_amount") as AnyObject)"
              //  self.PayBalanceAMount = "\(responseDict.value(forKey: "paylater_balance_amount") as AnyObject)"
//                self.SubTotal = "\(responseDict.value(forKey: "prop_amount") as AnyObject)"
//                self.AddonsAmount = "\(responseDict.value(forKey: "tax_amount") as AnyObject)"
//                self.TaxName = "\(responseDict.value(forKey: "tax_name") as AnyObject)"
//                self.TaxPercentage = "\(responseDict.value(forKey: "tax_percent") as AnyObject)"

             //   let BookedDays = responseDict.value(forKey: "total_days") as! Int
               // self.bookedDays = BookedDays
            //    self.BookingDays = responseDict.value(forKey: "numberofdates") as! String//"\(BookedDays) Days"
                self.no_of_weeks = "\(responseDict.value(forKey: "no_of_weeks") as AnyObject)"
                self.no_of_hours = "\(responseDict.value(forKey: "no_of_hours") as AnyObject)"
                self.no_of_days = "\(responseDict.value(forKey: "no_of_days") as AnyObject)"
                self.no_of_months = "\(responseDict.value(forKey: "no_of_months") as AnyObject)"
               
             //   self.numDates = "\(BookedDays)"
                self.hideActivityIndicator(uiView: self.view)

                let contentOffset = self.BookingTable.contentOffset
                self.BookingTable.reloadData()
              //  self.BookingTable.layoutIfNeeded()
                self.BookingTable.setContentOffset(contentOffset, animated: false)
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                 
            }
            
        }
//["booking_type": self.pricetype,"pickup": self.checkinDate,"vehicle_id": self.PropertyId,"currency_code": login_session.value(forKey: "APP_CURRENCY") as? String ?? "USD","drop": self.checkoutDate,"device_type":"ios","bundle_checkindate":bundle_checkindate,"bundle_checkoutdate":bundle_checkoutdate,"bundle_amount":Bundle_amount ,"choosed_option":"","bundle_details":BundleString,"add_on_amount":add_on_amount,"add_on_details":AddonString] as [String : Any]
        print(params)
        
        //lang_code:en
//        property_id:1
//        check_in:2021-08-17
//        check_out:2021-08-18
        
//        let manager = AFHTTPSessionManager()
//        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//        //manager.requestSerializer.setValue(tokenString, forHTTPHeaderField: "Authorization")
//        manager.post(DAY_CALC_API, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
//            DispatchQueue.main.async {
//                self.hideActivityIndicator(uiView: self.view)
//            }
//            let responseDict:NSDictionary = responseObject as! NSDictionary
//            print(responseDict)
//            if responseDict.value(forKey: "status") as! NSNumber == 1 {
//
//
//                self.PriceShow = 1
//
//
//
//
//
//                //                                        let mod = DayCalcModel(fromDictionary: responseDict as! [String : Any])
//                //                                                    Singleton.sharedInstance.dayCalc = mod
//                self.cancel_percentage = String(describing: responseDict.value(forKey: "cancel_percentage") as AnyObject)
//                self.CurrencySym = responseDict.value(forKey: "currency_symbols") as! String
//
//                self.ServiceFee = String(describing: responseDict.value(forKey: "service_fee") as AnyObject)//(json?.value(forKey: "service_fee") as? NSNumber)!
//                //                                                    let taxamount = NSDecimalNumber(string: "\(self.servFee)")
//                //                                                    let rounding2 = Double(truncating: taxamount)
//                //                                                    self.Tax = String(format: "%.2f",rounding2)
//                //                                                    self.Tax = self.servFee
//                self.SecurityDeposit = String(describing: responseDict.value(forKey: "secDeposite") as AnyObject)//(json?.value(forKey: "secDeposite") as? NSNumber)!
//                //                                                    self.CommonSubTotal = String(describing: responseDict.value(forKey: "subTotal") as AnyObject)
//                //                                                    self.subTotl = (responseDict.value(forKey: "subTotal") as? NSNumber)!
//                self.BundleAmount = "\(responseDict.value(forKey: "bundle_total_amount") as AnyObject)"
//                self.AddonsAmount = "\(responseDict.value(forKey: "add_on_total_amount") as AnyObject)"
//
//                self.TotalAmount = responseDict.value(forKey: "total_amount") as! String
//
//                    self.TotalAmount = "\(responseDict.value(forKey: "total_amount") as AnyObject)"
//
//
//                self.payLaterAmount = "\(responseDict.value(forKey: "paylater_payable_amount") as AnyObject)"
//                self.PayBalanceAMount = "\(responseDict.value(forKey: "paylater_balance_amount") as AnyObject)"
//                self.SubTotal = "\(responseDict.value(forKey: "subTotal") as AnyObject)"
//                //                                                    let amount = NSDecimalNumber(string: "\(self.dtotalAmt)")
//                //                                                    let rounding1 = Double(truncating: amount)
//                //                                                    self.AmtTrip = String(format: "%.2f",rounding1)
//                let BookedDays = responseDict.value(forKey: "total_days") as! Int
//                self.bookedDays = BookedDays
//                self.BookingDays = responseDict.value(forKey: "numberofdates") as! String//"\(BookedDays) Days"
//                self.no_of_weeks = "\(responseDict.value(forKey: "no_of_weeks") as AnyObject)"
//                self.no_of_hours = "\(responseDict.value(forKey: "no_of_hours") as AnyObject)"
//                self.no_of_days = "\(responseDict.value(forKey: "no_of_days") as AnyObject)"
//                self.no_of_months = "\(responseDict.value(forKey: "no_of_months") as AnyObject)"
//                //                                                    self.numWeeks = responseDict.value(forKey: "no_of_weeks") as! Int
//                //                                                    self.numMonths = responseDict.value(forKey: "no_of_months") as! Int
//                self.numDates = "\(BookedDays)"
//                //                                                    self.showPaymentView = true
//                //
//                let contentOffset = self.BookingTable.contentOffset
//                self.BookingTable.reloadData()
//                self.BookingTable.layoutIfNeeded()
//                self.BookingTable.setContentOffset(contentOffset, animated: false)
//            }
//            else {
//
//                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//            }
//
//
//        }, failure: { (operation, error) -> Void in
//            DispatchQueue.main.async {
//                self.hideActivityIndicator(uiView: self.view)
//            }
//            print(error)
//            self.showInformation(title: "Closest", message: error.localizedDescription)
//        })
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension NewBookingViewController: FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance
{
    func minimumDate(for calendar: FSCalendar) -> Date
    {
        let today = Date()
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
    
//    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)  -> Bool
//    {
//
//        let curDate = Date().addingTimeInterval(-24*60*60)
//
//        if date < curDate
//        {
//            return false
//        }
//        else
//        {
//            for i in 0..<unavailableDatesArr.count
//            {
//                let dayStr:String = unavailableDatesArr[i] as! String
//                print(dayStr)
//                if self.formatter.string(from: date) == dayStr
//                {
//                    return false
//                }
//            }
//        }
//        if date < curDate
//        {
//            return false
//        }
//        else
//        {
//            return true
//        }
//        return true
//    }
//
     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
      {
          //let key = self.formatter.string(from: date)
          if self.gregorian.isDateInToday(date)
          {
              return UIColor.orange
          }
          
          for i in 0..<self.BookindDates.count
          {
            let dayStr:String = self.BookindDates[i] as! String
              if self.formatter.string(from: date) == dayStr
              {
                return AppSecondColor
              }
          }
          for i in 0..<self.UnavaliableDates.count
          {
              let dayStr:String = self.UnavaliableDates[i] as! String
              if self.formatter.string(from: date) == dayStr
              {
                  return UIColor.gray
              }
          }
          for i in 0..<self.avaliableDates.count
          {
              let dayStr:String = self.avaliableDates[i] as! String
              if self.formatter.string(from: date) == dayStr
              {
                  return UIColor.clear
              }
          }
          
          
          return nil
      }
          func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
              
              let curDate = Date().addingTimeInterval(-24*60*60)
              
              for i in 0..<BookindDates.count {
                  let dayStr:String = BookindDates[i] as! String
                  if self.formatter.string(from: date) == dayStr {
                      return false
                  }
                  
              }
              for i in 0..<UnavaliableDates.count {
                  let dayStr:String = UnavaliableDates[i] as! String
                  if self.formatter.string(from: date) == dayStr {
                      return false
                  }
                  
              }
              for i in 0..<bookedDates.count {
                  let dayStr:String = bookedDates[i]
                  if self.formatter.string(from: date) == dayStr {
                      return false
                  }
                  
              }
    
              
              if date < curDate {
                  return false
              } else {
                  return true
              }
              
             
              // let curDate = Date().addingTimeInterval(-24*60*60)
              
              if date < curDate {
                  return false
              } else {
                  return true
              }
              
             
//              for i in 0..<HideDates.count {
//                  let dayStr:String = HideDates[i] as! String
//                  print(dayStr)
//                  if self.formatterNew1.string(from: date) == dayStr {
//                      return false
//                  }
//
//              }
              return true
              
          }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        if dateSingleSelection == true
        {
            
            dateSingleSelection = false
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            print("did select date \(formatter.string(from: date))")
            self.checkinDate = formatter.string(from: date)
            let responseFormatter = DateFormatter()
            responseFormatter.dateFormat = "E, d MMM"
            print("did select date \(formatter.string(from: date))")
            let startdDate = formatter.string(from: date)
            self.hpickUpDate = formatter.date(from: startdDate)!
            let time1 = startdDate
            self.pickup = time1
            let startArray = pickup.components(separatedBy: " ")
            startArr.removeAllObjects()
            for i in startArray
            {
                startArr.add(i)
            }
            self.DayStr = startArr[0] as! String
            self.DateStr = startArr[1] as! String
            self.MonthStr = startArr[2] as! String
            self.startDate = self.DayStr + self.DateStr + "" + self.MonthStr
            //            self.lbl_Pickupdate.text = self.startDate
            self.arriveDate = self.startDate
            UserDefaults.standard.set(self.arriveDate, forKey: "selectedArriveDate")
            
            self.checkinDate = formatter.string(from: date)
            self.checkoutDate = formatter.string(from: date)
            datesMutArray.add(checkinDate)
            datesMutArray.add(checkoutDate)
            print(datesMutArray)
            firstDate = date
            datesRange = [firstDate!]
            
        }
            
        else
        {
            
            if firstDate == nil
            {
                for d in calendar.selectedDates
                {
                    calendar.deselect(d)
                }
                firstDate = date
                lastDate = nil
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                calendar.select(date)
                return
            }
            if firstDate != nil && lastDate != nil{
                for d in calendar.selectedDates
                {
                    calendar.deselect(d)
                }
                lastDate = nil
                firstDate = nil
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                calendar.select(date)
                return
            }
        }
        
        // only first date is selected:
        if firstDate != nil && lastDate == nil
        {
            isRangeSelection = false
            // handle the case of if the last date is less than the first date:
            if date < firstDate!
            {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                self.checkinDate = formatter.string(from: firstDate!)
                //self.checkoutDate = formatter.string(from: lastDate!)
                print("datesRange contains: \(datesRange!)")
                return
            }
            
            let range = datesRange(from: firstDate!, to: date, _tempCalender:calendar)
            if range.count != 0{
                lastDate = range.last
                for d in range
                {
                    calendar.select(d)
                }
                datesRange = range
                self.checkinDate = formatter.string(from: firstDate!)
                self.checkoutDate = formatter.string(from: lastDate!)
                print("datesRange contains: \(datesRange!)")
                firstDate = nil
                //lastDate = nil
            }
            
            return
        }
        
        if firstDate != nil && lastDate != nil{
            isRangeSelection = true
            for d in calendar.selectedDates
            {
                calendar.deselect(d)
            }
            //        lastDate = nil
            //        firstDate = nil
            
            datesRange = []
            datesMutArray.removeAllObjects()
            datesFormatMutArray.removeAllObjects()
            self.checkinDate = formatter.string(from: firstDate!)
            self.checkoutDate = formatter.string(from: lastDate!)
            datesMutArray.add(datesRange!)
            
            print("datesRange contains: \(datesRange!)")
            print("datesMutArray contains: \(datesMutArray)")
        }
        else
        {
            selectedDateStr = dateFormatter.string(from: date)
            //   selectedDateString = self.selectedDateStr
            UserDefaults.standard.set(selectedDateStr, forKey: "selectedDateString")
            
        }
        
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition)
    {
        
        if firstDate != nil && lastDate == nil && firstTimeNotAllowed == true
        {
            isRangeSelection = false
            // handle the case of if the last date is less than the first date:
            if date < firstDate!
            {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                self.checkinDate = formatter.string(from: firstDate!)
                //self.checkoutDate = formatter.string(from: lastDate!)
                print("datesRange contains: \(datesRange!)")
                return
            }
            
            let range = datesRange(from: firstDate!, to: date, _tempCalender:calendar)
            if range.count != 0{
                lastDate = range.last
                for d in range
                {
                    calendar.select(d)
                }
                datesRange = range
                self.checkinDate = formatter.string(from: firstDate!)
                self.checkoutDate = formatter.string(from: lastDate!)
                print("datesRange contains: \(datesRange!)")
            }
            return
        }
        firstTimeNotAllowed = true
    }
 
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date)
    {
        
    }
    //    {
    //        if isRangeSelection == false
    //        {
    //        }else {
    //            // both are selected:
    //            // NOTE: the is a REDUANDENT CODE:
    //            if firstDate != nil && lastDate != nil
    //            {
    //                for d in calendar.selectedDates {
    //                    calendar.deselect(d)
    //                }
    //                lastDate = nil
    //                firstDate = nil
    //                datesRange = []
    //                print("datesRange contains: \(datesRange!)")
    //            }
    //            if firstDate != nil && lastDate == nil
    //            {
    //                isRangeSelection = false
    //                // handle the case of if the last date is less than the first date:
    //                if date < firstDate!
    //                {
    //                    calendar.deselect(firstDate!)
    //                    firstDate = date
    //                    datesRange = [firstDate!]
    //                    self.checkinDate = formatter.string(from: firstDate!)
    //                    //self.checkoutDate = formatter.string(from: lastDate!)
    //                    print("datesRange contains: \(datesRange!)")
    //                    return
    //                }
    //
    //                let range = datesRange(from: firstDate!, to: date, _tempCalender:calendar)
    //                if range.count != 0{
    //                lastDate = range.last
    //                for d in range
    //                {
    //                    calendar.select(d)
    //                }
    //                datesRange = range
    //                self.checkinDate = formatter.string(from: firstDate!)
    //                self.checkoutDate = formatter.string(from: lastDate!)
    //                print("datesRange contains: \(datesRange!)")
    //                }
    //
    //                return
    //            }
    //        }
    //        print("did deselect date \(self.formatter.string(from: date))")
    //    }
    
    func datesRange(from: Date, to: Date,_tempCalender: FSCalendar) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        datesMutArray.removeAllObjects()
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to
        {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyy HH:mm:ss"
        
        let checkDateFormatter = DateFormatter()
        checkDateFormatter.dateFormat = "yyy-MM-dd"
        
        for date in array
        {
            datesMutArray.add(formatter.string(from: date))
            let checkDateStr = checkDateFormatter.string(from: date)
            if unavailableDatesArr.contains(checkDateStr){
                
                self.showInformation(title: "Closest", message: "Already some dates are booked")
                firstDate = nil
                lastDate = nil
                datesRange = []
                for d in _tempCalender.selectedDates{
                    _tempCalender.deselect(d)
                }
                return []
            }
        }
        print("datesMutArray contains: \(datesMutArray)")
        bookedDays = datesMutArray.count

        //        selectedDateString = datesMutArray.componentsJoined(by: ",")
        //        UserDefaults.standard.set(datesMutArray, forKey: "RangeDatesArray")
        //        UserDefaults.standard.set(selectedDateString, forKey: "RangeDates")
        
        let dummy = DateFormatter()
        dummy.dateFormat = "E, d MMM"
        let start = dummy.string(from: array[0])
        self.startDate = String(describing: start)
        let end = dummy.string(from: array[array.count - 1])
        self.endDate = String(describing: end)
        
        print(self.startDate)
        print(self.endDate)
        //        self.startDate = dummy.date(from: datesMutArray.firstObject as! String)
        //        self.endDate = dummy.date(from: datesMutArray.lastObject as! String)
        //        self.endDate = dummy.date(from: datesMutArray.lastObject as! String)
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy HH:mm:ss"
        let startingDate = dateFormatter.date(from: datesMutArray.firstObject as! String)
        let EndDate = dateFormatter.date(from: datesMutArray.lastObject as! String)
        let newformat = DateFormatter()
        newformat.dateFormat =  "MM/dd/yyy HH:mm:ss"
        newformat.string(from: startingDate!)
        newformat.string(from: EndDate!)
        print(startingDate)
        print("Changed Date \(newformat.string(from: startingDate!))")
        print("Changed Date \(newformat.string(from: EndDate!))")
        self.checkinDate = newformat.string(from: startingDate!)
        self.checkoutDate = newformat.string(from: EndDate!)
        print(checkinDate)
        print(checkoutDate)
        //   selectedDateStringArray = datesMutArray
        //self.basetbl.reloadData()
        if pricetype == "daily"
        {
            self.DateShow = "Show"
            let contentOffset = self.BookingTable.contentOffset
            self.BookingTable.reloadData()
            self.BookingTable.layoutIfNeeded()
            self.BookingTable.setContentOffset(contentOffset, animated: false)
             DayCalcAPI()
        }
        else
        {
            self.DateShow = "Show"
            TableCount = 1
            let contentOffset = self.BookingTable.contentOffset
            self.BookingTable.reloadData()
            self.BookingTable.layoutIfNeeded()
            self.BookingTable.setContentOffset(contentOffset, animated: false)
        }
        return array
        
    }
}
extension NewBookingViewController: UITableViewDelegate,UITableViewDataSource {
    
    @objc func FrombtnClick(sender: UIButton)
    {
        self.GrayView.isHidden = false
       
    }
    @objc func TobtnClick(sender: UIButton)
    {
        isFromDate = "Depart"
        self.GrayView.isHidden = false
         
    }
    
    @objc func dayBtnTapped(sender:UIButton)
    {
        //  self.minStay = Int("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "minimum_stay") as AnyObject)")!
        pricetype = "daily"
        showimgPriceStatus = "day"
        // unavailableDatesArr = unAvailableDatesForDayBooking
        let contentOffset = self.BookingTable.contentOffset
        self.BookingTable.reloadData()
        self.BookingTable.layoutIfNeeded()
        self.BookingTable.setContentOffset(contentOffset, animated: false)
        //        self.basetbl.reloadData()
    }
    
    @objc func hourBtnTapped(sender:UIButton)
    {
          self.minStay = Int("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "min_hour") as AnyObject)")!
        showimgPriceStatus = "hour"
        pricetype = "hourly"
        //   unavailableDatesArr = unAvailableDatesForDayBooking
        let dummyArray = NSMutableArray()
        dummyArray.addObjects(from: unavailableDatesArr as! [Any])
        //            for i in 0..<unavailableDatesArr.count{
        //                let dateStr = (SomeOfHoursAvailbleArray.object(at: i)as! NSDictionary).object(forKey: "date")as! String
        //                if dummyArray.contains(dateStr){
        //                    dummyArray.remove(dateStr)
        //                }
        //            }
        //  let flattenCollection = [dummyArray, self.fullHoursBooked].joined()
        //  self.unavailableDatesArr = Array(flattenCollection) as NSArray
        let contentOffset = self.BookingTable.contentOffset
        self.BookingTable.reloadData()
        self.BookingTable.layoutIfNeeded()
        self.BookingTable.setContentOffset(contentOffset, animated: false)
        //self.basetbl.reloadData()
    }
    
    @objc func PlusbtnClick(sender: UIButton)
    {
       // print(Int(Singleton.sharedInstance.PropertyDetail.guest_capacity!))
       
        
        if self.GuestCnt ==  Int("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "max_qty") as AnyObject)") {
            showInformation(title: "Closest", message: "Quantity can't be morethan \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "max_qty") as AnyObject)")")
        }else{
            self.GuestCnt += 1
            
            if self.pricetype == "hourly" {
                HourCalcAPI()
            }else{
                DayCalcAPI()
            }
                   self.BookingTable.reloadData()
        }
        
        
       
    }
    @objc func MinusbtnClick(sender: UIButton)
    {
        if self.GuestCnt == 1 {
             showInformation(title: "Closest", message: "Quantity can't be lessthan one")
        }else{
            self.GuestCnt -= 1
            if self.pricetype == "hourly" {
                HourCalcAPI()
            }else{
                DayCalcAPI()
            }
            self.BookingTable.reloadData()
        }
        
        
       
    }
     func DateAndTimePickerTapped()
    {
        let min = self.dateFormatter.date(from: self.checkinDate)
        let max = self.dateFormatter.date(from: self.checkoutDate)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.is12HourFormat = true
        picker.includeMonth = true // if true the month shows at bottom of date cell
        picker.highlightColor = AppColor
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "Select"
      //  picker.dateTitleLabel.text = "Closest"
        
        picker.doneBackgroundColor = AppColor
        picker.completionHandler = { [self] date in
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
           
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let dateStr = formatter.string(from: date)
            print(dateStr)
            
            print ("\(self.checkinDate)   \(self.checkoutDate)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM"
            let hpickdate = dateFormatter.date(from: self.startDate)
            let hdropdate = dateFormatter.date(from:self.endDate)
            
            let newformat1 = DateFormatter()
            newformat1.dateFormat = "MM/dd/yyyy"
            self.hPickDate = newformat1.string(from: hpickdate!)
            self.hDropDate = newformat1.string(from: hdropdate!)
            let today = Date()
            let timestamp = today.timeIntervalSince1970
            let myTimeInterval = TimeInterval(timestamp)
            let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
            
            let timerformatter = DateFormatter()
            timerformatter.dateFormat = "MM/dd/yyyy HH:mm"
            let myString = timerformatter.string(from: time as Date)
            let DateTimeArray = myString.components(separatedBy: " ")
            let tempTimeStr = DateTimeArray[1]
            let tempArray = tempTimeStr.components(separatedBy: ":")
//            let selectedTime = Int(dateStr)!
//            var currentTime = Int(tempArray[0])!
          //  print("myString",currentTime)
            
            let tempCheckInStr = DateTimeArray[0]
            print(myString)
            
            //let timeArray = tim
            if self.isSelectTime == "PickUpTime"
            {
//                if self.Timeformat == "am"
////                {
////                    //            if currentTime > 12{
////                    //                currentTime = currentTime - 12
////                    //            }
////                    self.hourPick = self.hPickDate + " " + String(self.hourStr) + ":" +  "00:00"
////                    if self.hourStr == ""
////                    {
////                        showInformation(title: "Closest", message: "Please select a time before clicking on Done")
////                        return
////                    }
////                    else if tempCheckInStr == hPickDate && currentTime >= selectedTime{
////                        showInformation(title: "Closest", message: "Please select your booking time as before 24 hours from your current time.")
////                        return
////                    }else{
////                        self.hourlyStart = String(self.hourStr) + "" + ":00 AM"
////                        self.PickUPTime = Int(self.hourStr)!
////                    }
////                }else{
////                    let time = Int(self.hourStr)! + 12
////                    self.PickUPTime = Int(self.hourStr)! + 12
////
////                    if tempCheckInStr == hPickDate && currentTime >= time{
////                        showInformation(title: "Closest", message: "Please select your booking time as before 24 hours from your current time.")
////                        return
////                    }else{
////                        self.hourPick = self.hPickDate + " " + String(time) + ":" + "00:00"
////                        self.hourlyStart = String(self.hourStr) + "" + ":00 PM"
////                    }
////                }
              // self.PickUPTime = dateStr

                self.hourPick = self.hPickDate + " " + String(dateStr)
                self.hourlyStart = String(dateStr)
                self.GrayView.isHidden = true
                self.TimtPicker.isHidden = true
                let contentOffset = self.BookingTable.contentOffset
                self.BookingTable.reloadData()
                self.BookingTable.layoutIfNeeded()
                self.BookingTable.setContentOffset(contentOffset, animated: false)
                //self.basetbl.reloadData()
                
            }
            else
            {
                
                
//                if Timeformat == "am"
//                {
//                    self.hourDrop = self.hDropDate + " " + String(self.hourStr) + ":" + "00:00"
//                    self.hourlyEnd = String(self.hourStr) + "" + ":00 AM"
//                }
//                else
//                {
//                    let time = Int(self.hourStr)! + 12
//                    self.hourDrop = self.hDropDate + " " + String(time) + ":" + "00:00"
//                    self.hourlyEnd = String(self.hourStr) + "" + ":00 PM"
//                }
                
                self.hourDrop = self.hDropDate + " " + String(dateStr)
                self.hourlyEnd = String(dateStr)
                self.GrayView.isHidden = true
                self.TimtPicker.isHidden = true
                print("\( self.checkoutDate )")
                print("SelectTime",self.PickUPTime)
                print("SelectTime",self.hourlyEnd)
                print("SelectTime",self.checkoutDate)
                print("SelectTime",self.hourStr)
//                if self.checkinDate == self.checkoutDate {
//                    if self.hourlyEnd == "12:00 AM" {
//                        showInformation(title: "Closest", message: "Please choose different time")
//
//                    }
//                    else if self.PickUPTime >= Int(self.hourStr)! {
//                        showInformation(title: "Closest", message: "Please choose different time")
//                    }
//                    else{
//                        HourCalcAPI()
//                    }
//                }else{
                    self.HourCalcAPI()
              //  }
          }
            
            
            
            
        }
        picker.delegate = self
        picker.show()
    }
    @objc func infoAct(sender:UIButton)
    {
        self.confirmLbl.text = self.InfoMessageStr
        self.GrayView.isHidden = false
        self.SendMessage.isHidden = false

    }
    @objc func selectPickTime(sender:UIButton)
    {
        if self.startDate == "Date" || self.startDate == "" || self.endDate == "Date" || self.endDate == ""{
            showInformation(title: "Closest", message: "Select Pick and Drop dates before choosing time")
        }else{
            self.GrayView.isHidden = false
          //  self.TimtPicker.isHidden = false
            isSelectTime = "PickUpTime"
            self.view.endEditing(true)
            
          //  self.DateAndTimePickerTapped()
//            RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, style: .Inline, didSelectDate: {[weak self] (selectedDate) in
//                // TODO: Your implementation for date
//               print(selectedDate.dateString("hh:mm a"))
//            })
            let vc = SambagTimePickerViewController()
            vc.theme = .light
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            
        }
    }
    func sambagTimePickerDidSet(_ viewController: SambagTimePickerViewController, result: SambagTimePickerResult) {
        print(result)
        
        print ("\(checkinDate)   \(checkoutDate)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM"
        let hpickdate = dateFormatter.date(from: self.startDate)
        let hdropdate = dateFormatter.date(from:self.endDate)
        
        let newformat1 = DateFormatter()
        newformat1.dateFormat = "MM/dd/yyyy"
        self.hPickDate = newformat1.string(from: hpickdate!)
        self.hDropDate = newformat1.string(from: hdropdate!)
        let today = Date()
        let timestamp = today.timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let timerformatter = DateFormatter()
        timerformatter.dateFormat = "MM/dd/yyyy HH:mm"
        let myString = timerformatter.string(from: time as Date)
        let DateTimeArray = myString.components(separatedBy: " ")
        let tempTimeStr = DateTimeArray[1]
        let tempArray = tempTimeStr.components(separatedBy: ":")
        var currentTime = Int(tempArray[0])!
        print("myString",currentTime)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: Date())
        print(dateString)
        
       
        
        if isSelectTime == "PickUpTime"
        {
            let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "h:mm a"

           let date = dateFormatter.date(from: "\(result)")
           dateFormatter.dateFormat = "HH:mm:ss"

           let Date24 = dateFormatter.string(from: date!)
            print(Date24)
                self.hourPick = self.hPickDate + " " + "\(Date24)"
                self.hourlyStart = "\(result)"
                self.GrayView.isHidden = true
            viewController.dismiss(animated: true, completion: nil)

                let contentOffset = self.BookingTable.contentOffset
                self.BookingTable.reloadData()
                self.BookingTable.layoutIfNeeded()
                self.BookingTable.setContentOffset(contentOffset, animated: false)
        }else{
            print(self.hourlyStart,result)
            print ("\(checkinDate)   \(checkoutDate)")
            if self.checkinDate == self.checkoutDate {
                
                
                let time1 = self.hourlyStart
                    let time2 = "\(result)"

                    let formatter = DateFormatter()
                    formatter.dateFormat = "h:mm a"

                    let date1 = formatter.date(from: time1)!
                    let date2 = formatter.date(from: time2)!

                    let elapsedTime = date2.timeIntervalSince(date1)

                    // convert from seconds to hours, rounding down to the nearest hour
                    let hours = floor(elapsedTime / 60 / 60)

                    // we have to subtract the number of seconds in hours from minutes to get
                    // the remaining minutes, rounding down to the nearest minute (in case you
                    // want to get seconds down the road)
                    let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)

                    print("\(Int(hours)) hr and \(Int(minutes)) min")
                
                let difference = Calendar.current.dateComponents([.hour, .minute], from: date1, to: date2)
                let formattedString = String(format: "%02ld%02ld", difference.hour!, difference.minute!)
                print(formattedString)
                
                if "\(difference.hour!)".contains("-") || "\(difference.minute!)".contains("-")  {
                    self.GrayView.isHidden = true

                    viewController.dismiss(animated: true, completion: nil)

                    showToast(forMessage: "Please choose valid end time")
                }else{
                    let dateFormatter = DateFormatter()
                   dateFormatter.dateFormat = "h:mm a"

                   let date = dateFormatter.date(from: "\(result)")
                   dateFormatter.dateFormat = "HH:mm:ss"

                   let Date24 = dateFormatter.string(from: date!)
                    print(Date24)
                    self.hourDrop = self.hDropDate + " " + "\(Date24)"
                    self.hourlyEnd = "\(result)"
                    self.GrayView.isHidden = true
                    viewController.dismiss(animated: true, completion: nil)

                self.HourCalcAPI()
                   
                    
                }
                
//                if self.hourlyStart < "\(result)"{
//                  
//                    
//                }else{
//                   
//                }
            }else{
                self.hourDrop = self.hDropDate + " " + "\(result)"
                self.hourlyEnd = "\(result)"
                self.GrayView.isHidden = true
                viewController.dismiss(animated: true, completion: nil)

            self.HourCalcAPI()
            }
            
            

                

        }
        
        

    }
    
    func sambagTimePickerDidCancel(_ viewController: SambagTimePickerViewController) {
        self.GrayView.isHidden = true

        viewController.dismiss(animated: true, completion: nil)

    }
    func sambagMonthYearPickerDidSet(_ viewController: SambagMonthYearPickerViewController, result: SambagMonthYearPickerResult) {
        print(result)
        if let theLabel = self.BookingTable.viewWithTag(222) as? UITextField {
            theLabel.text =  "\(result)"
        }
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagMonthYearPickerDidCancel(_ viewController: SambagMonthYearPickerViewController) {
        self.GrayView.isHidden = true

        viewController.dismiss(animated: true, completion: nil)

    }
    @objc func selectDropTime(sender:UIButton)
    {
        if self.hourPick == ""
        {
            showInformation(title: "Closest", message: "Select pickup time before choosing dropoff time")
        }
        else
        {
            self.GrayView.isHidden = false
          //  self.TimtPicker.isHidden = false
            isSelectTime = "DropOffTime"
            self.view.endEditing(true)
          //  self.DateAndTimePickerTapped()
            let vc = SambagTimePickerViewController()
            vc.theme = .light
            vc.delegate = self
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 4
        }else if section == 1 {
            return TableCount
        } else{
            return self.PriceShow
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookImageTableViewCell") as? ReqBookImageTableViewCell
                cell!.selectionStyle = .none
                 cell!.ProductName.font = UIFont(name: SemiBoldFont, size: 15)
                cell!.ProductLocation.font = UIFont(name: RegularFont, size: 14)
                cell!.ProductPrice.font = UIFont(name: SemiBoldFont, size: 19)
                cell!.ProductLocation.text = "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "address") as AnyObject)"
                cell!.ProductName.text = "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "ren_title") as AnyObject)"
                
                let price = "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "productprice") as AnyObject)"
                cell!.ProductPrice.text = "\(currencySymbol) \(price)/ day "
                cell!.ProductPrice.textColor = AppColor

                 let imgUpdated =  URL(string:"\((((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "product_image") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "product_image") as! String)")
             
                         cell!.ProductImage.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                return cell!
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookGuestTableViewCell") as? ReqBookGuestTableViewCell
                cell!.selectionStyle = .none
                cell!.GuestValueLbl.font = UIFont(name: SemiBoldFont, size: 15)
                cell!.GuestLbl.font = UIFont(name: SemiBoldFont, size: 15)
                cell!.GuestLbl.text = GlobalLanguageDictionary.object(forKey: "key_guest") as! String
                cell!.GuestValueLbl.text = "\(self.GuestCnt)"
                cell!.PlusBtn.addTarget(self, action: #selector(PlusbtnClick), for: .touchUpInside)
                cell!.minusBtn.addTarget(self, action: #selector(MinusbtnClick), for: .touchUpInside)
                return cell!
                
            }else if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookStaticPriceTableViewCell") as? ReqBookStaticPriceTableViewCell
                
                cell!.selectionStyle = .none
                cell!.ChoosePrice.text = GlobalLanguageDictionary.object(forKey: "key_choosePricePer") as! String
                cell!.DayLbl.text = GlobalLanguageDictionary.object(forKey: "Key_day") as! String
                cell!.hourLbl.text = GlobalLanguageDictionary.object(forKey: "Key_hour") as! String
                cell!.hourLbl.text = GlobalLanguageDictionary.object(forKey: "Key_hour") as! String
                
                cell!.DailyPrice.text = GlobalLanguageDictionary.object(forKey: "key_dailyPrice") as! String
                cell!.WeeklyPrice.text = GlobalLanguageDictionary.object(forKey: "key_weeklyPrice") as! String
                cell!.MonthlyPrice.text = GlobalLanguageDictionary.object(forKey: "key_monthlyPrice") as! String
                cell!.HourlyPrice.text = GlobalLanguageDictionary.object(forKey: "key_hourlyPrice") as! String
                cell!.MinHourPrice.text = GlobalLanguageDictionary.object(forKey: "key_minHourPrice") as! String
                
                
                
                cell!.ChoosePrice.font = UIFont(name: RegularFont, size: 15)
                cell!.ColorLbl.backgroundColor = AppColor
                cell!.DailyPrice.font = UIFont(name: RegularFont, size: 14)
                cell!.HourlyPrice.font = UIFont(name: RegularFont, size: 14)
                cell!.DailyPrice.font = UIFont(name: RegularFont, size: 14)
                cell!.MinHourPrice.font = UIFont(name: RegularFont, size: 14)
                cell!.WeeklyPrice.font = UIFont(name: RegularFont, size: 14)
                cell!.DayLbl.font = UIFont(name: RegularFont, size: 14)
                cell!.hourLbl.font = UIFont(name: RegularFont, size: 14)

                cell!.DailyPriceValue.font = UIFont(name: RegularFont, size: 14)
                cell!.WeeklyPriceValue.font = UIFont(name: RegularFont, size: 14)
                cell!.MonthlyPriceValue.font = UIFont(name: RegularFont, size: 14)
                cell!.MinHourPriceValue.font = UIFont(name: RegularFont, size: 14)
                cell!.HourlyPriceValue.font = UIFont(name: RegularFont, size: 14)
                let CurrencySym = login_session.value(forKey: "APP_CURRENCY") as? String ?? "USD"
                
               
                
                if "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "productprice") as AnyObject)" == "0.00" {
                    cell!.DailyPriceView.isHidden = true
                    cell?.DailyPriceViewHeight.constant = 0
                }else{
                    cell!.DailyPriceView.isHidden = false
                    cell?.DailyPriceViewHeight.constant = 45
                }
                
                if "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "week_price") as AnyObject)" == "0" {
                    cell!.WeeklyPriceView.isHidden = true
                    cell?.WeeklyPriceViewHeight.constant = 0
                }else{
                    cell!.WeeklyPriceView.isHidden = false
                    cell?.WeeklyPriceViewHeight.constant = 45
                }
                
                if "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "month_price") as AnyObject)" == "0" {
                    cell!.MonthlyPriceView.isHidden = true
                    cell?.MonthlyPriceViewHeight.constant = 0
                }else{
                    cell!.MonthlyPriceView.isHidden = false
                    cell?.MonthlyPriceViewHeight.constant = 45
                }
                
                if "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "min_hour_price") as AnyObject)" == "0" {
                    cell!.HourlyPriceView.isHidden = true
                    cell?.HourlyPriceViewHeight.constant = 0
                    cell!.MinimumHourPrice.isHidden = true
                    cell?.MinimumHourPriceHeight.constant = 0
                }else{
                    cell!.HourlyPriceView.isHidden = true
                    cell?.HourlyPriceViewHeight.constant = 0
                    cell!.MinimumHourPrice.isHidden = false
                    cell?.MinimumHourPriceHeight.constant = 45
                }
                
                
                if "\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "hourly_price") as AnyObject)" == "0" {
                    cell!.HourlyPriceView.isHidden = true
                    cell?.HourlyPriceViewHeight.constant = 0
                   
                }else{
                    cell!.HourlyPriceView.isHidden = false
                    cell?.HourlyPriceViewHeight.constant = 45
                }
                
                
                
                
                cell!.DailyPriceValue.text = "\(currencySymbol) \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "productprice") as AnyObject)")"
                cell!.WeeklyPriceValue.text = "\(currencySymbol) \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "week_price") as AnyObject)")"
                cell!.MonthlyPriceValue.text = "\(currencySymbol) \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "month_price") as AnyObject)")"
                cell!.MinHourPriceValue.text = "\(currencySymbol) \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "min_hour_price") as AnyObject)")"
                cell!.HourlyPriceValue.text = "\(currencySymbol) \("\((self.ProperdyDetails.object(forKey: "property_details") as! NSDictionary).object(forKey: "hourly_price") as AnyObject)")"
                
                cell!.DayLbl.font = UIFont(name: RegularFont, size: 13)
                cell!.HourlyPriceValue.font = UIFont(name: RegularFont, size: 13)
                
                if self.vehBookstatus == "1,2"
                {
                    cell!.DayView.isHidden = false
                    cell!.HourView.isHidden = true
                    showimgPriceStatus = "day"
                    pricetype = "daily"
                    cell!.DayBtn.backgroundColor = AppColor
                    cell!.HourView.backgroundColor = UIColor.white
                    cell!.hourImg.image = UIImage(named: "Image-1")
                    cell!.DayImg.image = UIImage(named: "Image-3")
                    cell!.DayLbl.textColor = UIColor.white
                    
                }
                else if self.vehBookstatus == "1"
                {
                    cell!.DayView.isHidden = false
                    cell!.HourView.isHidden = true
                    showimgPriceStatus = "day"
                           pricetype = "daily"
                    
                }else if self.vehBookstatus == "2"
                {
                    cell!.DayView.isHidden = true
                    cell!.HourView.isHidden = true
                    showimgPriceStatus = "hour"
                           pricetype = "hourly"
                    
                }
             if showimgPriceStatus == "day"
                {
                    cell!.DayView.backgroundColor = AppColor
                    cell!.HourView.backgroundColor = UIColor.white
                    cell!.hourImg.image = UIImage(named: "Image")
                    cell!.DayImg.image = UIImage(named: "Image-3")
                    
                    cell!.DayLbl.textColor = UIColor.white
                    cell!.hourLbl.textColor = AppColor
                }
                else
                {
                    cell!.DayView.backgroundColor = UIColor.white
                    cell!.HourView.backgroundColor = AppColor
                    cell!.hourImg.image = UIImage(named: "Image-1")
                    cell!.DayImg.image = UIImage(named: "Image-2")
                    cell!.DayLbl.textColor = AppColor
                    cell!.hourLbl.textColor = UIColor.white
                }
                cell!.DayBtn.addTarget(self, action: #selector(dayBtnTapped), for: .touchUpInside)
                cell!.HourBtn.addTarget(self, action: #selector(hourBtnTapped), for: .touchUpInside)
             return cell!
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookCalenderTableViewCell") as? ReqBookCalenderTableViewCell
                
                cell!.selectionStyle = .none
                if self.DateShow == "Show" {
                    cell!.DatesViewHeight.constant = 100
                    cell!.DaysView.isHidden = false
                }else{
                      cell!.DatesViewHeight.constant = 0
                      cell!.DaysView.isHidden = true
                }
                cell!.PickUpLbl.text = GlobalLanguageDictionary.object(forKey: "key_pickUpDate") as! String
                cell!.dropLbl.text = GlobalLanguageDictionary.object(forKey: "key_dropDate") as! String
                cell!.bookeddaysLbl.text = GlobalLanguageDictionary.object(forKey: "key_unavailableDays") as! String

                
                cell!.bookeddaysLbl.font = UIFont(name: SemiBoldFont, size: 13)
                cell!.UnAvailabledaysLbl.font = UIFont(name: SemiBoldFont, size: 13)
                
                cell!.PickUpLbl.font = UIFont(name: SemiBoldFont, size: 13)
                cell!.dropLbl.font = UIFont(name: SemiBoldFont, size: 13)
                
                cell!.PickUpDate.font = UIFont(name: SemiBoldFont, size: 14)
                cell!.dropDate.font = UIFont(name: SemiBoldFont, size: 14)
                
                cell!.PickUpTime.font = UIFont(name: SemiBoldFont, size: 14)
                cell!.dropTime.font = UIFont(name: SemiBoldFont, size: 14)
                
                cell!.DatesCalender.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 16)
                cell!.DatesCalender.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 14)
                cell!.DatesCalender.appearance.titleFont = UIFont.init(name: RegularFont, size: 14)
                
                cell?.DatesCalender.allowsMultipleSelection = true
                cell?.DatesCalender.appearance.weekdayTextColor = UIColor.black
                cell?.DatesCalender.appearance.headerTitleColor = AppColor
                cell?.DatesCalender.appearance.headerMinimumDissolvedAlpha = 0.0
                cell?.DatesCalender.layer.shadowColor = UIColor.lightGray.cgColor
                cell?.DatesCalender.layer.shadowOffset = CGSize(width: 2, height: 2)
                cell?.DatesCalender.layer.shadowOpacity = 0.75
                cell?.DatesCalender.layer.shadowRadius = 3.0
                cell?.DatesCalender.layer.cornerRadius = 5.0
                //                cell?.DatesCalender = .none
                cell?.DatesCalender.delegate = self
                cell?.DatesCalender.dataSource = self
                cell?.DatesCalender.reloadData()
                if pricetype == "daily"
                {
                    
                    cell?.PickUpDate.text = self.startDate
                    cell?.dropDate.text = self.endDate
                    cell?.PickUpTime.text = ""
                    cell?.dropTime.text = ""
                }
                else
                {
                    
                    cell?.PickUpDate.text = self.startDate
                    cell?.dropDate.text = self.endDate
                    cell?.PickUpTime.text = self.hourlyStart
                    cell?.dropTime.text = self.hourlyEnd
                }
                
                return cell!
            }
            
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookTimeTableViewCell") as? ReqBookTimeTableViewCell
            cell!.selectionStyle = .none
            
            cell?.StartBtn.addTarget(self, action: #selector(selectPickTime), for: .touchUpInside)
            cell?.endBtn.addTarget(self, action: #selector(selectDropTime), for: .touchUpInside)
            cell?.PickUpTime.text = self.hourlyStart
            cell?.dropTime.text = self.hourlyEnd
            cell?.PickUpTime.layer.borderColor = UIColor.lightGray.cgColor
            cell?.PickUpTime.layer.borderWidth = 0.5
            cell?.dropTime.layer.borderColor = UIColor.lightGray.cgColor
                       cell?.dropTime.layer.borderWidth = 0.5
            return cell!
        }
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReqBookPriceTableViewCell") as? ReqBookPriceTableViewCell
            cell!.selectionStyle = .none
            cell!.BookingLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.ServiceFeeLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.SecurityDepositLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.TotalLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.BookingValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.ServiceFeeValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.SecurityDepositValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.TotalValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.bundleValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.addonsValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.addonsLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.bundleLbl.font = UIFont(name: RegularFont, size: 14)
            
            cell!.payLaterLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.PayBalanceLbl.font = UIFont(name: RegularFont, size: 14)
            cell!.payLaterValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell!.PayBalanceValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
//            
//            if self.AddonsAmount == "0" || self.AddonsAmount == ""{
//                cell!.addonsView.isHidden = true
//                cell?.addonsViewHeight.constant = 0
//               
//            }else{
//                cell!.addonsView.isHidden = false
//                cell?.addonsViewHeight.constant = 45
//            }
            
            if self.AddonsAmount == "0" || self.AddonsAmount == ""{
                cell!.bundleView.isHidden = true
                cell?.BundleViewHeight.constant = 0
               
            }else{
                cell!.bundleView.isHidden = false
                cell?.BundleViewHeight.constant = 45
            }
            
            if self.PaymentType == "pay_later" {
                cell?.payLaterView.isHidden = false
                cell?.PayBalanceView.isHidden = false
                cell?.payLaterViewHeight.constant = 45
                cell?.PayBalanceViewHeight.constant = 45
                cell?.TotalView.backgroundColor = UIColor.darkGray
                cell?.TotalLbl.textColor = .white
                cell?.TotalValueLbl.textColor = .white

            }else{
                cell?.payLaterView.isHidden = true
                cell?.PayBalanceView.isHidden = true
                cell?.payLaterViewHeight.constant = 0
                cell?.PayBalanceViewHeight.constant = 0
                cell?.TotalView.backgroundColor = UIColor.clear
                cell?.TotalLbl.textColor = .black
                cell?.TotalValueLbl.textColor = .black
            }
            
            cell!.addonsLbl.text = "\(self.TaxName) (\(self.TaxPercentage))"
            cell!.payLaterValueLbl.text = "\(self.currencySymbol) \(self.payLaterAmount)"
            cell!.PayBalanceValueLbl.text = "\(self.currencySymbol) \(self.PayBalanceAMount)"
            cell!.addonsValueLbl.text = "\(self.currencySymbol) \(self.TaxAmount)"
            cell!.bundleValueLbl.text = "\(self.currencySymbol) \(self.AddonsAmount)"
            
            cell!.ServiceFeeLbl.text = GlobalLanguageDictionary.object(forKey: "key_serviceFee") as! String
            cell!.bundleLbl.text = GlobalLanguageDictionary.object(forKey: "key_addonsAmt") as! String
            cell!.SecurityDepositLbl.text = GlobalLanguageDictionary.object(forKey: "key_securityDeposit") as! String
            cell!.TotalLbl.text = GlobalLanguageDictionary.object(forKey: "key_total") as! String
            cell!.payLaterLbl.text = GlobalLanguageDictionary.object(forKey: "key_PayLaterAmt") as! String
            cell?.infoBtn.addTarget(self, action: #selector(infoAct), for: .touchUpInside)
            cell!.BookingLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_propertyAmt") as! String) ( \(self.ProPrice) * \(self.GuestCnt) )"
            cell!.BookingValueLbl.text = "\(self.currencySymbol) \(self.SubTotal)"
             cell!.SecurityDepositValueLbl.text = "\(self.currencySymbol) \(self.SecurityDeposit)"
            cell!.ServiceFeeValueLbl.text = "\(self.currencySymbol) \(self.ServiceFee)"
            cell!.TotalValueLbl.text = "\(self.currencySymbol) \(self.TotalAmount)"
            return cell!
        }
    }
}

extension NewBookingViewController: UIPickerViewDataSource,UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch component {
        case 0:
            return TimingsArr.count
        case 1:
            return 2
            
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch component {
        case 0:
            return TimingsArr[row]
        case 1:
            return TimeARR[row]
        default:
            return ""
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if isSelectTime == "PickUpTime"
        {
            switch component
            {
            case 0:
                self.hourStr = TimingsArr[row]
                
                
            case 1:
                self.Timeformat = TimeARR[row]
                
            default:
                break;
            }
        }
            
        else
        {
            switch component
            {
            case 0:
                self.hourStr = TimingsArr[row]
                
                
            case 1:
                self.Timeformat = TimeARR[row]
                
            default:
                break;
            }
        }
        
    }
    
}
extension Date {
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
