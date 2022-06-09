//
//  Result.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 10, 2018

import Foundation


class Result : NSObject, NSCoding{

    var step1 : Step1!
    var step2 : Step2!
    var step3 : Step3!
    var step4 : Step4!
    var step5 : Step5!
    var step6 : Step6!
    var step7 : Step7!
    var step8 : Step8!
    var step9 : Step9!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let step1Data = dictionary["step1"] as? [String:Any]{
            step1 = Step1(fromDictionary: step1Data)
        }
        if let step2Data = dictionary["step2"] as? [String:Any]{
            step2 = Step2(fromDictionary: step2Data)
        }
        if let step3Data = dictionary["step3"] as? [[String:Any]], let s3 = step3Data.first {
            step3 = Step3(fromDictionary: s3)
        } else if let step3Data = dictionary["step3"] as? [String:Any] {
            step3 = Step3(fromDictionary: step3Data)
        }
        
        if let step4Data = dictionary["step4"] as? [String:Any]{
            step4 = Step4(fromDictionary: step4Data)
        }
        if let step5Data = dictionary["step5"] as? [String:Any]{
            step5 = Step5(fromDictionary: step5Data)
        }
        if let step6Data = dictionary["step6"] as? [String:Any]{
            step6 = Step6(fromDictionary: step6Data)
        }
        if let step7Data = dictionary["step7"] as? [String:Any]{
            step7 = Step7(fromDictionary: step7Data)
        }
        if let step8Data = dictionary["step8"] as? [String:Any]{
            step8 = Step8(fromDictionary: step8Data)
        }
        if let step9Data = dictionary["step9"] as? [String:Any]{
            step9 = Step9(fromDictionary: step9Data)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if step1 != nil{
            dictionary["step1"] = step1.toDictionary()
        }
        if step2 != nil{
            dictionary["step2"] = step2.toDictionary()
        }
        if step3 != nil{
            dictionary["step3"] = step3.toDictionary()
        }
        if step4 != nil{
            dictionary["step4"] = step4.toDictionary()
        }
        if step5 != nil{
            dictionary["step5"] = step5.toDictionary()
        }
        if step6 != nil{
            dictionary["step6"] = step6.toDictionary()
        }
        if step7 != nil{
            dictionary["step7"] = step7.toDictionary()
        }
        if step8 != nil{
            dictionary["step8"] = step8.toDictionary()
        }
        if step9 != nil{
            dictionary["step9"] = step9.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        step1 = aDecoder.decodeObject(forKey: "step1") as? Step1
        step2 = aDecoder.decodeObject(forKey: "step2") as? Step2
        step3 = aDecoder.decodeObject(forKey: "step3") as? Step3
        step4 = aDecoder.decodeObject(forKey: "step4") as? Step4
        step5 = aDecoder.decodeObject(forKey: "step5") as? Step5
        step6 = aDecoder.decodeObject(forKey: "step6") as? Step6
        step7 = aDecoder.decodeObject(forKey: "step7") as? Step7
        step8 = aDecoder.decodeObject(forKey: "step8") as? Step8
        step9 = aDecoder.decodeObject(forKey: "step9") as? Step9
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if step1 != nil{
            aCoder.encode(step1, forKey: "step1")
        }
        if step2 != nil{
            aCoder.encode(step2, forKey: "step2")
        }
        if step3 != nil{
            aCoder.encode(step3, forKey: "step3")
        }
        if step4 != nil{
            aCoder.encode(step4, forKey: "step4")
        }
        if step5 != nil{
            aCoder.encode(step5, forKey: "step5")
        }
        if step6 != nil{
            aCoder.encode(step6, forKey: "step6")
        }
        if step7 != nil{
            aCoder.encode(step7, forKey: "step7")
        }
        if step8 != nil{
            aCoder.encode(step8, forKey: "step8")
        }
        if step9 != nil{
            aCoder.encode(step9, forKey: "step9")
        }
    }
}
