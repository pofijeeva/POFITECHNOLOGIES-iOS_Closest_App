//
//  AddScheduleExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 20/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import AFNetworking

class AddScheduleExperienceViewController: BaseViewController, UITableViewDelegate,UITableViewDataSource,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    
    
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelAddScheduleDate: UILabel!
    @IBOutlet weak var imageViewStartDate: UIImageView!
    @IBOutlet weak var labelStartDate: UILabel!
    @IBOutlet weak var tableViewSchedules: UITableView!
    @IBOutlet weak var labelYourSchedules: UILabel!
    @IBOutlet weak var imageViewEmpty: UIImageView!
    @IBOutlet weak var LabelEmptyText: UILabel!
    
    @IBOutlet weak var buttonApply: UIButton!
    @IBOutlet weak var labelEndDate: UILabel!
    @IBOutlet weak var imageViewEndDate: UIImageView!
    @IBOutlet weak var viewStartDate: UIView!
    @IBOutlet weak var viewEndDate: UIView!
    
    @IBOutlet weak var CalenderView: UIView!
    @IBOutlet weak var ChooseDateCalender: FSCalendar!
    @IBOutlet weak var GrayView: UIView!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var OkBtn: UIButton!
    @IBOutlet weak var YearLbl: UILabel!
    @IBOutlet weak var DateLbl: UILabel!

    var arrayOfItems = [[String:AnyObject]]()
    var ListingActivityDelegate: listingActivityProtocol?

    var isFromDate = "Arrive"
    var fromDate = Date()
       var toDate = Date()
       var minimumDate = Date()
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
    
    fileprivate let formatterNewDate: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "EEE, dd yyyy"
           formatter.locale = Locale(identifier: "en_US_POSIX")
           return formatter
       }()
        // Oct 21, 2017
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    var fromDateStr = String()
    var toDateStr = String()
    var dateId = ""
    var status = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.sharedInstance.hideActivityIndicator(view: self.view)

        self.YearLbl.text =  Date().string(format: "yyyy")
         self.DateLbl.text =  Date().string(format: "EEE dd, yyyy")
        self.GrayView.isHidden = true
                         self.CalenderView.isHidden = true
        let today = Date()
       minimumDate = today
         
        self.ChooseDateCalender.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
        self.ChooseDateCalender.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
        self.ChooseDateCalender.appearance.titleFont = UIFont.init(name: RegularFont, size: 16)
        self.ChooseDateCalender.reloadData()
        
        self.LabelEmptyText.font = UIFont(name: RegularFont, size: 15.0)

        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
        self.labelAddScheduleDate.font = UIFont(name: RegularFont, size: 17.0)
        self.labelAddScheduleDate.textColor = .darkGray
        self.labelStartDate.font = UIFont(name: RegularFont, size: 15.0)
        self.labelStartDate.textColor = .darkGray
        self.labelEndDate.font = UIFont(name: RegularFont, size: 15.0)
        self.labelEndDate.textColor = .darkGray
        self.labelYourSchedules.textColor = .black
        self.labelYourSchedules.font = UIFont(name: RegularFont, size: 17.0)
        self.buttonApply.layer.cornerRadius = 5
        self.buttonApply.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        self.viewStartDate.layer.borderWidth = 0.5
        self.viewStartDate.layer.borderColor = BorderColor.cgColor
        
        self.viewEndDate.layer.borderWidth = 0.5
        self.viewEndDate.layer.borderColor = BorderColor.cgColor
        
        if TimingsArray.count > 0 {
            self.imageViewEmpty.isHidden = true
            self.LabelEmptyText.isHidden = true
            self.tableViewSchedules.isHidden = false
        }
        else {
            imageViewEmpty.isHidden = false
            self.LabelEmptyText.isHidden = false
            self.tableViewSchedules.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func ActiveAct(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewSchedules)
        let indexPath = self.tableViewSchedules.indexPathForRow(at: buttonPosition)
        print("indexPath?.row",indexPath?.row)
        status = "\((TimingsArray.object(at: indexPath!.row) as! NSDictionary).object(forKey: "date_status") as AnyObject)"
        dateId = (TimingsArray.object(at: indexPath!.row) as! NSDictionary).object(forKey: "date_id") as! String
        print(status)
        print(dateId)
        self.activeDeactiveStatus()
    }
    
    @objc func DeleteAct(sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableViewSchedules)
        let indexPath = self.tableViewSchedules.indexPathForRow(at: buttonPosition)
        print("indexPath?.row",indexPath?.row)
        dateId = (TimingsArray.object(at: indexPath!.row) as! NSDictionary).object(forKey: "date_id") as! String
        print(dateId)
        self.deleteSchedule()
    }
    
//    MARK: Table view delegate and data source:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return TimingsArray.count
        }
        else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableViewSchedules.dequeueReusableCell(withIdentifier: "cellSchedule", for: indexPath)
            let labelFrom:UILabel = cell.viewWithTag(1) as! UILabel
            let labelTo: UILabel = cell.viewWithTag(2) as! UILabel
            let labelFromDate: UILabel = cell.viewWithTag(3) as! UILabel
            let labelTODate : UILabel = cell.viewWithTag(4) as! UILabel
            
            let labelDelete : UILabel = cell.viewWithTag(5) as! UILabel
            let labelArchive : UILabel = cell.viewWithTag(7) as! UILabel
            let imageViewDelete:UIImageView = cell.viewWithTag(6) as! UIImageView
            let imageViewArchive:UIImageView = cell.viewWithTag(8) as! UIImageView
            
            labelFrom.font = UIFont(name: RegularFont, size: 12.0)
            labelFrom.textColor = .darkGray
            labelFrom.layer.borderColor = BorderColor.cgColor
            labelFrom.layer.borderWidth = 0.5
            labelTo.font = UIFont(name: RegularFont, size: 12.0)
            labelTo.textColor = .darkGray
            labelTo.layer.borderColor = BorderColor.cgColor
            labelTo.layer.borderWidth = 0.5
            
            
            labelFromDate.font = UIFont(name: RegularFont, size: 12.0)
            labelFromDate.textColor = .darkGray
            labelFromDate.layer.borderColor = BorderColor.cgColor
            labelFromDate.layer.borderWidth = 0.5
            labelTODate.font = UIFont(name: RegularFont, size: 12.0)
            labelTODate.textColor = .darkGray
            labelTODate.layer.borderColor = BorderColor.cgColor
            labelTODate.layer.borderWidth = 0.5
            
            labelDelete.font = UIFont(name: RegularFont, size: 10.0)
            labelDelete.textColor = .darkGray
            
            labelArchive.font = UIFont(name: RegularFont, size: 10.0)
            labelArchive.textColor = .darkGray
            
            let ActiveBtn:UIButton = cell.viewWithTag(10) as! UIButton
            let DeleteBtn:UIButton = cell.viewWithTag(9) as! UIButton
            
            
            labelFrom.font = UIFont(name: RegularFont, size: 17)
            labelFrom.backgroundColor = .white
            labelTo.font = UIFont(name: RegularFont, size: 17)
            labelTo.backgroundColor = .white
            labelFromDate.font = UIFont(name: RegularFont, size: 17)
            labelFromDate.backgroundColor = .white
            labelTODate.font = UIFont(name: RegularFont, size: 16)
            labelTODate.backgroundColor = .white
            labelDelete.font = UIFont(name: RegularFont, size: 16)
            labelArchive.font = UIFont(name: RegularFont, size: 16)
            labelArchive.text = "  Active"
            if TimingsArray.count > 0 {
                let fromdatee = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "from_date") as! String
                labelFromDate.text = "   " + fromdatee
                let toDatee = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "to_date") as! String
                labelTODate.text = "   " + toDatee
                if "\((TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "date_status") as AnyObject)" == "1" {
                    imageViewArchive.image = UIImage(named: "greenTick")
                }
                else {
                    imageViewArchive.image = UIImage(named: "unSelectBox")
                }
            }
            
            ActiveBtn.addTarget(self, action: #selector(ActiveAct), for: .touchUpInside)
            DeleteBtn.addTarget(self, action: #selector(DeleteAct), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellNext", for: indexPath)
            let nextButton = cell.viewWithTag(10) as! UIButton
            nextButton.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
            nextButton.layer.cornerRadius = 5
            nextButton.addTarget(self, action: #selector(updateNextButtonAction), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var dict = [String:AnyObject]()
        dict["from_date"] = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "from_date") as AnyObject
        dict["to_date"] = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "to_date") as AnyObject
       // self.differenceBetweenDates(startDate: (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "from_date") as! String, endDate: (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "to_date") as! String)
//        vc.dictValues = dict
        dateId = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "date_id") as! String
        //status = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "date_status") as! String
        let vc = storyBoardExperience.instantiateViewController(withIdentifier: "AddTimeSheetViewController") as! AddTimeSheetViewController
        vc.startDate = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "from_date") as! String
        vc.endDate = (TimingsArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "to_date") as! String
        vc.dateId = dateId
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    @objc func updateNextButtonAction() {
        if Helper.sharedInstance.isConnectedToInternet() {
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("API",ExperienceBaseDetails)
            print("PARAMS",params)
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                    dictOfExperience = responseDict
                    sharedInstanceExperience.gotoStepSix()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) in
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
    }
    func differenceBetweenDates(startDate:String, endDate:String) {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        // specify the format,
        formatter.dateFormat = "yyyy-MM-dd" // specify the start date
        let startDatee = formatter.date(from: startDate) // specify the end date
        let endDatee = formatter.date(from: endDate)
        print("startDate",startDatee!)
        print("endDate",endDatee!)
        let diff = calendar.dateComponents([.day], from: startDatee!, to: endDatee!) // print the diff between thedates
        print("difference dates:",diff)
        
        var dates = NSMutableArray()
        
        for i in 0 ... diff.day! {
            if let newDate = Calendar.current.date(byAdding: .day, value: i + 1, to: startDatee!) {
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
                let dateFormatterPrint3 = DateFormatter()
                dateFormatterPrint3.dateFormat = "yyyy-MM-dd"
                dateFormatterPrint3.locale = Locale(identifier: "en_US_POSIX")
                // let orderDateStringPasser = checkin
                //                if let date = dateFormatterGet.date(from: new)
                //                {
                print(dateFormatterPrint3.string(from: newDate),"dateFormatterPrint3.string(from: newDate)")
                let convertedDate = dateFormatterPrint3.string(from: newDate)
                print(convertedDate,"convertedDate")
                //                }
                //                else
                //                {
                //                    print("There was an error decoding the string")
                //                }
                dates.add(convertedDate)
            }
        }
        print(dates)
        let vc = storyBoardExperience.instantiateViewController(withIdentifier: "AddTimeSheetViewController") as! AddTimeSheetViewController
        vc.BookindDates = dates
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func deleteSchedule() {
        if Helper.sharedInstance.isConnectedToInternet() {
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"date_id":dateId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("API",DeleteScheduledExperience)
            print("PARAMS",params)
            manager.post(DeleteScheduledExperience, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                self.hideActivityIndicator(uiView: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    dictOfExperience = responseDict as! NSDictionary
                    let DataDict = responseDict.value(forKey: "result") as? NSArray
                    ((DataDict?.object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray
                    TimingsArray = (((DataDict?.object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray).copy() as! NSArray
                    print(TimingsArray)
                    if TimingsArray.count > 0 {
                        Helper.sharedInstance.hideActivityIndicator(view: self.view)
                        self.imageViewEmpty.isHidden = true
                        self.LabelEmptyText.isHidden = true

                        self.tableViewSchedules.isHidden = false
                    }
                    else {
                        self.imageViewEmpty.isHidden = false
                        self.LabelEmptyText.isHidden = false

                        self.tableViewSchedules.isHidden = true
                    }
                    self.tableViewSchedules.reloadData()

                }
                else {
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) in
                print(error)
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {//
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
        Helper.sharedInstance.hideActivityIndicator(view: self.view)
        
    }
    
    func activeDeactiveStatus() {
        if Helper.sharedInstance.isConnectedToInternet() {
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id":currentExpId,"date_id":dateId,"status":status]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("API",ChangeScheduledExperienceStatus)
            print("PARAMS",params)
            manager.post(ChangeScheduledExperienceStatus, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                self.hideActivityIndicator(uiView: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.hideActivityIndicator(uiView: self.view)
                    dictOfExperience = responseDict as! NSDictionary
                    let DataDict = responseDict.value(forKey: "result") as? NSArray
                    ((DataDict?.object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray
                    TimingsArray = (((DataDict?.object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray).copy() as! NSArray
                    print(TimingsArray)
                    if TimingsArray.count > 0 {
                        self.imageViewEmpty.isHidden = true
                        self.LabelEmptyText.isHidden = true

                        self.tableViewSchedules.isHidden = false
                    }
                    else {
                        self.imageViewEmpty.isHidden = false
                        self.LabelEmptyText.isHidden = false

                        self.tableViewSchedules.isHidden = true
                    }
                    self.tableViewSchedules.reloadData()
                    
                }
                else {
                    self.hideActivityIndicator(uiView: self.view)

                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) in
                print(error)
                self.hideActivityIndicator(uiView: self.view)

                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
        
    }
    func getNextMonth(date:Date)->Date {
                 return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
             }
             
             func getPreviousMonth(date:Date)->Date {
                 return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
             }
             
             
             
             
            
             // MARK:- FSCalendarDataSource
             // MARK:- FSCalendarDelegate
             func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
                 return UIColor(red: 67/255.0, green: 178/255.0, blue: 230/255.0, alpha: 1.0)
             }
           
             func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
               
                 return 0
             }
             func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
             {
                 
                 
                 
                 
                 return nil
             }
             
             
             func minimumDate(for calendar: FSCalendar) -> Date {
                return minimumDate
             }
             
             
             func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
                
                 self.minimumDate = date
                
                 if isFromDate == "Arrive"
                 {
                     
                     print("did select date \(self.formatter.string(from: date))")
                   
                     self.fromDateStr = self.formatterNew.string(from: date)
                     
                    
                    self.YearLbl.text =  date.string(format: "yyyy")
                            self.DateLbl.text =  date.string(format: "EEE dd, yyyy")
                    
                   

                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy"

                    if let tomorrow = self.minimumDate.tomorrow {
                        let tomorrowString = self.formatterNew.string(from: tomorrow)
                        print("\(tomorrowString)")
                        self.toDateStr =  tomorrowString
                                                             // "Mar 23, 2017, 00:14 AM\n"
                    }
                    
                    
                  
                 }
                 else
                 {
                    
                     print("did select date \(self.formatter.string(from: date))")
                   
                     self.toDateStr =  self.formatterNew.string(from: date)
                   self.labelEndDate.text = self.formatterNew.string(from: date)
                     self.GrayView.isHidden = true
                                   self.CalenderView.isHidden = true
                     
                    
                 }
                  calendar.reloadData()
             
             }
    
//    MARK:Button Actions:
    
    @IBAction func bttonStartDate(_ sender: Any) {
        self.GrayView.isHidden = false
        self.CalenderView.isHidden = false
        
    }
    @IBAction func buttonEndDate(_ sender: Any) {
        if self.toDateStr == "" {
            showInformation(title: "Closest", message: "Please choose start date.")
        }else{
            
        }
        
    }
    
    @IBAction func CalenderCancelAct(_ sender: Any) {
           
           self.GrayView.isHidden = true
                  self.CalenderView.isHidden = true
       }
    @IBAction func CalenderOkAct(_ sender: Any) {
        
        if self.toDateStr == "" {
                   showInformation(title: "Closest", message: "Please choose start date.")
               }else{
             self.labelStartDate.text = self.fromDateStr
            self.labelEndDate.text = self.toDateStr
                   self.GrayView.isHidden = true
                   self.CalenderView.isHidden = true
            
               }
           
            
       }
    
    @IBAction func buttonApply(_ sender: UIButton) {
        
        
        if self.fromDateStr == "" {
            self.showInformation(title: "Closest", message: "Please enter from and to date")
        }else{
            if Helper.sharedInstance.isConnectedToInternet() {
                self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","from_date":self.fromDateStr,"to_date":self.toDateStr]
                print(params)
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("API",ExperienceAddSchedule)
                print(params)
                manager.post(ExperienceAddSchedule, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.hideActivityIndicator(uiView: self.view)
                        let DataDict = responseDict.value(forKey: "result") as? NSArray
                        
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        
                        TimingsArray = (((DataDict?.object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray).copy() as! NSArray
                        print(TimingsArray)
                        if TimingsArray.count > 0 {
                            self.imageViewEmpty.isHidden = true
                            self.LabelEmptyText.isHidden = true

                            self.tableViewSchedules.isHidden = false
                        }
                        else {
                            self.imageViewEmpty.isHidden = false
                            self.tableViewSchedules.isHidden = true
                            self.LabelEmptyText.isHidden = false

                        }
                        self.tableViewSchedules.reloadData()
                    
                    }
                    else {

                        self.hideActivityIndicator(uiView: self.view)
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        self.hideActivityIndicator(uiView: self.view)
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
            }
        }
   }
}
extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Date {

    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
}
