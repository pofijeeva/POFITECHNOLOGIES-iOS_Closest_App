//
//  WishlistModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 17, 2018

import Foundation


class WishlistModel : NSObject, NSCoding{

    var message : String = ""
    var status : Int = 0
    var wishlist : [Wishlist]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        wishlist = [Wishlist]()
        if let wishlistArray = dictionary["wishlist"] as? [[String:Any]]{
            for dic in wishlistArray{
                let value = Wishlist(fromDictionary: dic)
                wishlist.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if wishlist != nil{
            var dictionaryElements = [[String:Any]]()
            for wishlistElement in wishlist {
                dictionaryElements.append(wishlistElement.toDictionary())
            }
            dictionary["wishlist"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        wishlist = aDecoder.decodeObject(forKey: "wishlist") as? [Wishlist]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if wishlist != nil{
            aCoder.encode(wishlist, forKey: "wishlist")
        }
    }
}
