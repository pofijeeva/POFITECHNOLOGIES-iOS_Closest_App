//
//  ReviewsByYou.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 11, 2019

import Foundation


class ReviewsByYou : NSObject, NSCoding{
    
    var id : String!
    var reviewBookingNo : String!
    var reviewDate : String!
    var reviewPropertyId : String!
    var reviewPropertyName : String!
    var reviewerComments : String!
    var reviewerId : String!
    var reviewerName : String!
    var reviewerRating : String!
    var reviwerImage : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String ?? ""
        reviewBookingNo = dictionary["review_booking_no"] as? String ?? ""
        reviewDate = dictionary["review_date"] as? String ?? ""
        reviewPropertyId = dictionary["review_property_id"] as? String ?? ""
        reviewPropertyName = dictionary["review_property_name"] as? String ?? ""
        reviewerComments = dictionary["reviewer_comments"] as? String ?? ""
        reviewerId = dictionary["reviewer_id"] as? String ?? ""
        reviewerName = dictionary["reviewer_name"] as? String ?? ""
        reviewerRating = dictionary["reviewer_rating"] as? String ?? ""
        reviwerImage = dictionary["reviwer_image"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if reviewBookingNo != nil{
            dictionary["review_booking_no"] = reviewBookingNo
        }
        if reviewDate != nil{
            dictionary["review_date"] = reviewDate
        }
        if reviewPropertyId != nil{
            dictionary["review_property_id"] = reviewPropertyId
        }
        if reviewPropertyName != nil{
            dictionary["review_property_name"] = reviewPropertyName
        }
        if reviewerComments != nil{
            dictionary["reviewer_comments"] = reviewerComments
        }
        if reviewerId != nil{
            dictionary["reviewer_id"] = reviewerId
        }
        if reviewerName != nil{
            dictionary["reviewer_name"] = reviewerName
        }
        if reviewerRating != nil{
            dictionary["reviewer_rating"] = reviewerRating
        }
        if reviwerImage != nil{
            dictionary["reviwer_image"] = reviwerImage
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        reviewBookingNo = aDecoder.decodeObject(forKey: "review_booking_no") as? String ?? ""
        reviewDate = aDecoder.decodeObject(forKey: "review_date") as? String ?? ""
        reviewPropertyId = aDecoder.decodeObject(forKey: "review_property_id") as? String ?? ""
        reviewPropertyName = aDecoder.decodeObject(forKey: "review_property_name") as? String ?? ""
        reviewerComments = aDecoder.decodeObject(forKey: "reviewer_comments") as? String ?? ""
        reviewerId = aDecoder.decodeObject(forKey: "reviewer_id") as? String ?? ""
        reviewerName = aDecoder.decodeObject(forKey: "reviewer_name") as? String ?? ""
        reviewerRating = aDecoder.decodeObject(forKey: "reviewer_rating") as? String ?? ""
        reviwerImage = aDecoder.decodeObject(forKey: "reviwer_image") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if reviewBookingNo != nil{
            aCoder.encode(reviewBookingNo, forKey: "review_booking_no")
        }
        if reviewDate != nil{
            aCoder.encode(reviewDate, forKey: "review_date")
        }
        if reviewPropertyId != nil{
            aCoder.encode(reviewPropertyId, forKey: "review_property_id")
        }
        if reviewPropertyName != nil{
            aCoder.encode(reviewPropertyName, forKey: "review_property_name")
        }
        if reviewerComments != nil{
            aCoder.encode(reviewerComments, forKey: "reviewer_comments")
        }
        if reviewerId != nil{
            aCoder.encode(reviewerId, forKey: "reviewer_id")
        }
        if reviewerName != nil{
            aCoder.encode(reviewerName, forKey: "reviewer_name")
        }
        if reviewerRating != nil{
            aCoder.encode(reviewerRating, forKey: "reviewer_rating")
        }
        if reviwerImage != nil{
            aCoder.encode(reviwerImage, forKey: "reviwer_image")
        }
    }
}
