//
//  HostCancellation.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 3, 2019

import Foundation


class HostCancellation : NSObject, NSCoding{
    
    var balanceAmount : String!
    var bookedDate : String!
    var bookingNo : String!
    var cancellationAmount : String!
    var checkin : String!
    var checkout : String!
    var currencycode : String!
    var paidAmount : String!
    var paidStatus : String!
    var productTitle : String!
    var userImage : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        balanceAmount = dictionary["balance_amount"] as? String ?? ""
        bookedDate = dictionary["bookedDate"] as? String ?? ""
        bookingNo = dictionary["booking_no"] as? String ?? ""
        cancellationAmount = dictionary["cancellation_amount"] as? String ?? ""
        checkin = dictionary["checkin"] as? String ?? ""
        checkout = dictionary["checkout"] as? String ?? ""
        currencycode = dictionary["currencycode"] as? String ?? ""
        paidAmount = dictionary["paid_amount"] as? String ?? ""
        paidStatus = dictionary["paid_status"] as? String ?? ""
        productTitle = dictionary["product_title"] as? String ?? ""
        userImage = dictionary["user_image"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if balanceAmount != nil{
            dictionary["balance_amount"] = balanceAmount
        }
        if bookedDate != nil{
            dictionary["bookedDate"] = bookedDate
        }
        if bookingNo != nil{
            dictionary["booking_no"] = bookingNo
        }
        if cancellationAmount != nil{
            dictionary["cancellation_amount"] = cancellationAmount
        }
        if checkin != nil{
            dictionary["checkin"] = checkin
        }
        if checkout != nil{
            dictionary["checkout"] = checkout
        }
        if currencycode != nil{
            dictionary["currencycode"] = currencycode
        }
        if paidAmount != nil{
            dictionary["paid_amount"] = paidAmount
        }
        if paidStatus != nil{
            dictionary["paid_status"] = paidStatus
        }
        if productTitle != nil{
            dictionary["product_title"] = productTitle
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        balanceAmount = aDecoder.decodeObject(forKey: "balance_amount") as? String ?? ""
        bookedDate = aDecoder.decodeObject(forKey: "bookedDate") as? String ?? ""
        bookingNo = aDecoder.decodeObject(forKey: "booking_no") as? String ?? ""
        cancellationAmount = aDecoder.decodeObject(forKey: "cancellation_amount") as? String ?? ""
        checkin = aDecoder.decodeObject(forKey: "checkin") as? String ?? ""
        checkout = aDecoder.decodeObject(forKey: "checkout") as? String ?? ""
        currencycode = aDecoder.decodeObject(forKey: "currencycode") as? String ?? ""
        paidAmount = aDecoder.decodeObject(forKey: "paid_amount") as? String ?? ""
        paidStatus = aDecoder.decodeObject(forKey: "paid_status") as? String ?? ""
        productTitle = aDecoder.decodeObject(forKey: "product_title") as? String ?? ""
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if balanceAmount != nil{
            aCoder.encode(balanceAmount, forKey: "balance_amount")
        }
        if bookedDate != nil{
            aCoder.encode(bookedDate, forKey: "bookedDate")
        }
        if bookingNo != nil{
            aCoder.encode(bookingNo, forKey: "booking_no")
        }
        if cancellationAmount != nil{
            aCoder.encode(cancellationAmount, forKey: "cancellation_amount")
        }
        if checkin != nil{
            aCoder.encode(checkin, forKey: "checkin")
        }
        if checkout != nil{
            aCoder.encode(checkout, forKey: "checkout")
        }
        if currencycode != nil{
            aCoder.encode(currencycode, forKey: "currencycode")
        }
        if paidAmount != nil{
            aCoder.encode(paidAmount, forKey: "paid_amount")
        }
        if paidStatus != nil{
            aCoder.encode(paidStatus, forKey: "paid_status")
        }
        if productTitle != nil{
            aCoder.encode(productTitle, forKey: "product_title")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
    }
}
