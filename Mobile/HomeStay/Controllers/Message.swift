//
//  Message.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation


class Message : NSObject, NSCoding{

    var id : String!
    var isHostRead : Bool!
    var isReceiverRead : Bool!
    var isSubject : Bool!
    var message : String!
    var messageBy : String!
    var serverTime : String!
    var userImage : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["Id"] as? String
        isHostRead = dictionary["is_host_read"] as? Bool
        isReceiverRead = dictionary["is_receiver_read"] as? Bool
        isSubject = dictionary["is_subject"] as? Bool
        message = dictionary["message"] as? String
        messageBy = dictionary["message_by"] as? String
        serverTime = dictionary["server_time"] as? String
        userImage = dictionary["user_image"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["Id"] = id
        }
        if isHostRead != nil{
            dictionary["is_host_read"] = isHostRead
        }
        if isReceiverRead != nil{
            dictionary["is_receiver_read"] = isReceiverRead
        }
        if isSubject != nil{
            dictionary["is_subject"] = isSubject
        }
        if message != nil{
            dictionary["message"] = message
        }
        if messageBy != nil{
            dictionary["message_by"] = messageBy
        }
        if serverTime != nil{
            dictionary["server_time"] = serverTime
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
        id = aDecoder.decodeObject(forKey: "Id") as? String
        isHostRead = aDecoder.decodeObject(forKey: "is_host_read") as? Bool
        isReceiverRead = aDecoder.decodeObject(forKey: "is_receiver_read") as? Bool
        isSubject = aDecoder.decodeObject(forKey: "is_subject") as? Bool
        message = aDecoder.decodeObject(forKey: "message") as? String
        messageBy = aDecoder.decodeObject(forKey: "message_by") as? String
        serverTime = aDecoder.decodeObject(forKey: "server_time") as? String
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "Id")
        }
        if isHostRead != nil{
            aCoder.encode(isHostRead, forKey: "is_host_read")
        }
        if isReceiverRead != nil{
            aCoder.encode(isReceiverRead, forKey: "is_receiver_read")
        }
        if isSubject != nil{
            aCoder.encode(isSubject, forKey: "is_subject")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if messageBy != nil{
            aCoder.encode(messageBy, forKey: "message_by")
        }
        if serverTime != nil{
            aCoder.encode(serverTime, forKey: "server_time")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
    }
}