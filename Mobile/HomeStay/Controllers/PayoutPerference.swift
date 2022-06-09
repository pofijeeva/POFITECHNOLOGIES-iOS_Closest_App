//
//  PayoutPerference.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class PayoutPerference : NSObject, NSCoding{

    var accname : String!
    var accno : String!
    var bankname : String!
    var paypalEmail : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accname = dictionary["accname"] as? String
        accno = dictionary["accno"] as? String
        bankname = dictionary["bankname"] as? String
        paypalEmail = dictionary["paypal_email"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accname != nil{
            dictionary["accname"] = accname
        }
        if accno != nil{
            dictionary["accno"] = accno
        }
        if bankname != nil{
            dictionary["bankname"] = bankname
        }
        if paypalEmail != nil{
                   dictionary["paypal_email"] = paypalEmail
               }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accname = aDecoder.decodeObject(forKey: "accname") as? String
        accno = aDecoder.decodeObject(forKey: "accno") as? String
        bankname = aDecoder.decodeObject(forKey: "bankname") as? String
         paypalEmail = aDecoder.decodeObject(forKey: "paypal_email") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accname != nil{
            aCoder.encode(accname, forKey: "accname")
        }
        if accno != nil{
            aCoder.encode(accno, forKey: "accno")
        }
        if bankname != nil{
            aCoder.encode(bankname, forKey: "bankname")
        }
        if paypalEmail != nil{
                   aCoder.encode(paypalEmail, forKey: "paypal_email")
               }
    }
}
