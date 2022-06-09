//
//  InboxConversationModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation


class InboxConversationModel : NSObject, NSCoding{

    var approval : String!
    var bookingId : String!
    var checkin : String!
    var checkout : String!
    var hostId : String!
    var hostImage : String!
    var hostName : String!
    var memberFrom : String!
    var message : String!
    var messages : [Message]!
    var noOfGuest : String!
    var propertyCurrencyCode : String!
    var propertyId : String!
    var propertyName : String!
    var requesterId : String!
    var requesterImage : String!
    var requesterName : String!
    var status : Int!
    var totalAmount : Float!
    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        approval = dictionary["approval"] as? String
        bookingId = dictionary["booking_id"] as? String
        checkin = dictionary["checkin"] as? String
        checkout = dictionary["checkout"] as? String
        hostId = dictionary["host_id"] as? String
        hostImage = dictionary["host_image"] as? String
        hostName = dictionary["host_name"] as? String
        memberFrom = dictionary["member_from"] as? String
        message = dictionary["message"] as? String
        noOfGuest = dictionary["no_of_guest"] as? String
        propertyCurrencyCode = dictionary["property_currency_code"] as? String
        propertyId = dictionary["property_id"] as? String
        propertyName = dictionary["property_name"] as? String
        requesterId = dictionary["requester_id"] as? String
        requesterImage = dictionary["requester_image"] as? String
        requesterName = dictionary["requester_name"] as? String
        status = dictionary["status"] as? Int
        totalAmount = dictionary["total_amount"] as? Float
        messages = [Message]()
        if let messagesArray = dictionary["messages"] as? [[String:Any]]{
            for dic in messagesArray{
                let value = Message(fromDictionary: dic)
                messages.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if approval != nil{
            dictionary["approval"] = approval
        }
        if bookingId != nil{
            dictionary["booking_id"] = bookingId
        }
        if checkin != nil{
            dictionary["checkin"] = checkin
        }
        if checkout != nil{
            dictionary["checkout"] = checkout
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if hostImage != nil{
            dictionary["host_image"] = hostImage
        }
        if hostName != nil{
            dictionary["host_name"] = hostName
        }
        if memberFrom != nil{
            dictionary["member_from"] = memberFrom
        }
        if message != nil{
            dictionary["message"] = message
        }
        if noOfGuest != nil{
            dictionary["no_of_guest"] = noOfGuest
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if propertyName != nil{
            dictionary["property_name"] = propertyName
        }
        if requesterId != nil{
            dictionary["requester_id"] = requesterId
        }
        if requesterImage != nil{
            dictionary["requester_image"] = requesterImage
        }
        if requesterName != nil{
            dictionary["requester_name"] = requesterName
        }
        if status != nil{
            dictionary["status"] = status
        }
        if totalAmount != nil{
            dictionary["total_amount"] = totalAmount
        }
        if messages != nil{
            var dictionaryElements = [[String:Any]]()
            for messagesElement in messages {
                dictionaryElements.append(messagesElement.toDictionary())
            }
            dictionary["messages"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        approval = aDecoder.decodeObject(forKey: "approval") as? String
        bookingId = aDecoder.decodeObject(forKey: "booking_id") as? String
        checkin = aDecoder.decodeObject(forKey: "checkin") as? String
        checkout = aDecoder.decodeObject(forKey: "checkout") as? String
        hostId = aDecoder.decodeObject(forKey: "host_id") as? String
        hostImage = aDecoder.decodeObject(forKey: "host_image") as? String
        hostName = aDecoder.decodeObject(forKey: "host_name") as? String
        memberFrom = aDecoder.decodeObject(forKey: "member_from") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        messages = aDecoder.decodeObject(forKey: "messages") as? [Message]
        noOfGuest = aDecoder.decodeObject(forKey: "no_of_guest") as? String
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? String
        propertyName = aDecoder.decodeObject(forKey: "property_name") as? String
        requesterId = aDecoder.decodeObject(forKey: "requester_id") as? String
        requesterImage = aDecoder.decodeObject(forKey: "requester_image") as? String
        requesterName = aDecoder.decodeObject(forKey: "requester_name") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        totalAmount = aDecoder.decodeObject(forKey: "total_amount") as? Float
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if approval != nil{
            aCoder.encode(approval, forKey: "approval")
        }
        if bookingId != nil{
            aCoder.encode(bookingId, forKey: "booking_id")
        }
        if checkin != nil{
            aCoder.encode(checkin, forKey: "checkin")
        }
        if checkout != nil{
            aCoder.encode(checkout, forKey: "checkout")
        }
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if hostImage != nil{
            aCoder.encode(hostImage, forKey: "host_image")
        }
        if hostName != nil{
            aCoder.encode(hostName, forKey: "host_name")
        }
        if memberFrom != nil{
            aCoder.encode(memberFrom, forKey: "member_from")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if messages != nil{
            aCoder.encode(messages, forKey: "messages")
        }
        if noOfGuest != nil{
            aCoder.encode(noOfGuest, forKey: "no_of_guest")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if propertyName != nil{
            aCoder.encode(propertyName, forKey: "property_name")
        }
        if requesterId != nil{
            aCoder.encode(requesterId, forKey: "requester_id")
        }
        if requesterImage != nil{
            aCoder.encode(requesterImage, forKey: "requester_image")
        }
        if requesterName != nil{
            aCoder.encode(requesterName, forKey: "requester_name")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if totalAmount != nil{
            aCoder.encode(totalAmount, forKey: "total_amount")
        }
    }
}
