//
//  CancellationAboutYou.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 2, 2019

import Foundation


class CancellationAboutYou : NSObject, NSCoding{
    
    var bookingNo : String!
    var cancelId : String!
    var createdDate : String!
    var message : String!
    var propertyName : String!
    var reviewEmail : String!
    var status : String!
    var userImage : String!
    var userName : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookingNo = dictionary["booking_no"] as? String ?? ""
        cancelId = dictionary["cancel_id"] as? String ?? ""
        createdDate = dictionary["created_date"] as? String ?? ""
        message = dictionary["message"] as? String ?? ""
        propertyName = dictionary["property_name"] as? String ?? ""
        reviewEmail = dictionary["review_email"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        userImage = dictionary["user_image"] as? String ?? ""
        userName = dictionary["host_name"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bookingNo != nil{
            dictionary["booking_no"] = bookingNo
        }
        if cancelId != nil{
            dictionary["cancel_id"] = cancelId
        }
        if createdDate != nil{
            dictionary["created_date"] = createdDate
        }
        if message != nil{
            dictionary["message"] = message
        }
        if propertyName != nil{
            dictionary["property_name"] = propertyName
        }
        if reviewEmail != nil{
            dictionary["review_email"] = reviewEmail
        }
        if status != nil{
            dictionary["status"] = status
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        if userName != nil{
            dictionary["host_name"] = userName
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookingNo = aDecoder.decodeObject(forKey: "booking_no") as? String ?? ""
        cancelId = aDecoder.decodeObject(forKey: "cancel_id") as? String ?? ""
        createdDate = aDecoder.decodeObject(forKey: "created_date") as? String ?? ""
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        propertyName = aDecoder.decodeObject(forKey: "property_name") as? String ?? ""
        reviewEmail = aDecoder.decodeObject(forKey: "review_email") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String ?? ""
        userName = aDecoder.decodeObject(forKey: "host_name") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bookingNo != nil{
            aCoder.encode(bookingNo, forKey: "booking_no")
        }
        if cancelId != nil{
            aCoder.encode(cancelId, forKey: "cancel_id")
        }
        if createdDate != nil{
            aCoder.encode(createdDate, forKey: "created_date")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if propertyName != nil{
            aCoder.encode(propertyName, forKey: "property_name")
        }
        if reviewEmail != nil{
            aCoder.encode(reviewEmail, forKey: "review_email")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "host_name")
        }
    }
}
