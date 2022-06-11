//
//  Accountinfo.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class Accountinfo : NSObject, NSCoding{

    var accname : String = ""
    var accno : String = ""
    var bankname : String = ""
    var country : Int = 0
    var created : String = ""
    var descriptionField : String = ""
    var displayLists : Bool = false 
    var dobDate : String = ""
    var dobMonth : String = ""
    var dobYear : String = ""
    var email : String = ""
    var emailNotifications : String = ""
    var expiredDate : String = ""
    var facebookId : String = ""
    var featureProduct : String = ""
    var firstname : String = ""
    var followersCount : String = ""
    var followingCount : String = ""
    var gender : String = ""
    var googleId : String = ""
    var group : String = ""
    var id : Int = 0
    var idVerified : Bool = false 
    var isBrand : Bool = false 
    var isVerified : Bool = false 
    var language : String = ""
    var languagesKnown : String = ""
    var lastLoginDate : String = ""
    var lastLogoutDate : String = ""
    var lastname : String = ""
    var linkedinId : String = ""
    var loginHit : String = ""
    var loginUserType : String = ""
    var notifications : String = ""
    var packageStatus : String = ""
    var phVerified : Bool = false 
    var phoneNo : String = ""
    var requestStatus : String = ""
    var searchByProfile : String = ""
    var socialRecommend : Bool = false 
    var status : String = ""
    var subscriber : Bool = false 
    var updates : String = ""
    var userImage : String = ""
    var verifyCode : String = ""
    var visibility : String = ""
    var whereYouLive : String = ""


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accname = dictionary["accname"] as? String ?? ""
        accno = dictionary["accno"] as? String ?? ""
        bankname = dictionary["bankname"] as? String ?? ""
        country = dictionary["country"] as? Int ?? 0
        created = dictionary["created"] as? String ?? ""
        descriptionField = dictionary["description"] as? String ?? ""
        displayLists = dictionary["display_lists"] as? Bool ?? false 
        dobDate = dictionary["dob_date"] as? String ?? ""
        dobMonth = dictionary["dob_month"] as? String ?? ""
        dobYear = dictionary["dob_year"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        emailNotifications = dictionary["email_notifications"] as? String ?? ""
        expiredDate = dictionary["expired_date"] as? String ?? ""
        facebookId = dictionary["facebook_id"] as? String ?? ""
        featureProduct = dictionary["feature_product"] as? String ?? ""
        firstname = dictionary["firstname"] as? String ?? ""
        followersCount = dictionary["followers_count"] as? String ?? ""
        followingCount = dictionary["following_count"] as? String ?? ""
        gender = dictionary["gender"] as? String ?? ""
        googleId = dictionary["google_id"] as? String ?? ""
        group = dictionary["group"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
        idVerified = dictionary["id_verified"] as? Bool ?? false
        isBrand = dictionary["is_brand"] as? Bool ?? false
        isVerified = dictionary["is_verified"] as? Bool ?? false
        language = dictionary["language"] as? String ?? ""
        languagesKnown = dictionary["languages_known"] as? String ?? ""
        lastLoginDate = dictionary["last_login_date"] as? String ?? ""
        lastLogoutDate = dictionary["last_logout_date"] as? String ?? ""
        lastname = dictionary["lastname"] as? String ?? ""
        linkedinId = dictionary["linkedin_id"] as? String ?? ""
        loginHit = dictionary["login_hit"] as? String ?? ""
        loginUserType = dictionary["loginUserType"] as? String ?? ""
        notifications = dictionary["notifications"] as? String ?? ""
        packageStatus = dictionary["package_status"] as? String ?? ""
        phVerified = dictionary["ph_verified"] as? Bool ?? false
        phoneNo = dictionary["phone_no"] as? String ?? ""
        requestStatus = dictionary["request_status"] as? String ?? ""
        searchByProfile = dictionary["search_by_profile"] as? String ?? ""
        socialRecommend = dictionary["social_recommend"] as? Bool ?? false
        status = dictionary["status"] as? String ?? ""
        subscriber = dictionary["subscriber"] as? Bool ?? false
        updates = dictionary["updates"] as? String ?? ""
        userImage = dictionary["user_image"] as? String ?? ""
        verifyCode = dictionary["verify_code"] as? String ?? ""
        visibility = dictionary["visibility"] as? String ?? ""
        whereYouLive = dictionary["where_you_live"] as? String ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accname != nil{
            dictionary["accname"] = accname
        }
        if accno != nil{
            dictionary["accno"] = accno
        }
        if bankname != nil{
            dictionary["bankname"] = bankname
        }
        if country != nil{
            dictionary["country"] = country
        }
        if created != nil{
            dictionary["created"] = created
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if displayLists != nil{
            dictionary["display_lists"] = displayLists
        }
        if dobDate != nil{
            dictionary["dob_date"] = dobDate
        }
        if dobMonth != nil{
            dictionary["dob_month"] = dobMonth
        }
        if dobYear != nil{
            dictionary["dob_year"] = dobYear
        }
        if email != nil{
            dictionary["email"] = email
        }
        if emailNotifications != nil{
            dictionary["email_notifications"] = emailNotifications
        }
        if expiredDate != nil{
            dictionary["expired_date"] = expiredDate
        }
        if facebookId != nil{
            dictionary["facebook_id"] = facebookId
        }
        if featureProduct != nil{
            dictionary["feature_product"] = featureProduct
        }
        if firstname != nil{
            dictionary["firstname"] = firstname
        }
        if followersCount != nil{
            dictionary["followers_count"] = followersCount
        }
        if followingCount != nil{
            dictionary["following_count"] = followingCount
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if googleId != nil{
            dictionary["google_id"] = googleId
        }
        if group != nil{
            dictionary["group"] = group
        }
        if id != nil{
            dictionary["id"] = id
        }
        if idVerified != nil{
            dictionary["id_verified"] = idVerified
        }
        if isBrand != nil{
            dictionary["is_brand"] = isBrand
        }
        if isVerified != nil{
            dictionary["is_verified"] = isVerified
        }
        if language != nil{
            dictionary["language"] = language
        }
        if languagesKnown != nil{
            dictionary["languages_known"] = languagesKnown
        }
        if lastLoginDate != nil{
            dictionary["last_login_date"] = lastLoginDate
        }
        if lastLogoutDate != nil{
            dictionary["last_logout_date"] = lastLogoutDate
        }
        if lastname != nil{
            dictionary["lastname"] = lastname
        }
        if linkedinId != nil{
            dictionary["linkedin_id"] = linkedinId
        }
        if loginHit != nil{
            dictionary["login_hit"] = loginHit
        }
        if loginUserType != nil{
            dictionary["loginUserType"] = loginUserType
        }
        if notifications != nil{
            dictionary["notifications"] = notifications
        }
        if packageStatus != nil{
            dictionary["package_status"] = packageStatus
        }
        if phVerified != nil{
            dictionary["ph_verified"] = phVerified
        }
        if phoneNo != nil{
            dictionary["phone_no"] = phoneNo
        }
        if requestStatus != nil{
            dictionary["request_status"] = requestStatus
        }
        if searchByProfile != nil{
            dictionary["search_by_profile"] = searchByProfile
        }
        if socialRecommend != nil{
            dictionary["social_recommend"] = socialRecommend
        }
        if status != nil{
            dictionary["status"] = status
        }
        if subscriber != nil{
            dictionary["subscriber"] = subscriber
        }
        if updates != nil{
            dictionary["updates"] = updates
        }
        if userImage != nil{
            dictionary["user_image"] = userImage
        }
        if verifyCode != nil{
            dictionary["verify_code"] = verifyCode
        }
        if visibility != nil{
            dictionary["visibility"] = visibility
        }
        if whereYouLive != nil{
            dictionary["where_you_live"] = whereYouLive
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accname = aDecoder.decodeObject(forKey: "accname") as? String ?? ""
        accno = aDecoder.decodeObject(forKey: "accno") as? String ?? ""
        bankname = aDecoder.decodeObject(forKey: "bankname") as? String ?? ""
        country = aDecoder.decodeObject(forKey: "country") as? Int ?? 0
        created = aDecoder.decodeObject(forKey: "created") as? String ?? ""
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        displayLists = aDecoder.decodeObject(forKey: "display_lists") as? Bool ?? false
        dobDate = aDecoder.decodeObject(forKey: "dob_date") as? String ?? ""
        dobMonth = aDecoder.decodeObject(forKey: "dob_month") as? String ?? ""
        dobYear = aDecoder.decodeObject(forKey: "dob_year") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        emailNotifications = aDecoder.decodeObject(forKey: "email_notifications") as? String ?? ""
        expiredDate = aDecoder.decodeObject(forKey: "expired_date") as? String ?? ""
        facebookId = aDecoder.decodeObject(forKey: "facebook_id") as? String ?? ""
        featureProduct = aDecoder.decodeObject(forKey: "feature_product") as? String ?? ""
        firstname = aDecoder.decodeObject(forKey: "firstname") as? String ?? ""
        followersCount = aDecoder.decodeObject(forKey: "followers_count") as? String ?? ""
        followingCount = aDecoder.decodeObject(forKey: "following_count") as? String ?? ""
        gender = aDecoder.decodeObject(forKey: "gender") as? String ?? ""
        googleId = aDecoder.decodeObject(forKey: "google_id") as? String ?? ""
        group = aDecoder.decodeObject(forKey: "group") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? Int ?? 0
        idVerified = aDecoder.decodeObject(forKey: "id_verified") as? Bool ?? false
        isBrand = aDecoder.decodeObject(forKey: "is_brand") as? Bool ?? false
        isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Bool ?? false
        language = aDecoder.decodeObject(forKey: "language") as? String ?? ""
        languagesKnown = aDecoder.decodeObject(forKey: "languages_known") as? String ?? ""
        lastLoginDate = aDecoder.decodeObject(forKey: "last_login_date") as? String ?? ""
        lastLogoutDate = aDecoder.decodeObject(forKey: "last_logout_date") as? String ?? ""
        lastname = aDecoder.decodeObject(forKey: "lastname") as? String ?? ""
        linkedinId = aDecoder.decodeObject(forKey: "linkedin_id") as? String ?? ""
        loginHit = aDecoder.decodeObject(forKey: "login_hit") as? String ?? ""
        loginUserType = aDecoder.decodeObject(forKey: "loginUserType") as? String ?? ""
        notifications = aDecoder.decodeObject(forKey: "notifications") as? String ?? ""
        packageStatus = aDecoder.decodeObject(forKey: "package_status") as? String ?? ""
        phVerified = aDecoder.decodeObject(forKey: "ph_verified") as? Bool ?? false
        phoneNo = aDecoder.decodeObject(forKey: "phone_no") as? String ?? ""
        requestStatus = aDecoder.decodeObject(forKey: "request_status") as? String ?? ""
        searchByProfile = aDecoder.decodeObject(forKey: "search_by_profile") as? String ?? ""
        socialRecommend = aDecoder.decodeObject(forKey: "social_recommend") as? Bool ?? false
        status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
        subscriber = aDecoder.decodeObject(forKey: "subscriber") as? Bool ?? false
        updates = aDecoder.decodeObject(forKey: "updates") as? String ?? ""
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String ?? ""
        verifyCode = aDecoder.decodeObject(forKey: "verify_code") as? String ?? ""
        visibility = aDecoder.decodeObject(forKey: "visibility") as? String ?? ""
        whereYouLive = aDecoder.decodeObject(forKey: "where_you_live") as? String ?? ""
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accname != nil{
            aCoder.encode(accname, forKey: "accname")
        }
        if accno != nil{
            aCoder.encode(accno, forKey: "accno")
        }
        if bankname != nil{
            aCoder.encode(bankname, forKey: "bankname")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if created != nil{
            aCoder.encode(created, forKey: "created")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if displayLists != nil{
            aCoder.encode(displayLists, forKey: "display_lists")
        }
        if dobDate != nil{
            aCoder.encode(dobDate, forKey: "dob_date")
        }
        if dobMonth != nil{
            aCoder.encode(dobMonth, forKey: "dob_month")
        }
        if dobYear != nil{
            aCoder.encode(dobYear, forKey: "dob_year")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if emailNotifications != nil{
            aCoder.encode(emailNotifications, forKey: "email_notifications")
        }
        if expiredDate != nil{
            aCoder.encode(expiredDate, forKey: "expired_date")
        }
        if facebookId != nil{
            aCoder.encode(facebookId, forKey: "facebook_id")
        }
        if featureProduct != nil{
            aCoder.encode(featureProduct, forKey: "feature_product")
        }
        if firstname != nil{
            aCoder.encode(firstname, forKey: "firstname")
        }
        if followersCount != nil{
            aCoder.encode(followersCount, forKey: "followers_count")
        }
        if followingCount != nil{
            aCoder.encode(followingCount, forKey: "following_count")
        }
        if gender != nil{
            aCoder.encode(gender, forKey: "gender")
        }
        if googleId != nil{
            aCoder.encode(googleId, forKey: "google_id")
        }
        if group != nil{
            aCoder.encode(group, forKey: "group")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if idVerified != nil{
            aCoder.encode(idVerified, forKey: "id_verified")
        }
        if isBrand != nil{
            aCoder.encode(isBrand, forKey: "is_brand")
        }
        if isVerified != nil{
            aCoder.encode(isVerified, forKey: "is_verified")
        }
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        if languagesKnown != nil{
            aCoder.encode(languagesKnown, forKey: "languages_known")
        }
        if lastLoginDate != nil{
            aCoder.encode(lastLoginDate, forKey: "last_login_date")
        }
        if lastLogoutDate != nil{
            aCoder.encode(lastLogoutDate, forKey: "last_logout_date")
        }
        if lastname != nil{
            aCoder.encode(lastname, forKey: "lastname")
        }
        if linkedinId != nil{
            aCoder.encode(linkedinId, forKey: "linkedin_id")
        }
        if loginHit != nil{
            aCoder.encode(loginHit, forKey: "login_hit")
        }
        if loginUserType != nil{
            aCoder.encode(loginUserType, forKey: "loginUserType")
        }
        if notifications != nil{
            aCoder.encode(notifications, forKey: "notifications")
        }
        if packageStatus != nil{
            aCoder.encode(packageStatus, forKey: "package_status")
        }
        if phVerified != nil{
            aCoder.encode(phVerified, forKey: "ph_verified")
        }
        if phoneNo != nil{
            aCoder.encode(phoneNo, forKey: "phone_no")
        }
        if requestStatus != nil{
            aCoder.encode(requestStatus, forKey: "request_status")
        }
        if searchByProfile != nil{
            aCoder.encode(searchByProfile, forKey: "search_by_profile")
        }
        if socialRecommend != nil{
            aCoder.encode(socialRecommend, forKey: "social_recommend")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if subscriber != nil{
            aCoder.encode(subscriber, forKey: "subscriber")
        }
        if updates != nil{
            aCoder.encode(updates, forKey: "updates")
        }
        if userImage != nil{
            aCoder.encode(userImage, forKey: "user_image")
        }
        if verifyCode != nil{
            aCoder.encode(verifyCode, forKey: "verify_code")
        }
        if visibility != nil{
            aCoder.encode(visibility, forKey: "visibility")
        }
        if whereYouLive != nil{
            aCoder.encode(whereYouLive, forKey: "where_you_live")
        }
    }
}
