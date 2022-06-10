//
//  CalendarList.swift
//  HomeStay
//
//  Created by Kala on 03/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
class CalendarList : NSObject, NSCoding{
    
    var book_id : Int!
    var check_in : String!
    var check_out : String!
    var created_at : String!
    var price : Int!
    var prop_id : Int!
    var prop_status : Int!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        book_id = dictionary["book_id"] as? Int ?? 0
        check_in = dictionary["check_in"] as? String ?? ""
        check_out = dictionary["check_out"] as? String ?? ""
        created_at = dictionary["created_at"] as? String ?? ""
        price = dictionary["price"] as? Int ?? 0
        prop_id = dictionary["prop_id"] as? Int ?? 0
        prop_status = dictionary["prop_status"] as? Int ?? 0
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if book_id != nil{
            dictionary["book_id"] = book_id
        }
        if check_in != nil{
            dictionary["check_in"] = check_in
        }
        if check_out != nil{
            dictionary["check_out"] = check_out
        }
        if created_at != nil{
            dictionary["created_at"] = created_at
        }
        if price != nil{
            dictionary["price"] = price
        }
        if prop_id != nil{
            dictionary["prop_id"] = prop_id
        }
        if prop_status != nil{
            dictionary["prop_status"] = prop_status
        }
        
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        book_id = aDecoder.decodeObject(forKey: "book_id") as? Int ?? 0
        check_in = aDecoder.decodeObject(forKey: "check_in") as? String ?? ""
        check_out = aDecoder.decodeObject(forKey: "check_out") as? String ?? ""
        created_at = aDecoder.decodeObject(forKey: "created_at") as? String ?? ""
        price = aDecoder.decodeObject(forKey: "price") as? Int ?? 0
        prop_id = aDecoder.decodeObject(forKey: "prop_id") as? Int ?? 0
        prop_status = aDecoder.decodeObject(forKey: "prop_status") as? Int ?? 0
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if book_id != nil{
            aCoder.encode(book_id, forKey: "book_id")
        }
        if check_in != nil{
            aCoder.encode(check_in, forKey: "check_in")
        }
        if check_out != nil{
            aCoder.encode(check_out, forKey: "check_out")
        }
        if created_at != nil{
            aCoder.encode(created_at, forKey: "created_at")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if prop_id != nil{
            aCoder.encode(prop_id, forKey: "prop_id")
        }
        if prop_status != nil{
            aCoder.encode(prop_status, forKey: "prop_status")
        }
    }
}
