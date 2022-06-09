//
//  AccountInfoModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on October 5, 2018

import Foundation


class AccountInfoModel : NSObject, NSCoding{

    var accountinfo : [Accountinfo]!
    var completedTransaction : [CompletedTransaction]!
    var countryList : [CountryList]!
    var futureTransaction : [FutureTransaction]!
    var message : String!
    var notifications : [Notification]!
    var payoutPerference : [PayoutPerference]!
    var privacy : [Privacy]!
    var status : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Int
        accountinfo = [Accountinfo]()
        if let accountinfoArray = dictionary["accountinfo"] as? [[String:Any]]{
            for dic in accountinfoArray{
                let value = Accountinfo(fromDictionary: dic)
                accountinfo.append(value)
            }
        }
        completedTransaction = [CompletedTransaction]()
        if let completedTransactionArray = dictionary["completed_transaction"] as? [[String:Any]]{
            for dic in completedTransactionArray{
                let value = CompletedTransaction(fromDictionary: dic)
                completedTransaction.append(value)
            }
        }
        countryList = [CountryList]()
        if let countryListArray = dictionary["country_list"] as? [[String:Any]]{
            for dic in countryListArray{
                let value = CountryList(fromDictionary: dic)
                countryList.append(value)
            }
        }
        
        futureTransaction = [FutureTransaction]()
        if let futureTransactionArray = dictionary["future_transaction"] as? [[String:Any]]{
            for dic in futureTransactionArray{
                let value = FutureTransaction(fromDictionary: dic)
                futureTransaction.append(value)
            }
        }
        notifications = [Notification]()
        if let notificationsArray = dictionary["notifications"] as? [[String:Any]]{
            for dic in notificationsArray{
                let value = Notification(fromDictionary: dic)
                notifications.append(value)
            }
        }
        payoutPerference = [PayoutPerference]()
        if let payoutPerferenceArray = dictionary["payout_perference"] as? [[String:Any]]{
            for dic in payoutPerferenceArray{
                let value = PayoutPerference(fromDictionary: dic)
                payoutPerference.append(value)
            }
        }
        privacy = [Privacy]()
        if let privacyArray = dictionary["privacy"] as? [[String:Any]]{
            for dic in privacyArray{
                let value = Privacy(fromDictionary: dic)
                privacy.append(value)
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
        if accountinfo != nil{
            var dictionaryElements = [[String:Any]]()
            for accountinfoElement in accountinfo {
                dictionaryElements.append(accountinfoElement.toDictionary())
            }
            dictionary["accountinfo"] = dictionaryElements
        }
        if completedTransaction != nil{
            var dictionaryElements = [[String:Any]]()
            for completedTransactionElement in completedTransaction {
                dictionaryElements.append(completedTransactionElement.toDictionary())
            }
            dictionary["completedTransaction"] = dictionaryElements
        }
        if countryList != nil{
            var dictionaryElements = [[String:Any]]()
            for countryListElement in countryList {
                dictionaryElements.append(countryListElement.toDictionary())
            }
            dictionary["countryList"] = dictionaryElements
        }
        if futureTransaction != nil{
            var dictionaryElements = [[String:Any]]()
            for futureTransactionElement in futureTransaction {
                dictionaryElements.append(futureTransactionElement.toDictionary())
            }
            dictionary["futureTransaction"] = dictionaryElements
        }
        if notifications != nil{
            var dictionaryElements = [[String:Any]]()
            for notificationsElement in notifications {
                dictionaryElements.append(notificationsElement.toDictionary())
            }
            dictionary["notifications"] = dictionaryElements
        }
        if payoutPerference != nil{
            var dictionaryElements = [[String:Any]]()
            for payoutPerferenceElement in payoutPerference {
                dictionaryElements.append(payoutPerferenceElement.toDictionary())
            }
            dictionary["payoutPerference"] = dictionaryElements
        }
        if privacy != nil{
            var dictionaryElements = [[String:Any]]()
            for privacyElement in privacy {
                dictionaryElements.append(privacyElement.toDictionary())
            }
            dictionary["privacy"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accountinfo = aDecoder.decodeObject(forKey: "accountinfo") as? [Accountinfo]
        completedTransaction = aDecoder.decodeObject(forKey: "completed_transaction") as? [CompletedTransaction]
        countryList = aDecoder.decodeObject(forKey: "country_list") as? [CountryList]
        futureTransaction = aDecoder.decodeObject(forKey: "future_transaction") as? [FutureTransaction]
        message = aDecoder.decodeObject(forKey: "message") as? String
        notifications = aDecoder.decodeObject(forKey: "notifications") as? [Notification]
        payoutPerference = aDecoder.decodeObject(forKey: "payout_perference") as? [PayoutPerference]
        privacy = aDecoder.decodeObject(forKey: "privacy") as? [Privacy]
        status = aDecoder.decodeObject(forKey: "status") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accountinfo != nil{
            aCoder.encode(accountinfo, forKey: "accountinfo")
        }
        if completedTransaction != nil{
            aCoder.encode(completedTransaction, forKey: "completed_transaction")
        }
        if countryList != nil{
            aCoder.encode(countryList, forKey: "country_list")
        }
        if futureTransaction != nil{
            aCoder.encode(futureTransaction, forKey: "future_transaction")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if notifications != nil{
            aCoder.encode(notifications, forKey: "notifications")
        }
        if payoutPerference != nil{
            aCoder.encode(payoutPerference, forKey: "payout_perference")
        }
        if privacy != nil{
            aCoder.encode(privacy, forKey: "privacy")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
