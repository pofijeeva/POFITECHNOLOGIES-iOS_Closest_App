//
//  Rentdetails.swift
//  HomeStay
//
//  Created by pofiapple10 on 08/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation


class Rentdetails : NSObject, NSCoding{
   
    
   
    var ren_guest_axes : String!
    var ren_house_rule : String!
    var ren_other_things : String!
    var ren_space : String!
    var ren_summary : String!
    var ren_title : String!
    var ren_meta_title : String!
    var ren_meta_keyword : String!
    var ren_meta_desc : String!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        ren_guest_axes = dictionary["ren_guest_axes"] as? String
        ren_house_rule = dictionary["ren_house_rule"] as? String
        ren_other_things = dictionary["ren_other_things"] as? String
        ren_space = dictionary["ren_space"] as? String
        ren_summary = dictionary["ren_summary"] as? String
        ren_title = dictionary["ren_title"] as? String
        ren_meta_title = dictionary["ren_meta_title"] as? String
        ren_meta_keyword = dictionary["ren_meta_keyword"] as? String
        ren_meta_desc = dictionary["ren_meta_desc"] as? String
        
        
       
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if ren_guest_axes != nil{
            dictionary["ren_guest_axes"] = ren_guest_axes
        }
        if ren_house_rule != nil{
            dictionary["ren_house_rule"] = ren_house_rule
        }
        if ren_other_things != nil{
            dictionary["ren_other_things"] = ren_other_things
        }
        if ren_space != nil{
            dictionary["ren_space"] = ren_space
        }
        if ren_summary != nil{
            dictionary["ren_summary"] = ren_summary
        }
        if ren_title != nil{
            dictionary["ren_title"] = ren_title
        }
        
        if ren_meta_title != nil{
            dictionary["ren_meta_title"] = ren_meta_title
        }
        if ren_meta_keyword != nil{
            dictionary["ren_meta_keyword"] = ren_meta_keyword
        }
        if ren_meta_desc != nil{
            dictionary["ren_meta_desc"] = ren_meta_desc
        }
            
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        ren_guest_axes = aDecoder.decodeObject(forKey: "ren_guest_axes") as? String
        ren_house_rule = aDecoder.decodeObject(forKey: "ren_house_rule") as? String
        ren_other_things = aDecoder.decodeObject(forKey: "ren_other_things") as? String
        ren_space = aDecoder.decodeObject(forKey: "ren_space") as? String
        ren_summary = aDecoder.decodeObject(forKey: "ren_summary") as? String
        ren_title = aDecoder.decodeObject(forKey: "ren_title") as? String
        ren_meta_title = aDecoder.decodeObject(forKey: "ren_meta_title") as? String
        ren_meta_keyword = aDecoder.decodeObject(forKey: "ren_meta_keyword") as? String
        ren_meta_desc = aDecoder.decodeObject(forKey: "ren_meta_desc") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        

        
        if ren_guest_axes != nil{
            aCoder.encode(ren_house_rule, forKey: "ren_guest_axes")
        }
        if ren_house_rule != nil{
            aCoder.encode(ren_house_rule, forKey: "ren_house_rule")
        }
        if ren_other_things != nil{
            aCoder.encode(ren_other_things, forKey: "ren_other_things")
        }
        if ren_space != nil{
            aCoder.encode(ren_space, forKey: "ren_space")
        }
        if ren_summary != nil{
            aCoder.encode(ren_summary, forKey: "ren_summary")
        }
        if ren_title != nil{
            aCoder.encode(ren_title, forKey: "ren_title")
        }
        if ren_meta_title != nil{
            aCoder.encode(ren_meta_title, forKey: "ren_meta_title")
        }
        if ren_meta_keyword != nil{
            aCoder.encode(ren_meta_keyword, forKey: "ren_meta_keyword")
        }
        if ren_meta_desc != nil{
            aCoder.encode(ren_meta_desc, forKey: "ren_meta_desc")
        }
    }
}

