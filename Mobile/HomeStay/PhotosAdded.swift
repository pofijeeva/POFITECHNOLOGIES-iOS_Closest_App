//
//  PhotosAdded.swift
//  HomeStay
//
//  Created by pofiapple10 on 09/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation

class PhotosAdded : NSObject, NSCoding{
   
    
   
    var photo_list : Addphotos!
    
    
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        if let n1 = dictionary["photo_list"] as? [String:Any]{
            photo_list = Addphotos(fromDictionary: n1)
                }
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        
        if photo_list != nil{
                    dictionary["photo_list"] = photo_list.toDictionary()
                }
      
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        photo_list = aDecoder.decodeObject(forKey: "photo_list") as? Addphotos
        
        
        
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        
        if photo_list != nil{
                    aCoder.encode(photo_list, forKey: "photo_list")
                }
        
        
     
    }
}
