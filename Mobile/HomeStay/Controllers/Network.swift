
//  Network.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 16/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.

/* ***************
 Usage:  HTTP request and response are handles in this file.
 
 ***************** */

import Foundation
import SystemConfiguration
import UIKit

protocol HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY:String,requestURL: String,responseDict: NSDictionary,errorDict: String)
}

protocol HTTP_GET_STRING_REQUEST_PROTOCOL {
    func httpGetRequest(APIKEY:String,requestURL: String,responseDict: NSDictionary,errorStr: String)
}

protocol HTTP_GET_JSON_REQUEST_PROTOCOL {
    func GetRequest(withParameterDict: NSDictionary , serviceURL: String , APIKEY: String)
}

class Network {
    
    //MARK:- SharedInstance.
    
    static var shared = Network()
    
    //MARK:- Variables.
    var HTTP_POST_STRING_REQUEST_DELEGATE : HTTP_POST_STRING_REQUEST_PROTOCOL?
    var HTTP_GET_STRING_REQUEST_DELEGATE: HTTP_GET_STRING_REQUEST_PROTOCOL?
    var HTTP_GET_JSON_REQUEST_DELEGATE: HTTP_GET_JSON_REQUEST_PROTOCOL?
    
    //MARK:- Post request with parameter String.
    func POSTRequest(withParameterString: String , serviceURL: String , APIKEY: String)
    {
        var RESPONSE_ERROR = String()
        var RESPONSE_DATA = NSDictionary()
        let Url = String(format: serviceURL)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        let postString = withParameterString
     //   print(postString)
        request.httpBody = Data(postString.utf8)
        //request.httpBody = postString.data(using: String.Encoding.utf8);
      request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.setValue(APIKEY, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if let response = response {
                print(response)
            }
            if let resdata = data {
                do {
                  //print(response)
                    let json =  try JSONSerialization.jsonObject(with: resdata, options: .mutableContainers) as? NSDictionary
                       if let parseJSON = json {
                        print(json as Any)
                        if parseJSON.object(forKey: "status") as? NSInteger == 1 {
                            if error != nil {
                               RESPONSE_ERROR = (error?.localizedDescription)!
                            }
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                            }
                        } else {
                            DispatchQueue.main.async {
                                 RESPONSE_DATA = parseJSON
                                self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            RESPONSE_ERROR = "No Data"
                            self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                        }
                    }
                }catch {
                     DispatchQueue.main.async {
                    RESPONSE_ERROR = "Check your input datas"
                    self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                }
                }
            } else {
                DispatchQueue.main.async {
                    RESPONSE_ERROR = (error?.localizedDescription)!
                    self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                }
            }
        })
        task.resume()
    }
    
    //Post request with parameter dict.
    func POSTRequest(withParameterDict: NSDictionary , serviceURL: String , APIKEY: String)
    {
        var RESPONSE_ERROR = String()
        var RESPONSE_DATA = NSDictionary()
        let Url = String(format: serviceURL)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: withParameterDict, options: []) else {
            return
        }
        print(withParameterDict)
        request.httpBody = httpBody
        //request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if let response = response {
                print(response)
            }
            if let resdata = data {
                do {
                    let json =  try JSONSerialization.jsonObject(with: resdata, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = json {
                        if parseJSON.object(forKey: "status") as! NSInteger == 1 {
                            if error != nil {
                                RESPONSE_ERROR = (error?.localizedDescription)!
                            }
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                            }
                        } else {
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            RESPONSE_ERROR = "No Data"
                            self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                        }
                    }
                } catch {
                    RESPONSE_ERROR = "Check your input datas"
                    self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                }
            } else {
                DispatchQueue.main.async {
                    RESPONSE_ERROR = (error?.localizedDescription)!
                    self.HTTP_POST_STRING_REQUEST_DELEGATE?.httpPostRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorDict: RESPONSE_ERROR)
                }
            }
        })
        task.resume()
    }
   
    //MARK:- GetRequest With Parameter.
    
    func GetRequest(withParameterString: String , serviceURL: String , APIKEY: String)
    {
        var RESPONSE_ERROR = String()
        var RESPONSE_DATA = NSDictionary()
        let Url = String(format: serviceURL)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        let postString = withParameterString
        print(postString)
       
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if let response = response {
                print(response)
            }
            if let resdata = data {
                do {
                    let json =  try JSONSerialization.jsonObject(with: resdata, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = json {
                        if parseJSON.object(forKey: "status") as! NSInteger == 1 {
                            if error != nil {
                                RESPONSE_ERROR = (error?.localizedDescription)!
                            }
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                            }
                        } else {
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            RESPONSE_ERROR = "No Data"
                            self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                        }
                    }
                }catch {
                    RESPONSE_ERROR = "Check your input datas"
                    self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                }
            } else {
                DispatchQueue.main.async {
                    RESPONSE_ERROR = (error?.localizedDescription)!
                    self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                }
            }
        })
        task.resume()
    }
    
    
    func GetRequest(withParameterDict: NSDictionary , serviceURL: String , APIKEY: String)
    {
        var RESPONSE_ERROR = String()
        var RESPONSE_DATA = NSDictionary()
        let Url = String(format: serviceURL)
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: withParameterDict, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            if let response = response {
                print(response)
            }
            if let resdata = data {
                do {
                    let json =  try JSONSerialization.jsonObject(with: resdata, options: .mutableContainers) as? NSDictionary
                    if let parseJSON = json {
                        if parseJSON.object(forKey: "status") as! NSInteger == 1 {
                            if error != nil {
                                RESPONSE_ERROR = (error?.localizedDescription)!
                            }
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                            }
                        } else {
                            DispatchQueue.main.async {
                                RESPONSE_DATA = parseJSON
                                self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            RESPONSE_ERROR = "No Data"
                            self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                        }
                    }
                }catch {
                    RESPONSE_ERROR = "Check your input datas"
                    self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                }
            } else {
                DispatchQueue.main.async {
                    RESPONSE_ERROR = (error?.localizedDescription)!
                    self.HTTP_GET_STRING_REQUEST_DELEGATE?.httpGetRequest(APIKEY: APIKEY, requestURL: serviceURL, responseDict: RESPONSE_DATA, errorStr: RESPONSE_ERROR)
                }
            }
        })
        task.resume()
    }
    
    
    
}
