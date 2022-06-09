//
//  HotelDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 17, 2018

import Foundation


class HotelDetail : NSObject, NSCoding{

    var bathrooms : String!
    var bedrooms : String!
    var hostId : Int!
    var notesDesc : String!
    var notesId : Int!
    var propertyAddress : String!
    var propertyCurrencyCode : String!
    var propertyCurrencySymbol : String!
    var propertyId : Int!
    var propertyImages : [PropertyImage]!
    var propertyPrice : AnyObject!
    var propertyTitle : String!
    var roomType : String!
    var userImage : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        bathrooms = dictionary["bathrooms"] as? String
        bedrooms = dictionary["bedrooms"] as? String
        hostId = dictionary["host_id"] as? Int
        notesDesc = dictionary["notes_desc"] as? String
        notesId = dictionary["notes_id"] as? Int
        propertyAddress = dictionary["property_address"] as? String
        propertyCurrencyCode = dictionary["property_currency_code"] as? String
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String
        propertyId = dictionary["property_id"] as? Int
        propertyPrice = dictionary["property_price"] as? AnyObject
        propertyTitle = dictionary["property_title"] as? String
        roomType = dictionary["room_type"] as? String
        userImage = dictionary["user_image"] as? String
        propertyImages = [PropertyImage]()
        if let propertyImagesArray = dictionary["property_images"] as? [[String:Any]]{
            for dic in propertyImagesArray{
                let value = PropertyImage(fromDictionary: dic)
                propertyImages.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bathrooms != nil{
            dictionary["bathrooms"] = bathrooms
        }
        if bedrooms != nil{
            dictionary["bedrooms"] = bedrooms
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if notesDesc != nil{
            dictionary["notes_desc"] = notesDesc
        }
        if notesId != nil{
            dictionary["notes_id"] = notesId
        }
        if propertyAddress != nil{
            dictionary["property_address"] = propertyAddress
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyCurrencySymbol != nil{
            dictionary["property_currency_symbol"] = propertyCurrencySymbol
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if propertyPrice != nil{
            dictionary["property_price"] = propertyPrice
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if roomType != nil{
            dictionary["room_type"] = roomType
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        if propertyImages != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyImagesElement in propertyImages {
                dictionaryElements.append(propertyImagesElement.toDictionary())
            }
            dictionary["propertyImages"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bathrooms = aDecoder.decodeObject(forKey: "bathrooms") as? String
        bedrooms = aDecoder.decodeObject(forKey: "bedrooms") as? String
        hostId = aDecoder.decodeObject(forKey: "host_id") as? Int
        notesDesc = aDecoder.decodeObject(forKey: "notes_desc") as? String
        notesId = aDecoder.decodeObject(forKey: "notes_id") as? Int
        propertyAddress = aDecoder.decodeObject(forKey: "property_address") as? String
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int
        propertyImages = aDecoder.decodeObject(forKey: "property_images") as? [PropertyImage]
        propertyPrice = aDecoder.decodeObject(forKey: "property_price") as? AnyObject
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String
        roomType = aDecoder.decodeObject(forKey: "room_type") as? String
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bathrooms != nil{
            aCoder.encode(bathrooms, forKey: "bathrooms")
        }
        if bedrooms != nil{
            aCoder.encode(bedrooms, forKey: "bedrooms")
        }
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if notesDesc != nil{
            aCoder.encode(notesDesc, forKey: "notes_desc")
        }
        if notesId != nil{
            aCoder.encode(notesId, forKey: "notes_id")
        }
        if propertyAddress != nil{
            aCoder.encode(propertyAddress, forKey: "property_address")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyCurrencySymbol != nil{
            aCoder.encode(propertyCurrencySymbol, forKey: "property_currency_symbol")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if propertyImages != nil{
            aCoder.encode(propertyImages, forKey: "property_images")
        }
        if propertyPrice != nil{
            aCoder.encode(propertyPrice, forKey: "property_price")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if roomType != nil{
            aCoder.encode(roomType, forKey: "room_type")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
    }
}
