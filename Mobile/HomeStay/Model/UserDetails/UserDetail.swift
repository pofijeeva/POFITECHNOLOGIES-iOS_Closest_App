//
//  UserDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 10, 2018

import Foundation


class UserDetail : NSObject, NSCoding{

    var descriptionField : String!
    var dob : String!
    var firstname : String!
    var gender : String!
    var idVerified : String!
    var image : String!
    var isVerified : String!
    var lastname : String!
    var phVerified : String!
    var phoneNo : String!
    var since : String!
    var userName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        descriptionField = dictionary["description"] as? String ?? ""
        dob = dictionary["dob"] as? String ?? ""
        firstname = dictionary["firstname"] as? String ?? ""
        gender = dictionary["gender"] as? String ?? ""
        idVerified = dictionary["id_verified"] as? String ?? ""
        image = dictionary["image"] as? String ?? ""
        isVerified = dictionary["is_verified"] as? String ?? ""
        lastname = dictionary["lastname"] as? String ?? ""
        phVerified = dictionary["ph_verified"] as? String ?? ""
        phoneNo = dictionary["phone_no"] as? String ?? ""
        since = dictionary["since"] as? String ?? ""
        userName = dictionary["user_name"] as? String ?? ""
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
        if dob != nil{
            dictionary["dob"] = dob
        }
        if firstname != nil{
            dictionary["firstname"] = firstname
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if idVerified != nil{
            dictionary["id_verified"] = idVerified
        }
        if image != nil{
            dictionary["image"] = image
        }
        if isVerified != nil{
            dictionary["is_verified"] = isVerified
        }
        if lastname != nil{
            dictionary["lastname"] = lastname
        }
        if phVerified != nil{
            dictionary["ph_verified"] = phVerified
        }
        if phoneNo != nil{
            dictionary["phone_no"] = phoneNo
        }
        if since != nil{
            dictionary["since"] = since
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
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        dob = aDecoder.decodeObject(forKey: "dob") as? String ?? ""
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String ?? ""
        gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
        idVerified = aDecoder.decodeObject(forKey: "id_verified") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        isVerified = aDecoder.decodeObject(forKey: "is_verified") as? String ?? ""
        lastname = aDecoder.decodeObject(forKey: "lastname") as? String ?? ""
        phVerified = aDecoder.decodeObject(forKey: "ph_verified") as? String ?? ""
        phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String ?? ""
        since = aDecoder.decodeObject(forKey: "since") as? String ?? ""
        userName = aDecoder.decodeObject(forKey: "user_name") as? String ?? ""
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
        if dob != nil{
            aCoder.encode(dob, forKey: "dob")
        }
        if firstname != nil{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if idVerified != nil{
            aCoder.encode(idVerified, forKey: "id_verified")
        }
        if image != nil{
            aCoder.encode(image, forKey: "image")
        }
        if isVerified != nil{
            aCoder.encode(isVerified, forKey: "is_verified")
        }
        if lastname != nil{
            aCoder.encode(lastname, forKey: "lastname")
        }
        if phVerified != nil{
            aCoder.encode(phVerified, forKey: "ph_verified")
        }
        if phoneNo != nil{
            aCoder.encode(phoneNo, forKey: "phone_no")
        }
        if since != nil{
            aCoder.encode(since, forKey: "since")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "user_name")
        }
    }
}
