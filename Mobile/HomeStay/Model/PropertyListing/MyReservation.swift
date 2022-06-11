//
//  MyReservation.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 6, 2018

import Foundation


class MyReservation : NSObject, NSCoding{

    var approvalStatus : String = ""
    var bookingDates : String = ""
    var bookingno : String = ""
    var cancelShowStatus : Bool = false 
    var cancellationPolicy : String = ""
    var cancelledBy : String = ""
    var checkin : String = ""
    var checkout : String = ""
    var city : String = ""
    var country : String = ""
    var guestAccess : String = ""
    var guestId : String = ""
    var houseRules : String = ""
    var id : String = ""
    var interactGuest : AnyObject!
    var isCanceled : Bool = false 
    var loginUserType : String = ""
    var neighborAround : String = ""
    var neighborOverview : String = ""
    var noofGuest : String = ""
    var numofdates : String = ""
    var otherThingsToNote : String = ""
    var paidCurrencyCode : String = ""
    var paidCurrencySymbol : String = ""
    var paymentStatus : String = ""
    var postCode : String = ""
    var propertyAddress : String = ""
    var propertyCurrencyCode : String = ""
    var propertyCurrencySymbol : String = ""
    var propertyId : String = ""
    var propertyPrice : Int = 0
    var propertyTitle : String = ""
    var securityDeposit : Int = 0
    var serviceFee : Int = 0
    var state : String = ""
    var subTotal : Int = 0
    var total :  AnyObject!
    var userImage : String = ""
    var userName : String = ""
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        approvalStatus = dictionary["approval_status"] as? String ?? ""
        bookingDates = dictionary["booking_dates"] as? String ?? ""
        bookingno = dictionary["bookingno"] as? String ?? ""
        cancelShowStatus = dictionary["cancel_show_status"] as? Bool ?? false
        cancellationPolicy = dictionary["cancellation_policy"] as? String ?? ""
        cancelledBy = dictionary["cancelled_by"] as? String ?? ""
        checkin = dictionary["checkin"] as? String ?? ""
        checkout = dictionary["checkout"] as? String ?? ""
        city = dictionary["city"] as? String ?? ""
        country = dictionary["country"] as? String ?? ""
        guestAccess = dictionary["guest_access"] as? String ?? ""
        guestId = dictionary["guest_id"] as? String ?? ""
        houseRules = dictionary["house_rules"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        interactGuest = dictionary["interact_guest"] as AnyObject
        isCanceled = dictionary["is_canceled"] as? Bool ?? false
        loginUserType = dictionary["loginUserType"] as? String ?? ""
        neighborAround = dictionary["neighbor_around"] as? String ?? ""
        neighborOverview = dictionary["neighbor_overview"] as? String ?? ""
        noofGuest = dictionary["NoofGuest"] as? String ?? ""
        numofdates = dictionary["numofdates"] as? String ?? ""
        otherThingsToNote = dictionary["other_things_to_note"] as? String ?? ""
        paidCurrencyCode = dictionary["paid_currency_code"] as? String ?? ""
        paidCurrencySymbol = dictionary["paid_currency_symbol"] as? String ?? ""
        paymentStatus = dictionary["payment_status"] as? String ?? ""
        postCode = dictionary["post_code"] as? String ?? ""
        propertyAddress = dictionary["property_address"] as? String ?? ""
        propertyCurrencyCode = dictionary["property_currency_code"] as? String ?? ""
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String ?? ""
        propertyId = dictionary["property_id"] as? String ?? ""
        propertyPrice = dictionary["property_price"] as? Int ?? 0
        propertyTitle = dictionary["property_title"] as? String ?? ""
        securityDeposit = dictionary["security_deposit"] as? Int ?? 0
        serviceFee = dictionary["service_fee"] as? Int ?? 0
        state = dictionary["state"] as? String ?? ""
        subTotal = dictionary["sub_total"] as? Int ?? 0
        total = dictionary["total"]  as AnyObject
        userImage = dictionary["user_image"] as? String ?? ""
        userName = dictionary["user_name"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if approvalStatus != nil{
            dictionary["approval_status"] = approvalStatus
        }
        if bookingDates != nil{
            dictionary["booking_dates"] = bookingDates
        }
        if bookingno != nil{
            dictionary["bookingno"] = bookingno
        }
        if cancelShowStatus != nil{
            dictionary["cancel_show_status"] = cancelShowStatus
        }
        if cancellationPolicy != nil{
            dictionary["cancellation_policy"] = cancellationPolicy
        }
        if cancelledBy != nil{
            dictionary["cancelled_by"] = cancelledBy
        }
        if checkin != nil{
            dictionary["checkin"] = checkin
        }
        if checkout != nil{
            dictionary["checkout"] = checkout
        }
        if city != nil{
            dictionary["city"] = city
        }
        if country != nil{
            dictionary["country"] = country
        }
        if guestAccess != nil{
            dictionary["guest_access"] = guestAccess
        }
        if guestId != nil{
            dictionary["guest_id"] = guestId
        }
        if houseRules != nil{
            dictionary["house_rules"] = houseRules
        }
        if id != nil{
            dictionary["id"] = id
        }
        if interactGuest != nil{
            dictionary["interact_guest"] = interactGuest
        }
        if isCanceled != nil{
            dictionary["is_canceled"] = isCanceled
        }
        if loginUserType != nil{
            dictionary["loginUserType"] = loginUserType
        }
        if neighborAround != nil{
            dictionary["neighbor_around"] = neighborAround
        }
        if neighborOverview != nil{
            dictionary["neighbor_overview"] = neighborOverview
        }
        if noofGuest != nil{
            dictionary["NoofGuest"] = noofGuest
        }
        if numofdates != nil{
            dictionary["numofdates"] = numofdates
        }
        if otherThingsToNote != nil{
            dictionary["other_things_to_note"] = otherThingsToNote
        }
        if paidCurrencyCode != nil{
            dictionary["paid_currency_code"] = paidCurrencyCode
        }
        if paidCurrencySymbol != nil{
            dictionary["paid_currency_symbol"] = paidCurrencySymbol
        }
        if paymentStatus != nil{
            dictionary["payment_status"] = paymentStatus
        }
        if postCode != nil{
            dictionary["post_code"] = postCode
        }
        if propertyAddress != nil{
            dictionary["property_address"] = propertyAddress
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyCurrencySymbol != nil{
            dictionary["property_currency_symbol"] = propertyCurrencySymbol
        }
        if propertyId != nil{
            dictionary["property_id"] = propertyId
        }
        if propertyPrice != nil{
            dictionary["property_price"] = propertyPrice
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if securityDeposit != nil{
            dictionary["security_deposit"] = securityDeposit
        }
        if serviceFee != nil{
            dictionary["service_fee"] = serviceFee
        }
        if state != nil{
            dictionary["state"] = state
        }
        if subTotal != nil{
            dictionary["sub_total"] = subTotal
        }
        if total != nil{
            dictionary["total"] = total
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
        approvalStatus = aDecoder.decodeObject(forKey: "approval_status") as? String ?? ""
        bookingDates = aDecoder.decodeObject(forKey: "booking_dates") as? String ?? ""
        bookingno = aDecoder.decodeObject(forKey: "bookingno") as? String ?? ""
        cancelShowStatus = aDecoder.decodeObject(forKey: "cancel_show_status") as? Bool ?? false
        cancellationPolicy = aDecoder.decodeObject(forKey: "cancellation_policy") as? String ?? ""
        cancelledBy = aDecoder.decodeObject(forKey: "cancelled_by") as? String ?? ""
        checkin = aDecoder.decodeObject(forKey: "checkin") as? String ?? ""
        checkout = aDecoder.decodeObject(forKey: "checkout") as? String ?? ""
        city = aDecoder.decodeObject(forKey: "city") as? String ?? ""
        country = aDecoder.decodeObject(forKey: "country") as? String ?? ""
        guestAccess = aDecoder.decodeObject(forKey: "guest_access") as? String ?? ""
        guestId = aDecoder.decodeObject(forKey: "guest_id") as? String ?? ""
        houseRules = aDecoder.decodeObject(forKey: "house_rules") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        interactGuest = aDecoder.decodeObject(forKey: "interact_guest") as? AnyObject
        isCanceled = aDecoder.decodeObject(forKey: "is_canceled") as? Bool ?? false
        loginUserType = aDecoder.decodeObject(forKey: "loginUserType") as? String ?? ""
        neighborAround = aDecoder.decodeObject(forKey: "neighbor_around") as? String ?? ""
        neighborOverview = aDecoder.decodeObject(forKey: "neighbor_overview") as? String ?? ""
        noofGuest = aDecoder.decodeObject(forKey: "NoofGuest") as? String ?? ""
        numofdates = aDecoder.decodeObject(forKey: "numofdates") as? String ?? ""
        otherThingsToNote = aDecoder.decodeObject(forKey: "other_things_to_note") as? String ?? ""
        paidCurrencyCode = aDecoder.decodeObject(forKey: "paid_currency_code") as? String ?? ""
        paidCurrencySymbol = aDecoder.decodeObject(forKey: "paid_currency_symbol") as? String ?? ""
        paymentStatus = aDecoder.decodeObject(forKey: "payment_status") as? String ?? ""
        postCode = aDecoder.decodeObject(forKey: "post_code") as? String ?? ""
        propertyAddress = aDecoder.decodeObject(forKey: "property_address") as? String ?? ""
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String ?? ""
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String ?? ""
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? String ?? ""
        propertyPrice = aDecoder.decodeObject(forKey: "property_price") as? Int ?? 0
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String ?? ""
        securityDeposit = aDecoder.decodeObject(forKey: "security_deposit") as? Int ?? 0
        serviceFee = aDecoder.decodeObject(forKey: "service_fee") as? Int ?? 0
        state = aDecoder.decodeObject(forKey: "state") as? String ?? ""
        subTotal = aDecoder.decodeObject(forKey: "sub_total") as? Int ?? 0
        total = aDecoder.decodeObject(forKey: "total") as AnyObject!
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String ?? ""
        userName = aDecoder.decodeObject(forKey: "user_name") as? String ?? ""
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if approvalStatus != nil{
            aCoder.encode(approvalStatus, forKey: "approval_status")
        }
        if bookingDates != nil{
            aCoder.encode(bookingDates, forKey: "booking_dates")
        }
        if bookingno != nil{
            aCoder.encode(bookingno, forKey: "bookingno")
        }
        if cancelShowStatus != nil{
            aCoder.encode(cancelShowStatus, forKey: "cancel_show_status")
        }
        if cancellationPolicy != nil{
            aCoder.encode(cancellationPolicy, forKey: "cancellation_policy")
        }
        if cancelledBy != nil{
            aCoder.encode(cancelledBy, forKey: "cancelled_by")
        }
        if checkin != nil{
            aCoder.encode(checkin, forKey: "checkin")
        }
        if checkout != nil{
            aCoder.encode(checkout, forKey: "checkout")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if guestAccess != nil{
            aCoder.encode(guestAccess, forKey: "guest_access")
        }
        if guestId != nil{
            aCoder.encode(guestId, forKey: "guest_id")
        }
        if houseRules != nil{
            aCoder.encode(houseRules, forKey: "house_rules")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if interactGuest != nil{
            aCoder.encode(interactGuest, forKey: "interact_guest")
        }
        if isCanceled != nil{
            aCoder.encode(isCanceled, forKey: "is_canceled")
        }
        if loginUserType != nil{
            aCoder.encode(loginUserType, forKey: "loginUserType")
        }
        if neighborAround != nil{
            aCoder.encode(neighborAround, forKey: "neighbor_around")
        }
        if neighborOverview != nil{
            aCoder.encode(neighborOverview, forKey: "neighbor_overview")
        }
        if noofGuest != nil{
            aCoder.encode(noofGuest, forKey: "NoofGuest")
        }
        if numofdates != nil{
            aCoder.encode(numofdates, forKey: "numofdates")
        }
        if otherThingsToNote != nil{
            aCoder.encode(otherThingsToNote, forKey: "other_things_to_note")
        }
        if paidCurrencyCode != nil{
            aCoder.encode(paidCurrencyCode, forKey: "paid_currency_code")
        }
        if paidCurrencySymbol != nil{
            aCoder.encode(paidCurrencySymbol, forKey: "paid_currency_symbol")
        }
        if paymentStatus != nil{
            aCoder.encode(paymentStatus, forKey: "payment_status")
        }
        if postCode != nil{
            aCoder.encode(postCode, forKey: "post_code")
        }
        if propertyAddress != nil{
            aCoder.encode(propertyAddress, forKey: "property_address")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyCurrencySymbol != nil{
            aCoder.encode(propertyCurrencySymbol, forKey: "property_currency_symbol")
        }
        if propertyId != nil{
            aCoder.encode(propertyId, forKey: "property_id")
        }
        if propertyPrice != nil{
            aCoder.encode(propertyPrice, forKey: "property_price")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if securityDeposit != nil{
            aCoder.encode(securityDeposit, forKey: "security_deposit")
        }
        if serviceFee != nil{
            aCoder.encode(serviceFee, forKey: "service_fee")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }
        if subTotal != nil{
            aCoder.encode(subTotal, forKey: "sub_total")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "user_name")
        }
    }
}
