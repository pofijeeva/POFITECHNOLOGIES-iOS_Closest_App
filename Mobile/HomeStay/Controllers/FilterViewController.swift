//
//  FilterViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 24/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar

class FilterViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    
    
    @IBOutlet weak var DurationLbl: UILabel!
              @IBOutlet weak var GuestLbl: UILabel!
            @IBOutlet weak var PriceLbl: UILabel!
         @IBOutlet weak var GuestValueLbl: UILabel!
               @IBOutlet weak var FromDateLbl: UILabel!
             @IBOutlet weak var ToDateLbl: UILabel!
      @IBOutlet weak var Calender: FSCalendar!

       @IBOutlet weak var PlusBtn: UIButton!
       @IBOutlet weak var minusBtn: UIButton!
      
       @IBOutlet weak var GrayView: UIView!
     
    
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
       fileprivate weak var calendar: FSCalendar!
       fileprivate weak var eventLabel: UILabel!
       private var firstDate: Date?
       private var lastDate: Date?
       private var datesRange: [Date]?
       var fromDateStr : String = ""
             var toDateStr : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
       @IBAction func GaryViewAct(_ sender: UITapGestureRecognizer) {
              self.GrayView.isHidden = true
             self.Calender.isHidden = true
        }
        
    
    //MARK:- Button Actions
          @IBAction func act_Back(_ sender: UIButton)
          {
              
              self.navigationController?.popViewController(animated: true)
              
          }
    @IBAction func act_Plus(_ sender: UIButton)
            {
                
                self.navigationController?.popViewController(animated: true)
                
            }
    @IBAction func act_Minus(_ sender: UIButton)
            {
                
                self.navigationController?.popViewController(animated: true)
                
            }
    
    @IBAction func act_FromDate(_ sender: UIButton)
               {
                   self.GrayView.isHidden = false
                        self.Calender.isHidden = false
               }
    
    
       @IBAction func act_ToDate(_ sender: UIButton)
               {
                   isFromDate = "Depart"
                          self.GrayView.isHidden = false
                            self.Calender.isHidden = false
                  
                   
               }
    
    
    @IBAction func act_ApplyFilters(_ sender: UIButton)
                {
                     self.navigationController?.popViewController(animated: true)
                }
    //    func presentationMode() -> CalendarMode {
    //           return .monthView
    //       }
    //
    //       func firstWeekday() -> Weekday {
    //           return Weekday.monday
    //       }
    //
           func getNextMonth(date:Date)->Date {
               return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
           }
           
           func getPreviousMonth(date:Date)->Date {
               return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
           }
           
           
           
           
          
           // MARK:- FSCalendarDataSource
           // MARK:- FSCalendarDelegate
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
               
               
               
               return nil
           }
           
           
           
           
           
           func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
               
               
               if isFromDate == "Arrive"
               {
                   self.minimumDate = date
                   print("did select date \(self.formatter.string(from: date))")
                 
                   self.fromDateStr = self.formatterNew.string(from: date)
                   self.GrayView.isHidden = true
                   self.Calender.isHidden = true
                   
               }
               else
               {
                  
                   print("did select date \(self.formatter.string(from: date))")
                 
                   self.toDateStr =  self.formatterNew.string(from: date)
               
                   self.GrayView.isHidden = true
                                 self.Calender.isHidden = true
                   
                  
               }
                calendar.reloadData()
           
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
