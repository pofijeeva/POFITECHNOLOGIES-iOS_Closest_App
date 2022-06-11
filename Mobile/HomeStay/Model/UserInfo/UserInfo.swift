//
//  UserInfo.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on May 21, 2019

import Foundation


class UserInfo : NSObject, NSCoding{
    
    var cancellationAboutYou : [CancellationAboutYou]!
    var cancellationByYou : [CancellationByYou]!
    var countryList : [CountryList]!
    var disputeAboutYou : [DisputeAboutYou]!
    var disputeByYou : [DisputeByYou]!
    var hostCancellation : [HostCancellation]!
    var message : String = ""
    var profileinfo : [Profileinfo]!
    var propertyListing : [PropertyListing]!
    var reviewsAboutYou : [ReviewsAboutYou]!
    var reviewsByYou : [ReviewsByYou]!
    var status : Int = 0
    var trustVerify : [TrustVerify]!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        cancellationAboutYou = [CancellationAboutYou]()
        if let cancellationAboutYouArray = dictionary["cancellation_about_you"] as? [[String:Any]]{
            for dic in cancellationAboutYouArray{
                let value = CancellationAboutYou(fromDictionary: dic)
                cancellationAboutYou.append(value)
            }
        }
        cancellationByYou = [CancellationByYou]()
        if let cancellationByYouArray = dictionary["cancellation_by_you"] as? [[String:Any]]{
            for dic in cancellationByYouArray{
                let value = CancellationByYou(fromDictionary: dic)
                cancellationByYou.append(value)
            }
        }
        countryList = [CountryList]()
        if let countryListArray = dictionary["country_list"] as? [[String:Any]]{
            for dic in countryListArray{
                let value = CountryList(fromDictionary: dic)
                countryList.append(value)
            }
        }
        disputeAboutYou = [DisputeAboutYou]()
        if let disputeAboutYouArray = dictionary["dispute_about_you"] as? [[String:Any]]{
            for dic in disputeAboutYouArray{
                let value = DisputeAboutYou(fromDictionary: dic)
                disputeAboutYou.append(value)
            }
        }
        disputeByYou = [DisputeByYou]()
        if let disputeByYouArray = dictionary["dispute_by_you"] as? [[String:Any]]{
            for dic in disputeByYouArray{
                let value = DisputeByYou(fromDictionary: dic)
                disputeByYou.append(value)
            }
        }
        hostCancellation = [HostCancellation]()
        if let hostCancellationArray = dictionary["host_cancellation"] as? [[String:Any]]{
            for dic in hostCancellationArray{
                let value = HostCancellation(fromDictionary: dic)
                hostCancellation.append(value)
            }
        }
        profileinfo = [Profileinfo]()
        if let profileinfoArray = dictionary["profileinfo"] as? [[String:Any]]{
            for dic in profileinfoArray{
                let value = Profileinfo(fromDictionary: dic)
                profileinfo.append(value)
            }
        }
        propertyListing = [PropertyListing]()
        if let propertyListingArray = dictionary["property_listing"] as? [[String:Any]]{
            for dic in propertyListingArray{
                let value = PropertyListing(fromDictionary: dic)
                propertyListing.append(value)
            }
        }
        reviewsAboutYou = [ReviewsAboutYou]()
        if let reviewsAboutYouArray = dictionary["reviews_about_you"] as? [[String:Any]]{
            for dic in reviewsAboutYouArray{
                let value = ReviewsAboutYou(fromDictionary: dic)
                reviewsAboutYou.append(value)
            }
        }
        reviewsByYou = [ReviewsByYou]()
        if let reviewsByYouArray = dictionary["reviews_by_you"] as? [[String:Any]]{
            for dic in reviewsByYouArray{
                let value = ReviewsByYou(fromDictionary: dic)
                reviewsByYou.append(value)
            }
        }
        trustVerify = [TrustVerify]()
        if let trustVerifyArray = dictionary["trust_verify"] as? [[String:Any]]{
            for dic in trustVerifyArray{
                let value = TrustVerify(fromDictionary: dic)
                trustVerify.append(value)
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
        if cancellationAboutYou != nil{
            var dictionaryElements = [[String:Any]]()
            for cancellationAboutYouElement in cancellationAboutYou {
                dictionaryElements.append(cancellationAboutYouElement.toDictionary())
            }
            dictionary["cancellationAboutYou"] = dictionaryElements
        }
        if cancellationByYou != nil{
            var dictionaryElements = [[String:Any]]()
            for cancellationByYouElement in cancellationByYou {
                dictionaryElements.append(cancellationByYouElement.toDictionary())
            }
            dictionary["cancellationByYou"] = dictionaryElements
        }
        if countryList != nil{
            var dictionaryElements = [[String:Any]]()
            for countryListElement in countryList {
                dictionaryElements.append(countryListElement.toDictionary())
            }
            dictionary["countryList"] = dictionaryElements
        }
        if disputeAboutYou != nil{
            var dictionaryElements = [[String:Any]]()
            for disputeAboutYouElement in disputeAboutYou {
                dictionaryElements.append(disputeAboutYouElement.toDictionary())
            }
            dictionary["disputeAboutYou"] = dictionaryElements
        }
        if disputeByYou != nil{
            var dictionaryElements = [[String:Any]]()
            for disputeByYouElement in disputeByYou {
                dictionaryElements.append(disputeByYouElement.toDictionary())
            }
            dictionary["disputeByYou"] = dictionaryElements
        }
        if hostCancellation != nil{
            var dictionaryElements = [[String:Any]]()
            for hostCancellationElement in hostCancellation {
                dictionaryElements.append(hostCancellationElement.toDictionary())
            }
            dictionary["hostCancellation"] = dictionaryElements
        }
        if profileinfo != nil{
            var dictionaryElements = [[String:Any]]()
            for profileinfoElement in profileinfo {
                dictionaryElements.append(profileinfoElement.toDictionary())
            }
            dictionary["profileinfo"] = dictionaryElements
        }
        if propertyListing != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyListingElement in propertyListing {
                dictionaryElements.append(propertyListingElement.toDictionary())
            }
            dictionary["propertyListing"] = dictionaryElements
        }
        if reviewsAboutYou != nil{
            var dictionaryElements = [[String:Any]]()
            for reviewsAboutYouElement in reviewsAboutYou {
                dictionaryElements.append(reviewsAboutYouElement.toDictionary())
            }
            dictionary["reviewsAboutYou"] = dictionaryElements
        }
        if reviewsByYou != nil{
            var dictionaryElements = [[String:Any]]()
            for reviewsByYouElement in reviewsByYou {
                dictionaryElements.append(reviewsByYouElement.toDictionary())
            }
            dictionary["reviewsByYou"] = dictionaryElements
        }
        if trustVerify != nil{
            var dictionaryElements = [[String:Any]]()
            for trustVerifyElement in trustVerify {
                dictionaryElements.append(trustVerifyElement.toDictionary())
            }
            dictionary["trustVerify"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cancellationAboutYou = aDecoder.decodeObject(forKey: "cancellation_about_you") as? [CancellationAboutYou]
        cancellationByYou = aDecoder.decodeObject(forKey: "cancellation_by_you") as? [CancellationByYou]
        countryList = aDecoder.decodeObject(forKey: "country_list") as? [CountryList]
        disputeAboutYou = aDecoder.decodeObject(forKey: "dispute_about_you") as? [DisputeAboutYou]
        disputeByYou = aDecoder.decodeObject(forKey: "dispute_by_you") as? [DisputeByYou]
        hostCancellation = aDecoder.decodeObject(forKey: "host_cancellation") as? [HostCancellation]
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        profileinfo = aDecoder.decodeObject(forKey: "profileinfo") as? [Profileinfo]
        propertyListing = aDecoder.decodeObject(forKey: "property_listing") as? [PropertyListing]
        reviewsAboutYou = aDecoder.decodeObject(forKey: "reviews_about_you") as? [ReviewsAboutYou]
        reviewsByYou = aDecoder.decodeObject(forKey: "reviews_by_you") as? [ReviewsByYou]
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        trustVerify = aDecoder.decodeObject(forKey: "trust_verify") as? [TrustVerify]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cancellationAboutYou != nil{
            aCoder.encode(cancellationAboutYou, forKey: "cancellation_about_you")
        }
        if cancellationByYou != nil{
            aCoder.encode(cancellationByYou, forKey: "cancellation_by_you")
        }
        if countryList != nil{
            aCoder.encode(countryList, forKey: "country_list")
        }
        if disputeAboutYou != nil{
            aCoder.encode(disputeAboutYou, forKey: "dispute_about_you")
        }
        if disputeByYou != nil{
            aCoder.encode(disputeByYou, forKey: "dispute_by_you")
        }
        if hostCancellation != nil{
            aCoder.encode(hostCancellation, forKey: "host_cancellation")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if profileinfo != nil{
            aCoder.encode(profileinfo, forKey: "profileinfo")
        }
        if propertyListing != nil{
            aCoder.encode(propertyListing, forKey: "property_listing")
        }
        if reviewsAboutYou != nil{
            aCoder.encode(reviewsAboutYou, forKey: "reviews_about_you")
        }
        if reviewsByYou != nil{
            aCoder.encode(reviewsByYou, forKey: "reviews_by_you")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if trustVerify != nil{
            aCoder.encode(trustVerify, forKey: "trust_verify")
        }
    }
}
