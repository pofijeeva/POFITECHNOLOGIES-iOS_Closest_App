//
//  DisputeByYou.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 21, 2019

import Foundation


class DisputeByYou : NSObject, NSCoding{
    
    var bookingNo : String!
    var createdDate : String!
    var disputeId : String!
    var hostName : String!
    var message : String!
    var rentalName : String!
    var reviewEmail : String!
    var status : String!
    var userImage : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookingNo = dictionary["booking_no"] as? String ?? ""
        createdDate = dictionary["created_date"] as? String ?? ""
        disputeId = dictionary["dispute_id"] as? String ?? ""
        hostName = dictionary["host_name"] as? String ?? ""
        message = dictionary["message"] as? String ?? ""
        rentalName = dictionary["rental_name"] as? String ?? ""
        reviewEmail = dictionary["review_email"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        userImage = dictionary["user_image"] as? String ?? ""
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
        if createdDate != nil{
            dictionary["created_date"] = createdDate
        }
        if disputeId != nil{
            dictionary["dispute_id"] = disputeId
        }
        if hostName != nil{
            dictionary["host_name"] = hostName
        }
        if message != nil{
            dictionary["message"] = message
        }
        if rentalName != nil{
            dictionary["rental_name"] = rentalName
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
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookingNo = aDecoder.decodeObject(forKey: "booking_no") as? String ?? ""
        createdDate = aDecoder.decodeObject(forKey: "created_date") as? String ?? ""
        disputeId = aDecoder.decodeObject(forKey: "dispute_id") as? String ?? ""
        hostName = aDecoder.decodeObject(forKey: "host_name") as? String ?? ""
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        rentalName = aDecoder.decodeObject(forKey: "rental_name") as? String ?? ""
        reviewEmail = aDecoder.decodeObject(forKey: "review_email") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String ?? ""
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
        if createdDate != nil{
            aCoder.encode(createdDate, forKey: "created_date")
        }
        if disputeId != nil{
            aCoder.encode(disputeId, forKey: "dispute_id")
        }
        if hostName != nil{
            aCoder.encode(hostName, forKey: "host_name")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if rentalName != nil{
            aCoder.encode(rentalName, forKey: "rental_name")
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
    }
}
