//
//  InboxConversationViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 04/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import Kingfisher

class InboxConversationViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberSince: UILabel!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblImgUser: UIImageView!
    @IBOutlet weak var tblInbox: UITableView!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblGuestnumber: UILabel!
    @IBOutlet weak var lblChatTitle: UILabel!
    @IBOutlet weak var lblEnquiryID: UILabel!
    @IBOutlet weak var btnPreApproval: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    
    @IBOutlet weak var viewTitle: UILabel!
    
      @IBOutlet weak var lblWelcome: UILabel!
    
    
      @IBOutlet weak var EnquiryID: UILabel!
      @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Guest: UILabel!
       @IBOutlet weak var PreApproveHeight: NSLayoutConstraint!
    
    
     
    
    // MARK:- variables
    var BookingId  : String = ""
    var AcceptStatus : String = ""
    var memberSince : String = ""
    var enquiryAbout : String = ""
    var guest : String = ""
    var memberSinceString : String = ""
    var fromDateString : String = ""
    var toDateString : String = ""
    var params = NSMutableDictionary()
    
   
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtMessage.text = ""
        self.tblInbox.isHidden = true
        self.lblImgUser.layer.cornerRadius = 50
        self.PreApproveHeight.constant = 0
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.btnSend.layer.masksToBounds = true
        self.btnSend.layer.cornerRadius = 5
        self.btnSend.isHidden = true
        if Reachability()!.isReachable
        {
            InboxConversationApiCall()
//            let id = Singleton.sharedInstance.selectedCategory
//            self.showActivityIndicator(uiView: self.view)
//            let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&bookingid=\(BookingId)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_HISTORY, APIKEY: "INBOX_HISTORY")
        }else {
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           
            self.viewTitle.font = UIFont(name: SemiBoldFont, size: 18)
        self.lblName.font = UIFont(name: BoldFont, size: 17)
         self.lblMemberSince.font = UIFont(name: SemiBoldFont, size: 13)
           self.lblChatTitle.font = UIFont(name: RegularFont, size: 14)
          self.lblEnquiryID.font = UIFont(name: RegularFont, size: 13)
         self.lblDate.font = UIFont(name: RegularFont, size: 13)
          self.lblGuestnumber.font = UIFont(name: SemiBoldFont, size: 13)
           self.lblPlaceHolder.font = UIFont(name: RegularFont, size: 13)
        self.btnDecline.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
         self.btnPreApproval.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
         self.btnSend.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
           self.EnquiryID.font = UIFont(name: SemiBoldFont, size: 13)
           self.Date.font = UIFont(name: SemiBoldFont, size: 13)
           self.Guest.font = UIFont(name: SemiBoldFont, size: 13)
        self.txtMessage.font = UIFont(name: SemiBoldFont, size: 14)
        
             
        
           let choose =  lanuguage_selection.value(forKey: "language") as? String
           if choose == "en"
           {
               self.viewTitle.text = LocalizeHelper().localizedStringForKey("inbox")
               memberSince = LocalizeHelper().localizedStringForKey("membersince")
               enquiryAbout = LocalizeHelper().localizedStringForKey("enquiryabout")
               guest = LocalizeHelper().localizedStringForKey("guest")
               self.lblPlaceHolder.text = LocalizeHelper().localizedStringForKey("enteryourmsg")
           }
           
       }
    func InboxConversationApiCall() {
       
         params = ["userid":login_session.value(forKey: "UserId")!,"bookingid":BookingId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":1]
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(INBOX_HISTORY, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                  self.tblInbox.isHidden = false
                let mod = InboxConversationModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxConversationModel = mod
                self.AcceptStatus = Singleton.sharedInstance.inboxConversationModel.approval
                self.setData()
                
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
    
    func SendMessageApi() {
        
       
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(SEND_MESSAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
             self.hideActivityIndicator(uiView: self.view)
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                self.InboxConversationApiCall()
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
    }
    
    @IBAction func act_BgViewTapped(_ sender: UITapGestureRecognizer) {
        self.txtMessage.resignFirstResponder()
    }
    
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_SendMessage(_ sender: UIButton) {
        self.txtMessage.resignFirstResponder()
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
           // let parameterStr = "sender_id=\(login_session.value(forKey: "UserId")!)&subject=\(BookingId)&message=\(self.txtMessage.text!)&property_id=\(Singleton.sharedInstance.inboxConversationModel.propertyId)&receiver_id=\(Singleton.sharedInstance.inboxConversationModel.requesterId)&bookingno=\(Singleton.sharedInstance.inboxConversationModel.bookingId)&base_id=\(id)"
            
            params = ["sender_id":login_session.value(forKey: "UserId")!,"subject":BookingId,"message":self.txtMessage.text!,"property_id":Singleton.sharedInstance.inboxConversationModel.propertyId,"receiver_id":Singleton.sharedInstance.inboxConversationModel.requesterId,"bookingno":Singleton.sharedInstance.inboxConversationModel.bookingId,"base_id":1]
            
            SendMessageApi()
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SEND_MESSAGE, APIKEY: "SEND_MESSAGE")
            self.txtMessage.text = ""
        }else {
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
    }
    
    @IBAction func act_PreApproval(_ sender: UIButton) {
        self.txtMessage.resignFirstResponder()
        
        if self.txtMessage.text.count == 0 {
             self.showInformation(title: "Closest", message: "Please enter a message")
        }
        else{
            
            if Reachability()!.isReachable {
                
                let id = Singleton.sharedInstance.selectedCategory
                //            showActivityIndicator(uiView: self.view)
                //            var params = NSMutableDictionary()
                params = ["sender_id":login_session.value(forKey: "UserId")!,"subject":BookingId,"message":self.txtMessage.text!,"property_id":Singleton.sharedInstance.inboxConversationModel.propertyId,"receiver_id":Singleton.sharedInstance.inboxConversationModel.requesterId,"bookingno":Singleton.sharedInstance.inboxConversationModel.bookingId,"status":"Accept","currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":id]
                
                
                //            APIManager.apiPost(serviceName: HOST_ACCEPT, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
                //                // DispatchQueue.main.async { self.dismiss(animated: true) }
                //                if error != nil
                //                {
                //                    print(error?.localizedDescription ?? "")
                //                    return
                //                }
                //                print(json!)
                //                if json?.value(forKey: "status") as? NSNumber ?? 0 == 1
                //                {
                //                    let mod = InboxConversationModel(fromDictionary: json as! [String : Any])
                //                                        Singleton.sharedInstance.inboxConversationModel = mod
                //                                        if Singleton.sharedInstance.inboxConversationModel.message == "Successfully accepted"
                //                                        {
                //                                            self.btnPreApproval.isHidden = true
                //                                            self.btnDecline.isHidden = true
                //                                            self.btnSend.isHidden = false
                //                                        }
                //                                        else
                //                                        {
                //                                            //                        self.btnPreApproval.isHidden = false
                //                                            //                        self.btnDecline.isHidden = false
                //                                            self.btnSend.isHidden = true
                //                                        }
                //                                        self.InboxConversationApiCall()
                //
                //                                    }
                //
                //                }
                //
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(HOST_ACCEPT, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        let mod = InboxConversationModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.inboxConversationModel = mod
                        if Singleton.sharedInstance.inboxConversationModel.message == "Successfully accepted"
                        {
                            self.btnPreApproval.isHidden = true
                            self.btnDecline.isHidden = true
                            self.btnSend.isHidden = false
                        }
                        else
                        {
                            //                        self.btnPreApproval.isHidden = false
                            //                        self.btnDecline.isHidden = false
                            self.btnSend.isHidden = true
                        }
                        self.InboxConversationApiCall()
                        
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
                
                
                
                
                
                
                
                //            self.showActivityIndicator(uiView: self.view)
                //            let parameterStr = "sender_id=\(login_session.value(forKey: "UserId")!)&subject=\(BookingId)&message=\(self.txtMessage.text!)&property_id=\(Singleton.sharedInstance.inboxConversationModel.propertyId)&receiver_id=\(Singleton.sharedInstance.inboxConversationModel.requesterId)&bookingno=\(Singleton.sharedInstance.inboxConversationModel.bookingId)&status=Accept&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(id)"
                //            print(parameterStr)
                //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOST_ACCEPT, APIKEY: "HOST_ACCEPT")
                //            self.txtMessage.text = ""
            } else {
                self.showInformation(title: "Closest", message: "Please check your internet")
            }
        }
    
        //        self.txtMessage.text = ""
    }
    
    
    @objc func AcceptAct(sender:UIButton) {
        self.txtMessage.resignFirstResponder()
               
               if self.txtMessage.text.count == 0 {
                    self.showInformation(title: "Closest", message: "Please enter a message")
               }
               else{
                   
                   if Reachability()!.isReachable {
                       
                       let id = Singleton.sharedInstance.selectedCategory
                       //            showActivityIndicator(uiView: self.view)
                       //            var params = NSMutableDictionary()
                       params = ["sender_id":login_session.value(forKey: "UserId")!,"subject":BookingId,"message":self.txtMessage.text!,"property_id":Singleton.sharedInstance.inboxConversationModel.propertyId,"receiver_id":Singleton.sharedInstance.inboxConversationModel.requesterId,"bookingno":Singleton.sharedInstance.inboxConversationModel.bookingId,"status":"Accept","currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":id]
            
                       
                       let manager = AFHTTPSessionManager()
                       manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                       
                       manager.post(HOST_ACCEPT, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                           DispatchQueue.main.async {
                               
                           }
                           let responseDict:NSDictionary = responseObject as! NSDictionary
                           print(responseDict)
                           self.hideActivityIndicator(uiView: self.view)
                           if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                               
                               let mod = InboxConversationModel(fromDictionary: responseDict as! [String : Any])
                               Singleton.sharedInstance.inboxConversationModel = mod
                               if Singleton.sharedInstance.inboxConversationModel.message == "Successfully accepted"
                               {
                                   self.btnPreApproval.isHidden = true
                                   self.btnDecline.isHidden = true
                                   self.btnSend.isHidden = false
                               }
                               else
                               {
                                   //                        self.btnPreApproval.isHidden = false
                                   //                        self.btnDecline.isHidden = false
                                   self.btnSend.isHidden = true
                               }
                               self.InboxConversationApiCall()
                               
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
                       
              
                   } else {
                       self.showInformation(title: "Closest", message: "Please check your internet")
                   }
               }
    }
      @objc func DeclineAct(sender:UIButton) {
                self.txtMessage.resignFirstResponder()
                
                if self.txtMessage.text.count == 0 {
                    self.showInformation(title: "Closest", message: "Please enter a message")
                }
                else{
                if Reachability()!.isReachable {
                    
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                   
                     params = ["sender_id":login_session.value(forKey: "UserId")!,"subject":BookingId,"message":self.txtMessage.text!,"property_id":Singleton.sharedInstance.inboxConversationModel.propertyId,"receiver_id":Singleton.sharedInstance.inboxConversationModel.requesterId,"bookingno":Singleton.sharedInstance.inboxConversationModel.bookingId,"status":"Decline"]
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(HOST_DECLINE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                           
                             self.InboxConversationApiCall()
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
                    
                    
                    
                    
        //            self.showActivityIndicator(uiView: self.view)
        //            let parameterStr = "sender_id=\(login_session.value(forKey: "UserId") as? String ?? "")&subject=\(BookingId)&message=\(self.txtMessage.text!)&property_id=\(Singleton.sharedInstance.inboxConversationModel.propertyId)&receiver_id=\(Singleton.sharedInstance.inboxConversationModel.requesterId)&bookingno=\(Singleton.sharedInstance.inboxConversationModel.bookingId)&status=Decline"
        //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOST_DECLINE, APIKEY: "HOST_DECLINE")
                    self.txtMessage.text = ""
                } else {
                    self.showInformation(title: "Closest", message: "Please check your internet")
                }
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
    
    @IBAction func act_Decline(_ sender: UIButton) {
        self.txtMessage.resignFirstResponder()
        
        if self.txtMessage.text.count == 0 {
            self.showInformation(title: "Closest", message: "Please enter a message")
        }
        else{
        if Reachability()!.isReachable {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
           
             params = ["sender_id":login_session.value(forKey: "UserId")!,"subject":BookingId,"message":self.txtMessage.text!,"property_id":Singleton.sharedInstance.inboxConversationModel.propertyId,"receiver_id":Singleton.sharedInstance.inboxConversationModel.requesterId,"bookingno":Singleton.sharedInstance.inboxConversationModel.bookingId,"status":"Decline"]
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(HOST_DECLINE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                   
                     self.InboxConversationApiCall()
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
            
            
            
            
//            self.showActivityIndicator(uiView: self.view)
//            let parameterStr = "sender_id=\(login_session.value(forKey: "UserId") as? String ?? "")&subject=\(BookingId)&message=\(self.txtMessage.text!)&property_id=\(Singleton.sharedInstance.inboxConversationModel.propertyId)&receiver_id=\(Singleton.sharedInstance.inboxConversationModel.requesterId)&bookingno=\(Singleton.sharedInstance.inboxConversationModel.bookingId)&status=Decline"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOST_DECLINE, APIKEY: "HOST_DECLINE")
            self.txtMessage.text = ""
        } else {
            self.showInformation(title: "Closest", message: "Please check your internet")
        }
    }
        
    }
    
    func setData() {
        
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        let dateFormatterPrint3 = DateFormatter()
        dateFormatterPrint3.dateFormat = "EEE dd, yyyy"
        dateFormatterPrint3.locale = Locale(identifier: "en_US_POSIX")
        // let orderDateStringPasser = checkin
        
        if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.memberFrom)
        {
            print(dateFormatterPrint3.string(from: date))
            memberSinceString = dateFormatterPrint3.string(from: date)
            
        }
        else
        {
            print("There was an error decoding the string")
        }

        
        self.lblName.text = Singleton.sharedInstance.inboxConversationModel.requesterName
        let date = Singleton.sharedInstance.inboxConversationModel.memberFrom.components(separatedBy: " ")
        self.lblMemberSince.text = memberSince + ", " + memberSinceString
        let url = URL(string: Singleton.sharedInstance.inboxConversationModel.requesterImage)
        self.lblEnquiryID.text = Singleton.sharedInstance.inboxConversationModel.bookingId
        self.lblImgUser.kf.setImage(with: url, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

        self.lblChatTitle.text =  enquiryAbout + " " + Singleton.sharedInstance.inboxConversationModel.propertyName
        
        let checkin = Singleton.sharedInstance.inboxConversationModel.checkin.components(separatedBy: " ")
        
        let checkout = Singleton.sharedInstance.inboxConversationModel.checkout.components(separatedBy: " ")
        
        
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
       // let orderDateStringPasser = checkin
        
        if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.checkin)
        {
            print(dateFormatterPrint.string(from: date))
            fromDateString = dateFormatterPrint.string(from: date)
            
        }
        else
        {
            print("There was an error decoding the string")
        }

        
        let dateFormatterPrint1 = DateFormatter()
        // dateFormatterPrint1.dateFormat = "dd-MM-yyyy hh:mm a"
        dateFormatterPrint1.dateFormat = "MMM dd yyyy"
        dateFormatterPrint1.locale = Locale(identifier: "en_US_POSIX")
        
       // let deliveryDateStringPasser = mytrip.checkout
        
        if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.checkout)
        {
            print(dateFormatterPrint1.string(from: date))
            toDateString = dateFormatterPrint1.string(from: date)
            
        }
        else
        {
            print("There was an error decoding the string")
        }

        
        self.lblDate.text = fromDateString + " - " + toDateString
        
        self.lblGuestnumber.text = Singleton.sharedInstance.inboxConversationModel.noOfGuest
        
        if AcceptStatus == "Pending"{
            self.btnPreApproval.isHidden = false
            self.btnDecline.isHidden = false
            self.btnSend.isHidden = true
             self.PreApproveHeight.constant = 40
        } else {
            self.btnPreApproval.isHidden = true
            self.btnDecline.isHidden = true
            self.btnSend.isHidden = false
        }
    }
}




extension InboxConversationViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
       
            if Singleton.sharedInstance.inboxConversationModel == nil {
                return 0
            } else {
                if section == 0 {
                    return 1
                }else{
                     return Singleton.sharedInstance.inboxConversationModel.messages.count
                }
               
            }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if login_session.value(forKey: "UserId")as? String == Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].messageBy
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InboxConversationStaticTableViewCell") as? InboxConversationStaticTableViewCell
            cell!.selectionStyle = .none
            
            
           
                cell!.lblName.font = UIFont(name: BoldFont, size: 17)
                 cell!.lblMemberSince.font = UIFont(name: SemiBoldFont, size: 13)
                   cell!.lblChatTitle.font = UIFont(name: RegularFont, size: 14)
                  cell!.lblEnquiryID.font = UIFont(name: RegularFont, size: 13)
                 cell!.lblDate.font = UIFont(name: RegularFont, size: 13)
                  cell!.lblGuestnumber.font = UIFont(name: SemiBoldFont, size: 13)
                  
                cell!.btnDecline.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
                 cell!.btnPreApproval.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
                
                   cell!.EnquiryID.font = UIFont(name: SemiBoldFont, size: 13)
                   cell!.Date.font = UIFont(name: SemiBoldFont, size: 13)
                   cell!.Guest.font = UIFont(name: SemiBoldFont, size: 13)
            
            
            
            
            
            
            
            let dateFormatterGet = DateFormatter()
                   dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                   dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
                   let dateFormatterPrint3 = DateFormatter()
                   dateFormatterPrint3.dateFormat = "MMM dd, yyyy"
                   dateFormatterPrint3.locale = Locale(identifier: "en_US_POSIX")
                   // let orderDateStringPasser = checkin
                   
                   if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.memberFrom)
                   {
                       print(dateFormatterPrint3.string(from: date))
                       memberSinceString = dateFormatterPrint3.string(from: date)
                       
                   }
                   else
                   {
                       print("There was an error decoding the string")
                   }

                   
            
            cell!.lblName.text = Singleton.sharedInstance.inboxConversationModel.requesterName
                   let date = Singleton.sharedInstance.inboxConversationModel.memberFrom.components(separatedBy: " ")
                   cell!.lblMemberSince.text = memberSince + ", " + memberSinceString
                   let url = URL(string: Singleton.sharedInstance.inboxConversationModel.requesterImage)
                   cell!.lblEnquiryID.text = Singleton.sharedInstance.inboxConversationModel.bookingId
                   cell!.lblImgUser.kf.setImage(with: url, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

                   cell!.lblChatTitle.text =  enquiryAbout + " " + Singleton.sharedInstance.inboxConversationModel.propertyName
                   
                   let checkin = Singleton.sharedInstance.inboxConversationModel.checkin.components(separatedBy: " ")
                   
                   let checkout = Singleton.sharedInstance.inboxConversationModel.checkout.components(separatedBy: " ")
                   
                   
                   
                   let dateFormatterPrint = DateFormatter()
                   dateFormatterPrint.dateFormat = "MMM dd yyyy"
                   dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
                  // let orderDateStringPasser = checkin
                   
                   if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.checkin)
                   {
                       print(dateFormatterPrint.string(from: date))
                       fromDateString = dateFormatterPrint.string(from: date)
                       
                   }
                   else
                   {
                       print("There was an error decoding the string")
                   }

                   
                   let dateFormatterPrint1 = DateFormatter()
                   // dateFormatterPrint1.dateFormat = "dd-MM-yyyy hh:mm a"
                   dateFormatterPrint1.dateFormat = "MMM dd yyyy"
                   dateFormatterPrint1.locale = Locale(identifier: "en_US_POSIX")
                   
                  // let deliveryDateStringPasser = mytrip.checkout
                   
                   if let date = dateFormatterGet.date(from: Singleton.sharedInstance.inboxConversationModel.checkout)
                   {
                       print(dateFormatterPrint1.string(from: date))
                       toDateString = dateFormatterPrint1.string(from: date)
                       
                   }
                   else
                   {
                       print("There was an error decoding the string")
                   }

                   
                   cell!.lblDate.text = fromDateString + " - " + toDateString
                   
                   cell!.lblGuestnumber.text = Singleton.sharedInstance.inboxConversationModel.noOfGuest
            
            
            
            
            if AcceptStatus == "Pending"{
                cell!.btnPreApproval.isHidden = false
                cell!.btnDecline.isHidden = false
                self.btnSend.isHidden = true
                 cell!.PreApproveHeight.constant = 40
            } else {
                cell!.btnPreApproval.isHidden = true
                cell!.btnDecline.isHidden = true
                self.btnSend.isHidden = false
                  cell!.PreApproveHeight.constant = 0
            }
            
            cell!.btnPreApproval.addTarget(self, action: #selector(AcceptAct), for: .touchUpInside)
                   cell!.btnDecline.addTarget(self, action: #selector(DeclineAct), for: .touchUpInside)
            
            return cell!
        }else {
        
        if Singleton.sharedInstance.inboxConversationModel.hostId != Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].messageBy
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MessageSenderCell
            cell!.selectionStyle = .none
            cell!.imgSender.layer.cornerRadius = 30.0
            cell!.viewBg.layer.cornerRadius = 5.0
            

            cell!.imgBubbleSender.image = UIImage(named: "chat_bubble_sent")!
                .resizableImage(withCapInsets:
                                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
            //cell!.imgBubbleSender.tintColor = UIColor(named: "chat_bubble_color_received")
            cell!.imgBubbleSender.tintColor = hexStringToUIColor(hex: "#F1F1F1")

            
            let url = URL(string: Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].userImage)
            //cell!.imgSender.kf.setImage(with:url!)
            cell!.imgSender.kf.setImage(with: url, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
 cell!.lblMessage.font = UIFont(name: RegularFont, size: 14)
            cell!.lblTime.font = UIFont(name: SemiBoldFont, size: 13)
            cell!.lblMessage.text = Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].message
            
          
            //cell!.lblMessage.textColor = UIColor.white
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
             dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let startingDate = dateFormatter.date(from: Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].serverTime)
            let newformat = DateFormatter()
            newformat.dateFormat =  "MMM d, h:mm a"
            newformat.locale = Locale(identifier: "en_US_POSIX")
            newformat.string(from: startingDate!)
            print(startingDate!)
            print("Changed Date \(newformat.string(from: startingDate!))")
            let date = Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].serverTime.components(separatedBy: " ")
            cell!.lblTime.text = newformat.string(from: startingDate!)//date[0]
           // cell!.lblTime.textColor = UIColor.white
            return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellReceiver") as? MessageReceiverCell
            cell!.selectionStyle = .none
            cell!.viewBg.layer.cornerRadius = 5.0
            cell!.imgReceiver.layer.cornerRadius = 30.0
            cell!.lblName.font = UIFont(name: RegularFont, size: 14)
            cell!.lblDate.font = UIFont(name: SemiBoldFont, size: 12)
            cell!.imgBubbleReceiver.image = UIImage(named: "chat_bubble_received")!
                .resizableImage(withCapInsets:
                                    UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                resizingMode: .stretch)
                .withRenderingMode(.alwaysTemplate)
           // cell!.imgBubbleReceiver.tintColor = UIColor(named: "chat_bubble_color_received")
       cell!.imgBubbleReceiver.tintColor = hexStringToUIColor(hex: "#F1F1F1")

            let url = URL(string: Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].userImage)
          //  cell!.imgReceiver.kf.setImage(with:url!)
            cell!.imgReceiver.kf.setImage(with: url, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)

            cell!.lblName.text = Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].message
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
             dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let startingDate = dateFormatter.date(from: Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].serverTime)
            let newformat = DateFormatter()
            newformat.dateFormat =  "d MMM yy, h:mm a"
            newformat.locale = Locale(identifier: "en_US_POSIX")
            newformat.string(from: startingDate!)
            print(startingDate!)
            print("Changed Date \(newformat.string(from: startingDate!))")
            let date = Singleton.sharedInstance.inboxConversationModel.messages[indexPath.row].serverTime.components(separatedBy: " ")
            cell!.lblDate.text = newformat.string(from: startingDate!) //date[0]
            return cell!
        }
    }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}

extension InboxConversationViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "INBOX_HISTORY" {
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            self.tblInbox.isHidden = false
            if errorDict.count == 0 {
                  if responseDict.value(forKey: "status") as? Int ?? 0 == 1{
                let mod = InboxConversationModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxConversationModel = mod
                setData()
                self.tblInbox.reloadData()
                  }else{
                    
                }
            }
        }
        else if APIKEY == "SEND_MESSAGE" {
            if errorDict.count == 0 {
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1{
                    self.showActivityIndicator(uiView: self.view)
                  
                    
//                    let id = Singleton.sharedInstance.selectedCategory
//                    let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&bookingid=\(BookingId)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_HISTORY, APIKEY: "INBOX_HISTORY")
                }
            } else {
                
            }
        }
        else if APIKEY == "HOST_ACCEPT"{
            print(responseDict)
            if errorDict.count == 0 {
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1{
                    self.showActivityIndicator(uiView: self.view)
                    let id = Singleton.sharedInstance.selectedCategory
                    let mod = InboxConversationModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.inboxConversationModel = mod
                    let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&bookingid=\(BookingId)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
                    print(parameterStr)
                    if Singleton.sharedInstance.inboxConversationModel.message == "Successfully accepted"
                    {
                        self.btnPreApproval.isHidden = true
                        self.btnDecline.isHidden = true
                        self.btnSend.isHidden = false
                    }
                    else
                    {
                        //                        self.btnPreApproval.isHidden = false
                        //                        self.btnDecline.isHidden = false
                        self.btnSend.isHidden = true
                    }
                    
                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_HISTORY, APIKEY: "INBOX_HISTORY")
                }
            } else {
                
            }
        } else if APIKEY == "HOST_DECLINE"{
            if errorDict.count == 0 {
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1{
                    self.showActivityIndicator(uiView: self.view)
                    let parameterStr = "userid=\(login_session.value(forKey: "UserId") as? String ?? "")&bookingid=\(BookingId)"
                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_HISTORY, APIKEY: "INBOX_HISTORY")
                }
            } else {
                
            }
            
        }
    }
}

extension InboxConversationViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.lblPlaceHolder.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.txtMessage.resignFirstResponder()
        self.lblPlaceHolder.isHidden = true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
