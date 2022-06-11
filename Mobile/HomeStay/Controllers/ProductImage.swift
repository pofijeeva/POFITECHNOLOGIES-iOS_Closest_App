//
//  ProductImage.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class ProductImage : NSObject, NSCoding{

    var productImage : String = ""
    var productImageId : Int = 0
    
    var imagePath : String = ""
    var propertyImageId : Int = 0


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        productImage = dictionary["product_image"] as? String ?? ""
        productImageId = dictionary["product_image_id"] as? Int ?? 0
        
        imagePath = dictionary["imagePath"] as? String ?? ""
        propertyImageId = dictionary["propertyImageId"] as? Int ?? 0
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if productImage != nil{
            dictionary["product_image"] = productImage
        }
        if productImageId != nil{
            dictionary["product_image_id"] = productImageId
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
        productImage = aDecoder.decodeObject(forKey: "product_image") as? String ?? ""
        productImageId = aDecoder.decodeObject(forKey: "product_image_id") as? Int ?? 0
        
        imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String ?? ""
        propertyImageId = aDecoder.decodeObject(forKey: "propertyImageId") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if productImage != nil{
            aCoder.encode(productImage, forKey: "product_image")
        }
        if productImageId != nil{
            aCoder.encode(productImageId, forKey: "product_image_id")
        }
        
        if imagePath != nil{
            aCoder.encode(imagePath, forKey: "imagePath")
        }
        if propertyImageId != nil{
            aCoder.encode(propertyImageId, forKey: "propertyImageId")
        }
    }
}
