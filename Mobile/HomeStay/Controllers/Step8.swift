//
//  Step8.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class Step8 : NSObject, NSCoding{

    var address : String = ""
    var city : String = ""
    var country : String = ""
    var lat : String = ""
    var longField : String = ""
    var propertyid : Int = 0
    var state : String = ""
    var stepCompleted : Bool = false 
    var street : String = ""
    var zip : String = ""
    
    var location_id : Int = 0
    var status : Int = 0
    var street_address : String = ""
    var zip_code : String = ""
    var latitude : String = ""
    var longitude : String = ""

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        address = dictionary["address"] as? String ?? ""
        city = dictionary["city"] as? String ?? ""
        country = dictionary["country"] as? String ?? ""
        lat = dictionary["lat"] as? String ?? ""
        longField = dictionary["long"] as? String ?? ""
        propertyid = dictionary["propertyid"] as? Int ?? 0
        state = dictionary["state"] as? String ?? ""
        stepCompleted = dictionary["step_completed"] as? Bool ?? false
        street = dictionary["street"] as? String ?? ""
        zip = dictionary["zip"] as? String ?? ""
        location_id = dictionary["location_id"] as? Int ?? 0
        status = dictionary["status"] as? Int ?? 0
        street_address = dictionary["street_address"] as? String ?? ""
        zip_code = dictionary["zip_code"] as? String ?? ""
        latitude = dictionary["latitude"] as? String ?? ""
        longitude = dictionary["longitude"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if city != nil{
            dictionary["city"] = city
        }
        if country != nil{
            dictionary["country"] = country
        }
        if lat != nil{
            dictionary["lat"] = lat
        }
        if longField != nil{
            dictionary["long"] = longField
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if state != nil{
            dictionary["state"] = state
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if street != nil{
            dictionary["street"] = street
        }
        if zip != nil{
            dictionary["zip"] = zip
        }
        if location_id != nil{
            dictionary["location_id"] = location_id
        }
        if status != nil{
            dictionary["status"] = status
        }
        if street_address != nil{
            dictionary["street_address"] = street_address
        }
        if zip_code != nil{
            dictionary["zip_code"] = zip_code
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        address = aDecoder.decodeObject(forKey: "address") as? String ?? ""
        city = aDecoder.decodeObject(forKey: "city") as? String ?? ""
        country = aDecoder.decodeObject(forKey: "country") as? String ?? ""
        lat = aDecoder.decodeObject(forKey: "lat") as? String ?? ""
        longField = aDecoder.decodeObject(forKey: "long") as? String ?? ""
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        state = aDecoder.decodeObject(forKey: "state") as? String ?? ""
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
        street = aDecoder.decodeObject(forKey: "street") as? String ?? ""
        zip = aDecoder.decodeObject(forKey: "zip") as? String ?? ""
        location_id = aDecoder.decodeObject(forKey: "location_id") as? Int ?? 0
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        street_address = aDecoder.decodeObject(forKey: "street_address") as? String ?? ""
        zip_code = aDecoder.decodeObject(forKey: "zip_code") as? String ?? ""
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if longField != nil{
            aCoder.encode(longField, forKey: "long")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if street != nil{
            aCoder.encode(street, forKey: "street")
        }
        if zip != nil{
            aCoder.encode(zip, forKey: "zip")
        }
        
        if location_id != nil{
            aCoder.encode(location_id, forKey: "location_id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if street_address != nil{
            aCoder.encode(street_address, forKey: "street_address")
        }
        if zip_code != nil{
            aCoder.encode(zip_code, forKey: "zip_code")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
    }
}

