//
//  PropertyListingModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2018

import Foundation


class PropertyListingModel : NSObject, NSCoding{

    var message : String!
    var myReservation : [MyReservation]!
    var propertyListing : [PropertyListing]!
    var status : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0 ?? 0
        myReservation = [MyReservation]()
        if let myReservationArray = dictionary["my_reservation"] as? [[String:Any]]{
            for dic in myReservationArray{
                let value = MyReservation(fromDictionary: dic)
                myReservation.append(value)
            }
        }
        propertyListing = [PropertyListing]()
        if let propertyListingArray = dictionary["property_listing"] as? [[String:Any]]{
            for dic in propertyListingArray{
                let value = PropertyListing(fromDictionary: dic)
                propertyListing.append(value)
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
        if myReservation != nil{
            var dictionaryElements = [[String:Any]]()
            for myReservationElement in myReservation {
                dictionaryElements.append(myReservationElement.toDictionary())
            }
            dictionary["myReservation"] = dictionaryElements
        }
        if propertyListing != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyListingElement in propertyListing {
                dictionaryElements.append(propertyListingElement.toDictionary())
            }
            dictionary["propertyListing"] = dictionaryElements
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
        myReservation = aDecoder.decodeObject(forKey: "my_reservation") as? [MyReservation]
        propertyListing = aDecoder.decodeObject(forKey: "property_listing") as? [PropertyListing]
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
        if myReservation != nil{
            aCoder.encode(myReservation, forKey: "my_reservation")
        }
        if propertyListing != nil{
            aCoder.encode(propertyListing, forKey: "property_listing")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
