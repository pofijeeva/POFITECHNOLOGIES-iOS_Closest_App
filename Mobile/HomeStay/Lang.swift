//
//  Lang.swift
//  HomeStay
//
//  Created by pofiapple10 on 07/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation

class Lang : NSObject, NSCoding{
   
    
   
    var ar : RentDe!
    var en : RentDe!
    
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        if let k1 = dictionary["ar"] as? [String:Any]{
                    ar = RentDe(fromDictionary: k1)
                }
        
        if let k1 = dictionary["en"] as? [String:Any]{
            en = RentDe(fromDictionary: k1)
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
        ar = aDecoder.decodeObject(forKey: "ar") as? RentDe
        
        en = aDecoder.decodeObject(forKey: "en") as? RentDe
        
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
