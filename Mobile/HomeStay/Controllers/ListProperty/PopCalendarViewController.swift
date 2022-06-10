//
//  PopCalendarViewController.swift
//  HomeStay
//
//  Created by apple5 on 01/02/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import MIBlurPopup
import DropDown
import AFNetworking
import Alamofire




class PopCalendarViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var backScrollView: UIScrollView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var fsCalendarView: FSCalendar!
    @IBOutlet weak var enterAmountTxtFld: UITextField!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var selectSerialOfDatesLbl: UIButton!
    @IBOutlet weak var AddBtn: UIButton!
    @IBOutlet weak var NextBtn: UIButton!
    
    @IBOutlet weak var AddLbl: UILabel!

    @IBOutlet weak var lblDailyCalendar: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var checkInTable: UITableView!
    
    @IBOutlet weak var popupContentContainerView: UIView!
    @IBOutlet weak var SetPriceLbl: UILabel!
    @IBOutlet weak var SetPriceStaticLbl: UILabel!
    @IBOutlet weak var StartDateLbl: UILabel!
    @IBOutlet weak var StartDateValueLbl: UILabel!
    @IBOutlet weak var EndDateLbl: UILabel!
    @IBOutlet weak var EndDateValueLbl: UILabel!
    @IBOutlet weak var StatusLbl: UILabel!
//    @IBOutlet weak var txt_Booking: UITextField!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var CurrencyLbl: UILabel!
    @IBOutlet weak var PriceTxt: UITextField!
    @IBOutlet weak var ViewCancelBtn: UIButton!
    @IBOutlet weak var SaveBtn: UIButton!
    @IBOutlet weak var MonthLbl: UILabel!
    
    @IBOutlet weak var BookedLbl: UILabel!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var UnavailableLbl: UILabel!
    
    @IBOutlet weak var popAddView: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtFromDate: UITextField!
    @IBOutlet weak var txtToDate: UITextField!
    
    @IBOutlet weak var viewSelect: UIView!
    @IBOutlet weak var txt_Booking: UITextField!
    @IBOutlet weak var  dropDownBtn: UIButton!
    
  

    
    var ListingActivityDelegate: listingActivityProtocol!
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter
    }()
    var minimumDate = Date()
    // first date in the range
    var firstDate: Date?
    // last date in the range
    var lastDate: Date?
    var datesRange: [Date]?
    
    let datesMutArray = NSMutableArray()
    var isRangeSelection = false
    var selectedDateString = String()
    var amountString = String()
    var isChecked = Bool()
    
    var rentYourSpace: RentYourSpaceModel!
    var PropertyID = Int()
    var DateFrom = String()
    var DateTo = String()
    var calenderChecked = String()
    var calenderDelegate: CalenderProtocol!
    
    let datesFormatMutArray = NSMutableArray()
    var dateFormatJsonString = String()
    var storedDatesArray = NSArray()
    var StepSaved = String()
    
    var DropData = ["Special","Booked","Unavailable"]
    let TypeDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.TypeDropdown
        ]
    }()
    
    var datePicker = UIDatePicker()
    
    var pickerToolbar: UIToolbar {
        let screenWidth = UIScreen.main.bounds.width
        let pickerToolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        
        //customize the toolbar
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked(_:)))
        
        //add the items to the toolbar
        pickerToolbar.items = [flexSpace, doneButton]
        return pickerToolbar
    }
    
    func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let resdate = date {
        return dateFormatter.string(from: resdate)
        }
        return ""


//            return  dateFormatter.string(from: date!)

        }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        let result = self.convertDateFormater(String(format: "%@", datePicker.date as CVarArg))
        if txtToDate.isEditing {
            
            txtToDate.text = result
        } else {
            
            txtFromDate.text = result
        }

        self.view.endEditing(true)
    }
    
//    @objc func dateValueChanges(_ sender: UIDatePicker) {
//        datePicker.date = sender.date
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NextBtn.backgroundColor = AppColor
        self.AddLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.availableLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.StartDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.EndDateLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.BookedLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.UnavailableLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.AddBtn.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
        self.BookedLbl.text = GlobalLanguageDictionary.object(forKey: "key_booked") as? String ?? ""
        self.availableLbl.text = GlobalLanguageDictionary.object(forKey: "key_specialPrice") as? String ?? ""
        self.UnavailableLbl.text = GlobalLanguageDictionary.object(forKey: "key_unavailable") as? String ?? ""
        self.StartDateLbl.text = GlobalLanguageDictionary.object(forKey: "key_startDate") as? String ?? ""
        self.EndDateLbl.text = GlobalLanguageDictionary.object(forKey: "key_endDate") as? String ?? ""
        self.txtFromDate.placeholder = GlobalLanguageDictionary.object(forKey: "key_startDate") as? String ?? ""
        self.txtToDate.placeholder = GlobalLanguageDictionary.object(forKey: "key_endDate") as? String ?? ""
        self.StatusLbl.text = GlobalLanguageDictionary.object(forKey: "key_status") as? String ?? ""
        self.txt_Booking.placeholder = GlobalLanguageDictionary.object(forKey: "key_booking") as? String ?? ""
        self.PriceLbl.text = GlobalLanguageDictionary.object(forKey: "key_priceusd") as? String ?? ""
        self.btnSave.setTitle(GlobalLanguageDictionary.object(forKey: "key_save") as? String ?? "", for: .normal)
        self.btnCancel.setTitle(GlobalLanguageDictionary.object(forKey: "key_capscancel") as? String ?? "", for: .normal)
        self.NextBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_capscancel") as? String ?? "", for: .normal)

        setData()
//     dropDownBtn.currentTitle = "Select"
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
                
//        datePicker.addTarget(self, action: #selector(dateValueChanges(_:)), for: .valueChanged)
        
        //TODO: - should be uncommented
        btnSave.layer.cornerRadius = 20
        btnCancel.layer.cornerRadius = 20
        
//        self.AddBtn.backgroundColor = AppSecondColor
         self.btnCancel.backgroundColor = AppColor
        self.btnSave.backgroundColor = AppColor
        self.popAddView.layer.shadowColor = BorderColor.cgColor
        self.popAddView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.popAddView.layer.shadowOpacity = 0.7
        self.popAddView.layer.shadowRadius = 3.0
        self.popAddView.layer.cornerRadius = 5.0
        self.popAddView.layer.borderWidth = 1.0
        self.popAddView.layer.borderColor = BorderColor.cgColor
        self.popAddView.isHidden = true
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        txtFromDate.inputAccessoryView = pickerToolbar
        txtToDate.inputAccessoryView = pickerToolbar
        txtFromDate.inputView = datePicker
        txtToDate.inputView = datePicker
        
//        self.checkInTable.isHidden = true
        
//        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)

        
                self.BookedLbl.font = UIFont(name: SemiBoldFont, size: 14)
                self.UnavailableLbl.font = UIFont(name: SemiBoldFont, size: 14)
                self.availableLbl.font = UIFont(name: SemiBoldFont, size: 14)
        //        self.SetPriceLbl.font = UIFont(name: SemiBoldFont, size: 14)
        //        self.SetPriceStaticLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.txtFromDate.font = UIFont(name: SemiBoldFont, size: 14)
        //        self.StartDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
                self.txtToDate.font = UIFont(name: SemiBoldFont, size: 13)
        //        self.EndDateValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
                self.StatusLbl.font = UIFont(name: SemiBoldFont, size: 14)
                self.txt_Booking.font = UIFont(name: SemiBoldFont, size: 14)
                self.PriceLbl.font = UIFont(name: SemiBoldFont, size: 14)
                self.PriceTxt.font = UIFont(name: SemiBoldFont, size: 14)
                self.btnCancel.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
                self.btnSave.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
        //
        //
        //        self.txt_Booking.delegate = self
        //        self.popupContentContainerView.isHidden = true
        //        isRangeSelection = true
        //        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        //        fsCalendarView.dataSource = self
        //        fsCalendarView.delegate = self
        //        fsCalendarView.allowsMultipleSelection = true
        //        fsCalendarView.calendarHeaderView.backgroundColor = limeYellow//UIColor.yellow
        //        fsCalendarView.headerHeight = 50
        //        fsCalendarView.calendarWeekdayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        //        fsCalendarView.appearance.eventSelectionColor = UIColor.white
        //        fsCalendarView.appearance.eve ntOffset = CGPoint(x: 0, y: -7)
        //        fsCalendarView.today = nil // Hide the today circle
        //        enterAmountTxtFld.delegate = self
        //
        //        if seasonalDatesArray.count != 0{
        //            if seasonalDatesArray.count > 1 {
        //                self.checkBoxBtn.setImage(UIImage(named: "checkbox-2"), for: .normal)
        //            }
        //            storedDatesArray = seasonalDatesArray.value(forKey: "date") as! NSArray
        //            let amountNum:NSNumber = (seasonalDatesArray[0] as? NSDictionary)?.value(forKey: "price") as! NSNumber
        //            amountString = "\(String(describing: amountNum))"
        //            enterAmountTxtFld.text = amountString
        //        }
        //        self.CurrencyLbl.text = SelectedCurrency
        //
        //        let BoolStatus = Singleton.sharedInstance.rentYourSpace.result[0].step2.stepCompleted!
        //
        //        if "\(BoolStatus)" == "1" {
        //            self.StepSaved = "True"
        //        }else{
        //            self.StepSaved = "False"
        //
        //        }
        //        let border = CALayer()
        //        let width = CGFloat(2.0)
        //        border.borderColor = UIColor.darkGray.cgColor
        //        border.frame = CGRect(x: 0, y: enterAmountTxtFld.frame.size.height - width, width: enterAmountTxtFld.frame.size.width, height: enterAmountTxtFld.frame.size.height)
        //        border.borderWidth = width
        //        enterAmountTxtFld.layer.addSublayer(border)
        //        enterAmountTxtFld.layer.masksToBounds = true
        //        // Do any additional setup after loading the view.
        //
        //        self.fsCalendarView.appearance.headerTitleFont = UIFont.init(name: SemiBoldFont, size: 25)
        //                              self.fsCalendarView.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
        //                              self.fsCalendarView.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)
        //
        //        self.fsCalendarView.appearance.headerTitleColor = AppColor
        //        self.fsCalendarView.appearance.weekdayTextColor = AppColor
        
        //TODO: - should be uncommented
        
    }
    func setData(){
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step3 = result.step3{
            self.checkInTable.isHidden = false
            checkInTable.reloadData()
        }
    }
    func calendarRangeSelection() {
        fsCalendarView.allowsMultipleSelection = true
        fsCalendarView.today = nil // Hide the today circle
        //fsCalendarView.setCurrentPage(Date(), animated: false)
        //cfsCalendarView.clipsToBounds = true // Remove top/bottom line
        fsCalendarView.swipeToChooseGesture.isEnabled = true // Swipe-To-Choose
        
        let scopeGesture = UIPanGestureRecognizer(target: fsCalendarView, action: #selector(fsCalendarView.handleScopeGesture(_:)));
        fsCalendarView.addGestureRecognizer(scopeGesture)
    }
    
    // MARK: UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txt_Booking {
            self.TypeDropdown.show()
            self.TypesDropDown()
            textField.resignFirstResponder()
        } else if textField == txtFromDate {
            
        } else if textField == txtToDate {
            
        }
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        amountString = textField.text!
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txt_Booking {
            return false
        }
        
        return true
    }
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    func TypesDropDown() {
        TypeDropdown.anchorView = self.txt_Booking
        TypeDropdown.bottomOffset = CGPoint(x: 0, y: (self.txt_Booking?.bounds.height)!)
        TypeDropdown.dataSource = DropData
        TypeDropdown.backgroundColor = UIColor.white
        TypeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txt_Booking.text = item
        }
    }
    
    @IBAction func act_BthAdd(_ sender: UIButton) {
        self.lblDailyCalendar.isHidden = true
        self.header.isHidden = true
        self.message.isHidden = true
        self.checkInTable.isHidden = true
//        self.popAddView.isHidden = false
        
        
        if isChecked {
//            self.pickuptype = "1"
            isChecked = false
       
            popAddView.isHidden = true
//            DaysViewHeight.constant = 0
            self.AddBtn.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
            
        }else{
            isChecked = true
     
            popAddView.isHidden = false
//            DaysViewHeight.constant = 485
            self.AddBtn.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)
            
        }
        
        
        
        
        
        
    }
    
   
    @IBAction func act_BtnNext(_ sender: UIButton) {
        if let calList = Singleton.sharedInstance.rentYourSpace.result.first?.step3.calendarList, calList.count > 0 {
            sharedInstanceListing.gotoStepThree()
        } else {
            sharedInstanceListing.gotoStepThree()
//            self.showInformation(title: "Closest", message: "Please Add")
        }
    }
    
    @IBAction func act_BtnCancel(_ sender: UIButton) {
        self.checkInTable.isHidden = false
        self.popAddView.isHidden = true
    }
    
    @IBAction func checkBoxBtnTapped(_ sender: UIButton) {
        for selectedDate in fsCalendarView.selectedDates {
            fsCalendarView.deselect(selectedDate)
        }
        if checkBoxBtn.isSelected == true {
            checkBoxBtn.isSelected = false
            datesMutArray.removeAllObjects()
            self.checkBoxBtn.setImage(UIImage(named: "tick-off"), for: .normal)
            isRangeSelection = false
            fsCalendarView.allowsMultipleSelection = false
        }
        else {
            checkBoxBtn.isSelected = true
            datesMutArray.removeAllObjects()
            self.checkBoxBtn.setImage(UIImage(named: "checkbox-2"), for: .normal)
            isRangeSelection = true
            fsCalendarView.allowsMultipleSelection = true
        }
    }
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        
        if self.StepSaved == "True" {
            self.popupContentContainerView.isHidden = true
            sharedInstanceListing.gotoStepThree()
        }else{
            self.showInformation(title: "Closest", message: "Please Choose special Dates")
        }
        
        
    }
    
    @IBAction func showdropDownActions(_ sender: Any) {
        self.TypeDropdown.show()
        self.TypesDropDown()
    }
    
    @IBAction func ViewCancelBtnTapped(_ sender: UIButton) {
        self.popupContentContainerView.isHidden = true
        
    }
    @IBAction func ViewSaveBtnTapped(_ sender: UIButton) {
        
        
        var Status = Int()
        if txt_Booking.text == "Unavailable"{
            Status = 3
            
        }else if txt_Booking.text! == "Booked"{
            Status = 2
            
        }else{
            Status = 1
        }
        
        if txt_Booking.text != "" && PriceTxt.text != "" {
            let seasonalDict = NSMutableDictionary()
            if datesMutArray.count != 0 {
                for i in 0..<datesMutArray.count {
                    let mutDict = NSMutableDictionary()
                    mutDict.setValue(datesMutArray[i], forKey: "date")
                    mutDict.setValue(amountString, forKey: "price")
                    mutDict.setValue(Status, forKey: "status")
                    datesFormatMutArray.add(mutDict)
                }
                print(datesFormatMutArray)
                seasonalDict.setValue(datesFormatMutArray, forKey: "seasonal_calendar_price")
                print(datesFormatMutArray)
            }
            
            print("\(String(describing: self.json(from:datesFormatMutArray as Any)))")
            
            do {
                //Convert to Data
                let jsonData = try JSONSerialization.data(withJSONObject: seasonalDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                //Convert back to string. Usually only do this for debugging
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                    self.dateFormatJsonString = JSONString
                }
            } catch {
                print(error.localizedDescription)
            }
            
            if Reachability()!.isReachable {
//                self.ListingActivityDelegate.showActivity()
                showActivityIndicator(uiView: self.view)
                //            let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&device_type=android&user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.PropertyID)&calendar_checked=sometimes&base_id=\(Singleton.sharedInstance.selectedCategory!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&seasonal_list=\(self.dateFormatJsonString)"
                //                               print(parameterStr)
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_CALENDER_LISTING, APIKEY: "SAVE_CALENDER_LISTING")
                
                //                {
                //                "lang_code":"en",
                //                "prop_status":"1",
                //                "check_in":"2021-08-22",
                //                "check_out":"2021-08-23",
                //                "price":"12",
                //                "property_id":"41884"
                //                }
                
                
                let params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                              "prop_status":self.txt_Booking.text!,
                              "check_in":self.txtFromDate.text!,
                              "check_out":self.txtToDate.text!,
                              "price":self.PriceTxt.text!,
                              "property_id":self.PropertyID]
                
                print(params)
                
//                let parameterStrs = ["currency_code": "\((login_session.value(forKey: "APP_CURRENCY")as? String ?? ""))",
//                                     "device_type":"android",
//                                     "user_id" : "\(login_session.value(forKey: "UserId")!)",
//                                     "property_id": "\(self.PropertyID)",
//                                     "calendar_checked":"sometimes",
//                                     "base_id":"1",
//                                     "lang_code":"en",
//                                     "seasonal_list": "\(self.dateFormatJsonString)"]
                
//                SAVE_PRICE_LISTING
                APIManager.apiPostWithHeaders(serviceName: SAVE_PRICE_LISTING
                                              , parameters: params) { response, error in
                    DispatchQueue.main.async {
                        self.ListingActivityDelegate.hideActivity()
                    }
//                    print(response)
                    print(SAVE_PRICE_LISTING)
                    if error != nil {
                        self.showInformation(title: "Closest", message: error!.localizedDescription)
                    } else {
                        let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                        print(response)
                        Singleton.sharedInstance.rentYourSpace = mod
  
                        self.hideActivityIndicator(uiView: self.view)
                        self.checkInTable.isHidden = false
                        self.popAddView.isHidden = true
                        self.checkInTable.reloadData()
                    }
                }
//                Alamofire.request(SAVE_CALENDER_LISTING, method: .post, parameters: parameterStrs,encoding: URLEncoding.default, headers: nil).responseJSON {
//                    response in
//                    switch response.result {
//                    case .success:
//                        print(response)
//                        let responseDict:NSDictionary = response.result.value as! NSDictionary
//                        print(responseDict)
//                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
//                            self.StepSaved = "True"
//
//                            for d in self.fsCalendarView.selectedDates {
//                                self.fsCalendarView.deselect(d)
//                            }
//                            self.hideActivityIndicator(uiView: self.view)
//
//                            let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                            UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
//                            Singleton.sharedInstance.rentYourSpace = mod
//                            seasonalDatesArray.removeAllObjects()
//                            let stepsTwoDict:NSDictionary = ((responseDict.value(forKey: "result") as AnyObject)[0] as AnyObject).value(forKey: "step2") as! NSDictionary
//                            print("stepsTwoDict : ", stepsTwoDict)
//                            let seasonalDateArr:NSArray = stepsTwoDict.value(forKey: "seasonal_calendar_price") as! NSArray
//                            print("seasonalDateArr : ", seasonalDateArr)
//                            if seasonalDateArr.count != 0 {
//                                seasonalDatesArray = NSMutableArray(array:seasonalDateArr)
//                                print("seasonalDatesArray : ", seasonalDatesArray)
//                            }
//                            print(seasonalDatesArray)
//                            self.fsCalendarView.reloadData()
//                            self.showInformation(title: "Closest", message: mod.message)
//                            self.popupContentContainerView.isHidden = true
//
//
//
//                        }
//
//                        else {
//                            self.hideActivityIndicator(uiView: self.view)
//
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
//                        }
//
//                        break
//                    case .failure(let error):
//
//                        print(error)
//                    }
//                }
                
                
//                showActivityIndicator(uiView: self.view)
                //                let parameterStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&device_type=android&user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.PropertyID)&calendar_checked=sometimes&base_id=\(Singleton.sharedInstance.selectedCategory!)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&seasonal_list=\(self.dateFormatJsonString)"
                //                print(parameterStr)
                //
                //
                //
                //
                //                let manager = AFHTTPSessionManager()
                //                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                //
                //                manager.post(SAVE_CALENDER_LISTING, parameters: parameterStr, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                //                    DispatchQueue.main.async {
                //                        self.ListingActivityDelegate?.hideActivity()
                //                    }
                //                    let responseDict:NSDictionary = responseObject as! NSDictionary
                //                    print(responseDict)
                //                   self.ListingActivityDelegate?.hideActivity()
                //                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                //                        let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                //                        UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                //                        Singleton.sharedInstance.rentYourSpace = mod
                //                     //   self.showInformation(title: "Closest", message: mod.message)
                //                        sharedInstanceListing.gotoStepEight()
                //
                //                    }
                //
                //                    else {
                //                        self.hideActivityIndicator(uiView: self.view)
                //
                //                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                //                    }
                //                }, failure: { (operation, error) -> Void in
                //                    DispatchQueue.main.async {
                //                        self.ListingActivityDelegate?.hideActivity()
                //                    }
                //                    print(error)
                //                    self.showInformation(title: "Closest", message: error.localizedDescription)
                //                })
                
                
                // Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_CALENDER_LISTING, APIKEY: "SAVE_CALENDER_LISTING")
            }else {
                showInformation(title: "Network Error", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            }
        }
        else {
            showInformation(title: "Error", message: "Please enter price detail")
        }
        
    }
    
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        
        self.popupContentContainerView.isHidden = true
        
        
        
    }
    
}
extension PopCalendarViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        return popupContentContainerView ?? UIView()
    }
    var blurEffectStyle: UIBlurEffectStyle {
        return UIBlurEffectStyle.light
    }
    var initialScaleAmmount: CGFloat {
        return 1.0
    }
    var animationDuration: TimeInterval {
        return 0.1
    }
}

//MARK: - FSCalendar Delegate DataSource
extension PopCalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // MARK:- FSCalendarDataSource
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.fsCalendarView.frame.size.height = bounds.height
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.blue
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        //       r
        for i in 0..<seasonalDatesArray.count {
            let dayStr:String = (seasonalDatesArray[i] as? NSDictionary)?.object(forKey: "date") as? String ?? ""
            let dayStatus = (seasonalDatesArray[i] as? NSDictionary)?.object(forKey: "status") as? Int ?? 0
            if self.formatter.string(from: date) == dayStr  {
                
                if dayStatus == 1 {
                    return hexStringToUIColor(hex: "#ffbb34")
                }else if dayStatus == 2 {
                    return hexStringToUIColor(hex: "#669900")
                }else{
                    return UIColor.darkGray
                }
                
            }
        }
        return nil
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
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
        
        if isRangeSelection == false {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            print("did select date \(formatter.string(from: date))")
            selectedDateString = formatter.string(from: date)
            datesMutArray.add(selectedDateString)
        }
        else {
            // nothing selected:
            if firstDate == nil {
                firstDate = date
                datesRange = [firstDate!]
                print("datesRange contains: \(datesRange!)")
                return
            }
            
            // only first date is selected:
            if firstDate != nil && lastDate == nil {
                // handle the case of if the last date is less than the first date:
                if date <= firstDate! {
                    calendar.deselect(firstDate!)
                    firstDate = date
                    datesRange = [firstDate!]
                    print("datesRange contains: \(datesRange!)")
                    return
                }
                
                let range = datesRange(from: firstDate!, to: date)
                lastDate = range.last
                for d in range {
                    calendar.select(d)
                }
                datesRange = range
                print("datesRange contains: \(datesRange!)")
                return
            }
            
            // both are selected:
            if firstDate != nil && lastDate != nil {
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }
                lastDate = nil
                firstDate = nil
                datesRange = []
                datesMutArray.removeAllObjects()
                datesFormatMutArray.removeAllObjects()
                print("datesRange contains: \(datesRange!)")
            }
        }
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date) {
        print("did deselect date \(self.formatter.string(from: date))")
        if isRangeSelection == false {
            
        }
        else {
            // both are selected:
            // NOTE: the is a REDUANDENT CODE:
            if firstDate != nil && lastDate != nil {
                for d in calendar.selectedDates {
                    calendar.deselect(d)
                }
                lastDate = nil
                firstDate = nil
                datesRange = []
                print("datesRange contains: \(datesRange!)")
            }
        }
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minimumDate
    }
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        datesMutArray.removeAllObjects()
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        for date in array {
            print("did select date \(formatter.string(from: date))")
            datesMutArray.add("\(formatter.string(from: date))")
        }
        print(datesMutArray)
        selectedDateString = datesMutArray.componentsJoined(by: ",")
        print(selectedDateString)
        self.popupContentContainerView.isHidden = false
        self.StartDateValueLbl.text = datesMutArray.firstObject as? String ?? ""
        self.EndDateValueLbl.text = datesMutArray.lastObject as? String ?? ""
        
        UserDefaults.standard.set(datesMutArray, forKey: "RangeDatesArray")
        UserDefaults.standard.set(selectedDateString, forKey: "RangeDates")
        return array
    }
}
extension PopCalendarViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        print(responseDict)
        if APIKEY == "SAVE_CALENDER_LISTING" {
            if errorDict.count == 0 {
                dismiss(animated: true)
                //                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                //                Singleton.sharedInstance.rentYourSpace = mod
                //                self.PropertyID = mod.propertyid
                //                self.DateFrom = Singleton.sharedInstance.rentYourSpace.result[0].step2.datefrom
                //                self.DateTo = Singleton.sharedInstance.rentYourSpace.result[0].step2.dateto
                //                self.calenderChecked = Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked
                //                if Singleton.sharedInstance.rentYourSpace.result[0].step2.calendarChecked == "always" {
                //                    //self.act_Always(self.btnAlways)
                //                } else {
                //                    //self.act_Sometimes(self.btnSomeTimes)
                //                }
                //                showInformation(title: "Closest", message: mod.message)
            }
        }
    }
}


extension PopCalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.sharedInstance.rentYourSpace.result.first?.step3.calendarList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "calenderCell") as? CalendarListTableViewCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "calenderCell") as? CalendarListTableViewCell
        let calList = Singleton.sharedInstance.rentYourSpace.result.first?.step3.calendarList[indexPath.row]
        cell.updateDetails(calList)
        
        cell.lblSNo.text = GlobalLanguageDictionary.object(forKey: "key_sno") as? String ?? ""
        cell.lblType.text = GlobalLanguageDictionary.object(forKey: "key_type") as? String ?? ""
        cell.lblCheckIn.text = GlobalLanguageDictionary.object(forKey: "key_fromDate") as? String ?? ""
        cell.lblCheckOut.text = GlobalLanguageDictionary.object(forKey: "key_todate") as? String ?? ""
        cell.lblPrice.text = GlobalLanguageDictionary.object(forKey: "Key_sprice") as? String ?? ""
        
        cell.lblSNoValue.text = String(format: "%d", indexPath.row)
        cell.lblSNoValue.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblSNo.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblType.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblTypeValue.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblCheckIn.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblCheckInValue.font = UIFont(name: SemiBoldFont, size: 14)
        
        cell.lblCheckOut.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblCheckOutValue.font = UIFont(name: SemiBoldFont, size: 14)
        
        cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 14)
        cell.lblPriceValue.font = UIFont(name: SemiBoldFont, size: 14)

        return cell
    }
}

