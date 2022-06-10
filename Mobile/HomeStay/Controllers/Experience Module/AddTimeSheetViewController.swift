//
//  AddTimeSheetViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 28/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import DropDown
import AFNetworking

class AddTimeSheetViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{

    
    //MARK: ViewMain Outlets
    @IBOutlet weak var labelCreateTimeSheet: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonAddTimeSheet: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelYourTimeSheetList: UILabel!
    @IBOutlet weak var tableListSchedules: UITableView!
    @IBOutlet weak var imageNoScheduleAvailable: UIImageView!
    @IBOutlet weak var LabelNoScheduleAvailable: UILabel!

    @IBOutlet weak var LabelNavHeading: UILabel!
    @IBOutlet weak var viewTopNavigation: UIView!
    
    //MARK: viwAdd time sheet outlets
    
    @IBOutlet weak var viewContentAddTimeSheet: UIView!
    @IBOutlet weak var labelDescriptionTwo: UILabel!
    @IBOutlet weak var labelSelectDate: UILabel!
    @IBOutlet weak var labelChooseDate: UILabel!
    @IBOutlet weak var labelSelectTime: UILabel!
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textfieldTitle: UITextField!
    @IBOutlet weak var labelheadingDescription: UILabel!
    @IBOutlet weak var textviewDescription: UITextView!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var viewSelectDate: UIView!
    
    @IBOutlet weak var viewEndTime: UIView!
    @IBOutlet weak var viewStartTime: UIView!
    @IBOutlet weak var calanderView: UIView!
    @IBOutlet weak var chooseDateCalander: FSCalendar!
    @IBOutlet weak var buttonCancelCalander: UIButton!
    @IBOutlet weak var buttonOk: UIButton!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var greyView: UIView!
    
    var BookindDates = NSMutableArray()
    var submitType = String()
    var TimeId = String()

    var fromDate = Date()
    var toDate = Date()
    var startDate = String()
    var endDate = String()
    var firstDate: Date?
    // last date in the range
    var lastDate: Date?
    var datesRange: [Date]?
    var minimumDate = Date()
    
    var arrayOfStartTime = NSArray()
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    fileprivate let formatterNew: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    fileprivate let formatterNew1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    fileprivate let formatterNewDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    // Oct 21, 2017
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    var fromDateStr = String()
    var toDateStr = String()
    
    var arrayOfDit = NSMutableArray()
    var dictValues = [String:AnyObject]()
    var result = NSMutableArray()
    var status = ""

    let currencyDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.currencyDropdown
            ]
    }()
    
    var dateId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewTimeScheduleList()
        
        
        self.buttonCancelCalander.addTarget(self, action: #selector(updateCancelcalenderButton), for: .touchUpInside)
        self.buttonOk.addTarget(self, action: #selector(updateOkCalenderButton), for: .touchUpInside)
        self.calanderView.isHidden = true
        self.viewContentAddTimeSheet.isHidden = true
        self.arrayOfStartTime = ["00:00:00","01:00:00","02:00:00","03:00:00","04:00:00","05:00:00","06:00:00","07:00:00","08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","13:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00","21:00:00","22:00:00","23:00:00"]
        
        print("dictValues",BookindDates)
        self.buttonAddTimeSheet.layer.cornerRadius = 5
        self.viewContentAddTimeSheet.isHidden = true
        
        self.diffBetweenDates()
        self.textviewDescription.text = "  Enter your value"
        self.textviewDescription.textColor = UIColor.lightGray
        self.textviewDescription.layer.borderWidth = 1.0
        self.textviewDescription.layer.borderColor = UIColor(hex: 0xBFBFC2).cgColor
        self.textviewDescription.layer.shadowColor = UIColor(hex: 0xBFBFC2).cgColor
        self.textviewDescription.layer.cornerRadius = 5
        self.textviewDescription.layer.shadowOffset = CGSize.zero
        self.textviewDescription.layer.shadowOpacity = 0.6
        self.textviewDescription.delegate = self
        self.textviewDescription.keyboardType = .default
        self.textviewDescription.returnKeyType = .done
        
        labelCreateTimeSheet.font = UIFont(name: RegularFont, size: 15.0)
        
        labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        labelDescription.textColor = .darkGray
        
        labelYourTimeSheetList.font = UIFont(name: RegularFont, size: 15.0)
        labelYourTimeSheetList.textColor = .darkGray
        
        LabelNavHeading.font = UIFont(name: RegularFont, size: 20.0)
        
        
        labelDescriptionTwo.font = UIFont(name: RegularFont, size: 15.0)
        labelDescriptionTwo.textColor = .darkGray
        
        labelSelectDate.font = UIFont(name: RegularFont, size: 15.0)
        labelSelectDate.textColor = .darkGray
        
        labelChooseDate.font = UIFont(name: RegularFont, size: 15.0)
        labelChooseDate.textColor = .darkGray
        
        labelSelectTime.font = UIFont(name: RegularFont, size: 15.0)
        labelSelectTime.textColor = .darkGray
        labelStartTime.font = UIFont(name:RegularFont, size: 15.0)
        labelStartTime.textColor = .darkGray

        labelEndTime.font = UIFont(name: RegularFont, size: 15.0)
        labelEndTime.textColor = .darkGray
        
        labelTitle.font = UIFont(name: RegularFont, size: 15.0)
        labelTitle.textColor = .darkGray
        self.LabelNoScheduleAvailable.font = UIFont(name: RegularFont, size: 15)
        
        labelheadingDescription.font = UIFont(name: RegularFont, size: 15.0)
        labelheadingDescription.textColor = .darkGray
        
        
        self.buttonSubmit.layer.cornerRadius = 5
        self.buttonSubmit.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        
        self.buttonCancel.layer.cornerRadius = 5
        self.buttonCancel.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        self.viewSelectDate.layer.borderWidth = 0.5
        self.viewSelectDate.layer.borderColor = BorderColor.cgColor
        
        self.viewStartTime.layer.borderWidth = 0.5
        self.viewStartTime.layer.borderColor = BorderColor.cgColor
        
        self.viewEndTime.layer.borderWidth = 0.5
        self.viewEndTime.layer.borderColor = BorderColor.cgColor
        
        Helper.sharedInstance.UpdateTextfield(self.textfieldTitle)
        
        self.buttonBack.addTarget(self, action: #selector(self.goBackAction), for: .touchUpInside)
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        self.imageNoScheduleAvailable.isHidden = false
        self.LabelNoScheduleAvailable.isHidden = false

//        if arrayOfResult.count > 0 {
//            self.arrayOfDit.addObjects(from: (((arrayOfResult[0] as? NSDictionary)?.object(forKey: "Timing") as? NSDictionary)?.object(forKey: "schedules") as! NSArray) as! [Any])
//            self.tableListSchedules.reloadData()
//            if arrayOfDit.count > 0 {
//                self.imageNoScheduleAvailable.isHidden = true
//            }
//        }
    }
    
    
    
    func DeleteTimeDetails(){

        

        if Helper.sharedInstance.isConnectedToInternet() {
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["time_id":self.TimeId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"date_id":dateId]
            
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",viewExperienceTimesheet)
            manager.post(EXPERIENCEDELETETIMESHEET, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                self.hideActivityIndicator(uiView: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.hideActivityIndicator(uiView: self.view)

                    self.arrayOfDit.removeAllObjects()
                    self.arrayOfDit.addObjects(from: (responseDict.object(forKey: "Time_details") as! NSArray) as! [Any])
                    if self.arrayOfDit.count == 0 {
                        self.imageNoScheduleAvailable.isHidden = false
                        self.LabelNoScheduleAvailable.isHidden = false
                    }
                    self.tableListSchedules.reloadData()
                    //                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                self.hideActivityIndicator(uiView: self.view)

                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.hideActivityIndicator(uiView: self.view)

            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }

    }
    
    
    func ActiveTimeDetails(){

        

        if Helper.sharedInstance.isConnectedToInternet() {
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["time_id":self.TimeId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"date_id":dateId,"status":self.status]
           
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",EXPERIENCETIMESTATUSCHANGE)
            manager.post(EXPERIENCETIMESTATUSCHANGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                self.hideActivityIndicator(uiView: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.hideActivityIndicator(uiView: self.view)
                    self.arrayOfDit.removeAllObjects()
                    self.arrayOfDit.addObjects(from: (responseDict.object(forKey: "Time_details") as! NSArray) as! [Any])
                    if self.arrayOfDit.count == 0 {
                        self.imageNoScheduleAvailable.isHidden = false
                        self.LabelNoScheduleAvailable.isHidden = false
                    }
                    self.tableListSchedules.reloadData()

                    self.viewTimeScheduleList()
//                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                self.hideActivityIndicator(uiView: self.view)

                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.hideActivityIndicator(uiView: self.view)

            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }

    }
    
    
    @objc func updateOkCalenderButton() {
        self.greyView.isHidden = true
        self.calanderView.isHidden = true
        if self.labelChooseDate.text == "Choose Date" {
            self.showInformation(title: "Closest", message: "Please choose date first.")
        }
    }
    
    @objc func updateCancelcalenderButton() {
        self.greyView.isHidden = true
        self.calanderView.isHidden = true
    }
    
    func viewTimeScheduleList() {
        if Helper.sharedInstance.isConnectedToInternet() {
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"date_id":dateId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",viewExperienceTimesheet)
            manager.post(viewExperienceTimesheet, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                self.hideActivityIndicator(uiView: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                   // currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    self.arrayOfDit.removeAllObjects()
                    self.arrayOfDit.addObjects(from: (responseDict.object(forKey: "Time_details") as! NSArray) as! [Any])
                    if self.arrayOfDit.count > 0 {
                        self.imageNoScheduleAvailable.isHidden = true
                        self.LabelNoScheduleAvailable.isHidden = true
                    }
                    self.tableListSchedules.reloadData()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                self.hideActivityIndicator(uiView: self.view)

                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
    }
    func diffBetweenDates() {
        
        let formatter = DateFormatter()
        let calendar = Calendar.current
        // specify the format,
        formatter.dateFormat = "dd-MM-yyyy" // specify the start date
        let startDate = formatter.date(from: "10-08-2018")
        // specify the end date
        let endDate = formatter.date(from: "23-09-2019")
        print("startDate",startDate!)
        print("endDate",endDate!)
        let diff = calendar.dateComponents([.day], from: startDate!, to: endDate!) // print the diff between the two dates
        print("diff",diff)
  }
    
//    MARK: Table view data source and delegate:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfDit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableListSchedules.dequeueReusableCell(withIdentifier: "cellList", for: indexPath)
        cell.selectionStyle = .none
        
        let labelTitle = cell.viewWithTag(3) as! UILabel
        let labelDate = cell.viewWithTag(4) as! UILabel
        let labelTime = cell.viewWithTag(5) as! UILabel
        let labelTitleValue = cell.viewWithTag(6) as! UILabel
        let labelDateValue = cell.viewWithTag(7) as! UILabel
        let labelTimeValue = cell.viewWithTag(8) as! UILabel
        let labelEdit = cell.viewWithTag(10) as! UILabel
        let labelDelete = cell.viewWithTag(12) as! UILabel
        let labelActive = cell.viewWithTag(13) as! UILabel
        let buttonEdit = cell.viewWithTag(15) as! UIButton
        let buttonDelete = cell.viewWithTag(14) as! UIButton
        let ActiveButton = cell.viewWithTag(16) as! UIButton
        let ActiveImage = cell.viewWithTag(17) as! UIImageView
        
        labelTitleValue.text = (self.arrayOfDit.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "title") as? String ?? ""
        
        labelDateValue.text = (self.arrayOfDit.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "schedule_date") as? String ?? ""
        
        let status = "\((self.arrayOfDit.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "time_status") as AnyObject)"
        
        if status == "1" {
            labelActive.text = "Active"
            ActiveImage.image = UIImage(named: "greenTick")
        }else{
            labelActive.text = "Inactive"
            ActiveImage.image = UIImage(named: "white_Tick_off")

        }
        
        let time = "\((self.arrayOfDit.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "start_time") as? String ?? "")" + " - \((self.arrayOfDit.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "end_time") as? String ?? "")"
        
        
        
        
        
        labelTimeValue.text = time
        
        labelTitle.font = UIFont(name: RegularFont, size: 17)
        labelDate.font = UIFont(name: RegularFont, size: 17)
        labelTime.font = UIFont(name: RegularFont, size: 17)
        labelTitleValue.font = UIFont(name: RegularFont, size: 16)
        labelDateValue.font = UIFont(name: RegularFont, size: 16)
        labelTimeValue.font = UIFont(name: RegularFont, size: 16)
        labelEdit.font = UIFont(name: RegularFont, size: 15)
        labelDelete.font = UIFont(name: RegularFont, size: 15)
        labelActive.font = UIFont(name: RegularFont, size: 15)
        
        buttonEdit.addTarget(self, action: #selector(self.updateEdit), for: .touchUpInside)
        buttonDelete.addTarget(self, action: #selector(self.updateDelete), for: .touchUpInside)
        ActiveButton.addTarget(self, action: #selector(self.updateActive), for: .touchUpInside)
        
        
        return cell
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textviewDescription.textColor == UIColor.lightGray {
            textviewDescription.text = ""
            textviewDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textviewDescription.text == "" {
            self.textviewDescription.text = "  Enter your value"
            self.textviewDescription.textColor = UIColor.lightGray
        }
    }
    
    @objc func updateEdit(sender:UIButton) {
        
        
        
        self.submitType = "Edit"
        
       
        
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableListSchedules)
        let indexPath = self.tableListSchedules.indexPathForRow(at: buttonPosition)
        print("indexPath?.row",indexPath?.row)
       
        
        
        self.TimeId = "\((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "time_id") as AnyObject)"
        self.textfieldTitle.text = (self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "title") as? String ?? ""
        
        self.labelStartTime.text = ((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "start_time") as? String ?? "")
        
        self.labelEndTime.text = ((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "end_time") as? String ?? "")
        
        
       // self.textviewDescription.text = ((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "description") as? String ?? "")
        
        self.viewContentAddTimeSheet.isHidden = false
        self.greyView.isHidden = true
        self.calanderView.isHidden = true
        
        
        
    }
    
    @objc func updateDelete(sender:UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableListSchedules)
        let indexPath = self.tableListSchedules.indexPathForRow(at: buttonPosition)
        print("indexPath?.row",indexPath?.row)
       
        
        
        self.TimeId = "\((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "time_id") as AnyObject)"
        
        self.DeleteTimeDetails()

        
    }
    
    @objc func updateActive(sender:UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableListSchedules)
        let indexPath = self.tableListSchedules.indexPathForRow(at: buttonPosition)
        print("indexPath?.row",indexPath?.row)
       
        let status = "\((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "time_status") as AnyObject)"
        
        if status == "1" {
            self.status = "0"
           
        }else{
            self.status = "1"

        }
        
        self.TimeId = "\((self.arrayOfDit.object(at: indexPath!.row) as? NSDictionary)?.object(forKey: "time_id") as AnyObject)"
        
        self.ActiveTimeDetails()

        
    }
    
    @objc func goBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    func startDateDropDown() {
        let hours = arrayOfStartTime
        currencyDropdown.anchorView = self.labelStartTime
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.labelStartTime?.bounds.height)!)
        currencyDropdown.dataSource = hours as! [String]
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.labelStartTime.text = item
          }
    }
    
    func endDateDropDown() {
        let hours = arrayOfStartTime
        currencyDropdown.anchorView = self.labelEndTime
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (self.labelStartTime?.bounds.height)!)
        currencyDropdown.dataSource = hours as! [String]
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.labelEndTime.text = item
          }
    }
    
    
    // MARK:- FSCalendarDataSource
    // MARK:- FSCalendarDelegate
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor(red: 67/255.0, green: 178/255.0, blue: 230/255.0, alpha: 1.0)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        return 0
    }

             
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minimumDate
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
     {
        
        if self.formatter.string(from: date) == startDate {
            return AppSecondColor
        }
        if self.formatter.string(from: date) == endDate {
            return AppSecondColor
        }
         
         
         return nil
     }
    
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {

        if self.formatter.string(from: date) == startDate {
            
            return true
        }
        if self.formatter.string(from: date) == endDate {
            return true
        }
        return false
    }
    
             
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        

            print("did select date \(self.formatter.string(from: date))")
        self.toDateStr =  self.formatterNew.string(from: date)
        self.labelChooseDate.text = self.formatterNew.string(from: date)
            self.greyView.isHidden = true
            self.calanderView.isHidden = true

        calendar.reloadData()
        
    }
    
    
//    MARK:Button Actions
    
    @IBAction func buttonAddTimeSheet(_ sender: Any) {
        self.submitType = "Add"
        self.viewContentAddTimeSheet.isHidden = false
        self.greyView.isHidden = true
        self.calanderView.isHidden = true
        
        
    }
    
    @IBAction func buttonOnChooseDate(_ sender: Any) {
        self.calanderView.isHidden = false
        self.greyView.isHidden = false
    }
    
    @IBAction func buttonStartTime(_ sender: Any) {
        self.currencyDropdown.show()
        self.startDateDropDown()
    }
    
    @IBAction func buttonEndTime(_ sender: Any) {
        self.currencyDropdown.show()
        self.endDateDropDown()
    }
    
    
    @IBAction func buttonSubmit(_ sender: Any) {
        if self.textviewDescription.text == "  Enter your value" {
            self.showInformation(title: "Closest", message: "Please enter few words in description.")
        }
        else if self.textviewDescription.text.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter few words in description.")
        }
        else if self.labelStartTime.text == "00:00:00" || self.labelEndTime.text == "00:00:00" {
            self.showInformation(title: "Closest", message: "Please select time.")
        }
        else if self.textfieldTitle.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter title.")
        }
        else if self.labelDate.text?.count == 0 {
            self.showInformation(title: "Closest", message: "Please select date.")
        }
        else {
            if Helper.sharedInstance.isConnectedToInternet() {
                self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                var APINAME = String()
                
                if self.submitType == "Add" {
                    APINAME = AddExperienceTimeSheet
                 
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"start_time":self.labelStartTime.text,"end_time":self.labelEndTime.text,"description":self.textviewDescription.text,"date_id":dateId,"title":self.textfieldTitle.text,"schedule_date":self.labelDate.text]
                }else{
                    APINAME = EXPERIENCEEDITTIMESHEET

                    params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"start_time":self.labelStartTime.text,"end_time":self.labelEndTime.text,"description":self.textviewDescription.text,"date_id":dateId,"title":self.textfieldTitle.text,"schedule_date":self.labelDate.text,"time_id":self.TimeId]
                    
                    
                }
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",APINAME)
                manager.post(APINAME, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    self.hideActivityIndicator(uiView: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        self.hideActivityIndicator(uiView: self.view)

                        self.viewContentAddTimeSheet.isHidden = true
//                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        self.arrayOfDit.removeAllObjects()
                        self.arrayOfDit.addObjects(from: (responseDict.object(forKey: "Time_details") as! NSArray) as! [Any])
                        self.tableListSchedules.reloadData()
                        if self.arrayOfDit.count > 0 {
                            self.imageNoScheduleAvailable.isHidden = true
                            self.LabelNoScheduleAvailable.isHidden = true
                        }
                    }
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) in
                    print(error)
                    self.hideActivityIndicator(uiView: self.view)

                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
            }
            else {
                self.hideActivityIndicator(uiView: self.view)

                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
            
        }
    }
    
    @IBAction func buttonCancel(_ sender: Any) {
        self.textfieldTitle.text = ""
        self.labelStartTime.text = "00:00:00"
        self.labelEndTime.text = "00:00:00"
        self.labelChooseDate.text = ""
        self.textviewDescription.text = "  Enter your value"
        self.textviewDescription.textColor = UIColor.lightGray
        self.viewContentAddTimeSheet.isHidden = true
    }
    
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        result.removeAllObjects()
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        for date in array {
            print("did select date \(formatter.string(from: date))")
            result.add("\(formatter.string(from: date))")
        }
        print(result)
//        selectedDateString = result.componentsJoined(by: ",")
//        print(selectedDateString)
//        UserDefaults.standard.set(datesMutArray, forKey: "RangeDatesArray")
//        UserDefaults.standard.set(selectedDateString, forKey: "RangeDates")
        return array
    }
    

}
