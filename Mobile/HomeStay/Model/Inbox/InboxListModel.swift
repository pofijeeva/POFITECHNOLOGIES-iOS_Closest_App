//
//  InboxListModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 4, 2018

import Foundation


class InboxListModel : NSObject, NSCoding{

    var message : String = ""
    var messageValues : [MessageValue]!
    var status : Int = 0


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        messageValues = [MessageValue]()
        if let messageValuesArray = dictionary["message_values"] as? [[String:Any]]{
            for dic in messageValuesArray{
                let value = MessageValue(fromDictionary: dic)
                messageValues.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if messageValues != nil{
            var dictionaryElements = [[String:Any]]()
            for messageValuesElement in messageValues {
                dictionaryElements.append(messageValuesElement.toDictionary())
            }
            dictionary["messageValues"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        messageValues = aDecoder.decodeObject(forKey: "message_values") as? [MessageValue]
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if messageValues != nil{
            aCoder.encode(messageValues, forKey: "message_values")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
