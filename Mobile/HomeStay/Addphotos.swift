//
//  Addphotos.swift
//  HomeStay
//
//  Created by pofiapple10 on 09/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation


class Addphotos : NSObject, NSCoding{
   
    
   
    var doc_verified_status : Int = 0
    var document : String = ""
    var imagePath : String = ""
    var propertyImageId : Int = 0
    
    
    
    
    
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
       
        doc_verified_status = dictionary["doc_verified_status"] as? Int ?? 0
        document = dictionary["document"] as? String ?? ""
        imagePath = dictionary["imagePath"] as? String ?? ""
        propertyImageId = dictionary["propertyImageId"] as? Int ?? 0
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if doc_verified_status != nil{
            dictionary["doc_verified_status"] = doc_verified_status
        }
        if document != nil{
            dictionary["document"] = document
        }
        if imagePath != nil{
            dictionary["imagePath"] = imagePath
        }
        if propertyImageId != nil{
            dictionary["propertyImageId"] = propertyImageId
        }
        
        
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        doc_verified_status = aDecoder.decodeObject(forKey: "doc_verified_status") as? Int ?? 0
        document = aDecoder.decodeObject(forKey: "document") as? String ?? ""
        imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String ?? ""
        propertyImageId = aDecoder.decodeObject(forKey: "propertyImageId") as? Int ?? 0
        
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        

        
        if doc_verified_status != nil{
            aCoder.encode(doc_verified_status, forKey: "doc_verified_status")
        }
        if document != nil{
            aCoder.encode(document, forKey: "document")
        }
        if imagePath != nil{
            aCoder.encode(imagePath, forKey: "imagePath")
        }
        if propertyImageId != nil{
            aCoder.encode(propertyImageId, forKey: "propertyImageId")
        }
        
       
    }
}
