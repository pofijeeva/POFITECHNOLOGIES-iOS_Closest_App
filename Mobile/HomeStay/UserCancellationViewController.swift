 //
 //  UserCancellationViewController.swift
 //  HomeStay
 //
 //  Created by saravanan2 on 20/12/19.
 //  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
 //
 
 import UIKit
 import AFNetworking
 
 
 class UserCancellationViewController: BaseViewController {
    
    
    
    
    
    @IBOutlet weak var ViewIndicator: UIView!
    @IBOutlet weak var CancelByYouCountLbl: UILabel!
    @IBOutlet weak var CancelAboutCountLbl: UILabel!
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var NavTitleLbl: UILabel!

    @IBOutlet weak var CancellationTable: UITableView!
    
    @IBOutlet weak var CancelByYouCountBtn: UIButton!
    @IBOutlet weak var CancelAboutCountBtn: UIButton!
    @IBOutlet weak var EmptyImg: UIImageView!
    
    var AboutYou = true
    var Reload = -1
    var ReloadReject = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CancelByYouCountLbl.backgroundColor = AppSecondColor
        self.CancelAboutCountLbl.backgroundColor = AppSecondColor
        self.ViewIndicator.backgroundColor = AppSecondColor
        
        self.NavTitleLbl.font = UIFont(name: SemiBoldFont, size: 15
        )
        self.noDataLbl.font = UIFont(name: RegularFont, size: 15)
        self.CancelByYouCountLbl.font = UIFont(name: SemiBoldFont, size: 12)
        self.CancelAboutCountLbl.font = UIFont(name: SemiBoldFont, size: 12)
        
         self.CancelByYouCountBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 12)
         self.CancelAboutCountBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 12)
        
        
        CancellationTable.tableFooterView = UIView()
        CancelByYouCountLbl.text = String(format: "%d", Singleton.sharedInstance.userInfoModel.cancellationByYou.count)
        CancelByYouCountLbl.isHidden = false
        CancelByYouCountLbl.layer.cornerRadius = 10
        CancelByYouCountLbl.layer.masksToBounds = true
        
        CancelAboutCountLbl.text = String(format: "%d", Singleton.sharedInstance.userInfoModel.cancellationAboutYou.count)
        CancelAboutCountLbl.isHidden = false
        CancelAboutCountLbl.layer.cornerRadius = 10
        CancelAboutCountLbl.layer.masksToBounds = true
        AboutYou = true
        if Singleton.sharedInstance.userInfoModel != nil {
            if Singleton.sharedInstance.userInfoModel.cancellationAboutYou.count != 0 {
                self.CancellationTable.isHidden = false
                self.noDataLbl.isHidden = true
                self.EmptyImg.isHidden = true
                self.CancellationTable.reloadData()
            }else{
                self.CancellationTable.isHidden = true
                self.noDataLbl.isHidden = false
                self.EmptyImg.isHidden = false

            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func back_Btn_Tapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Cancel_About_You_Act(_ sender: UIButton) {
        AboutYou = true
        if Singleton.sharedInstance.userInfoModel != nil {
            if Singleton.sharedInstance.userInfoModel.cancellationAboutYou.count != 0 {
                self.CancellationTable.isHidden = false
                self.noDataLbl.isHidden = true
                self.EmptyImg.isHidden = true

                self.CancellationTable.reloadData()
            }else{
                self.CancellationTable.isHidden = true
                self.noDataLbl.isHidden = false
                self.EmptyImg.isHidden = false

            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.ViewIndicator.frame = CGRect(x: 0, y: self.ViewIndicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
    }
    @IBAction func Cancel_By_You_Act(_ sender: UIButton) {
        AboutYou = false
        if Singleton.sharedInstance.userInfoModel != nil {
            if Singleton.sharedInstance.userInfoModel.cancellationByYou.count != 0 {
                self.CancellationTable.isHidden = false
                self.noDataLbl.isHidden = true
                self.EmptyImg.isHidden = true

                self.CancellationTable.reloadData()
            }else{
                self.CancellationTable.isHidden = true
                self.noDataLbl.isHidden = false
                self.EmptyImg.isHidden = false

            }
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.ViewIndicator.frame = CGRect(x: self.view.frame.width / 2, y: self.ViewIndicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
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
    
    @objc func HostAccept(sender:UIButton) {
        let Index = sender.tag
        let CancelID = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[Index].cancelId
        let BookingID = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[Index].bookingNo
        if (Reachability()?.isReachable)!
        {
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["language":login_session.value(forKey: "APP_LANGUAGE") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"user_id":login_session.value(forKey: "UserId")!,"device_type":"ios","booking_no":BookingID!,"cancel_id":CancelID!]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(HOST_ACCEPT_CANCE_REQUEST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    
                    self.Reload = Index
                    self.UserInformation()
                    //    self.CancellationTable.reloadData()
                    
                    
                    
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }else
        {
            self.showInformation(title: "Warning", message: "Check your internet connection")
        }
        
    }
    
    @objc func HostCancel(sender:UIButton) {
        let Index = sender.tag
        let CancelID = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[Index].cancelId
        let BookingID = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[Index].bookingNo
        if (Reachability()?.isReachable)!
        {
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["language":login_session.value(forKey: "APP_LANGUAGE") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"user_id":login_session.value(forKey: "UserId")!,"device_type":"ios","booking_no":BookingID!,"cancel_id":CancelID!]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(HOST_REJECT_CANCE_REQUEST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    
                    
                    self.ReloadReject = Index
                    self.UserInformation()
                    
                    
                    
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }else
        {
            self.showInformation(title: "Warning", message: "Check your internet connection")
        }
        
    }
    
    func UserInformation(){
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["language":login_session.value(forKey: "APP_LANGUAGE") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"userid":login_session.value(forKey: "UserId")!]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(USER_INFO_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.userInfoModel = mod
                    self.CancellationTable.reloadData()
                    
                }
                    
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }else
        {
            self.showInformation(title: "Warning", message: "Check your internet connection")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
 }
 extension UserCancellationViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if Singleton.sharedInstance.userInfoModel != nil {
            if self.AboutYou == true {
                return Singleton.sharedInstance.userInfoModel.cancellationAboutYou.count
            }else{
                return Singleton.sharedInstance.userInfoModel.cancellationByYou.count
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.userInfoModel != nil {
            if self.AboutYou == true {
                return 1
            }else{
                return 1
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if self.AboutYou == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell
            cell?.selectionStyle = .none
            let Image = URL(string: Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].userImage)
            cell?.img_user.setImageWith(Image!)
            
            cell!.lbl_reviewComments.font = UIFont(name: SemiBoldFont, size: 15)
                        cell!.rentalName.font = UIFont(name: RegularFont, size: 15)
                         cell!.lbl_userName.font = UIFont(name: RegularFont, size: 15)
                         cell!.bookingDateLabel.font = UIFont(name: RegularFont, size: 13)
                         cell!.bookingIdLabel.font = UIFont(name: RegularFont, size: 13)
            
             cell!.AcceptRejectStatus.font = UIFont(name: SemiBoldFont, size: 14)
                        
                        cell!.acceptBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                        cell!.rejectBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
            
            cell!.rejectBtn.layer.borderWidth = 0.5
            cell!.rejectBtn.layer.borderColor = UIColor.lightGray.cgColor
            
            cell?.rentalName.text = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].propertyName
            
            cell?.lbl_reviewComments.text = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].message
            
            cell?.lbl_userName.text = "By " + Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].userName
            
            let dateFormatterGet = DateFormatter()
                   dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                   dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
                   let dateFormatterPrint3 = DateFormatter()
                   dateFormatterPrint3.dateFormat = "yyyy-MM-dd"
                   dateFormatterPrint3.locale = Locale(identifier: "en_US_POSIX")
                   // let orderDateStringPasser = checkin
                   
                   if let date = dateFormatterGet.date(from: Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].createdDate!)
                   {
                       print(dateFormatterPrint3.string(from: date))
                    cell?.bookingDateLabel.text = dateFormatterPrint3.string(from: date)
                       
                   }
            
            
            
           // cell?.bookingDateLabel.text = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].createdDate
            cell?.bookingIdLabel.text = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].bookingNo
            let Status =  Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].status!
            let Email = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].reviewEmail!
            cell?.acceptBtn.isHidden = true
            cell?.rejectBtn.isHidden = true
            
            //            if self.Reload == indexPath.section {
            //                  cell?.AcceptRejectStatus.text = "Cancelled"
            //            }else if self.ReloadReject == indexPath.section {
            //                cell?.AcceptRejectStatus.text = "Rejected"
            //            }
            //            else{
            if Status == "Pending" {
                cell?.acceptBtn.isHidden = false
                cell?.rejectBtn.isHidden = false
                cell?.AcceptRejectStatus.isHidden = true
            }else if Status == "Accept" {
                cell?.AcceptRejectStatus.isHidden = false
                cell?.AcceptRejectStatus.text = "Cancelled"
            }else if Status == "Reject" {
                cell?.AcceptRejectStatus.isHidden = false
                cell?.AcceptRejectStatus.text = "Rejected"
            }else if String(describing: login_session.value(forKey: "UserId") as AnyObject) == Email {
                cell?.AcceptRejectStatus.isHidden = false
                cell?.AcceptRejectStatus.text = "Host Cancelled"
            }else{
                cell?.AcceptRejectStatus.isHidden = false
                cell?.AcceptRejectStatus.text = Singleton.sharedInstance.userInfoModel.cancellationAboutYou[indexPath.section].status!
            }
            //  }
            
            
            
            
            
            cell?.acceptBtn.tag = indexPath.section
            cell?.acceptBtn.addTarget(self, action:#selector(self.HostAccept(sender:)), for: .touchUpInside)
            cell?.rejectBtn.tag = indexPath.section
            cell?.rejectBtn.addTarget(self, action:#selector(self.HostCancel(sender:)), for: .touchUpInside)
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ByCell") as? ReviewsByTableViewCell
            cell?.selectionStyle = .none
            cell?.img_User.layer.cornerRadius = (cell?.img_User.frame.width)!/2
            cell?.img_User.layer.masksToBounds = true
            
            
            
            cell!.lbl_reviews.font = UIFont(name: SemiBoldFont, size: 14)
                                      cell!.rentalName.font = UIFont(name: RegularFont, size: 14)
                                       cell!.hostName.font = UIFont(name: RegularFont, size: 14)
                                       cell!.bookingDateLabel.font = UIFont(name: RegularFont, size: 13)
                                       cell!.bookingIdLabel.font = UIFont(name: RegularFont, size: 13)
                                       cell!.statusLabel.font = UIFont(name: RegularFont, size: 14)
            let image = URL(string: Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].userImage)
            cell?.img_User.setImageWith(image!)
            cell?.rentalName.text = Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].propertyName
            cell?.hostName.text = "By " + Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].hostName
            cell?.lbl_reviews.text = Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].message
            cell?.bookingIdLabel.text = Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].bookingNo
            
            let dateFormatterGet = DateFormatter()
                   dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                   dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
                   let dateFormatterPrint3 = DateFormatter()
                   dateFormatterPrint3.dateFormat = "yyyy-MM-dd"
                   dateFormatterPrint3.locale = Locale(identifier: "en_US_POSIX")
                   // let orderDateStringPasser = checkin
                   
                   if let date = dateFormatterGet.date(from: Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].createdDate!)
                   {
                       print(dateFormatterPrint3.string(from: date))
                    cell?.bookingDateLabel.text = dateFormatterPrint3.string(from: date)
                       
                   }
//            cell?.bookingDateLabel.text = Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].createdDate
            cell?.statusLabel.text = Singleton.sharedInstance.userInfoModel.cancellationByYou[indexPath.section].status
            
            
            
            
            return cell!
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 245
    //    }
 }

