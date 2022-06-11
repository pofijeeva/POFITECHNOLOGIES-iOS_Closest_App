//
//  HomePageDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 31, 2018

import Foundation


class HomePageDetail : NSObject, NSCoding{

    var citythumb : String = ""
    var imageUrl : String = ""
    var name : String = ""
    var overAllUnreadCount : Int = 0
    var propertyUrl : String = ""
    var no_of_listing : Int = 0
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        citythumb = dictionary["citythumb"] as? String ?? ""
        imageUrl = dictionary["fav_city_image"] as? String ?? ""
        name = dictionary["fav_city_name"] as? String ?? ""
        overAllUnreadCount = dictionary["overAll_unread_count"] as? Int ?? 0
         no_of_listing = dictionary["no_of_listing"] as? Int ?? 0
        propertyUrl = dictionary["property_url"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if citythumb != nil{
            dictionary["citythumb"] = citythumb
        }
        if imageUrl != nil{
            dictionary["fav_city_image"] = imageUrl
        }
        if name != nil{
            dictionary["fav_city_name"] = name
        }
        if no_of_listing != nil{
            dictionary["no_of_listing"] = no_of_listing
        }
        if overAllUnreadCount != nil{
                   dictionary["overAll_unread_count"] = overAllUnreadCount
               }
        if propertyUrl != nil{
            dictionary["property_url"] = propertyUrl
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        citythumb = aDecoder.decodeObject(forKey: "citythumb") as? String ?? ""
        imageUrl = aDecoder.decodeObject(forKey: "fav_city_image") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "fav_city_name") as? String ?? ""
        overAllUnreadCount = aDecoder.decodeObject(forKey: "overAll_unread_count") as? Int ?? 0
         no_of_listing = aDecoder.decodeObject(forKey: "no_of_listing") as? Int ?? 0
        propertyUrl = aDecoder.decodeObject(forKey: "property_url") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if citythumb != nil{
            aCoder.encode(citythumb, forKey: "citythumb")
        }
        if imageUrl != nil{
            aCoder.encode(imageUrl, forKey: "fav_city_image")
        }
        if name != nil{
            aCoder.encode(name, forKey: "fav_city_name")
        }
        if overAllUnreadCount != nil{
            aCoder.encode(overAllUnreadCount, forKey: "overAll_unread_count")
        }
        
        if no_of_listing != nil{
                  aCoder.encode(no_of_listing, forKey: "no_of_listing")
              }
        if propertyUrl != nil{
            aCoder.encode(propertyUrl, forKey: "property_url")
        }
    }
}
