//
//  Option.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 7, 2019

import Foundation


class OptionsNew : NSObject, NSCoding{

    var childId : Int!
    var childImage : String!
    var childName : String!
    var parentId : Int!
    var parentName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        childId = dictionary["child_id"] as? Int
        childImage = dictionary["child_image"] as? String
        childName = dictionary["child_name"] as? String
        parentId = dictionary["parent_id"] as? Int
        parentName = dictionary["parent_name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if childId != nil{
            dictionary["child_id"] = childId
        }
        if childImage != nil{
            dictionary["child_image"] = childImage
        }
        if childName != nil{
            dictionary["child_name"] = childName
        }
        if parentId != nil{
            dictionary["parent_id"] = parentId
        }
        if parentName != nil{
            dictionary["parent_name"] = parentName
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        childId = aDecoder.decodeObject(forKey: "child_id") as? Int
        childImage = aDecoder.decodeObject(forKey: "child_image") as? String
        childName = aDecoder.decodeObject(forKey: "child_name") as? String
        parentId = aDecoder.decodeObject(forKey: "parent_id") as? Int
        parentName = aDecoder.decodeObject(forKey: "parent_name") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if childId != nil{
            aCoder.encode(childId, forKey: "child_id")
        }
        if childImage != nil{
            aCoder.encode(childImage, forKey: "child_image")
        }
        if childName != nil{
            aCoder.encode(childName, forKey: "child_name")
        }
        if parentId != nil{
            aCoder.encode(parentId, forKey: "parent_id")
        }
        if parentName != nil{
            aCoder.encode(parentName, forKey: "parent_name")
        }
    }
}
