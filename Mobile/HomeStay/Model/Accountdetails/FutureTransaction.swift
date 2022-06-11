//
//  FutureTransaction.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class FutureTransaction : NSObject, NSCoding{

    var bookingno : AnyObject!
    var currencyCode : String = ""
    var currencySymbol : String = ""
    var dateadded : String = ""
    var firstname : String = ""
    var hostFee : Int = 0
    var payableAmount : AnyObject!
    var propertyPrice : Int = 0
    var propertyTitle : String = ""
    var securityDeposit : AnyObject!
    var serviceFee : AnyObject!
    var subTotal : AnyObject!
    var totalAmt : AnyObject!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookingno = dictionary["bookingno"] as? AnyObject
        currencyCode = dictionary["currency_code"] as? String ?? ""
        currencySymbol = dictionary["currency_symbol"] as? String ?? ""
        dateadded = dictionary["dateadded"] as? String ?? ""
        firstname = dictionary["firstname"] as? String ?? ""
        hostFee = dictionary["host_fee"] as? Int ?? 0
        payableAmount = dictionary["payable_amount"] as? AnyObject
        propertyPrice = dictionary["property_price"] as? Int ?? 0
        propertyTitle = dictionary["property_title"] as? String ?? ""
        securityDeposit = dictionary["security_deposit"] as? AnyObject
        serviceFee = dictionary["service_fee"] as? AnyObject
        subTotal = dictionary["sub_total"] as? AnyObject
        totalAmt = dictionary["totalAmt"] as? AnyObject
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bookingno != nil{
            dictionary["bookingno"] = bookingno
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if currencySymbol != nil{
            dictionary["currency_symbol"] = currencySymbol
        }
        if dateadded != nil{
            dictionary["dateadded"] = dateadded
        }
        if firstname != nil{
            dictionary["firstname"] = firstname
        }
        if hostFee != nil{
            dictionary["host_fee"] = hostFee
        }
        if payableAmount != nil{
            dictionary["payable_amount"] = payableAmount
        }
        if propertyPrice != nil{
            dictionary["property_price"] = propertyPrice
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if securityDeposit != nil{
            dictionary["security_deposit"] = securityDeposit
        }
        if serviceFee != nil{
            dictionary["service_fee"] = serviceFee
        }
        if subTotal != nil{
            dictionary["sub_total"] = subTotal
        }
        if totalAmt != nil{
            dictionary["totalAmt"] = totalAmt
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookingno = aDecoder.decodeObject(forKey: "bookingno") as? AnyObject
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String ?? ""
        currencySymbol = aDecoder.decodeObject(forKey: "currency_symbol") as? String ?? ""
        dateadded = aDecoder.decodeObject(forKey: "dateadded") as? String ?? ""
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String ?? ""
        hostFee = aDecoder.decodeObject(forKey: "host_fee") as? Int ?? 0
        payableAmount = aDecoder.decodeObject(forKey: "payable_amount") as? AnyObject
        propertyPrice = aDecoder.decodeObject(forKey: "property_price") as? Int ?? 0
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String ?? ""
        securityDeposit = aDecoder.decodeObject(forKey: "security_deposit") as? AnyObject
        serviceFee = aDecoder.decodeObject(forKey: "service_fee") as? AnyObject
        subTotal = aDecoder.decodeObject(forKey: "sub_total") as? AnyObject
        totalAmt = aDecoder.decodeObject(forKey: "totalAmt") as? AnyObject
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bookingno != nil{
            aCoder.encode(bookingno, forKey: "bookingno")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if currencySymbol != nil{
            aCoder.encode(currencySymbol, forKey: "currency_symbol")
        }
        if dateadded != nil{
            aCoder.encode(dateadded, forKey: "dateadded")
        }
        if firstname != nil{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if hostFee != nil{
            aCoder.encode(hostFee, forKey: "host_fee")
        }
        if payableAmount != nil{
            aCoder.encode(payableAmount, forKey: "payable_amount")
        }
        if propertyPrice != nil{
            aCoder.encode(propertyPrice, forKey: "property_price")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if securityDeposit != nil{
            aCoder.encode(securityDeposit, forKey: "security_deposit")
        }
        if serviceFee != nil{
            aCoder.encode(serviceFee, forKey: "service_fee")
        }
        if subTotal != nil{
            aCoder.encode(subTotal, forKey: "sub_total")
        }
        if totalAmt != nil{
            aCoder.encode(totalAmt, forKey: "totalAmt")
        }
    }
}
