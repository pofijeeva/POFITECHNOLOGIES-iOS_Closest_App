//
//  YourTripModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 3, 2018

import Foundation


class YourTripModel : NSObject, NSCoding{

    var message : String!
    var mytrips : [Mytrip]!
    var status : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        mytrips = [Mytrip]()
        if let mytripsArray = dictionary["mytrips"] as? [[String:Any]]{
            for dic in mytripsArray{
                let value = Mytrip(fromDictionary: dic)
                mytrips.append(value)
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
        if mytrips != nil{
            var dictionaryElements = [[String:Any]]()
            for mytripsElement in mytrips {
                dictionaryElements.append(mytripsElement.toDictionary())
            }
            dictionary["mytrips"] = dictionaryElements
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
        mytrips = aDecoder.decodeObject(forKey: "mytrips") as? [Mytrip]
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
        if mytrips != nil{
            aCoder.encode(mytrips, forKey: "mytrips")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
