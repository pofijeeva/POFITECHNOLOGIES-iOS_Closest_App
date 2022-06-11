//
//  UserDetailModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 10, 2018

import Foundation


class UserDetailModel : NSObject, NSCoding{

    var activeRentals : [ActiveRental]!
    var image : String = ""
    var pageId : String = ""
    var userDetails : UserDetail!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        image = dictionary["image"] as? String ?? ""
        pageId = dictionary["pageId"] as? String ?? ""
        if let userDetailsData = dictionary["userDetails"] as? [String:Any]{
            userDetails = UserDetail(fromDictionary: userDetailsData)
        }
        activeRentals = [ActiveRental]()
        if let activeRentalsArray = dictionary["Active_rentals"] as? [[String:Any]]{
            for dic in activeRentalsArray{
                let value = ActiveRental(fromDictionary: dic)
                activeRentals.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if image != nil{
            dictionary["image"] = image
        }
        if pageId != nil{
            dictionary["pageId"] = pageId
        }
        if userDetails != nil{
            dictionary["userDetails"] = userDetails.toDictionary()
        }
        if activeRentals != nil{
            var dictionaryElements = [[String:Any]]()
            for activeRentalsElement in activeRentals {
                dictionaryElements.append(activeRentalsElement.toDictionary())
            }
            dictionary["activeRentals"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        activeRentals = aDecoder.decodeObject(forKey: "Active_rentals") as? [ActiveRental]
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        pageId = aDecoder.decodeObject(forKey: "pageId") as? String ?? ""
        userDetails = aDecoder.decodeObject(forKey: "userDetails") as? UserDetail
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if activeRentals != nil{
            aCoder.encode(activeRentals, forKey: "Active_rentals")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if pageId != nil{
            aCoder.encode(pageId, forKey: "pageId")
        }
        if userDetails != nil{
            aCoder.encode(userDetails, forKey: "userDetails")
        }
    }
}
