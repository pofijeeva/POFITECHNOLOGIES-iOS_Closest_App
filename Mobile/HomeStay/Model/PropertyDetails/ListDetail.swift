//
//  ListDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class ListDetail : NSObject, NSCoding{

    var listImage : String!
    var listName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        listImage = dictionary["list_image"] as? String ?? ""
        listName = dictionary["list_name"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if listImage != nil{
            dictionary["list_image"] = listImage
        }
        if listName != nil{
            dictionary["list_name"] = listName
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        listImage = aDecoder.decodeObject(forKey: "list_image") as? String ?? ""
        listName = aDecoder.decodeObject(forKey: "list_name") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if listImage != nil{
            aCoder.encode(listImage, forKey: "list_image")
        }
        if listName != nil{
            aCoder.encode(listName, forKey: "list_name")
        }
    }
}
