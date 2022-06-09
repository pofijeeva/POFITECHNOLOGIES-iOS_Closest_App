//
//  APIManager.swift
//  ShopUrGrocery_DeliveryBoy
//
//  Created by apple5 on 22/03/19.
//  Copyright © 2019 apple5. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

class HeaderManager {
    
    class func headers() -> HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        
        
        
        var fcmToken = String()
        if UserDefaults.standard.object(forKey: "fcmToken") != nil{
            fcmToken = UserDefaults.standard.object(forKey: "fcmToken") as! String
        }else{
            fcmToken = ""
        }
        
        
        var iPhoneOSVersionString = String()
        if UserDefaults.standard.object(forKey: "iPhoneOSVersionString") != nil{
            iPhoneOSVersionString = UserDefaults.standard.object(forKey: "iPhoneOSVersionString") as! String
        }else{
            iPhoneOSVersionString = ""
        }
        
        var iPhoneModelString = String()
        if UserDefaults.standard.object(forKey: "iPhoneModelString") != nil{
            iPhoneModelString = UserDefaults.standard.object(forKey: "iPhoneModelString") as! String
        }else{
            iPhoneModelString = ""
        }
        
        var iPhoneIDString = String()
     iPhoneIDString = UIDevice.current.identifierForVendor!.uuidString
       print(iPhoneIDString)
        
        
        

        print("iPhoneIDString UUID is : \(iPhoneIDString)")
        
        print("iPhone Name is:: ", UIDevice.current.name)

        let modelName = UIDevice.current.name
        

        print("iPhone Model is:: ", modelName)

         iPhoneModelString = modelName

         iPhoneOSVersionString = UIDevice.current.systemVersion

         print("systemVersion is:: ", iPhoneOSVersionString)

        var appBuildVersion = String()
        appBuildVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        print("appVersion is:: ", appBuildVersion)

//        UIDevice.currentDevice().identifierForVendor
//        or if you want a string:
//
//        UIDevice.currentDevice().identifierForVendor!.UUIDString
//        if UserDefaults.standard.object(forKey: "iPhoneIDString") != nil{
//            iPhoneIDString = UserDefaults.standard.object(forKey: "iPhoneIDString") as! String
//        }else{
//            iPhoneIDString = ""
//        }
        
       
//        if UserDefaults.standard.object(forKey: "appBuildVersion") != nil{
//            appBuildVersion = UserDefaults.standard.object(forKey: "appBuildVersion") as! String
//        }else{
//            appBuildVersion = ""
//        }
        
//        headers["type"] = "ios"
//                headers["os-type"] = "ios \(iPhoneOSVersionString)"
//                headers["device-model"] = iPhoneModelString
//                headers["device-id"] = iPhoneIDString
//                headers["app-build-version"] = appBuildVersion
//                headers["fcm-id"] = fcmToken
//
//                headers["Content-Type"] = "application/json"
//
//                if login_session.value(forKey: "user_token") != nil {
//                    let tokenStr:String = login_session.object(forKey: "user_token") as! String
//                    headers["Authorization"] = "Bearer " + tokenStr
//                }


        
        
        headers["type"] = "ios"
        headers["os-type"] =   iPhoneOSVersionString
        headers["device-model"] = iPhoneModelString
        headers["device-id"] = iPhoneIDString
        headers["app-build-version"] = appBuildVersion
        headers["fcm-id"] = fcmToken
        
       // headers["Authorization"] = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGVtb3JlbnRhbC5zaG9wdXJncm9jZXJ5LmluXC9hcGlcL3ZfMV8wXC9tb2JpbGVfbG9naW4iLCJpYXQiOjE2MjkxNzU2NjUsImV4cCI6MTYyOTI2MjA2NSwibmJmIjoxNjI5MTc1NjY1LCJqdGkiOiJDdklHWll0R21EQkM1eFpCIiwic3ViIjoyLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.y09fwZh40ycKOIjQQrqBsZEjfbl6i0V_55lex0cetPg"
        

        
        if login_session.value(forKey: "user_token") != nil {
         
            let tokenStr:String = login_session.object(forKey: "user_token") as! String
            headers["Authorization"] = " Bearer " + tokenStr
            print("Bearer "+tokenStr)
           
        }
        
        return headers
    }
}
class APIManager: NSObject {

    class func apiGet(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        Alamofire.request(serviceName, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = data as? NSDictionary
                    completionHandler(json,nil)
                }
                break
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    
    class func encry_apiPostWithToken(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        print("BASE URL : \(serviceName as String)")

//        let tokenStr = usersession.object(forKey: "UserToken")as! String
//        let postheaders : HTTPHeaders = ["Authorization" : tokenStr]
        let url = URL(string:"\(serviceName)")!
        let data = try! JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        let key = "625202f9149e061d"
        let iv = "5efd3f6060e20330"
        var plainText = NSString()
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
           if let json = json {
            plainText = json
           }

        let cryptLib = CryptLib()
        //let newStr =
        var newStr = String()
        newStr = plainText as String
        let encryStr = cryptLib.encryptPlainText(newStr, key: key, iv: iv)
        let jsonData = try! JSONSerialization.data(withJSONObject: [encryStr!] as Any, options: [])

print(jsonData)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
        
        if login_session.value(forKey: "user_token") != nil {
         
            let tokenStr:String = login_session.object(forKey: "user_token") as! String
             request.setValue(" Bearer " + tokenStr, forHTTPHeaderField: "Authorization")

            print("Bearer "+tokenStr)
           
        }
        
//        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true{
//            let tokenStr = usersession.object(forKey: "user_token")as! String
//            request.setValue(tokenStr, forHTTPHeaderField: "Authorization")
//            print("tokenStr:::", tokenStr)
//        }
//        
        
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
    print(request)

        Alamofire.request(request).response { (response) in
            print(response)

            if let data = response.data {
                let json = String(data: data, encoding: String.Encoding.utf8)
                let decryptedStr = cryptLib.decryptCipherText(json, key: key, iv: iv)
                if let data = decryptedStr!.data(using: String.Encoding.utf8) {
                    do {
                        let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        completionHandler(result as NSDictionary?,nil)
                    } catch {
                        print("Something went wrong")
                    }
                }
            }

        }
    }
    class func apiPostWithHeaders(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        var tokenStr = String()
        if login_session.value(forKey: "loginToken") != nil {
            tokenStr = login_session.object(forKey: "loginToken")as! String
        }
        let postheaders : HTTPHeaders = HeaderManager.headers()
            //["Authorization" : "Bearer \(tokenStr)"]
        print("************ Service Start ************")
        print(serviceName)
        print("************ Service End ************")
        print("************ Headers Start ************")
        print(postheaders)
        print("************ Headers End ************")
        print("************ Parameters Start ************")
        print(parameters)
        print("************ Parameters Start ************")
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HeaderManager.headers()).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.value{
                    let json = data as? NSDictionary
                    completionHandler(json,nil)
                }
                break
            case .failure(_):
                completionHandler(nil,response.error as NSError?)
                break
            }
        }
    }
    class func apiPostWithHeadersCodable(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (_ responseData: Data?,_ error: Error?) -> ()) {
        var tokenStr = String()
        if login_session.value(forKey: "loginToken") != nil {
            tokenStr = login_session.object(forKey: "loginToken")as! String
        }
        let postheaders : HTTPHeaders = HeaderManager.headers()
            //["Authorization" : "Bearer \(tokenStr)"]
        print("************ Service Start ************")
        print(serviceName)
        print("************ Service End ************")
        print("************ Headers Start ************")
        print(postheaders)
        print("************ Headers End ************")
        print("************ Parameters Start ************")
        print(parameters)
        print("************ Parameters Start ************")
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HeaderManager.headers()).responseJSON { (response) in
            print(response)
            switch (response.result) {
            case .success:
                guard let jsonData = response.data else {
                    return
                }
                completionHandler(jsonData, nil)
                
            case .failure:
                print(response.error?.localizedDescription)
                completionHandler(nil, response.error)
            }
        }
    }
    
    class func apiPost(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    let json = data as? NSDictionary
                    completionHandler(json,nil)
                }
                break
            case .failure(_):
                completionHandler(nil,response.result.error as NSError?)
                break
                
            }
        }
    }
    class func apiPostCodable(serviceName:String,parameters: [String:Any]?, completionHandler: @escaping (_ responseData: Data?,_ error: Error?) -> ()) {
        Alamofire.request(serviceName, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print(response)
            switch (response.result) {
            case .success:
                guard let jsonData = response.data else {
                    return
                }
                completionHandler(jsonData, nil)
                
            case .failure:
                print(response.error?.localizedDescription)
                completionHandler(nil, response.error)
            }
        }
    }
    
}
