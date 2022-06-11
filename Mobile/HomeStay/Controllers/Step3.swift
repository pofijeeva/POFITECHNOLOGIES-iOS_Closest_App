//
//  Step3.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Step3 : NSObject, NSCoding{

    var chk : String = ""
    var currencyCode : String = ""
    var price : Int = 0
    var propertyid : Int = 0
    var stepCompleted : Bool = false 
    var daily_booking_status : Bool = false 
    var hourly_booking_status : Bool = false 
    var min_days : AnyObject!
    
    var price_per_day : AnyObject!
    var price_permonth : AnyObject!
    var price_perweek : AnyObject!
    
    var min_hour : AnyObject!
    var min_hour_price : AnyObject!
    var price_per_hour : AnyObject!
    var calendarList : [CalendarList]!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        chk = dictionary["chk"] as? String ?? ""
        currencyCode = dictionary["currency_code"] as? String ?? ""
        price = dictionary["price"] as? Int ?? 0
        propertyid = dictionary["propertyid"] as? Int ?? 0
        stepCompleted = dictionary["step_completed"] as? Bool ?? false ?? false
        daily_booking_status = dictionary["daily_booking_status"] as? Bool ?? false
        hourly_booking_status = dictionary["hourly_booking_status"] as? Bool ?? false
        min_days = dictionary["min_days"] as? AnyObject
        
        price_per_day = dictionary["price_per_day"] as? AnyObject
        price_permonth = dictionary["price_permonth"] as? AnyObject
        price_perweek = dictionary["price_perweek"] as? AnyObject
        min_hour = dictionary["min_hour"] as? AnyObject
        min_hour_price = dictionary["min_hour_price"] as? AnyObject
        price_per_hour = dictionary["price_per_hour"] as? AnyObject
        
        calendarList = [CalendarList]()
        if let calendarListArray = dictionary["calender_list"] as? [[String:Any]] {
            for val in calendarListArray {
                let dic = val as! [String:Any]
                let value = CalendarList(fromDictionary: dic)
                calendarList.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if chk != nil{
            dictionary["chk"] = chk
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if price != nil{
            dictionary["price"] = price
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if daily_booking_status != nil{
            dictionary["daily_booking_status"] = daily_booking_status
        }
        if hourly_booking_status != nil{
            dictionary["hourly_booking_status"] = hourly_booking_status
        }
        if min_days != nil{
            dictionary["min_days"] = min_days
        }
        if price_per_day != nil{
            dictionary["price_per_day"] = price_per_day
        }
        if price_per_hour != nil{
            dictionary["price_per_hour"] = price_per_hour
        }
        if price_permonth != nil{
            dictionary["price_permonth"] = price_permonth
        }
        if price_perweek != nil{
            dictionary["price_perweek"] = price_perweek
        }
        if min_hour != nil{
            dictionary["min_hour"] = min_hour
        }
        if min_hour_price != nil{
            dictionary["min_hour_price"] = min_hour_price
        }
        if price_per_hour != nil{
            dictionary["price_per_hour"] = price_per_hour
        }
        if calendarList != nil{
            var dictionaryElements = [[String:Any]]()
            for calendarListElement in calendarList {
                dictionaryElements.append(calendarListElement.toDictionary())
            }
            dictionary["calender_list"] = dictionaryElements
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        chk = aDecoder.decodeObject(forKey: "chk") as? String ?? ""
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String ?? ""
        price = aDecoder.decodeObject(forKey: "price") as? Int ?? 0
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
        daily_booking_status = aDecoder.decodeObject(forKey: "daily_booking_status") as? Bool ?? false
        hourly_booking_status = aDecoder.decodeObject(forKey: "hourly_booking_status") as? Bool ?? false
        min_days = aDecoder.decodeObject(forKey: "min_days") as? AnyObject
        price_per_day = aDecoder.decodeObject(forKey: "price_per_day") as? AnyObject

        price_per_hour = aDecoder.decodeObject(forKey: "price_per_hour") as? AnyObject
        price_permonth = aDecoder.decodeObject(forKey: "price_permonth") as? AnyObject
        price_perweek = aDecoder.decodeObject(forKey: "price_perweek") as? AnyObject
        min_hour = aDecoder.decodeObject(forKey: "min_hour") as? AnyObject
        min_hour_price = aDecoder.decodeObject(forKey: "min_hour_price") as? AnyObject
        price_per_hour = aDecoder.decodeObject(forKey: "price_per_hour") as? AnyObject
        
        calendarList = aDecoder.decodeObject(forKey: "calender_list") as? [CalendarList]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if chk != nil{
            aCoder.encode(chk, forKey: "chk")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if daily_booking_status != nil{
            aCoder.encode(daily_booking_status, forKey: "daily_booking_status")
        }
        if hourly_booking_status != nil{
            aCoder.encode(hourly_booking_status, forKey: "hourly_booking_status")
        }
        if min_days != nil{
            aCoder.encode(min_days, forKey: "min_days")
        }
        if price_per_day != nil{
            aCoder.encode(price_per_day, forKey: "price_per_day")
        }
        if price_per_hour != nil{
            aCoder.encode(price_per_hour, forKey: "price_per_hour")
        }
        if price_permonth != nil{
            aCoder.encode(price_permonth, forKey: "price_permonth")
        }
        if price_perweek != nil{
            aCoder.encode(price_perweek, forKey: "price_perweek")
        }
        if min_hour != nil{
            aCoder.encode(min_hour, forKey: "min_hour")
        }
        if min_hour_price != nil{
            aCoder.encode(min_hour_price, forKey: "min_hour_price")
        }
        if price_per_hour != nil{
            aCoder.encode(price_per_hour, forKey: "price_per_hour")
        }
        
        if calendarList != nil{
            aCoder.encode(calendarList, forKey: "calender_list")
        }
    }
}
