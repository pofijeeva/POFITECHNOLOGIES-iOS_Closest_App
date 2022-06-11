//
//  Privacy.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class Privacy : NSObject, NSCoding{

    var searchByProfile : Bool = false 
    var socialRecommend : Bool = false 


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        searchByProfile = dictionary["search_by_profile"] as? Bool ?? false
        socialRecommend = dictionary["social_recommend"] as? Bool ?? false 
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if searchByProfile != nil{
            dictionary["search_by_profile"] = searchByProfile
        }
        if socialRecommend != nil{
            dictionary["social_recommend"] = socialRecommend
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        searchByProfile = aDecoder.decodeObject(forKey: "search_by_profile") as? Bool ?? false
        socialRecommend = aDecoder.decodeObject(forKey: "social_recommend") as? Bool ?? false
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if searchByProfile != nil{
            aCoder.encode(searchByProfile, forKey: "search_by_profile")
        }
        if socialRecommend != nil{
            aCoder.encode(socialRecommend, forKey: "social_recommend")
        }
    }
}
