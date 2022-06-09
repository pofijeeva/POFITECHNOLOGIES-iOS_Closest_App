//
//  BasicPriceViewController.swift
//  CarRental
//
//  Created by POFI TECHNOLOGIES on 11/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import DropDown
import AFNetworking
import Alamofire

class BasicPriceViewController: BaseViewController,CommonListingSaveDelegate
{
    @IBOutlet weak var view_Scrolls: UIScrollView!
    @IBOutlet weak var view_SelectCurrency: UIView!
    @IBOutlet weak var txf_selectedCurrncy: UITextField!
    @IBOutlet weak var view_BookingTypes: UIView!
    @IBOutlet weak var btn_dailyBooking: UIButton!
    @IBOutlet weak var btn_HourlyBooking: UIButton!
    @IBOutlet weak var view_HourlyPrices: UIView!
    @IBOutlet weak var view_MinHours: UIView!
    @IBOutlet weak var txf_MinHrs: UITextField!
    @IBOutlet weak var view_minHrPrice: UIView!
    @IBOutlet weak var txf_minHrPrice: UITextField!
    @IBOutlet weak var view_PriceperHr: UIView!
    @IBOutlet weak var txf_PriceperHour: UITextField!
    @IBOutlet weak var view_Mindays: UIView!
    @IBOutlet weak var txf_MinDays: UITextField!
    @IBOutlet weak var view_Priceperday: UIView!
    @IBOutlet weak var txf_Priceperday: UITextField!
    @IBOutlet weak var view_WeeklyPrice: UIView!
    @IBOutlet weak var txf_WeeklyPrice: UITextField!
    @IBOutlet weak var view_MonthlyPrice: UIView!
    @IBOutlet weak var txf_MnthlyPrice: UITextField!
    @IBOutlet weak var view_DailyPrices: UIView!
    @IBOutlet weak var new_view_DailyPrices: UIView!
    @IBOutlet weak var dailyViewTopSpc: NSLayoutConstraint!
    @IBOutlet weak var hourlyViewTopSpc: NSLayoutConstraint!
    @IBOutlet weak var currncy_MinhrPrice: UILabel!
    @IBOutlet weak var currncy_PriceperHr: UILabel!
    @IBOutlet weak var currncy_Priceperday: UILabel!
    @IBOutlet weak var currncy_WeeklyPrice: UILabel!
    @IBOutlet weak var currncy_MnthlyPrice: UILabel!
    @IBOutlet weak var currncy_MnthlyhrPrice: UILabel!
    @IBOutlet weak var DaysViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hoursViewheight: NSLayoutConstraint!
    @IBOutlet weak var WeeeklyHeight: NSLayoutConstraint!
    @IBOutlet weak var MonthlyHeight: NSLayoutConstraint!
    @IBOutlet weak var YearlyHeight: NSLayoutConstraint!
    @IBOutlet weak var BasicPrice: UILabel!
    @IBOutlet weak var CurrenceyLbl: UILabel!
    @IBOutlet weak var BookingTypeLbl: UILabel!
    @IBOutlet weak var DailyBookingLbl: UILabel!
    @IBOutlet weak var HourlyBookingLbl: UILabel!
    
    @IBOutlet weak var WeeklyDisaLbl: UILabel!
    @IBOutlet weak var MonthlyDisaLbl: UILabel!
    @IBOutlet weak var YearlyDisaLbl: UILabel!
    
    @IBOutlet weak var LblWeeklyEna: UILabel!
    @IBOutlet weak var LblWeeklyDis: UILabel!
    @IBOutlet weak var LblMonthlyEna: UILabel!
    @IBOutlet weak var LblMonthlyDis: UILabel!
    @IBOutlet weak var LblYearlyEna: UILabel!
    @IBOutlet weak var LblYearlyDis: UILabel!
    
    @IBOutlet weak var dailyBookingTitleLbl: UILabel!
    @IBOutlet weak var priceperdayTitle: UILabel!
    @IBOutlet weak var dailyBookingDescLbl: UILabel!

    @IBOutlet weak var weekelyPriceTitleLbl: UILabel!
    @IBOutlet weak var weekelyPriceDescLbl: UILabel!
    @IBOutlet weak var MonthelyPriceTitleLbl: UILabel!
    @IBOutlet weak var MonthelyPriceDescLbl: UILabel!
    @IBOutlet weak var yearPriceTitleLbl: UILabel!
    @IBOutlet weak var yearDescLbl: UILabel!

    
    @IBOutlet weak var HourlTitle: UILabel!
    @IBOutlet weak var MinimumHouresTitle: UILabel!
    @IBOutlet weak var SaveBtnheight: NSLayoutConstraint!
    
    @IBOutlet weak var txt_PricePerDay: UITextField!
    @IBOutlet weak var txt_PricePerWeek: UITextField!
    @IBOutlet weak var txt_PricePerMonth: UITextField!
    @IBOutlet weak var txt_PricePerYear: UITextField!
    
    @IBOutlet weak var btn_PricePerWeekEnable: UIButton!
    @IBOutlet weak var btn_PricePerWeekDisable: UIButton!
    
    @IBOutlet weak var btn_PricePerMonthEnable: UIButton!
    @IBOutlet weak var btn_PricePerMonthDisable: UIButton!
    
    @IBOutlet weak var btn_PricePerYearEnable: UIButton!
    @IBOutlet weak var btn_PricePerYearDisable: UIButton!
    @IBOutlet weak var btn_Next: UIButton!
    
    @IBOutlet weak var btn_Enable: UIButton!
    @IBOutlet weak var btn_Disable: UIButton!
    
    @IBOutlet weak var btn_MonEnable: UIButton!
    @IBOutlet weak var btn_MonDisable: UIButton!
    
    @IBOutlet weak var btn_YearEnable: UIButton!
    @IBOutlet weak var btn_YearDisable: UIButton!
    
    
    

    
    let radioController: RadioButtonController = RadioButtonController()
    
    let radioMonController: RadioButtonMonController = RadioButtonMonController()
    
    let radioYearController: RadioButtonYearController = RadioButtonYearController()
    

    
    var PROPERTY_ID = String()
    
    
    
    
    var dailySelected = Bool()
    var hourlySelected = Bool()
    var PropertyID = Int()
    var Currencies = NSMutableArray()
    var BookingType = String()
    var BothSelected = Bool()
    var dropDownCurrencyArray = [String]()
    var priceChange = false
    var currencyArr = [Currency]()
    let currencyDropdown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.currencyDropdown,
            
        ]
    }()
    var ListingActivityDelegate: listingActivityProtocol!
    var pickuptype = String()
    var selectdCurrncy = String()
    var isDailyBooking = Bool()
    var isHourlyBooking = Bool()
    var CurrncySymblArray = NSMutableArray()
    var symbol = String()
    var minHrArray = ["01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00"]
    var minDaysArray = ["1","2","3","4","5","6","7","8","9","10"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.btn_Next.backgroundColor = AppColor
        radioController.buttonsArray = [btn_Enable,btn_Disable]
        radioController.defaultButton = btn_Disable
        
        radioMonController.buttonsMonArray = [btn_MonEnable,btn_MonDisable]
        radioMonController.defaultButton = btn_MonDisable

        radioYearController.buttonsYearArray = [btn_YearEnable,btn_YearDisable]
        radioYearController.defaultButton = btn_YearDisable

        txt_PricePerDay.keyboardType = UIKeyboardType.numberPad
        txt_PricePerWeek.keyboardType = UIKeyboardType.numberPad
        txt_PricePerMonth.keyboardType = UIKeyboardType.numberPad
        txt_PricePerYear.keyboardType = UIKeyboardType.numberPad
        

        
        setData()
        self.txf_selectedCurrncy.text = "USD"
        SharedsaveInstance.delegate = self
        txf_selectedCurrncy.delegate = self
        txf_MinDays.delegate = self
        txf_MinHrs.delegate = self
        
        txf_Priceperday.delegate = self
        txf_WeeklyPrice.delegate = self
        txf_MnthlyPrice.delegate = self
        txf_PriceperHour.delegate = self
        txf_minHrPrice.delegate = self
        
        WeeeklyHeight.constant = 0
        txt_PricePerWeek.isHidden = true
        txt_PricePerMonth.isHidden = true
        txt_PricePerYear.isHidden = true
        MonthlyHeight.constant = 0
        YearlyHeight.constant = 0
        
        self.view_HourlyPrices.layer.shadowColor = BorderColor.cgColor
        self.view_HourlyPrices.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.view_HourlyPrices.layer.shadowOpacity = 0.7
        self.view_HourlyPrices.layer.shadowRadius = 3.0
        self.view_HourlyPrices.layer.cornerRadius = 5.0
        self.view_DailyPrices.layer.shadowColor = BorderColor.cgColor
        self.view_DailyPrices.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.view_DailyPrices.layer.shadowOpacity = 0.7
        self.view_DailyPrices.layer.shadowRadius = 3.0
        self.view_DailyPrices.layer.cornerRadius = 5.0
        self.new_view_DailyPrices.layer.shadowColor = BorderColor.cgColor
        self.new_view_DailyPrices.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.new_view_DailyPrices.layer.shadowOpacity = 0.7
        self.new_view_DailyPrices.layer.shadowRadius = 3.0
        self.new_view_DailyPrices.layer.cornerRadius = 5.0
        
        
        
        
        self.LblWeeklyEna.font = UIFont(name: SemiBoldFont, size: 14)
        self.LblWeeklyDis.font = UIFont(name: SemiBoldFont, size: 14)
        self.LblMonthlyEna.font = UIFont(name: SemiBoldFont, size: 14)
        self.LblMonthlyDis.font = UIFont(name: SemiBoldFont, size: 14)
        self.LblYearlyEna.font = UIFont(name: SemiBoldFont, size: 14)
        self.LblYearlyDis.font = UIFont(name: SemiBoldFont, size: 14)
        self.CurrenceyLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.BookingTypeLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.DailyBookingLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.dailyBookingTitleLbl.font = UIFont(name: SemiBoldFont, size: 18)
        self.priceperdayTitle.font = UIFont(name: SemiBoldFont, size: 16)
        self.txt_PricePerDay.font = UIFont(name: SemiBoldFont, size: 14)
        self.dailyBookingDescLbl.font = UIFont(name: SemiBoldFont, size: 12)
        self.weekelyPriceTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.WeeklyDisaLbl.font = UIFont(name: SemiBoldFont, size: 12)
        
        self.MonthelyPriceTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.MonthlyDisaLbl.font = UIFont(name: SemiBoldFont, size: 12)
        
        self.yearPriceTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.YearlyDisaLbl.font = UIFont(name: SemiBoldFont, size: 12)

        
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        //self.view_DailyPrices.isHidden = true
        self.BookingType = ""
        // self.view_HourlyPrices.isHidden = true
        view_Scrolls.contentSize = CGSize(width: self.view.frame.width, height: 980)
        self.view_SelectCurrency.layer.masksToBounds = true
        self.view_SelectCurrency.layer.cornerRadius = 15
        self.view_SelectCurrency.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_MinHours.layer.masksToBounds = true
        self.view_MinHours.layer.cornerRadius = 5
        self.view_MinHours.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_minHrPrice.layer.masksToBounds = true
        self.view_minHrPrice.layer.cornerRadius = 5
        self.view_minHrPrice.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_PriceperHr.layer.masksToBounds = true
        self.view_PriceperHr.layer.cornerRadius = 5
        self.view_PriceperHr.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_Mindays.layer.masksToBounds = true
        self.view_Mindays.layer.cornerRadius = 5
        self.view_Mindays.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_Priceperday.layer.masksToBounds = true
        self.view_Priceperday.layer.cornerRadius = 5
        self.view_Priceperday.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_WeeklyPrice.layer.masksToBounds = true
        self.view_WeeklyPrice.layer.cornerRadius = 5
        self.view_WeeklyPrice.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        self.view_MonthlyPrice.layer.masksToBounds = true
        self.view_MonthlyPrice.layer.cornerRadius = 5
        self.view_MonthlyPrice.setBorder(withColor: BorderColor, width: 1.0, cornerRadius: 5)
        
        currencyArr = Singleton.sharedInstance.rentYourSpace.currency
        let currencyCodeArray = NSMutableArray()
//        for num in 0..<Singleton.sharedInstance.rentYourSpace.currency.count
//        {
//            if !dropDownCurrencyArray.contains(Singleton.sharedInstance.rentYourSpace.currency[num].currencyType){
//                dropDownCurrencyArray.append(Singleton.sharedInstance.rentYourSpace.currency[num].currencyType)
//                currencyCodeArray.add(Singleton.sharedInstance.rentYourSpace.currency[num].currencyType)
//                let currncySymbl = Singleton.sharedInstance.rentYourSpace.currency[num].countrySymbols
//                self.CurrncySymblArray.add(currncySymbl!)
//            }
//        }
//        if self.CurrncySymblArray.count != 0{
//            self.symbol = self.CurrncySymblArray.object(at: 0) as! String
//        }
        
//        if Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode != nil && Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode == ""
//        {
//            let select_code = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode)
//            if select_code != "" && currencyCodeArray.contains(select_code){
//                self.txf_selectedCurrncy.text = select_code
//                SelectedCurrency = self.txf_selectedCurrncy.text!
//
//                let index = currencyCodeArray.index(of: select_code)
//                self.symbol = CurrncySymblArray.object(at: index) as! String
//            }else{
//                self.txf_selectedCurrncy.text = self.symbol
//                SelectedCurrency = self.txf_selectedCurrncy.text!
//
//            }
//
//        }else if Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode != ""{
//            let select_code = String(Singleton.sharedInstance.rentYourSpace.result[0].step3.currencyCode)
//            if select_code != "" && currencyCodeArray.contains(select_code){
//                self.txf_selectedCurrncy.text = select_code
//                SelectedCurrency = self.txf_selectedCurrncy.text!
//
//                let index = currencyCodeArray.index(of: select_code)
//                self.symbol = CurrncySymblArray.object(at: index) as! String
//            }else{
//                self.txf_selectedCurrncy.text = self.symbol
//                SelectedCurrency = self.txf_selectedCurrncy.text!
//
//            }
//
//        }else{
//
//        }
        
        btn_Next.backgroundColor = AppSecondColor1
        
        self.currncy_MinhrPrice.text = self.symbol
        self.currncy_PriceperHr.text = self.symbol
        self.currncy_Priceperday.text = self.symbol
        self.currncy_PriceperHr.text = self.symbol
        self.currncy_MnthlyPrice.text = self.symbol
        self.currncy_WeeklyPrice.text = self.symbol
        self.currncy_MnthlyhrPrice.text = self.symbol
        
        txf_selectedCurrncy.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_selectedCurrncy.frame.height))
        txf_selectedCurrncy.leftViewMode = .always
        
        txf_MinHrs.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_MinHrs.frame.height))
        txf_MinHrs.leftViewMode = .always
        
        txf_minHrPrice.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_minHrPrice.frame.height))
        txf_minHrPrice.leftViewMode = .always
        
        txf_PriceperHour.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_PriceperHour.frame.height))
        txf_PriceperHour.leftViewMode = .always
        
        txf_MinDays.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_MinDays.frame.height))
        txf_MinDays.leftViewMode = .always
        
        txf_Priceperday.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_Priceperday.frame.height))
        txf_Priceperday.leftViewMode = .always
        
        txf_WeeklyPrice.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_WeeklyPrice.frame.height))
        txf_WeeklyPrice.leftViewMode = .always
        
        txf_MnthlyPrice.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txf_MnthlyPrice.frame.height))
        txf_MnthlyPrice.leftViewMode = .always
        
       
        
    }
    
    func setData()
    {
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step2 = result.step2 {
//            cell.ratingLabel.text = String(format: "%0.0f", Double(step2.currencyCode) ?? 0.0)
            self.txf_selectedCurrncy.text = step2.currencyCode
//            self.txf_selectedCurrncy.text = step2.currencyCode
            self.isDailyBooking = step2.daily_sts
            if isDailyBooking {
                new_view_DailyPrices.isHidden = false
                self.btn_dailyBooking.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)
             //   self.btn_dailyBooking.setImage(UIImage(named: "tick-on"), for: .normal)
            }else{
                new_view_DailyPrices.isHidden = true
                self.btn_dailyBooking.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
               // self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
            }

                                        
            self.txt_PricePerDay.text = String(format: "%0.0f", Double(step2.price_list) ?? 0.0)
//            self.txt_PricePerDay.text = String(format: "%0.2f", step2.price_list)
            self.txt_PricePerWeek.text = step2.weekly_price_status ? String(format: "%0.2f", step2.weekly_price_list) : ""
            self.txt_PricePerMonth.text = step2.monthly_price_status ? String(format: "%0.2f", step2.monthly_price_list) : ""
            self.txt_PricePerYear.text = step2.yearly_price_status ? String(format: "%0.2f", step2.yearly_price_list) : ""
            
            self.txt_PricePerDay.isUserInteractionEnabled = true
            self.txt_PricePerWeek.isUserInteractionEnabled = step2.weekly_price_status
            self.txt_PricePerMonth.isUserInteractionEnabled = step2.monthly_price_status
            self.txt_PricePerYear.isUserInteractionEnabled = step2.yearly_price_status
            
//            self.btn_PricePerWeekEnable.backgroundColor = step2.weekly_price_status ? .systemOrange : .systemGray
//            self.btn_PricePerWeekDisable.backgroundColor = step2.weekly_price_status ? .systemGray : .systemOrange
//
//            self.btn_PricePerMonthEnable.backgroundColor = step2.weekly_price_status ? .systemOrange : .systemGray
//            self.btn_PricePerMonthDisable.backgroundColor = step2.weekly_price_status ? .systemGray : .systemOrange
//
//            self.btn_PricePerYearEnable.backgroundColor = step2.weekly_price_status ? .systemOrange : .systemGray
//            self.btn_PricePerYearDisable.backgroundColor = step2.weekly_price_status ? .systemGray : .systemOrange
        }
        
        
//        self.dropDownCurrencyArray = [stepTwo.currencyCode]
        
//        if Singleton.sharedInstance.rentYourSpace.result != nil
//        {
//
//            self.isDailyBooking = stepTwo.daily_booking_status
//            self.isHourlyBooking = stepTwo.hourly_booking_status
//            UserDefaults.standard.setValue(stepTwo.currencyCode, forKey: "HOST_CURRENCY")
//            if self.isDailyBooking == true{
//                pickuptype = "1"
//                self.btn_dailyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//                self.view_DailyPrices.isHidden = false
//                self.DaysViewHeight.constant = 485
//                self.txf_MinDays.text = "\(stepTwo.min_days!)"
//                self.txf_Priceperday.text = "\(stepTwo.price_per_day!)"
//                self.txf_WeeklyPrice.text = "\(stepTwo.price_perweek!)"
//                self.txf_MnthlyPrice.text = "\(stepTwo.price_permonth!)"
//            }else
//            {
//                self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//                self.view_DailyPrices.isHidden = true
//                self.DaysViewHeight.constant = 0
//
//            }
//            if self.isHourlyBooking == true{
//                pickuptype = "2"
//                self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//                self.view_HourlyPrices.isHidden = false
//                self.hoursViewheight.constant = 370
//                self.txf_MinHrs.text = String(describing: stepTwo.min_hour!)
//                self.txf_minHrPrice.text = String(describing: stepTwo.min_hour_price!)
//                self.txf_PriceperHour.text = String(describing: stepTwo.price_per_hour!)
//            }else{
//                self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//                self.view_HourlyPrices.isHidden = true
//                self.hoursViewheight.constant = 0
//            }
//        }
//
//
//
//        self.BasicPrice.font  = UIFont(name: SemiBoldFont, size: 15)
//        self.CurrenceyLbl.font  = UIFont(name: SemiBoldFont, size: 14)
//        self.txf_selectedCurrncy.font  = UIFont(name: SemiBoldFont, size: 14)
//        self.BookingTypeLbl.font  = UIFont(name: SemiBoldFont, size: 17)
//        self.DailyBookingLbl.font  = UIFont(name: SemiBoldFont, size: 14)
//        self.HourlyBookingLbl.font  = UIFont(name: SemiBoldFont, size: 17)
//        self.HourlTitle.font  = UIFont(name: SemiBoldFont, size: 17)
//        self.MinimumHouresTitle.font  = UIFont(name: SemiBoldFont, size: 14)
//        self.MinimumHouresTitle.font  = UIFont(name: RegularFont, size: 14)
//
//        if self.isDailyBooking == true && self.isHourlyBooking == true
//        {
//            pickuptype = "1,2"
//        }
//
//        if pickuptype == "1"
//        {
//            if stepTwo.daily_booking_status! == true
//            {
//                isDailyBooking = false
//                self.btn_dailyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            } else
//            {
//                isHourlyBooking = false
//                self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//            }
//            self.view_DailyPrices.isHidden = false
//            self.btn_dailyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//        }
//        if pickuptype == "2"
//        {
//            if stepTwo.hourly_booking_status! == true {
//                isHourlyBooking = true
//                self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            }
//            else
//            {
//                isHourlyBooking = false
//                self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//            }
//            self.view_HourlyPrices.isHidden = false
//            self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//
//        }
//        if pickuptype == "1,2"
//        {
//            if stepTwo.hourly_booking_status! == true && stepTwo.daily_booking_status! == true
//            {
//                self.btn_dailyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//                self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            }
//            else
//            {
//                self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//                self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//            }
//            self.view_DailyPrices.isHidden = false
//            self.view_HourlyPrices.isHidden = false
//            self.btn_dailyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
//
//        }
//        if pickuptype != "1,2" && pickuptype != "1" && pickuptype != "2"
//        {
//            self.view_HourlyPrices.isHidden = true
//            self.view_DailyPrices.isHidden = true
//            self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//            self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
//        }
//
//        else
//
//        {
//
//        }
        
    }
    @IBAction func act_btnEnable(_ sender: UIButton) {
        switch sender {
        case btn_PricePerWeekEnable:
            self.btn_PricePerWeekEnable.backgroundColor = .systemOrange
            self.btn_PricePerWeekDisable.backgroundColor = .systemGray
            self.txt_PricePerWeek.isUserInteractionEnabled = true
        case btn_PricePerMonthEnable:
            self.btn_PricePerMonthEnable.backgroundColor = .systemOrange
            self.btn_PricePerMonthDisable.backgroundColor = .systemGray
            self.txt_PricePerMonth.isUserInteractionEnabled = true
        case btn_PricePerYearEnable:
            self.btn_PricePerYearEnable.backgroundColor = .systemOrange
            self.btn_PricePerYearDisable.backgroundColor = .systemGray
            self.txt_PricePerYear.isUserInteractionEnabled = true
        default: break
        }
    }
    
    @IBAction func act_btnDisable(_ sender: UIButton) {
        switch sender {
        case btn_PricePerWeekDisable:
            self.btn_PricePerWeekEnable.backgroundColor = .systemGray
            self.btn_PricePerWeekDisable.backgroundColor = .systemOrange
            self.txt_PricePerWeek.isUserInteractionEnabled = false
        case btn_PricePerMonthDisable:
            self.btn_PricePerMonthEnable.backgroundColor = .systemGray
            self.btn_PricePerMonthDisable.backgroundColor = .systemOrange
            self.txt_PricePerMonth.isUserInteractionEnabled = false
        case btn_PricePerYearDisable:
            self.btn_PricePerYearEnable.backgroundColor = .systemGray
            self.btn_PricePerYearDisable.backgroundColor = .systemOrange
            self.txt_PricePerYear.isUserInteractionEnabled = false
        default: break
        }
    }
    
    @IBAction func act_dailyBooking(_ sender: UIButton)
    {
        //        if isRememberPassword
        //           {
        //            isRememberPassword = false
        //            self.BookingType = "daily"
        //            self.view_DailyPrices.isHidden = false
        //            self.dailySelected = true
        //           // self.dailyViewTopSpc.constant = 15
        //            self.btn_dailyBooking.setImage(UIImage(named: "checked-symbol"), for: .normal)
        //            self.pickuptype = "1"
        //           }
        //            else if hourlySelected == true
        //           {
        //            self.view_HourlyPrices.isHidden = false
        //            self.view_DailyPrices.isHidden = false
        //            //self.dailyViewTopSpc.constant = 15
        //            self.hourlyViewTopSpc.constant = 400
        //            self.pickuptype = "1,2"
        //           }
        //           else
        //           {
        //            self.BothSelected = false
        //            isRememberPassword = true
        //            self.BookingType = ""
        //            self.dailySelected = false
        //            self.view_DailyPrices.isHidden = true
        //            self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
        //          }
        //        print(pickuptype)
                
        if isDailyBooking {
            self.pickuptype = "1"
            isDailyBooking = false
       //     view_DailyPrices.isHidden = true
            new_view_DailyPrices.isHidden = true
            DaysViewHeight.constant = 0
            self.btn_dailyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btn_dailyBooking.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
            // self.view_Scrolls.contentSize = CGSize(width: 0, height: 700)
        }else{
            isDailyBooking = true
     //       view_DailyPrices.isHidden = false
            new_view_DailyPrices.isHidden = false
            DaysViewHeight.constant = 485
            self.btn_dailyBooking.setImage(UIImage(named: "tick-on"), for: .normal)
            self.btn_dailyBooking.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)
            //self.view_Scrolls.contentSize = CGSize(width: 0, height: 1000)
        }

        let stepTwo = (Singleton.sharedInstance.rentYourSpace.result.first)!.step2!
        self.txt_PricePerDay.text = String(format: "%0.2f", stepTwo.price_list)
        self.txt_PricePerWeek.text = stepTwo.weekly_price_status ? String(format: "%0.2f", stepTwo.weekly_price_list) : "0"
        self.txt_PricePerMonth.text = stepTwo.monthly_price_status ? String(format: "%0.2f", stepTwo.monthly_price_list) : "0"
        self.txt_PricePerYear.text = stepTwo.yearly_price_status ? String(format: "%0.2f", stepTwo.yearly_price_list) : "0"
        
        self.txt_PricePerDay.isUserInteractionEnabled = true
        self.txt_PricePerWeek.isUserInteractionEnabled = stepTwo.weekly_price_status
        self.txt_PricePerMonth.isUserInteractionEnabled = stepTwo.monthly_price_status
        self.txt_PricePerYear.isUserInteractionEnabled = stepTwo.yearly_price_status
        
//        self.btn_PricePerWeekEnable.backgroundColor = stepTwo.weekly_price_status ? .systemOrange : .systemGray
//        self.btn_PricePerWeekDisable.backgroundColor = stepTwo.weekly_price_status ? .systemGray : .systemOrange
//
//        self.btn_PricePerMonthEnable.backgroundColor = stepTwo.weekly_price_status ? .systemOrange : .systemGray
//        self.btn_PricePerMonthDisable.backgroundColor = stepTwo.weekly_price_status ? .systemGray : .systemOrange
//
//        self.btn_PricePerYearEnable.backgroundColor = stepTwo.weekly_price_status ? .systemOrange : .systemGray
//        self.btn_PricePerYearDisable.backgroundColor = stepTwo.weekly_price_status ? .systemGray : .systemOrange
    }
    
    @IBAction func act_HourlyBooking(_ sender: Any)
    {
        //         if isRememberPassword
        //          {
        //            isRememberPassword = false
        //            self.BookingType = "hourly"
        //            self.view_HourlyPrices.isHidden = false
        //            self.hourlySelected = true
        //            self.hourlyViewTopSpc.constant = 15
        //            self.btn_HourlyBooking.setImage(UIImage(named: "checked-symbol"), for: .normal)
        //            self.pickuptype = "2"
        //        }
        //        else if self.dailySelected == true
        //         {
        //            self.view_DailyPrices.isHidden = false
        //            self.view_HourlyPrices.isHidden = false
        //            //self.dailyViewTopSpc.constant = 15
        //            self.hourlyViewTopSpc.constant = 400
        //            self.pickuptype = "1,2"
        //            self.btn_HourlyBooking.setImage(UIImage(named: "checked-symbol"), for: .normal)
        //         }
        //        else
        //        {
        //            self.BothSelected = false
        //            isRememberPassword = true
        //            self.BookingType = ""
        //            self.view_HourlyPrices.isHidden = true
        //            self.hourlySelected = false
        //            self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
        //        }
        //             print(pickuptype)
        
        if isHourlyBooking{
            self.pickuptype = "2"
            isHourlyBooking = false
            view_HourlyPrices.isHidden = true
            
            self.btn_HourlyBooking.setImage(UIImage(named: "tick-off"), for: .normal)
            self.btn_HourlyBooking.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
        }else{
            isHourlyBooking = true
            view_HourlyPrices.isHidden = false
            hoursViewheight.constant = 370
            self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2"), for: .normal)
            self.btn_HourlyBooking.setImage(UIImage(named: "checkbox-2")?.maskWithColor(color: AppColor), for: .normal)
        }
        
        if isHourlyBooking == true &&  isDailyBooking == true {
            self.pickuptype = "1,2"
        }else{
            
        }
    }
    
    @IBAction func act_Save(_ sender: Any){
        self.ActasCommonSave()
    }
    
    @IBAction func act_Enable(_ sender: UIButton){
        radioController.buttonArrayUpdated(buttonSelected: sender)
        txt_PricePerWeek.isHidden = false
        txt_PricePerWeek.isUserInteractionEnabled = true
        txt_PricePerWeek.isEnabled = true
        
        WeeeklyHeight.constant = 40
        WeeklyDisaLbl.isHighlighted = false
    }
    @IBAction func act_Disable(_ sender: UIButton){
        radioController.buttonArrayUpdated(buttonSelected: sender)
        txt_PricePerWeek.isHidden = true
        
        WeeeklyHeight.constant = 0
        txt_PricePerDay.text = ""
        WeeklyDisaLbl.isHighlighted = false
    }
    
    @IBAction func act_MonEnable(_ sender: UIButton){
        radioMonController.buttonMonArrayUpdated(buttonSelected: sender)
        txt_PricePerMonth.isHidden = false
        txt_PricePerMonth.isUserInteractionEnabled = true
        txt_PricePerMonth.isEnabled = true
        
        MonthlyHeight.constant = 40
        MonthlyDisaLbl.isHighlighted = false
        
    }
    @IBAction func act_MonDisable(_ sender: UIButton){
        radioMonController.buttonMonArrayUpdated(buttonSelected: sender)
        txt_PricePerMonth.isHidden = true
        MonthlyHeight.constant = 0
        txt_PricePerMonth.text = ""
        MonthlyDisaLbl.isHighlighted = false
    }
    @IBAction func act_YearEnable(_ sender: UIButton){
        radioYearController.buttonArrayYearUpdated(buttonSelected: sender)
        txt_PricePerYear.isHidden = false
        txt_PricePerYear.isUserInteractionEnabled = true
        txt_PricePerYear.isEnabled = true
        
        YearlyHeight.constant = 40
        YearlyDisaLbl.isHighlighted = false
    }
    @IBAction func act_YearDisable(_ sender: UIButton){
        radioYearController.buttonArrayYearUpdated(buttonSelected: sender)
        txt_PricePerYear.isHidden = true
        YearlyHeight.constant = 0
        txt_PricePerYear.text = ""
        YearlyDisaLbl.isHighlighted = false
    }
    
    
    
    func ActasCommonSave()
    {
        if self.txf_selectedCurrncy.text == "" {
            self.showInformation(title: "Closest", message: "Please select currency")
        }else{
            if !isDailyBooking {
                self.showInformation(title: "Closest", message: "Please select Daily Booking")
            } else {
                SavePricing()
            }
            
//            if !isDailyBooking && !isHourlyBooking
//            {
//                self.showInformation(title: "Closest", message: "Please select any one Hourly / Daily Price Details")
//                return
//            }
//            if isDailyBooking && isHourlyBooking
//            {
//                if txf_MinDays.text == "0" || txf_MinDays.text == ""{
//                    self.showInformation(title: "Closest", message: "Please Select Minimum days")
//                    return
//                }else if txf_Priceperday.text == "0" || txf_Priceperday.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter price per day")
//                    return
//                }else if txf_WeeklyPrice.text == "0" || txf_WeeklyPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Price per week")
//                    return
//                }else if txf_MnthlyPrice.text == "0" || txf_MnthlyPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter price per month")
//                    return
//                }else if txf_MinHrs.text == "0" || txf_MinHrs.text == ""{
//                    self.showInformation(title: "Closest", message: "Please Select Minimum Hours")
//                    return
//                }else if txf_minHrPrice.text == "0" || txf_minHrPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Minimum hour price")
//                    return
//                }else if txf_PriceperHour.text == "0" || txf_PriceperHour.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Price per hour")
//                    return
//                }else{
//                    SavePricing()
//                    return
//                }
//            }
//
//            if isDailyBooking{
//                if txf_MinDays.text == "0" || txf_MinDays.text == ""{
//                    self.showInformation(title: "Closest", message: "Please Select Minimum days")
//                    return
//                }else if txf_Priceperday.text == "0" || txf_Priceperday.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter price per day")
//                    return
//                }else if txf_WeeklyPrice.text == "0" || txf_WeeklyPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Price per week")
//                    return
//                }else if txf_MnthlyPrice.text == "0" || txf_MnthlyPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter price per month")
//                    return
//                }else{
//                    SavePricing()
//                    return
//                }
//            }
//
//            if isHourlyBooking
//            {
//                 if txf_MinHrs.text == "0" || txf_MinHrs.text == ""{
//                    self.showInformation(title: "Closest", message: "Please Select Minimum Hours")
//                    return
//                }
//                else if txf_minHrPrice.text == "0" || txf_minHrPrice.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Minimum hour price")
//                    return
//                }else if txf_PriceperHour.text == "0" || txf_PriceperHour.text == ""{
//                    self.showInformation(title: "Closest", message: "Please enter Price per hour")
//                    return
//                }else{
//                    SavePricing()
//                    return
//                }
//            }
        }
    }
    
    func currncyDropdown()
    {
        //        var currencies = NSMutableArray()
        //        currencies = CurrencyArray
        currencyDropdown.anchorView = txf_selectedCurrncy
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (txf_selectedCurrncy?.bounds.height)!)
        currencyDropdown.dataSource = dropDownCurrencyArray
        currencyDropdown.backgroundColor = UIColor.white
        // Action triggered on selection
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txf_selectedCurrncy.text = item
//            self.symbol = self.CurrncySymblArray.object(at: index) as! String
//            //  common_list_cuureny_symbol = self.symbol
//            print(self.symbol)
//            self.selectdCurrncy = item
//            UserDefaults.standard.setValue(self.selectdCurrncy, forKey: "HOST_CURRENCY")
//            self.currncy_MinhrPrice.text = self.symbol
//            self.currncy_PriceperHr.text = self.symbol
//            self.currncy_Priceperday.text = self.symbol
//            self.currncy_PriceperHr.text = self.symbol
//            self.currncy_MnthlyPrice.text = self.symbol
//            self.currncy_WeeklyPrice.text = self.symbol
            
        }
    }
    
    func minHrdropdown()
    {
        let hours = minHrArray
        currencyDropdown.anchorView = txf_MinHrs
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (txf_MinHrs?.bounds.height)!)
        currencyDropdown.dataSource = hours as! [String]
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
//            self.txf_MinHrs.text = item
            
        }
    }
    
    func minDaysdropdown()
    {
        let mindays = minDaysArray
        currencyDropdown.anchorView = txf_MinDays
        currencyDropdown.bottomOffset = CGPoint(x: 0, y: (txf_MinDays?.bounds.height)!)
        currencyDropdown.dataSource = mindays as! [String]
        currencyDropdown.backgroundColor = UIColor.white
        currencyDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
//            self.txf_MinDays.text = item
            
        }
    }
    
    func SavePricing()
    {
        //self.ShowLoadingIndicator(sender: self)
        ListingActivityDelegate.showActivity()
        
        
        let params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                      "booking_type": ["booking_type": self.isDailyBooking ? 1 : 0],
                      "property_id":self.PropertyID,
                      "price_list":self.txt_PricePerDay.text!,
                      "weekly_price_list":self.txt_PricePerWeek.text!,
                      "monthly_price_list":self.txt_PricePerMonth.text!,
                      "yearly_price_list":self.txt_PricePerYear.text!,
                      "weekly_price_status":self.txt_PricePerWeek.isUserInteractionEnabled ? 1 : 0,
                      "monthly_price_status":self.txt_PricePerMonth.isUserInteractionEnabled ? 1 : 0,
                      "yearly_price_status":self.txt_PricePerYear.isUserInteractionEnabled ? 1 : 0
        ]
        print(params)
//        SAVE_CALENDER_LISTING
        APIManager.apiPostWithHeaders(serviceName: SAVE_CALENDER_LISTING, parameters: params) { response, error in
            DispatchQueue.main.async {
                self.ListingActivityDelegate.hideActivity()
            }
            
            let responseDict:NSDictionary = response as! NSDictionary
                                
                self.hideActivityIndicator(uiView: self.view)
            
           
            print(responseDict)
            if let code = responseDict.value(forKey: "code") as? Int , (200...299).contains(code){
                
                print("INSIDE")
                let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                sharedInstanceListing.gotoStepTwo()
                
            }  else {
                print("OUTSIDE LOOP")
                self.showInformation(title: "Closest",
                message: responseDict.value(forKey: "message") as! String)
                }
            
        }
        
    
        
//        let manager = AFHTTPSessionManager()
//        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//        //manager.requestSerializer.setValue(tokenString, forHTTPHeaderField: "Authorization")
//        manager.post(PRICING_API, parameters: params, headers: nil, progress: nil, success: { (operation, responseObject) -> Void in
//            DispatchQueue.main.async {
//                self.ListingActivityDelegate.hideActivity()
//            }
//
//
//            let responseDict:NSDictionary = responseObject as! NSDictionary
//            print(responseDict)
//            if responseDict.value(forKey: "status") as! NSNumber == 1 {
//                SelectedCurrency = self.txf_selectedCurrncy.text!
//                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                Singleton.sharedInstance.rentYourSpace = mod
//
//                //                                                                    self.showInformation(title: "Closest", message: mod.message)
//                self.setData()
//                sharedInstanceListing.gotoStepTwo()
//            }
//            else {
//
//                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//            }
//
//
//        }, failure: { (operation, error) -> Void in
//            DispatchQueue.main.async {
//                self.ListingActivityDelegate.hideActivity()
//            }
//            print(error)
//            self.showInformation(title: "Closest", message: error.localizedDescription)
//        })
        
        
        
        //            APIManager.apiPost(serviceName: PRICING_API, parameters: params) { (json:NSDictionary?, error:NSError?) in
        //                DispatchQueue.main.async {  }
        //                if error != nil
        //                {
        //                    print(error!.localizedDescription)
        //                    return
        //                }
        //                print(json!)
        //                if json?.value(forKey: "status") as! NSNumber == 1
        //                {
        //                    let mod = BasicInfoModel(fromDictionary: json as! [String : Any])
        //                    Singleton.sharedInstance.basicInfo = mod
        //                    self.showInformation(title: "Closest", message: "Successfully Added")
        //                    self.setData()
        ////                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController
        ////                    self.navigationController?.pushViewController(nav!, animated: true)
        //                }
        //                else
        //                {
        //                    self.showInformation(title: "Closest", message: json?.value(forKey: "message") as! String)
        //                }
        //                ListingBundleObject.LocalstopLoadingIndicator()
        //
        //
        //            }
    }
    
    
}
extension BasicPriceViewController:UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == txf_selectedCurrncy
        {
//            txf_selectedCurrncy.resignFirstResponder()
//            currncyDropdown()
//            currencyDropdown.show()
            return false
        }
        else if textField == txf_MinHrs
        {
            txf_MinHrs.resignFirstResponder()
            minHrdropdown()
            currencyDropdown.show()
            return false
            
        }
        else if textField == txf_MinDays
        {
            txf_MinDays.resignFirstResponder()
            minDaysdropdown()
            currencyDropdown.show()
            return false
        }
        return true
    }
    // MARK: UITextField Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        if textField == txf_Priceperday || textField == txf_WeeklyPrice || textField == txf_MnthlyPrice || textField == txf_PriceperHour || textField == txf_minHrPrice {
            guard let text = textField.text else { return true }
            let count = text.count + string.count - range.length
            result = count <= 5
            //return count <= 1056466
        }
        
        return result
    }
    
}




