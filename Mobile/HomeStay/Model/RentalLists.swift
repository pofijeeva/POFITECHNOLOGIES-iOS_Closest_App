//
//  RentalList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on February 7, 2019

import Foundation


class RentalLists : NSObject, NSCoding{

    var descriptionField : String = ""
    var homeType : String = ""
    var hostId : Int = 0
    var hostname : String = ""
    var isFavourite : Int = 0
    var latitude : String = ""
    var longitude : String = ""
    var propertyCurrencyCode : String = ""
    var propertyCurrencySymbol : String = ""
    var rentalId : Int = 0
    var rentalImage : String = ""
    var rentalPrice : Int = 0
    var rentalTitle : String = ""
    var userCurrency : String = ""
    var userphoto : String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String ?? ""
        homeType = dictionary["home_type"] as? String ?? ""
        hostId = dictionary["host_id"] as? Int ?? 0
        hostname = dictionary["hostname"] as? String ?? ""
        isFavourite = dictionary["is_favourite"] as? Int ?? 0
        latitude = dictionary["latitude"] as? String ?? ""
        longitude = dictionary["longitude"] as? String ?? ""
        propertyCurrencyCode = dictionary["property_currency_code"] as? String ?? ""
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String ?? ""
        rentalId = dictionary["rental_id"] as? Int ?? 0
        rentalImage = dictionary["rental_image"] as? String ?? ""
        rentalPrice = dictionary["rental_price"] as? Int ?? 0
        rentalTitle = dictionary["rental_title"] as? String ?? ""
        userCurrency = dictionary["user_currency"] as? String ?? ""
        userphoto = dictionary["userphoto"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if homeType != nil{
            dictionary["home_type"] = homeType
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if hostname != nil{
            dictionary["hostname"] = hostname
        }
        if isFavourite != nil{
            dictionary["is_favourite"] = isFavourite
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyCurrencySymbol != nil{
            dictionary["property_currency_symbol"] = propertyCurrencySymbol
        }
        if rentalId != nil{
            dictionary["rental_id"] = rentalId
        }
        if rentalImage != nil{
            dictionary["rental_image"] = rentalImage
        }
        if rentalPrice != nil{
            dictionary["rental_price"] = rentalPrice
        }
        if rentalTitle != nil{
            dictionary["rental_title"] = rentalTitle
        }
        if userCurrency != nil{
            dictionary["user_currency"] = userCurrency
        }
        if userphoto != nil{
            dictionary["userphoto"] = userphoto
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        homeType = aDecoder.decodeObject(forKey: "home_type") as? String ?? ""
        hostId = aDecoder.decodeObject(forKey: "host_id") as? Int ?? 0
        hostname = aDecoder.decodeObject(forKey: "hostname") as? String ?? ""
        isFavourite = aDecoder.decodeObject(forKey: "is_favourite") as? Int ?? 0
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String ?? ""
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String ?? ""
        rentalId = aDecoder.decodeObject(forKey: "rental_id") as? Int ?? 0
        rentalImage = aDecoder.decodeObject(forKey: "rental_image") as? String ?? ""
        rentalPrice = aDecoder.decodeObject(forKey: "rental_price") as? Int ?? 0
        rentalTitle = aDecoder.decodeObject(forKey: "rental_title") as? String ?? ""
        userCurrency = aDecoder.decodeObject(forKey: "user_currency") as? String ?? ""
        userphoto = aDecoder.decodeObject(forKey: "userphoto") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if homeType != nil{
            aCoder.encode(homeType, forKey: "home_type")
        }
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if hostname != nil{
            aCoder.encode(hostname, forKey: "hostname")
        }
        if isFavourite != nil{
            aCoder.encode(isFavourite, forKey: "is_favourite")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyCurrencySymbol != nil{
            aCoder.encode(propertyCurrencySymbol, forKey: "property_currency_symbol")
        }
        if rentalId != nil{
            aCoder.encode(rentalId, forKey: "rental_id")
        }
        if rentalImage != nil{
            aCoder.encode(rentalImage, forKey: "rental_image")
        }
        if rentalPrice != nil{
            aCoder.encode(rentalPrice, forKey: "rental_price")
        }
        if rentalTitle != nil{
            aCoder.encode(rentalTitle, forKey: "rental_title")
        }
        if userCurrency != nil{
            aCoder.encode(userCurrency, forKey: "user_currency")
        }
        if userphoto != nil{
            aCoder.encode(userphoto, forKey: "userphoto")
        }
    }
}
