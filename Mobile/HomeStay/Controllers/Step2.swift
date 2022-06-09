
//
//  Step2.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class Step2 : NSObject, NSCoding{

    var calendarChecked : String!
    var calendarStatus : Bool!
    var datefrom : String!
    var dateto : String!
    var propertyid : Int!
    var seasonalCalendarPrice : [AnyObject]!
    var stepCompleted : Bool!
    
    var monthly_price_list : Double!
    var monthly_price_status : Bool!
    var price_list : Double!
    var weekly_price_list : Double!
    var weekly_price_status : Bool!
    var yearly_price_list : Double!
    var yearly_price_status : Bool!
    var currencyCode: String!
    var daily_sts : Bool!
    var hourly_sts : Bool!
    var hour_price : AnyObject!
    var min_hour : AnyObject!
    var min_hour_price : AnyObject!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        hour_price = dictionary["hour_price"] as? AnyObject
        min_hour = dictionary["min_hour"] as? AnyObject
        min_hour_price = dictionary["min_hour_price"] as? AnyObject

        calendarChecked = dictionary["calendar_checked"] as? String
        calendarStatus = dictionary["calendar_status"] as? Bool
        datefrom = dictionary["datefrom"] as? String
        dateto = dictionary["dateto"] as? String
        propertyid = dictionary["propertyid"] as? Int
        stepCompleted = dictionary["step_completed"] as? Bool
        
        monthly_price_list = dictionary["monthly_price_list"] as? Double
        monthly_price_status = dictionary["monthly_price_status"] as? Bool
        price_list = dictionary["price_list"] as? Double
        weekly_price_list = dictionary["weekly_price_list"] as? Double
        weekly_price_status = dictionary["weekly_price_status"] as? Bool
        yearly_price_list = dictionary["yearly_price_list"] as? Double
        yearly_price_status = dictionary["yearly_price_status"] as? Bool
        currencyCode = dictionary["host_currency_code"] as? String
        daily_sts = dictionary["daily_sts"] as? Bool
        hourly_sts = dictionary["hourly_sts"] as? Bool

    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if calendarChecked != nil{
            dictionary["calendar_checked"] = calendarChecked
        }
        if calendarStatus != nil{
            dictionary["calendar_status"] = calendarStatus
        }
        if datefrom != nil{
            dictionary["datefrom"] = datefrom
        }
        if dateto != nil{
            dictionary["dateto"] = dateto
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        
        if monthly_price_list != nil {
            dictionary["monthly_price_list"] = monthly_price_list
        }
        
        if monthly_price_status != nil {
            dictionary["monthly_price_status"] = monthly_price_status
        }
        
        if price_list != nil {
            dictionary["price_list"] = price_list
        }
        
        if weekly_price_list != nil {
            dictionary["weekly_price_list"] = weekly_price_list
        }
        
        if weekly_price_status != nil {
            dictionary["weekly_price_status"] = weekly_price_status
        }
        
        if yearly_price_list != nil {
            dictionary["yearly_price_list"] = yearly_price_list
        }
        
        if yearly_price_status != nil {
            dictionary["yearly_price_status"] = yearly_price_status
        }
        
        if currencyCode != nil {
            dictionary["host_currency_code"] = currencyCode
        }
        
        if daily_sts != nil {
            dictionary["daily_sts"] = daily_sts
        }
        if hourly_sts != nil {
            dictionary["hourly_sts"] = hourly_sts
        }
        
        if hour_price != nil {
            dictionary["hour_price"] = hour_price
        }
        if min_hour != nil {
            dictionary["min_hour"] = min_hour
        }
        if min_hour_price != nil {
            dictionary["min_hour_price"] = min_hour_price
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        min_hour_price = aDecoder.decodeObject(forKey: "min_hour_price") as? AnyObject
        min_hour = aDecoder.decodeObject(forKey: "min_hour") as? AnyObject
        hour_price = aDecoder.decodeObject(forKey: "hour_price") as? AnyObject

        calendarChecked = aDecoder.decodeObject(forKey: "calendar_checked") as? String
        calendarStatus = aDecoder.decodeObject(forKey: "calendar_status") as? Bool
        datefrom = aDecoder.decodeObject(forKey: "datefrom") as? String
        dateto = aDecoder.decodeObject(forKey: "dateto") as? String
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int
        seasonalCalendarPrice = aDecoder.decodeObject(forKey: "seasonal_calendar_price") as? [AnyObject]
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool
        
        monthly_price_list = aDecoder.decodeObject(forKey: "monthly_price_list") as? Double
        monthly_price_status = aDecoder.decodeObject(forKey: "monthly_price_status") as? Bool
        price_list = aDecoder.decodeObject(forKey: "price_list") as? Double
        weekly_price_list = aDecoder.decodeObject(forKey: "weekly_price_list") as? Double
        weekly_price_status = aDecoder.decodeObject(forKey: "weekly_price_status") as? Bool
        yearly_price_list = aDecoder.decodeObject(forKey: "yearly_price_list") as? Double
        yearly_price_status = aDecoder.decodeObject(forKey: "yearly_price_status") as? Bool
        daily_sts = aDecoder.decodeObject(forKey: "daily_sts") as? Bool
        hourly_sts = aDecoder.decodeObject(forKey: "hourly_sts") as? Bool

        currencyCode = aDecoder.decodeObject(forKey: "host_currency_code") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if calendarChecked != nil{
            aCoder.encode(calendarChecked, forKey: "calendar_checked")
        }
        if calendarStatus != nil{
            aCoder.encode(calendarStatus, forKey: "calendar_status")
        }
        if datefrom != nil{
            aCoder.encode(datefrom, forKey: "datefrom")
        }
        if dateto != nil{
            aCoder.encode(dateto, forKey: "dateto")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if seasonalCalendarPrice != nil{
            aCoder.encode(seasonalCalendarPrice, forKey: "seasonal_calendar_price")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        
        
        if monthly_price_list != nil{
            aCoder.encode(monthly_price_list, forKey: "monthly_price_list")
        }
         
        if monthly_price_status != nil{
            aCoder.encode(monthly_price_status, forKey: "monthly_price_status")
        }
         
        if price_list != nil{
            aCoder.encode(price_list, forKey: "price_list")
        }
        
        if weekly_price_list != nil{
            aCoder.encode(weekly_price_list, forKey: "weekly_price_list")
        }
        
        if weekly_price_status != nil{
            aCoder.encode(weekly_price_status, forKey: "weekly_price_status")
        }
         
        if yearly_price_list != nil{
            aCoder.encode(yearly_price_list, forKey: "yearly_price_list")
        }
         
        if yearly_price_status != nil{
            aCoder.encode(yearly_price_status, forKey: "yearly_price_status")
        }
        
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "host_currency_code")
        }
        
        if daily_sts != nil{
            aCoder.encode(daily_sts, forKey: "daily_sts")
        }
        
        if hourly_sts != nil{
            aCoder.encode(hourly_sts, forKey: "hourly_sts")
        }
        
        if hour_price != nil{
            aCoder.encode(hour_price, forKey: "hour_price")
        }
        if min_hour != nil{
            aCoder.encode(min_hour, forKey: "min_hour")
        }
        if min_hour_price != nil{
            aCoder.encode(min_hour_price, forKey: "min_hour_price")
        }
        
    }
}
