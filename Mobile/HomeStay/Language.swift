//
//  Language.swift
//  HomeStay
//
//  Created by pofiapple10 on 08/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation

class Language : NSObject, NSCoding{
   
    
   
    var ar : Rentdetails!
    var en : Rentdetails!
    
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        if let l1 = dictionary["ar"] as? [String:Any]{
                    ar = Rentdetails(fromDictionary: l1)
                }
        
        if let l1 = dictionary["en"] as? [String:Any]{
            en = Rentdetails(fromDictionary: l1)
                }
        
        
       
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if ar != nil{
                    dictionary["ar"] = ar.toDictionary()
                }
        if en != nil{
                    dictionary["en"] = ar.toDictionary()
                }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        ar = aDecoder.decodeObject(forKey: "ar") as? Rentdetails
        
        en = aDecoder.decodeObject(forKey: "en") as? Rentdetails
        
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        
        if ar != nil{
                    aCoder.encode(ar, forKey: "ar")
                }
        
        if en != nil{
                    aCoder.encode(en, forKey: "en")
                }
     
    }
}
