//
//  RentDe.swift
//  HomeStay
//
//  Created by pofiapple10 on 07/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation


class RentDe : NSObject, NSCoding {
    
   
    var cancel_policy_desc : String!
    var sec_dep_desc : String!
    var ren_meta_title : String!
    var ren_tax : String!
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
       
        cancel_policy_desc = dictionary["cancel_policy_desc"] as? String ?? ""
        sec_dep_desc = dictionary["sec_dep_desc"] as? String ?? ""
        ren_meta_title = dictionary["ren_meta_title"] as? String ?? ""
        ren_tax = dictionary["ren_tax"] as? String ?? ""
        
        
       
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        
        
        if cancel_policy_desc != nil{
            dictionary["cancel_policy_desc"] = cancel_policy_desc
        }
        if sec_dep_desc != nil{
            dictionary["sec_dep_desc"] = sec_dep_desc
        }
        if ren_meta_title != nil{
            dictionary["ren_meta_title"] = ren_meta_title
        }
        if ren_tax != nil{
            dictionary["ren_tax"] = ren_tax
        }
            
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        
        
        cancel_policy_desc = aDecoder.decodeObject(forKey: "cancel_policy_desc") as? String ?? ""
        sec_dep_desc = aDecoder.decodeObject(forKey: "sec_dep_desc") as? String ?? ""
        ren_meta_title = aDecoder.decodeObject(forKey: "ren_meta_title") as? String ?? ""
        ren_tax = aDecoder.decodeObject(forKey: "ren_tax") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        

        
       
        if cancel_policy_desc != nil{
            aCoder.encode(cancel_policy_desc, forKey: "cancel_policy_desc")
        }
        if sec_dep_desc != nil{
            aCoder.encode(ren_tax, forKey: "ren_tax")
        }
        if ren_meta_title != nil{
            aCoder.encode(ren_meta_title, forKey: "ren_meta_title")
        }
        if ren_tax != nil{
            aCoder.encode(ren_tax, forKey: "ren_tax")
        }
    }
    
    
    
    
}
