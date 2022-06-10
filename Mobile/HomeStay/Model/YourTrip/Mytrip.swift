//
//  Mytrip.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 3, 2018

import Foundation


class Mytrip : NSObject, NSCoding{

    var approvalStatus : String!
    var bookedon : String!
    var bookingStatus : String!
    var bookingno : String!
    var cancelPercentage : String!
    var cancelShowStatus : Bool!
    var cancelStatus : String!
    var cancellationPolicy : String!
    var cancelledBy : String!
    var checkin : String!
    var checkout : String!
    var city : String!
    var country : String!
    var couponAmount : String!
    var creditCardStatus : String!
    var disputeShowStatus : Bool!
    var expiredate : String!
    var guestEmail : String!
    var guestId : Int!
    var hostId : Int!
    var hostName : String!
    var houseRules : String!
    var id : Int!
    var isCanceled : Bool!
    var isCouponUsed : String!
    var isDispute : Bool!
    var isPrevious : Bool!
    var isReview : Bool!
    var isWalletUsed : String!
    
    var noofGuest : Int!
    var numofdates : Int!
    var paidCurrencyCode : String!
    var paidCurrencySymbol : String!
    var payablePaypalCurrency : String!
    var payablePaypalSymbol : String!
    var payablePaypalTotal : String!
    var paypalStatus : String!
    var propertyAddress : String!
    var propertyCurrencyCode : String!
    var propertyCurrencySymbol : String!
    var propertyId : Int!
    var propertyImage : String!
    var propertyPrice : Float!
    var propertyTitle : String!
    var reviewShowStatus : Bool!
    var securityDeposit : Float!
    var serviceFee : Float!
    var showStatus : Bool!
    var state : String!
    var stripeStatus : String!
    var subTotal : AnyObject!
    var total : AnyObject!
    var userCurrencyCode : String!
    var userCurrencySymbol : String!
    var walletAmount : String!
    var walletBalanceAmount : String!
     var isBookingAllowed : String!
    var pay_later_availabe : AnyObject!
    var pay_later_balance_amount : AnyObject!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        approvalStatus = dictionary["approval_status"] as? String ?? ""
        pay_later_availabe = dictionary["pay_later_availabe"] as? AnyObject
        pay_later_balance_amount = dictionary["pay_later_balance_amount"] as? AnyObject

        bookedon = dictionary["bookedon"] as? String ?? ""
        bookingStatus = dictionary["booking_status"] as? String ?? ""
        bookingno = dictionary["bookingno"] as? String ?? ""
        cancelPercentage = dictionary["cancel_percentage"] as? String ?? ""
        cancelShowStatus = dictionary["cancel_show_status"] as? Bool ?? false
        cancelStatus = dictionary["cancel_status"] as? String ?? ""
        cancellationPolicy = dictionary["cancellation_policy"] as? String ?? ""
        cancelledBy = dictionary["cancelled_by"] as? String ?? ""
        checkin = dictionary["checkin"] as? String ?? ""
        checkout = dictionary["checkout"] as? String ?? ""
        city = dictionary["city"] as? String ?? ""
        country = dictionary["country"] as? String ?? ""
        couponAmount = dictionary["coupon_amount"] as? String ?? ""
        creditCardStatus = dictionary["Credit_Card_status"] as? String ?? ""
        disputeShowStatus = dictionary["dispute_show_status"] as? Bool ?? false
        expiredate = dictionary["expiredate"] as? String ?? ""
        guestEmail = dictionary["guest_email"] as? String ?? ""
        guestId = dictionary["guest_id"] as? Int ?? 0
        hostId = dictionary["host_id"] as? Int ?? 0
        hostName = dictionary["host_name"] as? String ?? ""
        houseRules = dictionary["house_rules"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
        isCanceled = dictionary["is_canceled"] as? Bool ?? false
        isCouponUsed = dictionary["is_coupon_used"] as? String ?? ""
        isDispute = dictionary["is_dispute"] as? Bool ?? false
        isPrevious = dictionary["is_previous"] as? Bool ?? false
        isReview = dictionary["is_review"] as? Bool ?? false
        isWalletUsed = dictionary["is_wallet_used"] as? String ?? ""
        
        noofGuest = dictionary["NoofGuest"] as? Int ?? 0
        numofdates = dictionary["numofdates"] as? Int ?? 0
        paidCurrencyCode = dictionary["paid_currency_code"] as? String ?? ""
        paidCurrencySymbol = dictionary["paid_currency_symbol"] as? String ?? ""
        payablePaypalCurrency = dictionary["payable_paypal_currency"] as? String ?? ""
        payablePaypalSymbol = dictionary["payable_paypal_symbol"] as? String ?? ""
        payablePaypalTotal = dictionary["payable_paypal_total"] as? String ?? ""
        paypalStatus = dictionary["paypal_status"] as? String ?? ""
        propertyAddress = dictionary["property_address"] as? String ?? ""
        propertyCurrencyCode = dictionary["property_currency_code"] as? String ?? ""
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String ?? ""
        propertyId = dictionary["property_id"] as? Int ?? 0
        propertyImage = dictionary["property_image"] as? String ?? ""
        propertyPrice = dictionary["property_price"] as? Float
        propertyTitle = dictionary["property_title"] as? String ?? ""
        reviewShowStatus = dictionary["review_show_status"] as? Bool ?? false
        securityDeposit = dictionary["security_deposit"] as? Float
        serviceFee = dictionary["service_fee"] as? Float
        showStatus = dictionary["show_status"] as? Bool ?? false
        state = dictionary["state"] as? String ?? ""
        stripeStatus = dictionary["Stripe_status"] as? String ?? ""
        subTotal = dictionary["sub_total"] as? AnyObject
        total = dictionary["total"] as AnyObject
        userCurrencyCode = dictionary["user_currency_code"] as? String ?? ""
        userCurrencySymbol = dictionary["user_currency_symbol"] as? String ?? ""
        walletAmount = dictionary["wallet_Amount"] as? String ?? ""
        walletBalanceAmount = dictionary["wallet_balance_amount"] as? String ?? ""
         isBookingAllowed = dictionary["is_booking_allowed"] as? String ?? ""
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
        if pay_later_availabe != nil{
            dictionary["pay_later_availabe"] = pay_later_availabe
        }
        if pay_later_balance_amount != nil{
            dictionary["pay_later_balance_amount"] = pay_later_balance_amount
        }
        if bookedon != nil{
            dictionary["bookedon"] = bookedon
        }
        if bookingStatus != nil{
            dictionary["booking_status"] = bookingStatus
        }
        if bookingno != nil{
            dictionary["bookingno"] = bookingno
        }
        if cancelPercentage != nil{
            dictionary["cancel_percentage"] = cancelPercentage
        }
        if cancelShowStatus != nil{
            dictionary["cancel_show_status"] = cancelShowStatus
        }
        if cancelStatus != nil{
            dictionary["cancel_status"] = cancelStatus
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
        if isBookingAllowed != nil{
            dictionary["is_booking_allowed"] = isBookingAllowed
        }
        if city != nil{
            dictionary["city"] = city
        }
        if country != nil{
            dictionary["country"] = country
        }
        if couponAmount != nil{
            dictionary["coupon_amount"] = couponAmount
        }
        if creditCardStatus != nil{
            dictionary["Credit_Card_status"] = creditCardStatus
        }
        if disputeShowStatus != nil{
            dictionary["dispute_show_status"] = disputeShowStatus
        }
        if expiredate != nil{
            dictionary["expiredate"] = expiredate
        }
        if guestEmail != nil{
            dictionary["guest_email"] = guestEmail
        }
        if guestId != nil{
            dictionary["guest_id"] = guestId
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if hostName != nil{
            dictionary["host_name"] = hostName
        }
        if houseRules != nil{
            dictionary["house_rules"] = houseRules
        }
        if id != nil{
            dictionary["id"] = id
        }
        if isCanceled != nil{
            dictionary["is_canceled"] = isCanceled
        }
        if isCouponUsed != nil{
            dictionary["is_coupon_used"] = isCouponUsed
        }
        if isDispute != nil{
            dictionary["is_dispute"] = isDispute
        }
        if isPrevious != nil{
            dictionary["is_previous"] = isPrevious
        }
        if isReview != nil{
            dictionary["is_review"] = isReview
        }
        if isWalletUsed != nil{
            dictionary["is_wallet_used"] = isWalletUsed
        }
        if noofGuest != nil{
            dictionary["NoofGuest"] = noofGuest
        }
        if numofdates != nil{
            dictionary["numofdates"] = numofdates
        }
        if paidCurrencyCode != nil{
            dictionary["paid_currency_code"] = paidCurrencyCode
        }
        if paidCurrencySymbol != nil{
            dictionary["paid_currency_symbol"] = paidCurrencySymbol
        }
        if payablePaypalCurrency != nil{
            dictionary["payable_paypal_currency"] = payablePaypalCurrency
        }
        if payablePaypalSymbol != nil{
            dictionary["payable_paypal_symbol"] = payablePaypalSymbol
        }
        if payablePaypalTotal != nil{
            dictionary["payable_paypal_total"] = payablePaypalTotal
        }
        if paypalStatus != nil{
            dictionary["paypal_status"] = paypalStatus
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
        if propertyImage != nil{
            dictionary["property_image"] = propertyImage
        }
        if propertyPrice != nil{
            dictionary["property_price"] = propertyPrice
        }
        if propertyTitle != nil{
            dictionary["property_title"] = propertyTitle
        }
        if reviewShowStatus != nil{
            dictionary["review_show_status"] = reviewShowStatus
        }
        if securityDeposit != nil{
            dictionary["security_deposit"] = securityDeposit
        }
        if serviceFee != nil{
            dictionary["service_fee"] = serviceFee
        }
        if showStatus != nil{
            dictionary["show_status"] = showStatus
        }
        if state != nil{
            dictionary["state"] = state
        }
        if stripeStatus != nil{
            dictionary["Stripe_status"] = stripeStatus
        }
        if subTotal != nil{
            dictionary["sub_total"] = subTotal
        }
        if total != nil{
            dictionary["total"] = total
        }
        if userCurrencyCode != nil{
            dictionary["user_currency_code"] = userCurrencyCode
        }
        if userCurrencySymbol != nil{
            dictionary["user_currency_symbol"] = userCurrencySymbol
        }
        if walletAmount != nil{
            dictionary["wallet_Amount"] = walletAmount
        }
        if walletBalanceAmount != nil{
            dictionary["wallet_balance_amount"] = walletBalanceAmount
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
        pay_later_availabe = aDecoder.decodeObject(forKey: "pay_later_availabe") as? AnyObject
        pay_later_balance_amount = aDecoder.decodeObject(forKey: "pay_later_balance_amount") as? AnyObject

        bookedon = aDecoder.decodeObject(forKey: "bookedon") as? String ?? ""
        bookingStatus = aDecoder.decodeObject(forKey: "booking_status") as? String ?? ""
        bookingno = aDecoder.decodeObject(forKey: "bookingno") as? String ?? ""
        cancelPercentage = aDecoder.decodeObject(forKey: "cancel_percentage") as? String ?? ""
        cancelShowStatus = aDecoder.decodeObject(forKey: "cancel_show_status") as? Bool ?? false
        cancelStatus = aDecoder.decodeObject(forKey: "cancel_status") as? String ?? ""
        cancellationPolicy = aDecoder.decodeObject(forKey: "cancellation_policy") as? String ?? ""
        cancelledBy = aDecoder.decodeObject(forKey: "cancelled_by") as? String ?? ""
        checkin = aDecoder.decodeObject(forKey: "checkin") as? String ?? ""
        checkout = aDecoder.decodeObject(forKey: "checkout") as? String ?? ""
        city = aDecoder.decodeObject(forKey: "city") as? String ?? ""
        country = aDecoder.decodeObject(forKey: "country") as? String ?? ""
        couponAmount = aDecoder.decodeObject(forKey: "coupon_amount") as? String ?? ""
        creditCardStatus = aDecoder.decodeObject(forKey: "Credit_Card_status") as? String ?? ""
        disputeShowStatus = aDecoder.decodeObject(forKey: "dispute_show_status") as? Bool ?? false
        expiredate = aDecoder.decodeObject(forKey: "expiredate") as? String ?? ""
        guestEmail = aDecoder.decodeObject(forKey: "guest_email") as? String ?? ""
        guestId = aDecoder.decodeObject(forKey: "guest_id") as? Int ?? 0
        hostId = aDecoder.decodeObject(forKey: "host_id") as? Int ?? 0
        hostName = aDecoder.decodeObject(forKey: "host_name") as? String ?? ""
        houseRules = aDecoder.decodeObject(forKey: "house_rules") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
        isCanceled = aDecoder.decodeObject(forKey: "is_canceled") as? Bool ?? false
        isCouponUsed = aDecoder.decodeObject(forKey: "is_coupon_used") as? String ?? ""
        isDispute = aDecoder.decodeObject(forKey: "is_dispute") as? Bool ?? false
        isPrevious = aDecoder.decodeObject(forKey: "is_previous") as? Bool ?? false
        isReview = aDecoder.decodeObject(forKey: "is_review") as? Bool ?? false
        isWalletUsed = aDecoder.decodeObject(forKey: "is_wallet_used") as? String ?? ""
         isBookingAllowed = aDecoder.decodeObject(forKey: "is_booking_allowed") as? String ?? ""
        noofGuest = aDecoder.decodeObject(forKey: "NoofGuest") as? Int ?? 0
        numofdates = aDecoder.decodeObject(forKey: "numofdates") as? Int ?? 0
        paidCurrencyCode = aDecoder.decodeObject(forKey: "paid_currency_code") as? String ?? ""
        paidCurrencySymbol = aDecoder.decodeObject(forKey: "paid_currency_symbol") as? String ?? ""
        payablePaypalCurrency = aDecoder.decodeObject(forKey: "payable_paypal_currency") as? String ?? ""
        payablePaypalSymbol = aDecoder.decodeObject(forKey: "payable_paypal_symbol") as? String ?? ""
        payablePaypalTotal = aDecoder.decodeObject(forKey: "payable_paypal_total") as? String ?? ""
        paypalStatus = aDecoder.decodeObject(forKey: "paypal_status") as? String ?? ""
        propertyAddress = aDecoder.decodeObject(forKey: "property_address") as? String ?? ""
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String ?? ""
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String ?? ""
        propertyId = aDecoder.decodeObject(forKey: "property_id") as? Int ?? 0
        propertyImage = aDecoder.decodeObject(forKey: "property_image") as? String ?? ""
        propertyPrice = aDecoder.decodeObject(forKey: "property_price") as? Float
        propertyTitle = aDecoder.decodeObject(forKey: "property_title") as? String ?? ""
        reviewShowStatus = aDecoder.decodeObject(forKey: "review_show_status") as? Bool ?? false
        securityDeposit = aDecoder.decodeObject(forKey: "security_deposit") as? Float
        serviceFee = aDecoder.decodeObject(forKey: "service_fee") as? Float
        showStatus = aDecoder.decodeObject(forKey: "show_status") as? Bool ?? false
        state = aDecoder.decodeObject(forKey: "state") as? String ?? ""
        stripeStatus = aDecoder.decodeObject(forKey: "Stripe_status") as? String ?? ""
        subTotal = aDecoder.decodeObject(forKey: "sub_total") as? AnyObject
        total = aDecoder.decodeObject(forKey: "total") as AnyObject
        userCurrencyCode = aDecoder.decodeObject(forKey: "user_currency_code") as? String ?? ""
        userCurrencySymbol = aDecoder.decodeObject(forKey: "user_currency_symbol") as? String ?? ""
        walletAmount = aDecoder.decodeObject(forKey: "wallet_Amount") as? String ?? ""
        walletBalanceAmount = aDecoder.decodeObject(forKey: "wallet_balance_amount") as? String ?? ""
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
        if pay_later_availabe != nil{
            aCoder.encode(pay_later_availabe, forKey: "pay_later_availabe")
        }
        if pay_later_balance_amount != nil{
            aCoder.encode(pay_later_balance_amount, forKey: "pay_later_balance_amount")
        }
        
        if bookedon != nil{
            aCoder.encode(bookedon, forKey: "bookedon")
        }
        if bookingStatus != nil{
            aCoder.encode(bookingStatus, forKey: "booking_status")
        }
        if bookingno != nil{
            aCoder.encode(bookingno, forKey: "bookingno")
        }
        if cancelPercentage != nil{
            aCoder.encode(cancelPercentage, forKey: "cancel_percentage")
        }
        if cancelShowStatus != nil{
            aCoder.encode(cancelShowStatus, forKey: "cancel_show_status")
        }
        if cancelStatus != nil{
            aCoder.encode(cancelStatus, forKey: "cancel_status")
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
        if couponAmount != nil{
            aCoder.encode(couponAmount, forKey: "coupon_amount")
        }
        if creditCardStatus != nil{
            aCoder.encode(creditCardStatus, forKey: "Credit_Card_status")
        }
        if disputeShowStatus != nil{
            aCoder.encode(disputeShowStatus, forKey: "dispute_show_status")
        }
        if expiredate != nil{
            aCoder.encode(expiredate, forKey: "expiredate")
        }
        if guestEmail != nil{
            aCoder.encode(guestEmail, forKey: "guest_email")
        }
        if guestId != nil{
            aCoder.encode(guestId, forKey: "guest_id")
        }
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if hostName != nil{
            aCoder.encode(hostName, forKey: "host_name")
        }
        if houseRules != nil{
            aCoder.encode(houseRules, forKey: "house_rules")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if isCanceled != nil{
            aCoder.encode(isCanceled, forKey: "is_canceled")
        }
        if isCouponUsed != nil{
            aCoder.encode(isCouponUsed, forKey: "is_coupon_used")
        }
        if isDispute != nil{
            aCoder.encode(isDispute, forKey: "is_dispute")
        }
        if isPrevious != nil{
            aCoder.encode(isPrevious, forKey: "is_previous")
        }
        if isReview != nil{
            aCoder.encode(isReview, forKey: "is_review")
        }
        if isWalletUsed != nil{
            aCoder.encode(isWalletUsed, forKey: "is_wallet_used")
        }
        if noofGuest != nil{
            aCoder.encode(noofGuest, forKey: "NoofGuest")
        }
        if numofdates != nil{
            aCoder.encode(numofdates, forKey: "numofdates")
        }
        if paidCurrencyCode != nil{
            aCoder.encode(paidCurrencyCode, forKey: "paid_currency_code")
        }
        if paidCurrencySymbol != nil{
            aCoder.encode(paidCurrencySymbol, forKey: "paid_currency_symbol")
        }
        if payablePaypalCurrency != nil{
            aCoder.encode(payablePaypalCurrency, forKey: "payable_paypal_currency")
        }
        if payablePaypalSymbol != nil{
            aCoder.encode(payablePaypalSymbol, forKey: "payable_paypal_symbol")
        }
        if payablePaypalTotal != nil{
            aCoder.encode(payablePaypalTotal, forKey: "payable_paypal_total")
        }
        if paypalStatus != nil{
            aCoder.encode(paypalStatus, forKey: "paypal_status")
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
        if propertyImage != nil{
            aCoder.encode(propertyImage, forKey: "property_image")
        }
        if propertyPrice != nil{
            aCoder.encode(propertyPrice, forKey: "property_price")
        }
        if propertyTitle != nil{
            aCoder.encode(propertyTitle, forKey: "property_title")
        }
        if reviewShowStatus != nil{
            aCoder.encode(reviewShowStatus, forKey: "review_show_status")
        }
        if securityDeposit != nil{
            aCoder.encode(securityDeposit, forKey: "security_deposit")
        }
        if serviceFee != nil{
            aCoder.encode(serviceFee, forKey: "service_fee")
        }
        if showStatus != nil{
            aCoder.encode(showStatus, forKey: "show_status")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }
        if stripeStatus != nil{
            aCoder.encode(stripeStatus, forKey: "Stripe_status")
        }
        if subTotal != nil{
            aCoder.encode(subTotal, forKey: "sub_total")
        }
        if total != nil{
            aCoder.encode(total, forKey: "total")
        }
        if userCurrencyCode != nil{
            aCoder.encode(userCurrencyCode, forKey: "user_currency_code")
        }
        if userCurrencySymbol != nil{
            aCoder.encode(userCurrencySymbol, forKey: "user_currency_symbol")
        }
        if walletAmount != nil{
            aCoder.encode(walletAmount, forKey: "wallet_Amount")
        }
        if walletBalanceAmount != nil{
            aCoder.encode(walletBalanceAmount, forKey: "wallet_balance_amount")
        }
    }
}
