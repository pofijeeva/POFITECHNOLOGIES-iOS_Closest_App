//
//  MessageValue.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation


class MessageValue : NSObject, NSCoding{

    var bookingno : String!
    var dateAdded : String!
    var hostMsgreadStatus : String!
    var id : String!
    var message : String!
    var msgRead : String!
    var msgStatus : String!
    var msgUnreadCount : String!
    var propertyId : String!
    var senderName : String!
    var starStatus : String!
    var status : String!
    var subject : String!
    var userImage : String!
    var userMsgreadStatus : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bookingno = dictionary["bookingno"] as? String
        dateAdded = dictionary["dateAdded"] as? String
        hostMsgreadStatus = dictionary["host_msgread_status"] as? String
        id = dictionary["id"] as? String
        message = dictionary["message"] as? String
        msgRead = dictionary["msg_read"] as? String
        msgStatus = dictionary["msg_status"] as? String
        msgUnreadCount = dictionary["msg_unread_count"] as? String
        propertyId = dictionary["property_id"] as? String
        senderName = dictionary["sender_name"] as? String
        starStatus = dictionary["star_status"] as? String
        status = dictionary["status"] as? String
        subject = dictionary["subject"] as? String
        userImage = dictionary["user_image"] as? String
        userMsgreadStatus = dictionary["user_msgread_status"] as? String
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
        if dateAdded != nil{
            dictionary["dateAdded"] = dateAdded
        }
        if hostMsgreadStatus != nil{
            dictionary["host_msgread_status"] = hostMsgreadStatus
        }
        if id != nil{
            dictionary["id"] = id
        }
        if message != nil{
            dictionary["message"] = message
        }
        if msgRead != nil{
            dictionary["msg_read"] = msgRead
        }
        if msgStatus != nil{
            dictionary["msg_status"] = msgStatus
        }
        if msgUnreadCount != nil{
            dictionary["msg_unread_count"] = msgUnreadCount
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if senderName != nil{
            dictionary["sender_name"] = senderName
        }
        if starStatus != nil{
            dictionary["star_status"] = starStatus
        }
        if status != nil{
            dictionary["status"] = status
        }
        if subject != nil{
            dictionary["subject"] = subject
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        if userMsgreadStatus != nil{
            dictionary["user_msgread_status"] = userMsgreadStatus
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bookingno = aDecoder.decodeObject(forKey: "bookingno") as? String
        dateAdded = aDecoder.decodeObject(forKey: "dateAdded") as? String
        hostMsgreadStatus = aDecoder.decodeObject(forKey: "host_msgread_status") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        msgRead = aDecoder.decodeObject(forKey: "msg_read") as? String
        msgStatus = aDecoder.decodeObject(forKey: "msg_status") as? String
        msgUnreadCount = aDecoder.decodeObject(forKey: "msg_unread_count") as? String
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? String
        senderName = aDecoder.decodeObject(forKey: "sender_name") as? String
        starStatus = aDecoder.decodeObject(forKey: "star_status") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        subject = aDecoder.decodeObject(forKey: "subject") as? String
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String
        userMsgreadStatus = aDecoder.decodeObject(forKey: "user_msgread_status") as? String
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
        if dateAdded != nil{
            aCoder.encode(dateAdded, forKey: "dateAdded")
        }
        if hostMsgreadStatus != nil{
            aCoder.encode(hostMsgreadStatus, forKey: "host_msgread_status")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if msgRead != nil{
            aCoder.encode(msgRead, forKey: "msg_read")
        }
        if msgStatus != nil{
            aCoder.encode(msgStatus, forKey: "msg_status")
        }
        if msgUnreadCount != nil{
            aCoder.encode(msgUnreadCount, forKey: "msg_unread_count")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if senderName != nil{
            aCoder.encode(senderName, forKey: "sender_name")
        }
        if starStatus != nil{
            aCoder.encode(starStatus, forKey: "star_status")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if subject != nil{
            aCoder.encode(subject, forKey: "subject")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
        if userMsgreadStatus != nil{
            aCoder.encode(userMsgreadStatus, forKey: "user_msgread_status")
        }
    }
}
