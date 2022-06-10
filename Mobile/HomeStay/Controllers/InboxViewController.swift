//
//  InboxViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Kingfisher
import AFNetworking
import Alamofire
class InboxViewController: BaseViewController,filterDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var lblNoMessageFound: UILabel!
      @IBOutlet weak var lblNoMessage: UIImageView!
    @IBOutlet weak var tblInbox: UITableView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var searchView: UIView!
    
      @IBOutlet weak var searchBtn: UIButton!
    
    //MARK:- Variables
    var filterBookingId  = String()
    var BookingId  = String()
    var selected = Bool()
    var SelectedId = Int()
    var SelectedIds = Int()
    var starChangeStaus  = String()
    var messages = NSMutableArray()
    
    
    //MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblInbox.tableFooterView = UIView()

        //        if Reachability()!.isReachable
        //        {
        //               let parameters = ["userid":login_session.value(forKey: "UserId")!,"base_id":1,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        //
        //
        //            InboxApiCall()
        //            print(parameters)
        //
        //
        //      //      let id = Singleton.sharedInstance.selectedCategory!
        ////            self.showActivityIndicator(uiView: self.view)
        ////            let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
        ////            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_API, APIKEY: "INBOX_API")
        //
        //        }else {
        //            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        //        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
           
           
              self.viewTitle.font = UIFont(name: SemiBoldFont, size: 15)
         self.searchBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
         self.lblNoMessageFound.font = UIFont(name: SemiBoldFont, size: 15)
        self.searchBtn.layer.borderWidth = 1
        self.searchBtn.layer.borderColor = hexStringToUIColor(hex: "#EEEEEE").cgColor
           let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
//           if choose == "en"
//           {
//               self.viewTitle.text = LocalizeHelper().localizedStringForKey("inbox")
//           }
           self.tblInbox.isHidden = true
                  Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
                  
                  self.loadDATA()
       }
    func loadDATA()
    {
        if Reachability()!.isReachable
        {
            
            let id = Singleton.sharedInstance.selectedCategory!
            self.showActivityIndicator(uiView: self.view)
            
            if SelectedId == 1
            {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                
                params = ["userid":login_session.value(forKey: "UserId")as Any,"base_id":id,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios"]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(INBOX_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        
                        
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                            self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
//                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&device_type=\("ios")"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_API, APIKEY: "INBOX_API")
                //                print(parameterStr)
                SelectedIds = 1
            }
            else if SelectedId == 2
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["userid":login_session.value(forKey: "UserId")!]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_STARRED_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_STARRED_MESSGAE, APIKEY: "MOBILE_INBOX_STARRED_MESSGAE")
                //                print(parameterStr)
                SelectedIds = 2
            }
            else if SelectedId == 3
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["userid":login_session.value(forKey: "UserId")!]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_UNREAD_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                //
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_UNREAD_MESSGAE, APIKEY: "MOBILE_INBOX_UNREAD_MESSGAE")
                //                print(parameterStr)
                SelectedIds = 3
            }
            else if SelectedId == 4
            {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["userid":login_session.value(forKey: "UserId")!]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_RESERVATION_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                //
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_RESERVATION_MESSGAE, APIKEY: "MOBILE_INBOX_RESERVATION_MESSGAE")
                //                print(parameterStr)
                SelectedIds = 4
            }
            else  if SelectedId == 5
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["userid":login_session.value(forKey: "UserId")!]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_PENDINGREQ_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                //
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_PENDINGREQ_MESSGAE, APIKEY: "MOBILE_INBOX_PENDINGREQ_MESSGAE")
                //                print(parameterStr)
                SelectedIds = 5
            }
            else  if SelectedId == 6
            {
                // let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&device_type=\("ios")"
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["userid":login_session.value(forKey: "UserId")!]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_ARCHIVED_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.lblNoMessageFound.isHidden = false
                         self.lblNoMessage.isHidden = false
                        self.searchView.isHidden = true
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: c, APIKEY: "MOBILE_INBOX_ARCHIVED_MESSGAE")
                //                print(parameterStr)
                SelectedIds = 6
            }
        }
            
            
        else
        {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            
        }
        
        
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func InboxApiCall() {
        var params = NSMutableDictionary()
        
        params = ["userid":login_session.value(forKey: "UserId")!,"base_id":1,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(INBOX_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                     self.lblNoMessage.isHidden = false
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                     self.lblNoMessage.isHidden = true
                }
                self.tblInbox.reloadData()
            }
                
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func json(from object:Any) -> String?
    {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else
        {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    func updateFilter(bookingName: String) {
        print(bookingName)
        self.hideActivityIndicator(uiView: self.view)
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        SelectedBookingNum.removeAllObjects()
        SelectedBookingNum.addObjects(from: bookingName.components(separatedBy: ","))
        print(SelectedBookingNum)
        filterBookingId = bookingName
        if Reachability()!.isReachable
        {
            
            self.showActivityIndicator(uiView: self.view)
            if SelectedId == 1
            {
               
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                let mutDict = NSMutableDictionary()
                mutDict.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        mutDict.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                print(mutDict)
                //                let CheckStr = mutDict.componentsJoined(by: "&")
                //                print(CheckStr)
                // print("\(String(describing: self.json(from:CheckStr as Any)))")
                // let Decode = String(describing: self.json(from:CheckStr as Any))
                // let param = ["userid":login_session.value(forKey: "UserId")!,CheckStr]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(INBOX_API, parameters: mutDict, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        
                        
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_API, APIKEY: "INBOX_API")
                //                print(parameterStr)
            }
            else if SelectedId == 2
            {
                var params = NSMutableDictionary()
                
                params.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        params.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                showActivityIndicator(uiView: self.view)
                
                
                // params = ["userid":login_session.value(forKey: "UserId")!,"booking_numbers":filterBookingId]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_STARRED_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_STARRED_MESSGAE, APIKEY: "MOBILE_INBOX_STARRED_MESSGAE")
                //                print(parameterStr)
            }
            else if SelectedId == 3
            {
                let params = NSMutableDictionary()
                
                params.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        params.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                showActivityIndicator(uiView: self.view)
                
                
                //  params = ["userid":login_session.value(forKey: "UserId")!,"booking_numbers":filterBookingId]
                
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_UNREAD_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_UNREAD_MESSGAE, APIKEY: "MOBILE_INBOX_UNREAD_MESSGAE")
                //                print(parameterStr)
            }
            else if SelectedId == 4
            {
                var params = NSMutableDictionary()
                
                params.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        params.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                showActivityIndicator(uiView: self.view)
                
                
                
                // params = ["userid":login_session.value(forKey: "UserId")!,"booking_numbers":filterBookingId]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_RESERVATION_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_RESERVATION_MESSGAE, APIKEY: "MOBILE_INBOX_RESERVATION_MESSGAE")
                //                print(parameterStr)
            }
            else  if SelectedId == 5
            {
                var params = NSMutableDictionary()
                
                // params.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        params.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                showActivityIndicator(uiView: self.view)
                
                
                
                
                // params = ["userid":login_session.value(forKey: "UserId")!,"booking_numbers":filterBookingId]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_PENDINGREQ_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_PENDINGREQ_MESSGAE, APIKEY: "MOBILE_INBOX_PENDINGREQ_MESSGAE")
                //                print(parameterStr)
            }
            else  if SelectedId == 6
            {
                
                var params = NSMutableDictionary()
                
                params.setValue(login_session.value(forKey: "UserId")!, forKey: "userid")
                if SelectedBookingNum.count != 0 {
                    for i in 0..<SelectedBookingNum.count {
                        
                        
                        params.setValue(SelectedBookingNum[i], forKey: "booking_numbers\([i])")
                        //add("booking_numbers[]=\(SelectedBookingNum[i])")
                        
                        
                    }
                    
                }
                // let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&device_type=\("ios")"
                
                showActivityIndicator(uiView: self.view)
                
                
                // params = ["userid":login_session.value(forKey: "UserId")!,"booking_numbers":filterBookingId]
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(MOBILE_INBOX_ARCHIVED_MESSGAE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxList = mod
                        if mod.messageValues.count == 0 {
                            self.tblInbox.isHidden = true
                            self.lblNoMessageFound.isHidden = false
                             self.lblNoMessage.isHidden = false
                            self.searchView.isHidden = true
                        } else {
                            self.tblInbox.isHidden = false
                            self.lblNoMessageFound.isHidden = true
                             self.lblNoMessage.isHidden = true
                            self.searchView.isHidden = false
                            
                        }
                        self.tblInbox.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                //                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&booking_numbers=\(filterBookingId)"
                //                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_ARCHIVED_MESSGAE, APIKEY: "MOBILE_INBOX_ARCHIVED_MESSGAE")
                //                print(parameterStr)
            }
        }
        else{
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            
        }
        
        
        
        
    }
    @IBAction func searchFilterBtn(_ sender: Any)
    {
        if Singleton.sharedInstance.inboxList.messageValues.count == 0 {
            self.showInformation(title: "Closest", message: "There is no messages to display")
        }else{
            let rentSpaceVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterInboxViewController") as? FilterInboxViewController
            self.messages.addObjects(from: Singleton.sharedInstance.inboxList.messageValues)
            rentSpaceVC?.filterDelegate = self
            rentSpaceVC?.selectedId = SelectedIds
            self.navigationController?.pushViewController(rentSpaceVC!, animated: true)
        }
        
    }
    @IBAction func search_Act(_ sender: UIButton) {
        let eeStoryboard = UIStoryboard(name: "SearchVC", bundle: nil)
        let searchVC = eeStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        searchVC?.searchLoctaionDelegate = self
        
        self.navigationController?.pushViewController(searchVC!, animated: true)
    }
   
    @IBAction func act_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InboxViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "INBOX_API"{
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                
                
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                }
                self.tblInbox.reloadData()
                
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_STARRED_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                }
                self.tblInbox.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_UNREAD_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                }
                self.tblInbox.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_RESERVATION_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                }
                self.tblInbox.reloadData()
            }
        }
            
            
            
            
            
            
        else if APIKEY == "MOBILE_INBOX_PENDINGREQ_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                }
                self.tblInbox.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_ARCHIVED_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
                if mod.messageValues.count == 0 {
                    self.tblInbox.isHidden = true
                    self.lblNoMessageFound.isHidden = false
                    self.searchView.isHidden = true
                } else {
                    self.tblInbox.isHidden = false
                    self.lblNoMessageFound.isHidden = true
                    self.searchView.isHidden = false
                    
                }
                self.tblInbox.reloadData()
            }
        }
            
            
        else if APIKEY == "MOBILE_INBOX_ARCHIVE_STATUS"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            self.tblInbox.reloadData()
            self.loadDATA()
        }
            
        else if APIKEY == "MOBILE_INBOX_STAR_STATUS"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            self.tblInbox.reloadData()
            self.loadDATA()
            
        }
        else
        {
            
        }
        
        
    }
}

extension InboxViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Singleton.sharedInstance.inboxList != nil {
            return Singleton.sharedInstance.inboxList.messageValues.count
        } else {
            return 0
        }
    }
    @objc func starredbtnClick(sender: UIButton)
    {
        let buttonRow = sender.tag
        print(buttonRow)
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        if (Reachability()?.isReachable)!
        {
            
            let starStatus = Singleton.sharedInstance.inboxList.messageValues[buttonRow].starStatus!
            if starStatus == "1"
            {
                starChangeStaus = "No"
            }
            else
            {
                starChangeStaus = "Yes"
                
            }
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["message_id":Singleton.sharedInstance.inboxList.messageValues[buttonRow].id!,"bookingNo":Singleton.sharedInstance.inboxList.messageValues[buttonRow].bookingno!,"star_change_status":starChangeStaus]
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(MOBILE_INBOX_STAR_STATUS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.tblInbox.reloadData()
                    self.loadDATA()
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
            
            //            let parameterStr = "message_id=\(Singleton.sharedInstance.inboxList.messageValues[buttonRow].id!)&bookingNo=\(Singleton.sharedInstance.inboxList.messageValues[buttonRow].bookingno!)&star_change_status=\(starChangeStaus)"
            //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_STAR_STATUS, APIKEY: "MOBILE_INBOX_STAR_STATUS")
            //            print(parameterStr)
            
        }
        else
        {
            self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    @objc func archiveBtnClick(sender: UIButton)
    {
        let buttonRow = sender.tag
        print(buttonRow)
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["message_id":Singleton.sharedInstance.inboxList.messageValues[buttonRow].id!]
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(MOBILE_INBOX_ARCHIVE_STATUS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.tblInbox.reloadData()
                    self.loadDATA()
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
            
            
            //            let parameterStr = "message_id=\(Singleton.sharedInstance.inboxList.messageValues[buttonRow].id!)"
            //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_ARCHIVE_STATUS, APIKEY: "MOBILE_INBOX_ARCHIVE_STATUS")
            //            print(parameterStr)
            
        }
        else
        {
            self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InboxCell
        cell!.imgUser.layer.cornerRadius = cell!.imgUser.frame.size.width / 2
        cell!.imgUser.clipsToBounds = true
        let url = URL(string: Singleton.sharedInstance.inboxList.messageValues[indexPath.row].userImage!)
        cell?.imgUser.setImageWith(url!, placeholderImage: UIImage(named: "user"))
//        cell!.imgUser.kf.setImage(with: url)
        
        
        if  Singleton.sharedInstance.inboxList.messageValues[indexPath.row].starStatus == "0"
        {
            cell!.starredBtn.setImage(UIImage(named: "starInbox"), for: .normal)
        }
        else
            
        {
            cell!.starredBtn.setImage(UIImage(named: "star"), for: .normal)
            
        }
        cell!.starredBtn.tag = indexPath.row
        cell!.archiveBtn.tag = indexPath.row
        cell!.starredBtn.addTarget(self, action: #selector(starredbtnClick), for: .touchUpInside)
        cell!.archiveBtn.addTarget(self, action: #selector(archiveBtnClick), for: .touchUpInside)
        
        if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].msgRead!  != "Yes" {
            cell!.lblDate.textColor = UIColor.black
            cell!.lblMessage.textColor = UIColor.black
            cell!.lblBooking.textColor = UIColor.black
            cell!.lblBooking.font = UIFont(name: SemiBoldFont, size: 15)
        } else
        {
            cell!.lblDate.textColor = UIColor.lightGray
            cell!.lblMessage.textColor = UIColor.lightGray
            cell!.lblBooking.textColor = UIColor.lightGray
            cell!.lblBooking.font = UIFont(name: SemiBoldFont, size: 15)
        }
        
        if SelectedId == 6
        {
            cell!.starredBtn.isHidden = true
            
            
        }
        else{
            cell!.starredBtn.isHidden = false
        }
        
        
        //        if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].status! == "Accept"
        //        {
        //            if selected  != true {
        //                cell!.lblBooking.textColor = UIColor.darkGray
        //                cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        //            } else
        //            {
        //                cell!.lblBooking.textColor = UIColor.black
        //                cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Regular", size: 16.0)
        //            }
        //        }else{
        //
        //        }
        cell!.UnreadMsgCount.layer.cornerRadius = 12.5
        cell!.UnreadMsgCount.layer.borderWidth = 1
        cell!.UnreadMsgCount.layer.borderColor = hexStringToUIColor(hex: "#F8BC05").cgColor
        cell!.lblBooking.text =  Singleton.sharedInstance.inboxList.messageValues[indexPath.row].subject!
        //Singleton.sharedInstance.inboxList.messageValues[indexPath.row].subject!
        cell!.lblMessage.text = (Singleton.sharedInstance.inboxList.messageValues[indexPath.row].message!).uppercased()
        cell!.lblMessage.font = UIFont(name: RegularFont, size: 15)
          cell!.lblDate.font = UIFont(name: RegularFont, size: 12)
           cell!.UnreadMsgCount.font = UIFont(name: RegularFont, size: 14.0)
        if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].msgUnreadCount! == "0"{
            cell!.UnreadMsgCount.isHidden = true
        }else {
            cell!.UnreadMsgCount.isHidden = false
        }
        
        if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].message!.uppercased() == "ACCEPTED" {
                      cell!.lblMessage.textColor = hexStringToUIColor(hex: "00CE22")
                  }else if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].message!.uppercased() == "REJECTED"{
                       cell!.lblMessage.textColor = hexStringToUIColor(hex: "DE1E00")
                  }else {
                    cell!.lblMessage.textColor = .darkGray
                  }
        cell!.UnreadMsgCount.text = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].msgUnreadCount!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let startingDate = dateFormatter.date(from: Singleton.sharedInstance.inboxList.messageValues[indexPath.row].dateAdded!)
        let newformat = DateFormatter()
        newformat.dateFormat =  "d MMM yy, h:mm a"
        newformat.locale = Locale(identifier: "en_US_POSIX")
        newformat.string(from: startingDate!)
        print(startingDate)
        print("Changed Date \(newformat.string(from: startingDate!))")
        
        
        
        let date = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].dateAdded!.components(separatedBy: " ")
        cell!.lblDate.text = newformat.string(from: startingDate!)
        
        
        
          cell!.UnreadMsgCount.isHidden = true
          cell!.starredBtn.isHidden = true//date[0]
        return cell!
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InboxCell
        //        cell!.imgUser.layer.cornerRadius = cell!.imgUser.frame.size.width / 2
        //        cell!.imgUser.clipsToBounds = true
        //        let url = URL(string: Singleton.sharedInstance.inboxList.messageValues[indexPath.row].userImage!)
        //        //cell!.imgUser.kf.setImage(with: url)
        //        cell!.imgUser.kf.setImage(with: url, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
        //
        //
        ////        if Singleton.sharedInstance.inboxList.messageValues[indexPath.row].status! == "Accept"
        ////        {
        ////            if selected  != true {
        ////                cell!.lblBooking.textColor = UIColor.darkGray
        ////                cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        ////            } else
        ////            {
        ////                cell!.lblBooking.textColor = UIColor.black
        ////                cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Regular", size: 16.0)
        ////            }
        ////        }
        ////        else
        ////        {
        ////
        ////        }
        //
        //        if (Singleton.sharedInstance.inboxList.messageValues[indexPath.row].msgRead) == "Yes"
        //        {
        //            cell!.lblBooking.textColor = UIColor.lightGray
        //            cell!.lblMessage.textColor = UIColor.lightGray
        //            cell!.lblDate.textColor = UIColor.lightGray
        //            cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Regular", size: 16.0)
        //
        //        }
        //        else
        //        {
        //            cell!.lblMessage.textColor = UIColor.black
        //            cell!.lblDate.textColor = UIColor.black
        //            cell!.lblBooking.textColor = UIColor.black
        //            cell!.lblBooking.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        //
        //        }
        //
        //        cell!.lblBooking.text = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].subject!
        //        cell!.lblMessage.text = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].message!
        //
        //        let date = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].dateAdded!.components(separatedBy: " ")
        //        cell!.lblDate.text = date[0]
        //        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "InboxConversationViewController") as? InboxConversationViewController
        selected = true
        nav!.BookingId = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].bookingno!
        nav!.AcceptStatus = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].status!
        self.navigationController?.pushViewController(nav!, animated: true)
    }
}
extension InboxViewController: LoctaionSearchProtocol
{
    func showPlaceList(searchResult: String)
    {
        self.showActivityIndicator(uiView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.hideActivityIndicator(uiView: self.view)
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PlaceListController") as? PlaceListController
            nav!.headerTxt = searchResult
            self.navigationController?.pushViewController(nav!, animated: true)
        })
    }
    
    func getLocationFromCoordinates(lat: String, long: String) {
    }
    
    func getLocation(SearchResult: String) {
    }
}
