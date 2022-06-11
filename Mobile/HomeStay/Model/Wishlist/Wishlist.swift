//
//  Wishlist.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 17, 2018

import Foundation


class Wishlist : NSObject, NSCoding{

    var carsDetails : [AnyObject]!
    var experienceDetails : [AnyObject]!
    var hotelDetails : [HotelDetail]!
    var officeDetails : [AnyObject]!
    var resortDetails : [AnyObject]!
    var restaurantDetails : [AnyObject]!
    var vansDetails : [AnyObject]!
    var wishlistId : Int = 0
    var wishlistImage : String = ""
    var wishlistTitle : String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        wishlistId = dictionary["wishlist_id"] as? Int ?? 0 ?? 0
        wishlistImage = dictionary["wishlist_image"] as? String ?? ""
        wishlistTitle = dictionary["wishlist_title"] as? String ?? ""
        hotelDetails = [HotelDetail]()
        if let hotelDetailsArray = dictionary["hotel_details"] as? [[String:Any]]{
            for dic in hotelDetailsArray{
                let value = HotelDetail(fromDictionary: dic)
                hotelDetails.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if wishlistId != nil{
            dictionary["wishlist_id"] = wishlistId
        }
        if wishlistImage != nil{
            dictionary["wishlist_image"] = wishlistImage
        }
        if wishlistTitle != nil{
            dictionary["wishlist_title"] = wishlistTitle
        }
        if hotelDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for hotelDetailsElement in hotelDetails {
                dictionaryElements.append(hotelDetailsElement.toDictionary())
            }
            dictionary["hotelDetails"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        carsDetails = aDecoder.decodeObject(forKey: "cars_details") as? [AnyObject]
        experienceDetails = aDecoder.decodeObject(forKey: "experience_details") as? [AnyObject]
        hotelDetails = aDecoder.decodeObject(forKey: "hotel_details") as? [HotelDetail]
        officeDetails = aDecoder.decodeObject(forKey: "office_details") as? [AnyObject]
        resortDetails = aDecoder.decodeObject(forKey: "resort_details") as? [AnyObject]
        restaurantDetails = aDecoder.decodeObject(forKey: "restaurant_details") as? [AnyObject]
        vansDetails = aDecoder.decodeObject(forKey: "vans_details") as? [AnyObject]
        wishlistId = aDecoder.decodeObject(forKey: "wishlist_id") as? Int ?? 0
        wishlistImage = aDecoder.decodeObject(forKey: "wishlist_image") as? String ?? ""
        wishlistTitle = aDecoder.decodeObject(forKey: "wishlist_title") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if carsDetails != nil{
            aCoder.encode(carsDetails, forKey: "cars_details")
        }
        if experienceDetails != nil{
            aCoder.encode(experienceDetails, forKey: "experience_details")
        }
        if hotelDetails != nil{
            aCoder.encode(hotelDetails, forKey: "hotel_details")
        }
        if officeDetails != nil{
            aCoder.encode(officeDetails, forKey: "office_details")
        }
        if resortDetails != nil{
            aCoder.encode(resortDetails, forKey: "resort_details")
        }
        if restaurantDetails != nil{
            aCoder.encode(restaurantDetails, forKey: "restaurant_details")
        }
        if vansDetails != nil{
            aCoder.encode(vansDetails, forKey: "vans_details")
        }
        if wishlistId != nil{
            aCoder.encode(wishlistId, forKey: "wishlist_id")
        }
        if wishlistImage != nil{
            aCoder.encode(wishlistImage, forKey: "wishlist_image")
        }
        if wishlistTitle != nil{
            aCoder.encode(wishlistTitle, forKey: "wishlist_title")
        }
    }
}
