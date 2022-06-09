//
//  TrustVerify.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 28, 2018

import Foundation


class TrustVerify : NSObject, NSCoding{

    var country : Int!
    var emailIdVerified : Bool!
    var facebookConnect : String!
    var googleConnect : String!
    var linkedinConnect : String!
    var phone : String!
    var phoneVerified : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        country = dictionary["country"] as? Int
        emailIdVerified = dictionary["email_id_verified"] as? Bool
        facebookConnect = dictionary["facebook_connect"] as? String
        googleConnect = dictionary["google_connect"] as? String
        linkedinConnect = dictionary["linkedin_connect"] as? String
        phone = dictionary["phone"] as? String
        phoneVerified = dictionary["phone_verified"] as? Bool
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if country != nil{
            dictionary["country"] = country
        }
        if emailIdVerified != nil{
            dictionary["email_id_verified"] = emailIdVerified
        }
        if facebookConnect != nil{
            dictionary["facebook_connect"] = facebookConnect
        }
        if googleConnect != nil{
            dictionary["google_connect"] = googleConnect
        }
        if linkedinConnect != nil{
            dictionary["linkedin_connect"] = linkedinConnect
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if phoneVerified != nil{
            dictionary["phone_verified"] = phoneVerified
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        country = aDecoder.decodeObject(forKey: "country") as? Int
        emailIdVerified = aDecoder.decodeObject(forKey: "email_id_verified") as? Bool
        facebookConnect = aDecoder.decodeObject(forKey: "facebook_connect") as? String
        googleConnect = aDecoder.decodeObject(forKey: "google_connect") as? String
        linkedinConnect = aDecoder.decodeObject(forKey: "linkedin_connect") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        phoneVerified = aDecoder.decodeObject(forKey: "phone_verified") as? Bool
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if emailIdVerified != nil{
            aCoder.encode(emailIdVerified, forKey: "email_id_verified")
        }
        if facebookConnect != nil{
            aCoder.encode(facebookConnect, forKey: "facebook_connect")
        }
        if googleConnect != nil{
            aCoder.encode(googleConnect, forKey: "google_connect")
        }
        if linkedinConnect != nil{
            aCoder.encode(linkedinConnect, forKey: "linkedin_connect")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if phoneVerified != nil{
            aCoder.encode(phoneVerified, forKey: "phone_verified")
        }
    }
}