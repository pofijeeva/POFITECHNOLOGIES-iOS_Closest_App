//
//  PropertyListing.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2018

import Foundation



//"calendar_status" =                 (
//                {
//color = "#E99C00";
//end = "1970-01-02";
//start = "1970-01-01 00:00:00";
//title = "3.00(USD) ";
//}
//);
//"cancel_booking" = 0;
//"daily_sts" = 1;
//"hourly_price" = "";
//"hourly_sts" = 1;
//id = 499;
//payable = 0;
//"property_address" = Bandoli;
//"property_currency_code" = USD;
//"property_currency_symbol" = "$";
//"property_id" = 42119;
//"property_image" = "https://demorental.shopurgrocery.in/public/images/property/default.png";
//"property_price" = 3;
//"property_status" = 0;
//"property_title" = "";
//ratings = "";
//"review_count" = 0;
//"steps_to_complete" = "6 Steps to list";
//"tot_booking" = 0;




class PropertyListing : NSObject, NSCoding{

//    var calendarStatus : [[String: Any]]!
    var cancelBooking : Int
    var dailyStatus : Bool
    var hourlyPrice : String
    var hourlystatus : Bool
    var iD : Int
    
    var createdDate : String!
    var hostId : Int!
    var hostname : String!
    var payable : Bool!
    var propertyCurrencyCode : String!
    var propertyCurrencySymbol : String!
    var propertyId : Int!
    var propertyImage : String!
    var propertyPrice : Int!
    var propertyStatus : Bool!
    var propertyTitle : String!
    var ratingss : String
    var reviewCount : Int
    var stepstoComplete : String
    var  totalBooking : Int
    
        
    var remainingSteps : Int!
    var propertyAddress : String!
    var creditCardStatus : String!
    var stripeStatus : String!
    var paypalStatus : String!
    var host_id_verified : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        print(dictionary)
//        calendarStatus = dictionary["calendar_status"] as? [[String: Any]]
        cancelBooking = (dictionary["cancel_booking"] as? Int) ?? 0
        dailyStatus = (dictionary["daily_sts"] as? Bool) ?? false
        hourlyPrice = "\((dictionary["hourly_price"] as? AnyObject)!)"
        hourlystatus = (dictionary["hourly_sts"] as? Bool) ?? false
        iD = (dictionary["id"] as? Int) ?? 0
        
        createdDate = dictionary["created_date"] as? String ?? ""
        host_id_verified = dictionary["host_id_verified"] as? String ?? ""

        hostId = dictionary["host_id"] as? Int ?? 0
        hostname = dictionary["hostname"] as? String ?? ""
        payable = dictionary["payable"] as? Bool ?? false
        propertyCurrencyCode = dictionary["property_currency_code"] as? String ?? ""
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String ?? ""
        propertyId = dictionary["property_id"] as? Int ?? 0
        propertyImage = dictionary["property_image"] as? String ?? ""
        propertyPrice = dictionary["property_price"] as? Int ?? 0
        propertyStatus = dictionary["property_status"] as? Bool ?? false
        propertyTitle = dictionary["property_title"] as? String ?? ""
        ratingss = (dictionary["ratings"] as? String ?? "")
        reviewCount = (dictionary["review_count"] as? Int) ?? 0
        stepstoComplete = (dictionary["steps_to_complete"] as? String ?? "")
        totalBooking = (dictionary["tot_booking"] as? Int) ?? 0
        
        
        
        remainingSteps = dictionary["remaining_steps"] as? Int ?? 0
        propertyAddress = dictionary["property_address"] as? String ?? ""
        creditCardStatus = dictionary["Credit_Card_status"] as? String ?? ""
        stripeStatus = dictionary["Stripe_status"] as? String ?? ""
        paypalStatus = dictionary["paypal_status"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
//        if calendarStatus != nil{
//            dictionary["calendar_status"] = calendarStatus
//        }
        if cancelBooking != nil{
            dictionary["cancel_booking"] = cancelBooking
        }
        if dailyStatus != nil{
            dictionary["daily_sts"] = dailyStatus
        }
        if hourlyPrice != nil{
            dictionary["hourly_price"] = hourlyPrice
        }
        if hourlystatus != nil{
            dictionary["hourly_sts"] = hourlystatus
        }
        if iD != nil{
            dictionary["id"] = iD
        }
        
        if createdDate != nil{
            dictionary["created_date"] = createdDate
        }
        if host_id_verified != nil{
            dictionary["host_id_verified"] = host_id_verified
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if hostname != nil{
            dictionary["hostname"] = hostname
        }
        if payable != nil{
            dictionary["payable"] = payable
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyCurrencySymbol != nil{
            dictionary["property_currency_symbol"] = propertyCurrencySymbol
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if propertyImage != nil{
            dictionary["property_image"] = propertyImage
        }
        if propertyPrice != nil{
            dictionary["property_price"] = propertyPrice
        }
        if propertyStatus != nil{
            dictionary["property_status"] = propertyStatus
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if ratingss != nil{
            dictionary["ratings"] = ratingss
        }
        if reviewCount != nil{
            dictionary["review_count"] = reviewCount
        }
        if stepstoComplete != nil{
            dictionary["steps_to_complete"] = stepstoComplete
        }
        if totalBooking != nil{
            dictionary["tot_booking"] = totalBooking
        }
        
        
        
        
        if remainingSteps != nil{
            dictionary["remaining_steps"] = remainingSteps
        }
        if propertyAddress != nil{
            dictionary["property_address"] = propertyAddress
        }
        if creditCardStatus != nil{
            dictionary["Credit_Card_status"] = creditCardStatus
        }
        if stripeStatus != nil{
            dictionary["Stripe_status"] = stripeStatus
        }
        if paypalStatus != nil{
            dictionary["paypal_status"] = paypalStatus
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        propertyAddress = aDecoder.decodeObject(forKey: "property_address") as? String ?? ""
//        calendarStatus = aDecoder.decodeObject(forKey: "calendar_status") as? [[String: Any]]
        cancelBooking = (aDecoder.decodeObject(forKey: "cancel_booking") as? Int) ?? 0
        dailyStatus = (aDecoder.decodeObject(forKey: "daily_sts") as? Bool) ?? false
        hourlyPrice = (aDecoder.decodeObject(forKey: "hourly_price") as? String ?? "")
        hourlystatus = (aDecoder.decodeObject(forKey: "hourly_sts") as? Bool) ?? false
        iD = (aDecoder.decodeObject(forKey: "id") as? Int) ?? 0
        
        createdDate = aDecoder.decodeObject(forKey: "created_date") as? String ?? ""
        host_id_verified = aDecoder.decodeObject(forKey: "host_id_verified") as? String ?? ""

        hostId = aDecoder.decodeObject(forKey: "host_id") as? Int ?? 0
        hostname = aDecoder.decodeObject(forKey: "hostname") as? String ?? ""
        payable = aDecoder.decodeObject(forKey: "payable") as? Bool ?? false
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String ?? ""
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String ?? ""
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int ?? 0
        propertyImage = aDecoder.decodeObject(forKey: "property_image") as? String ?? ""
        propertyPrice = aDecoder.decodeObject(forKey: "property_price") as? Int ?? 0
        propertyStatus = aDecoder.decodeObject(forKey: "property_status") as? Bool ?? false
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String ?? ""
        ratingss = (aDecoder.decodeObject(forKey: "ratings") as? String ?? "")
        reviewCount = (aDecoder.decodeObject(forKey: "review_count") as? Int) ?? 0
        stepstoComplete = (aDecoder.decodeObject(forKey: "steps_to_complete") as? String ?? "")
        totalBooking = (aDecoder.decodeObject(forKey: "tot_booking") as? Int) ?? 0
        
        
        remainingSteps = aDecoder.decodeObject(forKey: "remaining_steps") as? Int ?? 0
        creditCardStatus = aDecoder.decodeObject(forKey: "Credit_Card_status") as? String ?? ""
        stripeStatus = aDecoder.decodeObject(forKey: "Stripe_status") as? String ?? ""
        paypalStatus = aDecoder.decodeObject(forKey: "paypal_status") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if propertyAddress != nil{
            aCoder.encode(propertyAddress, forKey: "property_address")
        }
//        if calendarStatus != nil{
//            aCoder.encode(calendarStatus, forKey: "calendar_status")
//        }
        if cancelBooking != nil{
            aCoder.encode(cancelBooking, forKey: "cancel_booking")
        }
        if dailyStatus != nil{
            aCoder.encode(dailyStatus, forKey: "daily_sts")
        }
        if hourlyPrice != nil{
            aCoder.encode(hourlyPrice, forKey: "hourly_price")
        }
        if hourlystatus != nil{
            aCoder.encode(hourlystatus, forKey: "hourly_sts")
        }
        if iD != nil{
            aCoder.encode(iD, forKey: "id")
        }
        
        
        
        if createdDate != nil{
            aCoder.encode(createdDate, forKey: "created_date")
        }
        
        if host_id_verified != nil{
            aCoder.encode(host_id_verified, forKey: "host_id_verified")
        }
        
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if hostname != nil{
            aCoder.encode(hostname, forKey: "hostname")
        }
        if payable != nil{
            aCoder.encode(payable, forKey: "payable")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyCurrencySymbol != nil{
            aCoder.encode(propertyCurrencySymbol, forKey: "property_currency_symbol")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if propertyImage != nil{
            aCoder.encode(propertyImage, forKey: "property_image")
        }
        if propertyPrice != nil{
            aCoder.encode(propertyPrice, forKey: "property_price")
        }
        if propertyStatus != nil{
            aCoder.encode(propertyStatus, forKey: "property_status")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if ratingss != nil{
            aCoder.encode(ratingss, forKey: "ratings")
        }
        if reviewCount != nil{
            aCoder.encode(reviewCount, forKey: "review_count")
        }
        if totalBooking != nil{
            aCoder.encode(totalBooking, forKey: "tot_booking")
        }
                
        if remainingSteps != nil{
            aCoder.encode(remainingSteps, forKey: "remaining_steps")
        }
        if creditCardStatus != nil{
            aCoder.encode(creditCardStatus, forKey: "Credit_Card_status")
        }
        if stripeStatus != nil{
            aCoder.encode(stripeStatus, forKey: "Stripe_status")
        }
        if paypalStatus != nil{
            aCoder.encode(paypalStatus, forKey: "paypal_status")
        }
        
    }
}
