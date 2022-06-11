//
//  Step9.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on August 10, 2018

import Foundation


class Step9 : NSObject, NSCoding{
    
    var baseId : String = ""
    var cancelDescription : String = ""
    var cancelDescriptionPh : String = ""
    var cancelPercentage : String = ""
    var cancellationPolicy : String = ""
    var cancellationPolicyDescription : String = ""
    var cancellationPolicyTitle : String = ""
    var metaDescription : String = ""
    var metaDescriptionPh : String = ""
    var metaKeyword : String = ""
    var metaKeywordPh : String = ""
    var metaTitle : String = ""
    var metaTitlePh : String = ""
    var propertyCurrency : String = ""
    var propertyid : Int = 0
    var securityDeposit : String = ""
    var stepCompleted : Bool = false 
    
    var ren_tax_percent : AnyObject!
    var cancel_policy_type : String = ""
    var sec_dep : Int = 0
    var seo_tags : Language!
    var ren_details : Lang!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseId = dictionary["base_id"] as? String ?? ""
        cancelDescription = dictionary["cancel_description"] as? String ?? ""
        cancelDescriptionPh = dictionary["cancel_description_ph"] as? String ?? ""
        cancelPercentage = dictionary["cancel_percentage"] as? String ?? ""
        cancellationPolicy = dictionary["cancellation_policy"] as? String ?? ""
        cancellationPolicyDescription = dictionary["cancellation_policy_description"] as? String ?? ""
        cancellationPolicyTitle = dictionary["cancellation_policy_title"] as? String ?? ""
        metaDescription = dictionary["ren_meta_desc"] as? String ?? ""
        metaDescriptionPh = dictionary["meta_description_ph"] as? String ?? ""
        metaKeyword = dictionary["meta_keyword"] as? String ?? ""
        metaKeywordPh = dictionary["meta_keyword_ph"] as? String ?? ""
        metaTitle = dictionary["ren_meta_title"] as? String ?? ""
        metaTitlePh = dictionary["ren_meta_title_ph"] as? String ?? ""
        propertyCurrency = dictionary["property_currency"] as? String ?? ""
        propertyid = dictionary["propertyid"] as? Int ?? 0
        securityDeposit = dictionary["security_deposit"] as? String ?? ""
        stepCompleted = dictionary["step_completed"] as? Bool ?? false
        ren_tax_percent = dictionary["ren_tax_percent"] as? AnyObject
        cancel_policy_type = dictionary["cancel_policy_type"] as? String ?? ""
        sec_dep = dictionary["sec_dep"] as? Int ?? 0
        if let st = dictionary["seo_tags"] as? [String:Any] {
            seo_tags = Language(fromDictionary: st)
        }
        if let sr = dictionary["ren_details"] as? [String:Any] {
            ren_details = Lang(fromDictionary: sr)
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
        if cancelDescription != nil{
            dictionary["cancel_description"] = cancelDescription
        }
        if cancelDescriptionPh != nil{
            dictionary["cancel_description_ph"] = cancelDescriptionPh
        }
        if cancelPercentage != nil{
            dictionary["cancel_percentage"] = cancelPercentage
        }
        if cancellationPolicy != nil{
            dictionary["cancellation_policy"] = cancellationPolicy
        }
        if cancellationPolicyDescription != nil{
            dictionary["cancellation_policy_description"] = cancellationPolicyDescription
        }
        if cancellationPolicyTitle != nil{
            dictionary["cancellation_policy_title"] = cancellationPolicyTitle
        }
        if metaDescription != nil{
            dictionary["meta_description"] = metaDescription
        }
        if metaDescriptionPh != nil{
            dictionary["meta_description_ph"] = metaDescriptionPh
        }
        if metaKeyword != nil{
            dictionary["meta_keyword"] = metaKeyword
        }
        if metaKeywordPh != nil{
            dictionary["meta_keyword_ph"] = metaKeywordPh
        }
        if metaTitle != nil{
            dictionary["ren_meta_title"] = metaTitle
        }
        if metaTitlePh != nil{
            dictionary["ren_meta_title_ph"] = metaTitlePh
        }
        if propertyCurrency != nil{
            dictionary["property_currency"] = propertyCurrency
        }
        if propertyid != nil{
            dictionary["propertyid"] = propertyid
        }
        if securityDeposit != nil{
            dictionary["security_deposit"] = securityDeposit
        }
        if stepCompleted != nil{
            dictionary["step_completed"] = stepCompleted
        }
        if ren_tax_percent != nil{
            dictionary["ren_tax_percent"] = ren_tax_percent
        }
        if cancel_policy_type != nil{
            dictionary["cancel_policy_type"] = cancel_policy_type
        }
        if sec_dep != nil{
            dictionary["sec_dep"] = sec_dep
        }
        if seo_tags != nil{
            dictionary["seo_tags"] = seo_tags
        }
        if ren_details != nil{
            dictionary["ren_details"] = ren_details
        }
        
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        baseId = aDecoder.decodeObject(forKey: "base_id") as? String ?? ""
        cancelDescription = aDecoder.decodeObject(forKey: "cancel_description") as? String ?? ""
        cancelDescriptionPh = aDecoder.decodeObject(forKey: "cancel_description_ph") as? String ?? ""
        cancelPercentage = aDecoder.decodeObject(forKey: "cancel_percentage") as? String ?? ""
        cancellationPolicy = aDecoder.decodeObject(forKey: "cancellation_policy") as? String ?? ""
        cancellationPolicyDescription = aDecoder.decodeObject(forKey: "cancellation_policy_description") as? String ?? ""
        cancellationPolicyTitle = aDecoder.decodeObject(forKey: "cancellation_policy_title") as? String ?? ""
        metaDescription = aDecoder.decodeObject(forKey: "meta_description") as? String ?? ""
        metaDescriptionPh = aDecoder.decodeObject(forKey: "meta_description_ph") as? String ?? ""
        metaKeyword = aDecoder.decodeObject(forKey: "meta_keyword") as? String ?? ""
        metaKeywordPh = aDecoder.decodeObject(forKey: "meta_keyword_ph") as? String ?? ""
        metaTitle = aDecoder.decodeObject(forKey: "ren_meta_title") as? String ?? ""
        
        metaTitlePh = aDecoder.decodeObject(forKey: "ren_meta_title_ph") as? String ?? ""
        propertyCurrency = aDecoder.decodeObject(forKey: "property_currency") as? String ?? ""
        propertyid = aDecoder.decodeObject(forKey: "propertyid") as? Int ?? 0
        securityDeposit = aDecoder.decodeObject(forKey: "security_deposit") as? String ?? ""
        stepCompleted = aDecoder.decodeObject(forKey: "step_completed") as? Bool ?? false
        ren_tax_percent = aDecoder.decodeObject(forKey: "ren_tax_percent") as? AnyObject
        cancel_policy_type = aDecoder.decodeObject(forKey: "cancel_policy_type") as? String ?? ""
        sec_dep = aDecoder.decodeObject(forKey: "sec_dep") as? Int ?? 0
        seo_tags = aDecoder.decodeObject(forKey: "seo_tags") as? Language
        ren_details = aDecoder.decodeObject(forKey: "ren_details") as? Lang
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
        if cancelDescription != nil{
            aCoder.encode(cancelDescription, forKey: "cancel_description")
        }
        if cancelDescriptionPh != nil{
            aCoder.encode(cancelDescriptionPh, forKey: "cancel_description_ph")
        }
        if cancelPercentage != nil{
            aCoder.encode(cancelPercentage, forKey: "cancel_percentage")
        }
        if cancellationPolicy != nil{
            aCoder.encode(cancellationPolicy, forKey: "cancellation_policy")
        }
        if cancellationPolicyDescription != nil{
            aCoder.encode(cancellationPolicyDescription, forKey: "cancellation_policy_description")
        }
        if cancellationPolicyTitle != nil{
            aCoder.encode(cancellationPolicyTitle, forKey: "cancellation_policy_title")
        }
        if metaDescription != nil{
            aCoder.encode(metaDescription, forKey: "meta_description")
        }
        if metaDescriptionPh != nil{
            aCoder.encode(metaDescriptionPh, forKey: "meta_description_ph")
        }
        if metaKeyword != nil{
            aCoder.encode(metaKeyword, forKey: "meta_keyword")
        }
        if metaKeywordPh != nil{
            aCoder.encode(metaKeywordPh, forKey: "meta_keyword_ph")
        }
        if metaTitle != nil{
            aCoder.encode(metaTitle, forKey: "ren_meta_title")
        }
        if metaTitlePh != nil{
            aCoder.encode(metaTitlePh, forKey: "ren_meta_title_ph")
        }
        if propertyCurrency != nil{
            aCoder.encode(propertyCurrency, forKey: "property_currency")
        }
        if propertyid != nil{
            aCoder.encode(propertyid, forKey: "propertyid")
        }
        if securityDeposit != nil{
            aCoder.encode(securityDeposit, forKey: "security_deposit")
        }
        if stepCompleted != nil{
            aCoder.encode(stepCompleted, forKey: "step_completed")
        }
        if ren_tax_percent != nil{
            aCoder.encode(ren_tax_percent, forKey: "ren_tax_percent")
        }
        if cancel_policy_type != nil{
            aCoder.encode(cancel_policy_type, forKey: "cancel_policy_type")
        }
        if sec_dep != nil{
            aCoder.encode(sec_dep, forKey: "sec_dep")
        }
        if seo_tags != nil{
            aCoder.encode(seo_tags, forKey: "seo_tags")
        }
        if ren_details != nil{
            aCoder.encode(ren_details, forKey: "ren_details")
        }
    }
}

