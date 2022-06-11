//
//  PropertyDetail.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 28, 2018

import Foundation


class PropertyDetails : NSObject, NSCoding{
    
    var accommodates : String = ""
    var address : String = ""
    var bathrooms : String = ""
    var bedrooms : String = ""
    var beds : String = ""
    var cancellation : String = ""
    var check : [Check]!
    var city : String = ""
    var country : String = ""
    var datefrom : String = ""
    var dateto : String = ""
    var defaultproducttitle : String = ""
    var emailVerified : String = ""
    var facebook : String = ""
    var google : String = ""
    var guestAccess : String = ""
    var homeType : String = ""
    var hostEmail : String = ""
    var hostId : Int = 0
    var hostabout : String = ""
    var hostimg : String = ""
    var hostname : String = ""
    var houseRules : String = ""
    var idVerified : String = ""
    var instantPayStatus : Int = 0
    var requestToBookStatus : Bool = false 
    var interactGuest : String = ""
    var isFavourite : Int = 0
    var latitude : String = ""
    var listDetails : [ListDetail]!
    var listName : String = ""
    var listingInfo : [ListingInfo]!
    var loginUserType : String = ""
    var longitude : String = ""
    var memberSince : String = ""
    var message : String = ""
    var minimumStay : String = ""
    var monthPrice : String = ""
    var neighborAround : String = ""
    var neighborOverview : String = ""
    var otherThingsToNote : String = ""
    var phVerified : String = ""
    var postCode : String = ""
    var productImage : [ProductImage]!
    var productdesc : String = ""
    var productprice : AnyObject!
    var propertyCurrencyCode : String = ""
    var propertyCurrencySymbol : String = ""
    var propertyReviews : [PropertyReview]!
    var rentalId : Int = 0
    var seasonalCalendarPrice : [SeasonalCalendarPrice]!
    var securityDeposit : AnyObject!
    var services : Service!
    var starRating : Int = 0
    var state : String = ""
    var status : Int = 0
    var totalReviewCount : Int = 0
    var url : String = ""
    var userAbout : String = ""
    var userCurrency : String = ""
    var userAddress : String = ""
    var weekPrice : String = ""
    var productSpace : String = ""
    var couponDetails : [CouponDetail]!
    var min_hour_price : String = ""
    var booking_type : String = ""
     var min_hour : Int = 0
     var min_days : Int = 0
    var guest_capacity : String = ""
    var over_all_rating : AnyObject!
    var rental_hourly_price : String = ""
    var host_status : String = ""
    var guest_status : String = ""
    var min_hour_exprice : String = ""
    var pay_later_status : AnyObject!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        rental_hourly_price = dictionary["rental_hourly_price"] as? String ?? ""
        min_hour_exprice = dictionary["min_hour_exprice"] as? String ?? ""
        pay_later_status = dictionary["pay_later_status"] as? AnyObject

        host_status = dictionary["host_status"] as? String ?? ""
        guest_status = dictionary["guest_status"] as? String ?? ""

        over_all_rating = dictionary["over_all_rating"] as? AnyObject
        min_hour_price = dictionary["min_hour_price"] as? String ?? ""
         booking_type = dictionary["booking_type"] as? String ?? ""
         productSpace = dictionary["product_space"] as? String ?? ""
        accommodates = dictionary["accommodates"] as? String ?? ""
        address = dictionary["address"] as? String ?? ""
        bathrooms = dictionary["bathrooms"] as? String ?? ""
        bedrooms = dictionary["bedrooms"] as? String ?? ""
        beds = dictionary["beds"] as? String ?? ""
        cancellation = dictionary["cancellation"] as? String ?? ""
        city = dictionary["city"] as? String ?? ""
        country = dictionary["country"] as? String ?? ""
        datefrom = dictionary["datefrom"] as? String ?? ""
        dateto = dictionary["dateto"] as? String ?? ""
        defaultproducttitle = dictionary["defaultproducttitle"] as? String ?? ""
        emailVerified = dictionary["email_verified"] as? String ?? ""
        facebook = dictionary["facebook"] as? String ?? ""
        google = dictionary["google"] as? String ?? ""
        guestAccess = dictionary["guest_access"] as? String ?? ""
         guest_capacity = dictionary["guest_capacity"] as? String ?? ""
        homeType = dictionary["home_type"] as? String ?? ""
        hostEmail = dictionary["host_email"] as? String ?? ""
        hostId = dictionary["host_id"] as? Int ?? 0
         min_hour = dictionary["min_hour"] as? Int ?? 0
          min_days = dictionary["min_days"] as? Int ?? 0
        hostabout = dictionary["hostabout"] as? String ?? ""
        hostimg = dictionary["hostimg"] as? String ?? ""
        hostname = dictionary["hostname"] as? String ?? ""
        houseRules = dictionary["house_rules"] as? String ?? ""
        idVerified = dictionary["id_verified"] as? String ?? ""
        instantPayStatus = dictionary["instant_pay_status"] as? Int ?? 0
        requestToBookStatus = dictionary["request_to_book_status"] as? Bool ?? false
        interactGuest = dictionary["interact_guest"] as? String ?? ""
        isFavourite = dictionary["is_favourite"] as? Int ?? 0
        latitude = dictionary["latitude"] as? String ?? ""
        listName = dictionary["list_name"] as? String ?? ""
        loginUserType = dictionary["loginUserType"] as? String ?? ""
        longitude = dictionary["longitude"] as? String ?? ""
        memberSince = dictionary["member_since"] as? String ?? ""
        message = dictionary["message"] as? String ?? ""
        minimumStay = dictionary["minimum_stay"] as? String ?? ""
        monthPrice = dictionary["month_price"] as? String ?? ""
        neighborAround = dictionary["neighbor_around"] as? String ?? ""
        neighborOverview = dictionary["neighbor_overview"] as? String ?? ""
        otherThingsToNote = dictionary["other_things_to_note"] as? String ?? ""
        phVerified = dictionary["ph_verified"] as? String ?? ""
        postCode = dictionary["post_code"] as? String ?? ""
        productdesc = dictionary["productdesc"] as? String ?? ""
        productprice = dictionary["product_price"] as? AnyObject
        propertyCurrencyCode = dictionary["property_currency_code"] as? String ?? ""
        propertyCurrencySymbol = dictionary["property_currency_symbol"] as? String ?? ""
        rentalId = dictionary["rental_id"] as? Int ?? 0
        securityDeposit = dictionary["security_deposit"] as? AnyObject
        starRating = dictionary["star_rating"] as? Int ?? 0
        state = dictionary["state"] as? String ?? ""
        status = dictionary["status"] as? Int ?? 0
        totalReviewCount = dictionary["total_review_count"] as? Int ?? 0
        url = dictionary["url"] as? String ?? ""
        userAbout = dictionary["user_about"] as? String ?? ""
        userCurrency = dictionary["user_currency"] as? String ?? ""
        userAddress = dictionary["userAddress"] as? String ?? ""
        weekPrice = dictionary["week_price"] as? String ?? ""
        if let servicesData = dictionary["services"] as? [String:Any]{
            services = Service(fromDictionary: servicesData)
        }
        check = [Check]()
        if let checkArray = dictionary["check"] as? [[String:Any]]{
            for dic in checkArray{
                let value = Check(fromDictionary: dic)
                check.append(value)
            }
        }
        listDetails = [ListDetail]()
        if let listDetailsArray = dictionary["list_details"] as? [[String:Any]]{
            for dic in listDetailsArray{
                let value = ListDetail(fromDictionary: dic)
                listDetails.append(value)
            }
        }
        listingInfo = [ListingInfo]()
        if let listingInfoArray = dictionary["listing_info"] as? [[String:Any]]{
            for dic in listingInfoArray{
                let value = ListingInfo(fromDictionary: dic)
                listingInfo.append(value)
            }
        }
        productImage = [ProductImage]()
        if let productImageArray = dictionary["product_image"] as? [[String:Any]]{
            for dic in productImageArray{
                let value = ProductImage(fromDictionary: dic)
                productImage.append(value)
            }
        }
        propertyReviews = [PropertyReview]()
        if let propertyReviewsArray = dictionary["property_reviews"] as? [[String:Any]]{
            for dic in propertyReviewsArray{
                let value = PropertyReview(fromDictionary: dic)
                propertyReviews.append(value)
            }
        }
        seasonalCalendarPrice = [SeasonalCalendarPrice]()
        if let seasonalCalendarPriceArray = dictionary["seasonal_calendar_price"] as? [[String:Any]]{
            for dic in seasonalCalendarPriceArray{
                let value = SeasonalCalendarPrice(fromDictionary: dic)
                seasonalCalendarPrice.append(value)
            }
        }
        couponDetails = [CouponDetail]()
        if let couponDetailsArray = dictionary["coupon_details"] as? [[String:Any]]{
            for dic in couponDetailsArray{
                let value = CouponDetail(fromDictionary: dic)
                couponDetails.append(value)
            }
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accommodates != nil{
            dictionary["accommodates"] = accommodates
        }
        if rental_hourly_price != nil{
            dictionary["rental_hourly_price"] = rental_hourly_price
        }
        if pay_later_status != nil{
            dictionary["pay_later_status"] = pay_later_status
        }

        if min_hour_exprice != nil{
            dictionary["min_hour_exprice"] = min_hour_exprice
        }
        if over_all_rating != nil{
            dictionary["over_all_rating"] = over_all_rating
        }
        if productSpace != nil{
            dictionary["product_space"] = productSpace
        }
        if address != nil{
            dictionary["address"] = address
        }
        if guest_status != nil{
            dictionary["guest_status"] = guest_status
        }
        if host_status != nil{
            dictionary["host_status"] = host_status
        }
        if bathrooms != nil{
            dictionary["bathrooms"] = bathrooms
        }
        if bedrooms != nil{
            dictionary["bedrooms"] = bedrooms
        }
        if beds != nil{
            dictionary["beds"] = beds
        }
        if cancellation != nil{
            dictionary["cancellation"] = cancellation
        }
        if city != nil{
            dictionary["city"] = city
        }
        if country != nil{
            dictionary["country"] = country
        }
        if datefrom != nil{
            dictionary["datefrom"] = datefrom
        }
        if dateto != nil{
            dictionary["dateto"] = dateto
        }
        if defaultproducttitle != nil{
            dictionary["defaultproducttitle"] = defaultproducttitle
        }
        if emailVerified != nil{
            dictionary["email_verified"] = emailVerified
        }
        if facebook != nil{
            dictionary["facebook"] = facebook
        }
        if google != nil{
            dictionary["google"] = google
        }
        if guestAccess != nil{
            dictionary["guest_access"] = guestAccess
        }
        if guest_capacity != nil{
                   dictionary["guest_capacity"] = guest_capacity
               }
        if homeType != nil{
            dictionary["home_type"] = homeType
        }
        if hostEmail != nil{
            dictionary["host_email"] = hostEmail
        }
        if hostId != nil{
            dictionary["host_id"] = hostId
        }
        if min_days != nil{
                  dictionary["min_days"] = min_days
              }
        
        if min_hour != nil{
                   dictionary["min_hour"] = min_hour
               }
        
        if hostabout != nil{
            dictionary["hostabout"] = hostabout
        }
        if hostimg != nil{
            dictionary["hostimg"] = hostimg
        }
        if hostname != nil{
            dictionary["hostname"] = hostname
        }
        if houseRules != nil{
            dictionary["house_rules"] = houseRules
        }
        if idVerified != nil{
            dictionary["id_verified"] = idVerified
        }
        if instantPayStatus != nil{
            dictionary["instant_pay_status"] = instantPayStatus
        }
        if requestToBookStatus != nil{
            dictionary["request_to_book_status"] = requestToBookStatus
        }
        if interactGuest != nil{
            dictionary["interact_guest"] = interactGuest
        }
        if isFavourite != nil{
            dictionary["is_favourite"] = isFavourite
        }
        if latitude != nil{
            dictionary["latitude"] = latitude
        }
        if listName != nil{
            dictionary["list_name"] = listName
        }
        if loginUserType != nil{
            dictionary["loginUserType"] = loginUserType
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if memberSince != nil{
            dictionary["member_since"] = memberSince
        }
        if message != nil{
            dictionary["message"] = message
        }
        if minimumStay != nil{
            dictionary["minimum_stay"] = minimumStay
        }
        if monthPrice != nil{
            dictionary["month_price"] = monthPrice
        }
        if min_hour_price != nil{
                   dictionary["min_hour_price"] = min_hour_price
               }
        if booking_type != nil{
                          dictionary["booking_type"] = booking_type
                      }
        if neighborAround != nil{
            dictionary["neighbor_around"] = neighborAround
        }
        if neighborOverview != nil{
            dictionary["neighbor_overview"] = neighborOverview
        }
        if otherThingsToNote != nil{
            dictionary["other_things_to_note"] = otherThingsToNote
        }
        if phVerified != nil{
            dictionary["ph_verified"] = phVerified
        }
        if postCode != nil{
            dictionary["post_code"] = postCode
        }
        if productdesc != nil{
            dictionary["productdesc"] = productdesc
        }
        if productprice != nil{
            dictionary["product_price"] = productprice
        }
        if propertyCurrencyCode != nil{
            dictionary["property_currency_code"] = propertyCurrencyCode
        }
        if propertyCurrencySymbol != nil{
            dictionary["property_currency_symbol"] = propertyCurrencySymbol
        }
        if rentalId != nil{
            dictionary["rental_id"] = rentalId
        }
        if securityDeposit != nil{
            dictionary["security_deposit"] = securityDeposit
        }
        if starRating != nil{
            dictionary["star_rating"] = starRating
        }
        if state != nil{
            dictionary["state"] = state
        }
        if status != nil{
            dictionary["status"] = status
        }
        if totalReviewCount != nil{
            dictionary["total_review_count"] = totalReviewCount
        }
        if url != nil{
            dictionary["url"] = url
        }
        if userAbout != nil{
            dictionary["user_about"] = userAbout
        }
        if userCurrency != nil{
            dictionary["user_currency"] = userCurrency
        }
        if userAddress != nil{
            dictionary["userAddress"] = userAddress
        }
        if weekPrice != nil{
            dictionary["week_price"] = weekPrice
        }
        if services != nil{
            dictionary["services"] = services.toDictionary()
        }
        if check != nil{
            var dictionaryElements = [[String:Any]]()
            for checkElement in check {
                dictionaryElements.append(checkElement.toDictionary())
            }
            dictionary["check"] = dictionaryElements
        }
        if listDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for listDetailsElement in listDetails {
                dictionaryElements.append(listDetailsElement.toDictionary())
            }
            dictionary["listDetails"] = dictionaryElements
        }
        if listingInfo != nil{
            var dictionaryElements = [[String:Any]]()
            for listingInfoElement in listingInfo {
                dictionaryElements.append(listingInfoElement.toDictionary())
            }
            dictionary["listingInfo"] = dictionaryElements
        }
        if productImage != nil{
            var dictionaryElements = [[String:Any]]()
            for productImageElement in productImage {
                dictionaryElements.append(productImageElement.toDictionary())
            }
            dictionary["productImage"] = dictionaryElements
        }
        if propertyReviews != nil{
            var dictionaryElements = [[String:Any]]()
            for propertyReviewsElement in propertyReviews {
                dictionaryElements.append(propertyReviewsElement.toDictionary())
            }
            dictionary["propertyReviews"] = dictionaryElements
        }
        if seasonalCalendarPrice != nil{
            var dictionaryElements = [[String:Any]]()
            for seasonalCalendarPriceElement in seasonalCalendarPrice {
                dictionaryElements.append(seasonalCalendarPriceElement.toDictionary())
            }
            dictionary["seasonalCalendarPrice"] = dictionaryElements
        }
        if couponDetails != nil{
            var dictionaryElements = [[String:Any]]()
            for couponDetailsElement in couponDetails {
                dictionaryElements.append(couponDetailsElement.toDictionary())
            }
            dictionary["couponDetails"] = dictionaryElements
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        min_hour_exprice = aDecoder.decodeObject(forKey: "min_hour_exprice") as? String ?? ""
        pay_later_status = aDecoder.decodeObject(forKey: "pay_later_status") as? AnyObject


        rental_hourly_price = aDecoder.decodeObject(forKey: "rental_hourly_price") as? String ?? ""
        host_status = aDecoder.decodeObject(forKey: "host_status") as? String ?? ""
        guest_status = aDecoder.decodeObject(forKey: "guest_status") as? String ?? ""

        over_all_rating = aDecoder.decodeObject(forKey: "over_all_rating") as? AnyObject
        productSpace = aDecoder.decodeObject(forKey: "product_space") as? String ?? ""
         min_hour_price = aDecoder.decodeObject(forKey: "min_hour_price") as? String ?? ""
         booking_type = aDecoder.decodeObject(forKey: "booking_type") as? String ?? ""
        
        accommodates = aDecoder.decodeObject(forKey: "accommodates") as? String ?? ""
        address = aDecoder.decodeObject(forKey: "address") as? String ?? ""
        bathrooms = aDecoder.decodeObject(forKey: "bathrooms") as? String ?? ""
        bedrooms = aDecoder.decodeObject(forKey: "bedrooms") as? String ?? ""
        beds = aDecoder.decodeObject(forKey: "beds") as? String ?? ""
        cancellation = aDecoder.decodeObject(forKey: "cancellation") as? String ?? ""
        check = aDecoder.decodeObject(forKey: "check") as? [Check]
        city = aDecoder.decodeObject(forKey: "city") as? String ?? ""
        country = aDecoder.decodeObject(forKey: "country") as? String ?? ""
        datefrom = aDecoder.decodeObject(forKey: "datefrom") as? String ?? ""
        dateto = aDecoder.decodeObject(forKey: "dateto") as? String ?? ""
        defaultproducttitle = aDecoder.decodeObject(forKey: "defaultproducttitle") as? String ?? ""
        emailVerified = aDecoder.decodeObject(forKey: "email_verified") as? String ?? ""
        facebook = aDecoder.decodeObject(forKey: "facebook") as? String ?? ""
        google = aDecoder.decodeObject(forKey: "google") as? String ?? ""
        guestAccess = aDecoder.decodeObject(forKey: "guest_access") as? String ?? ""
         guest_capacity = aDecoder.decodeObject(forKey: "guest_capacity") as? String ?? ""
        homeType = aDecoder.decodeObject(forKey: "home_type") as? String ?? ""
        hostEmail = aDecoder.decodeObject(forKey: "host_email") as? String ?? ""
        hostId = aDecoder.decodeObject(forKey: "host_id") as? Int ?? 0
         min_hour = aDecoder.decodeObject(forKey: "min_hour") as? Int ?? 0
         min_days = aDecoder.decodeObject(forKey: "min_days") as? Int ?? 0
        
        hostabout = aDecoder.decodeObject(forKey: "hostabout") as? String ?? ""
        hostimg = aDecoder.decodeObject(forKey: "hostimg") as? String ?? ""
        hostname = aDecoder.decodeObject(forKey: "hostname") as? String ?? ""
        houseRules = aDecoder.decodeObject(forKey: "house_rules") as? String ?? ""
        idVerified = aDecoder.decodeObject(forKey: "id_verified") as? String ?? ""
        instantPayStatus = aDecoder.decodeObject(forKey: "instant_pay_status") as? Int ?? 0
        requestToBookStatus = aDecoder.decodeObject(forKey: "request_to_book_status") as? Bool ?? false
        interactGuest = aDecoder.decodeObject(forKey: "interact_guest") as? String ?? ""
        isFavourite = aDecoder.decodeObject(forKey: "is_favourite") as? Int ?? 0
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String ?? ""
        listDetails = aDecoder.decodeObject(forKey: "list_details") as? [ListDetail]
        listName = aDecoder.decodeObject(forKey: "list_name") as? String ?? ""
        listingInfo = aDecoder.decodeObject(forKey: "listing_info") as? [ListingInfo]
        loginUserType = aDecoder.decodeObject(forKey: "loginUserType") as? String ?? ""
        longitude = aDecoder.decodeObject(forKey: "longitude") as? String ?? ""
        memberSince = aDecoder.decodeObject(forKey: "member_since") as? String ?? ""
        message = aDecoder.decodeObject(forKey: "message") as? String ?? ""
        minimumStay = aDecoder.decodeObject(forKey: "minimum_stay") as? String ?? ""
        monthPrice = aDecoder.decodeObject(forKey: "month_price") as? String ?? ""
        neighborAround = aDecoder.decodeObject(forKey: "neighbor_around") as? String ?? ""
        neighborOverview = aDecoder.decodeObject(forKey: "neighbor_overview") as? String ?? ""
        otherThingsToNote = aDecoder.decodeObject(forKey: "other_things_to_note") as? String ?? ""
        phVerified = aDecoder.decodeObject(forKey: "ph_verified") as? String ?? ""
        postCode = aDecoder.decodeObject(forKey: "post_code") as? String ?? ""
        productImage = aDecoder.decodeObject(forKey: "product_image") as? [ProductImage]
        productdesc = aDecoder.decodeObject(forKey: "productdesc") as? String ?? ""
        productprice = aDecoder.decodeObject(forKey: "product_price") as?  AnyObject
        propertyCurrencyCode = aDecoder.decodeObject(forKey: "property_currency_code") as? String ?? ""
        propertyCurrencySymbol = aDecoder.decodeObject(forKey: "property_currency_symbol") as? String ?? ""
        propertyReviews = aDecoder.decodeObject(forKey: "property_reviews") as? [PropertyReview]
        rentalId = aDecoder.decodeObject(forKey: "rental_id") as? Int ?? 0
        
        seasonalCalendarPrice = aDecoder.decodeObject(forKey: "seasonal_calendar_price") as? [SeasonalCalendarPrice]
        services = aDecoder.decodeObject(forKey: "services") as? Service
        starRating = aDecoder.decodeObject(forKey: "star_rating") as? Int ?? 0
        state = aDecoder.decodeObject(forKey: "state") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? Int ?? 0
        totalReviewCount = aDecoder.decodeObject(forKey: "total_review_count") as? Int ?? 0
        url = aDecoder.decodeObject(forKey: "url") as? String ?? ""
        userAbout = aDecoder.decodeObject(forKey: "user_about") as? String ?? ""
        userCurrency = aDecoder.decodeObject(forKey: "user_currency") as? String ?? ""
        userAddress = aDecoder.decodeObject(forKey: "userAddress") as? String ?? ""
        weekPrice = aDecoder.decodeObject(forKey: "week_price") as? String ?? ""
         couponDetails = aDecoder.decodeObject(forKey: "coupon_details") as? [CouponDetail]
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accommodates != nil{
            aCoder.encode(accommodates, forKey: "accommodates")
        }
        if guest_status != nil{
            aCoder.encode(guest_status, forKey: "guest_status")
        }
        if pay_later_status != nil{
            aCoder.encode(pay_later_status, forKey: "pay_later_status")
        }
        if rental_hourly_price != nil{
            aCoder.encode(rental_hourly_price, forKey: "rental_hourly_price")
        }
        if min_hour_exprice != nil{
            aCoder.encode(min_hour_exprice, forKey: "min_hour_exprice")
        }
        if over_all_rating != nil{
            aCoder.encode(over_all_rating, forKey: "over_all_rating")
        }
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if host_status != nil{
            aCoder.encode(host_status, forKey: "host_status")
        }
        if bathrooms != nil{
            aCoder.encode(bathrooms, forKey: "bathrooms")
        }
        if bedrooms != nil{
            aCoder.encode(bedrooms, forKey: "bedrooms")
        }
        if beds != nil{
            aCoder.encode(beds, forKey: "beds")
        }
        if cancellation != nil{
            aCoder.encode(cancellation, forKey: "cancellation")
        }
        if check != nil{
            aCoder.encode(check, forKey: "check")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        
        if min_hour_price != nil{
                  aCoder.encode(min_hour_price, forKey: "min_hour_price")
              }
        
        if datefrom != nil{
            aCoder.encode(datefrom, forKey: "datefrom")
        }
        if productSpace != nil{
            aCoder.encode(productSpace, forKey: "product_space")
        }
        if dateto != nil{
            aCoder.encode(dateto, forKey: "dateto")
        }
        if defaultproducttitle != nil{
            aCoder.encode(defaultproducttitle, forKey: "defaultproducttitle")
        }
        if emailVerified != nil{
            aCoder.encode(emailVerified, forKey: "email_verified")
        }
        if facebook != nil{
            aCoder.encode(facebook, forKey: "facebook")
        }
        if google != nil{
            aCoder.encode(google, forKey: "google")
        }
        if guestAccess != nil{
            aCoder.encode(guestAccess, forKey: "guest_access")
        }
        if guest_capacity != nil{
                   aCoder.encode(guest_capacity, forKey: "guest_capacity")
               }
        if homeType != nil{
            aCoder.encode(homeType, forKey: "home_type")
        }
        if hostEmail != nil{
            aCoder.encode(hostEmail, forKey: "host_email")
        }
        if hostId != nil{
            aCoder.encode(hostId, forKey: "host_id")
        }
        if min_hour != nil{
                   aCoder.encode(min_hour, forKey: "min_hour")
               }
        if min_days != nil{
                         aCoder.encode(min_days, forKey: "min_days")
                     }
        if hostabout != nil{
            aCoder.encode(hostabout, forKey: "hostabout")
        }
        if hostimg != nil{
            aCoder.encode(hostimg, forKey: "hostimg")
        }
        if hostname != nil{
            aCoder.encode(hostname, forKey: "hostname")
        }
        if houseRules != nil{
            aCoder.encode(houseRules, forKey: "house_rules")
        }
        if idVerified != nil{
            aCoder.encode(idVerified, forKey: "id_verified")
        }
        if instantPayStatus != nil{
            aCoder.encode(instantPayStatus, forKey: "instant_pay_status")
        }
        if requestToBookStatus != nil{
            aCoder.encode(requestToBookStatus, forKey: "request_to_book_status")
        }
        if interactGuest != nil{
            aCoder.encode(interactGuest, forKey: "interact_guest")
        }
        if isFavourite != nil{
            aCoder.encode(isFavourite, forKey: "is_favourite")
        }
        if latitude != nil{
            aCoder.encode(latitude, forKey: "latitude")
        }
        if listDetails != nil{
            aCoder.encode(listDetails, forKey: "list_details")
        }
        if listName != nil{
            aCoder.encode(listName, forKey: "list_name")
        }
        if listingInfo != nil{
            aCoder.encode(listingInfo, forKey: "listing_info")
        }
        if loginUserType != nil{
            aCoder.encode(loginUserType, forKey: "loginUserType")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if memberSince != nil{
            aCoder.encode(memberSince, forKey: "member_since")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if minimumStay != nil{
            aCoder.encode(minimumStay, forKey: "minimum_stay")
        }
        if monthPrice != nil{
            aCoder.encode(monthPrice, forKey: "month_price")
        }
        if booking_type != nil{
                  aCoder.encode(booking_type, forKey: "booking_type")
              }
        if neighborAround != nil{
            aCoder.encode(neighborAround, forKey: "neighbor_around")
        }
        if neighborOverview != nil{
            aCoder.encode(neighborOverview, forKey: "neighbor_overview")
        }
        if otherThingsToNote != nil{
            aCoder.encode(otherThingsToNote, forKey: "other_things_to_note")
        }
        if phVerified != nil{
            aCoder.encode(phVerified, forKey: "ph_verified")
        }
        if postCode != nil{
            aCoder.encode(postCode, forKey: "post_code")
        }
        if productImage != nil{
            aCoder.encode(productImage, forKey: "product_image")
        }
        if productdesc != nil{
            aCoder.encode(productdesc, forKey: "productdesc")
        }
        if productprice != nil{
            aCoder.encode(productprice, forKey: "product_price")
        }
        if propertyCurrencyCode != nil{
            aCoder.encode(propertyCurrencyCode, forKey: "property_currency_code")
        }
        if propertyCurrencySymbol != nil{
            aCoder.encode(propertyCurrencySymbol, forKey: "property_currency_symbol")
        }
        if propertyReviews != nil{
            aCoder.encode(propertyReviews, forKey: "property_reviews")
        }
        if rentalId != nil{
            aCoder.encode(rentalId, forKey: "rental_id")
        }
        if seasonalCalendarPrice != nil{
            aCoder.encode(seasonalCalendarPrice, forKey: "seasonal_calendar_price")
        }
        if securityDeposit != nil{
            aCoder.encode(securityDeposit, forKey: "security_deposit")
        }
        if services != nil{
            aCoder.encode(services, forKey: "services")
        }
        if starRating != nil{
            aCoder.encode(starRating, forKey: "star_rating")
        }
        if state != nil{
            aCoder.encode(state, forKey: "state")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if totalReviewCount != nil{
            aCoder.encode(totalReviewCount, forKey: "total_review_count")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if userAbout != nil{
            aCoder.encode(userAbout, forKey: "user_about")
        }
        if userCurrency != nil{
            aCoder.encode(userCurrency, forKey: "user_currency")
        }
        if userAddress != nil{
            aCoder.encode(userAddress, forKey: "userAddress")
        }
        if weekPrice != nil{
            aCoder.encode(weekPrice, forKey: "week_price")
        }
        if couponDetails != nil{
            aCoder.encode(couponDetails, forKey: "coupon_details")
        }
    }
}
