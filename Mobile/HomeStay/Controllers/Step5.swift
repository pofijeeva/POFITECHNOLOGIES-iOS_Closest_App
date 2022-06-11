//
//  Step5.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Step5 : NSObject, NSCoding{

    var productImage : [ProductImage]!
    var propertyid : Int = 0
    var stepCompleted : Bool = false 
    var photos : PhotosAdded!
    
    var doc_verified_status: Bool = false 
    var document: String = ""
    var photo_list : [ProductImage]!
        
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        propertyid = dictionary["propertyid"] as? Int ?? 0
        stepCompleted = dictionary["step_completed"] as? Bool ?? false
        productImage = [ProductImage]()
        if let productImageArray = dictionary["product_image"] as? [[String:Any]]{
            for dic in productImageArray{
                let value = ProductImage(fromDictionary: dic)
                productImage.append(value)
            }
        }
        
        doc_verified_status = dictionary["doc_verified_status"] as? Bool ?? false
        document = dictionary["document"] as? String ?? ""
        photo_list = [ProductImage]()
        if let productImageArray = dictionary["photo_list"] as? [[String:Any]]{
            for dic in productImageArray{
                let value = ProductImage(fromDictionary: dic)
                photo_list.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if productImage != nil{
            var dictionaryElements = [[String:Any]]()
            for productImageElement in productImage {
                dictionaryElements.append(productImageElement.toDictionary())
            }
            dictionary["productImage"] = dictionaryElements
        }
        
        if doc_verified_status != nil{
            dictionary["doc_verified_status"] = doc_verified_status
        }
        if document != nil{
            dictionary["document"] = document
        }
        if photo_list != nil{
            var dictionaryElements = [[String:Any]]()
            for productImageElement in photo_list {
                dictionaryElements.append(productImageElement.toDictionary())
            }
            dictionary["photo_list"] = dictionaryElements
        }
         
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        productImage = aDecoder.decodeObject(forKey: "product_image") as? [ProductImage]
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
        
        doc_verified_status = aDecoder.decodeObject(forKey: "doc_verified_status") as? Bool ?? false
        document = aDecoder.decodeObject(forKey: "document") as? String ?? ""
        photo_list = aDecoder.decodeObject(forKey: "photo_list") as? [ProductImage]
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
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        
        if doc_verified_status != nil{
            aCoder.encode(doc_verified_status, forKey: "doc_verified_status")
        }
        if document != nil{
            aCoder.encode(document, forKey: "document")
        }
        if photo_list != nil{
            aCoder.encode(photo_list, forKey: "photo_list")
        }         
    }
}
