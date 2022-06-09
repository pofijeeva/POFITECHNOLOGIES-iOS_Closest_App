//
//  CompletedTransaction.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class CompletedTransaction : NSObject, NSCoding{

    var amount : AnyObject!
    var currencyCode : String!
    var currencySymbol : String!
    var dateadded : String!
    var transactionId : String!
    var transactionMethod : String!
    var bookingno : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        amount = dictionary["amount"] as? AnyObject
        bookingno = dictionary["bookingno"] as? String
        currencyCode = dictionary["currency_code"] as? String
        currencySymbol = dictionary["currency_symbol"] as? String
        dateadded = dictionary["dateadded"] as? String
        transactionId = dictionary["transaction_id"] as? String
        transactionMethod = dictionary["transaction_method"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if amount != nil{
            dictionary["amount"] = amount
        }
        if currencyCode != nil{
            dictionary["currency_code"] = currencyCode
        }
        if bookingno != nil{
                   dictionary["bookingno"] = bookingno
               }
        if currencySymbol != nil{
            dictionary["currency_symbol"] = currencySymbol
        }
        if dateadded != nil{
            dictionary["dateadded"] = dateadded
        }
        if transactionId != nil{
            dictionary["transaction_id"] = transactionId
        }
        if transactionMethod != nil{
            dictionary["transaction_method"] = transactionMethod
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        amount = aDecoder.decodeObject(forKey: "amount") as? AnyObject
        currencyCode = aDecoder.decodeObject(forKey: "currency_code") as? String
         bookingno = aDecoder.decodeObject(forKey: "bookingno") as? String
        currencySymbol = aDecoder.decodeObject(forKey: "currency_symbol") as? String
        dateadded = aDecoder.decodeObject(forKey: "dateadded") as? String
        transactionId = aDecoder.decodeObject(forKey: "transaction_id") as? String
        transactionMethod = aDecoder.decodeObject(forKey: "transaction_method") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if currencyCode != nil{
            aCoder.encode(currencyCode, forKey: "currency_code")
        }
        if bookingno != nil{
                   aCoder.encode(bookingno, forKey: "bookingno")
               }
        if currencySymbol != nil{
            aCoder.encode(currencySymbol, forKey: "currency_symbol")
        }
        if dateadded != nil{
            aCoder.encode(dateadded, forKey: "dateadded")
        }
        if transactionId != nil{
            aCoder.encode(transactionId, forKey: "transaction_id")
        }
        if transactionMethod != nil{
            aCoder.encode(transactionMethod, forKey: "transaction_method")
        }
    }
}
