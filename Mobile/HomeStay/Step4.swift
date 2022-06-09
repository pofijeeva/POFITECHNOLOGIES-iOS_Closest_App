//
//  Step4.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Step4 : NSObject, NSCoding{
    
    var baseId : String!
    var guestAccess : String!
    var guestAccessPh : String!
    var houseRules : String!
    var houseRulesPh : String!
    var instantPay : String!
    var pay_later : String!

    var interactGuest : String!
    var interactGuestPh : String!
    var neighborAround : String!
    var neighborAroundPh : String!
    var otherThingsToNote : String!
    var otherThingsToNotePh : String!
    var propertyDescription : String!
    var propertyDescriptionPh : String!
    var propertyTitle : String!
    var propertyTitlePh : String!
    var propertyid : Int!
    var requestToBook : String!
    var space : String!
    var spacePh : String!
    var stepCompleted : Bool!
    var rentDetail : Language!
   
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseId = dictionary["base_id"] as? String
        pay_later = dictionary["pay_later"] as? String

        guestAccess = dictionary["guest_access"] as? String
        guestAccessPh = dictionary["guest_access_ph"] as? String
        houseRules = dictionary["house_rules"] as? String
        houseRulesPh = dictionary["house_rules_ph"] as? String
        instantPay = dictionary["instant_pay"] as? String
        interactGuest = dictionary["interact_guest"] as? String
        interactGuestPh = dictionary["interact_guest_ph"] as? String
        neighborAround = dictionary["neighbor_around"] as? String
        neighborAroundPh = dictionary["neighbor_around_ph"] as? String
        otherThingsToNote = dictionary["other_things_to_note"] as? String
        otherThingsToNotePh = dictionary["other_things_to_note_ph"] as? String
        propertyDescription = dictionary["property_description"] as? String
        propertyDescriptionPh = dictionary["property_description_ph"] as? String
        propertyTitle = dictionary["property_title"] as? String
        propertyTitlePh = dictionary["property_title_ph"] as? String
        propertyid = dictionary["propertyid"] as? Int
        requestToBook = dictionary["request_to_book"] as? String
        space = dictionary["space"] as? String
        spacePh = dictionary["space_ph"] as? String
        stepCompleted = dictionary["step_completed"] as? Bool
        if let rd = dictionary["ren_details"] as? [String:Any]{
                    rentDetail = Language(fromDictionary: rd)
                }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if baseId != nil{
            dictionary["base_id"] = baseId
        }
        if pay_later != nil{
            dictionary["pay_later"] = pay_later
        }
        if guestAccess != nil{
            dictionary["guest_access"] = guestAccess
        }
        if guestAccessPh != nil{
            dictionary["guest_access_ph"] = guestAccessPh
        }
        if houseRules != nil{
            dictionary["house_rules"] = houseRules
        }
        if houseRulesPh != nil{
            dictionary["house_rules_ph"] = houseRulesPh
        }
        if instantPay != nil{
            dictionary["instant_pay"] = instantPay
        }
        if interactGuest != nil{
            dictionary["interact_guest"] = interactGuest
        }
        if interactGuestPh != nil{
            dictionary["interact_guest_ph"] = interactGuestPh
        }
        if neighborAround != nil{
            dictionary["neighbor_around"] = neighborAround
        }
        if neighborAroundPh != nil{
            dictionary["neighbor_around_ph"] = neighborAroundPh
        }
        if otherThingsToNote != nil{
            dictionary["other_things_to_note"] = otherThingsToNote
        }
        if otherThingsToNotePh != nil{
            dictionary["other_things_to_note_ph"] = otherThingsToNotePh
        }
        if propertyDescription != nil{
            dictionary["property_description"] = propertyDescription
        }
        if propertyDescriptionPh != nil{
            dictionary["property_description_ph"] = propertyDescriptionPh
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if propertyTitlePh != nil{
            dictionary["property_title_ph"] = propertyTitlePh
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if requestToBook != nil{
            dictionary["request_to_book"] = requestToBook
        }
        if space != nil{
            dictionary["space"] = space
        }
        if spacePh != nil{
            dictionary["space_ph"] = spacePh
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if rentDetail != nil{
                    dictionary["ren_details"] = rentDetail.toDictionary()
                }
        return dictionary
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        
        pay_later = aDecoder.decodeObject(forKey: "pay_later") as? String

        baseId = aDecoder.decodeObject(forKey: "base_id") as? String
        guestAccess = aDecoder.decodeObject(forKey: "guest_access") as? String
        guestAccessPh = aDecoder.decodeObject(forKey: "guest_access_ph") as? String
        houseRules = aDecoder.decodeObject(forKey: "house_rules") as? String
        houseRulesPh = aDecoder.decodeObject(forKey: "house_rules_ph") as? String
        instantPay = aDecoder.decodeObject(forKey: "instant_pay") as? String
        interactGuest = aDecoder.decodeObject(forKey: "interact_guest") as? String
        interactGuestPh = aDecoder.decodeObject(forKey: "interact_guest_ph") as? String
        neighborAround = aDecoder.decodeObject(forKey: "neighbor_around") as? String
        neighborAroundPh = aDecoder.decodeObject(forKey: "neighbor_around_ph") as? String
        otherThingsToNote = aDecoder.decodeObject(forKey: "other_things_to_note") as? String
        otherThingsToNotePh = aDecoder.decodeObject(forKey: "other_things_to_note_ph") as? String
        propertyDescription = aDecoder.decodeObject(forKey: "property_description") as? String
        propertyDescriptionPh = aDecoder.decodeObject(forKey: "property_description_ph") as? String
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String
        propertyTitlePh = aDecoder.decodeObject(forKey: "property_title_ph") as? String
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int
        requestToBook = aDecoder.decodeObject(forKey: "request_to_book") as? String
        space = aDecoder.decodeObject(forKey: "space") as? String
        spacePh = aDecoder.decodeObject(forKey: "space_ph") as? String
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool
        rentDetail = aDecoder.decodeObject(forKey: "ren_details") as? Language
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if baseId != nil{
            aCoder.encode(baseId, forKey: "base_id")
        }
        if pay_later != nil{
            aCoder.encode(pay_later, forKey: "pay_later")
        }
        if guestAccess != nil{
            aCoder.encode(guestAccess, forKey: "guest_access")
        }
        if guestAccessPh != nil{
            aCoder.encode(guestAccessPh, forKey: "guest_access_ph")
        }
        if houseRules != nil{
            aCoder.encode(houseRules, forKey: "house_rules")
        }
        if houseRulesPh != nil{
            aCoder.encode(houseRulesPh, forKey: "house_rules_ph")
        }
        if instantPay != nil{
            aCoder.encode(instantPay, forKey: "instant_pay")
        }
        if interactGuest != nil{
            aCoder.encode(interactGuest, forKey: "interact_guest")
        }
        if interactGuestPh != nil{
            aCoder.encode(interactGuestPh, forKey: "interact_guest_ph")
        }
        if neighborAround != nil{
            aCoder.encode(neighborAround, forKey: "neighbor_around")
        }
        if neighborAroundPh != nil{
            aCoder.encode(neighborAroundPh, forKey: "neighbor_around_ph")
        }
        if otherThingsToNote != nil{
            aCoder.encode(otherThingsToNote, forKey: "other_things_to_note")
        }
        if otherThingsToNotePh != nil{
            aCoder.encode(otherThingsToNotePh, forKey: "other_things_to_note_ph")
        }
        if propertyDescription != nil{
            aCoder.encode(propertyDescription, forKey: "property_description")
        }
        if propertyDescriptionPh != nil{
            aCoder.encode(propertyDescriptionPh, forKey: "property_description_ph")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if propertyTitlePh != nil{
            aCoder.encode(propertyTitlePh, forKey: "property_title_ph")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if requestToBook != nil{
            aCoder.encode(requestToBook, forKey: "request_to_book")
        }
        if space != nil{
            aCoder.encode(space, forKey: "space")
        }
        if spacePh != nil{
            aCoder.encode(spacePh, forKey: "space_ph")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if rentDetail != nil{
                    aCoder.encode(rentDetail, forKey: "ren_details")
                }
    }
}
