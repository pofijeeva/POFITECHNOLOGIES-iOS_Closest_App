//
//  Notification.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class Notification : NSObject, NSCoding{

    var emailNotifications : String!
    var reservationRequest : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        emailNotifications = dictionary["email_notifications"] as? String ?? ""
        reservationRequest = dictionary["reservation_request"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if emailNotifications != nil{
            dictionary["email_notifications"] = emailNotifications
        }
        if reservationRequest != nil{
            dictionary["reservation_request"] = reservationRequest
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        emailNotifications = aDecoder.decodeObject(forKey: "email_notifications") as? String ?? ""
        reservationRequest = aDecoder.decodeObject(forKey: "reservation_request") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if emailNotifications != nil{
            aCoder.encode(emailNotifications, forKey: "email_notifications")
        }
        if reservationRequest != nil{
            aCoder.encode(reservationRequest, forKey: "reservation_request")
        }
    }
}
