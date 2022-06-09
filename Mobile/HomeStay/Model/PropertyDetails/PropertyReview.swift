//
//  PropertyReview.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 30, 2018

import Foundation


class PropertyReview : NSObject, NSCoding{

    var review : String!
    var reviewDate : String!
    var starRating : AnyObject!
    var userImage : String!
    var userName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        review = dictionary["review"] as? String
        reviewDate = dictionary["review_date"] as? String
        starRating = dictionary["star_rating"] as? AnyObject
        userImage = dictionary["user_image"] as? String
        userName = dictionary["user_name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if review != nil{
            dictionary["review"] = review
        }
        if reviewDate != nil{
            dictionary["review_date"] = reviewDate
        }
        if starRating != nil{
            dictionary["star_rating"] = starRating
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        if userName != nil{
            dictionary["user_name"] = userName
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        review = aDecoder.decodeObject(forKey: "review") as? String
        reviewDate = aDecoder.decodeObject(forKey: "review_date") as? String
        starRating = aDecoder.decodeObject(forKey: "star_rating") as? AnyObject
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String
        userName = aDecoder.decodeObject(forKey: "user_name") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if review != nil{
            aCoder.encode(review, forKey: "review")
        }
        if reviewDate != nil{
            aCoder.encode(reviewDate, forKey: "review_date")
        }
        if starRating != nil{
            aCoder.encode(starRating, forKey: "star_rating")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "user_name")
        }
    }
}
