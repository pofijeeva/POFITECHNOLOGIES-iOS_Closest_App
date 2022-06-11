//
//  ExperienceBookingViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class ExperienceBookingViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var tableViewList: UITableView!
    
    var bookingID : String = ""
    var noOfGuest : String = ""
    var dateOfBooking : String = ""
    var timeOfBooking : String = ""
    var locationPlace : String = ""
    var daycount : String = ""

    var unitPrice : String = ""
    var servicePrice : String = ""
    var securityDeposit : String = ""
    var totalAmount : String = ""
    var nameOfBoat : String = ""
    var arrayOfSlots = [[String:AnyObject]]()
    var CurrencySymbol  : String = ""
    
    var DateId : String = ""
    var expId : String = ""
    var exp_host_id : String = ""
    var ChooseTimeArray : NSMutableArray = []
    var ImageStr : String = ""
    var CurrencyCornId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChooseTime()
        self.labelDescription.font = UIFont(name: SemiBoldFont, size: 20.0)
        self.labelDescription.textColor = UIColor.darkGray
    }
    
    func ChooseTime(){
        
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","date_id":self.DateId,"exp_id":self.expId,"host_id":self.exp_host_id]
        
        
             
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(ExperienceChooseTime, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    
                    self.bookingID = ((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Booking_no") as? String ?? ""
                    self.nameOfBoat = ((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "experience_title") as? String ?? ""
                    
                    self.ImageStr = ((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "exp_image") as? String ?? ""
                    
                    self.noOfGuest = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "no_of_guest") as AnyObject) Guest"
                    
                    let starteDate = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "from_date") as AnyObject)"
                    var EndDate = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "to_date") as AnyObject)"
                    self.dateOfBooking = starteDate + " - " + EndDate
                    self.locationPlace = ((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "exp_address") as? String ?? ""
                    self.daycount = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "no_of_guest") as AnyObject)"
                    self.CurrencySymbol = ((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "userCurSym") as? String ?? ""
                    self.unitPrice = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "exp_unit_price") as? String ?? "")"
                    self.servicePrice = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "service_fee") as! AnyObject)"
                    self.securityDeposit = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "security_deposit") as? String ?? "")"
                    self.totalAmount = "\(((responseDict.object(forKey: "Booking_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "total") as AnyObject)"
                    
                    self.ChooseTimeArray.addObjects(from: (responseDict.object(forKey: "Exp_Schedules") as? NSArray) as? [Any] ?? [])
                    self.tableViewList.reloadData()
                    
                    
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
    
    @objc func BookNowAct(sender: UIButton)
    {
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","date_id":self.DateId,"exp_id":self.expId,"host_id":self.exp_host_id,"booking_no":self.self.bookingID]
    
       
         
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(ExperienceConfirm, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                
                var PaymentMethodsArr : NSMutableArray = []
                
               let BoookinId = "\(responseDict.value(forKey: "Booking_id") as? String ?? "")"
                let TotalAMOUNT = "\(((responseDict.value(forKey: "exp_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Total_Amount") as AnyObject)"

                let Enquiry = responseDict.value(forKey: "Booking_id") as AnyObject

                PaymentMethodsArr.add("Stripe")
                PaymentMethodsArr.add("PayPal")
                PaymentMethodsArr.add("Credit Card")
                print(PaymentMethodsArr)

                
                let BookingVC = self.storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as! NewPaymentViewController
               
                BookingVC.PaymentsArray = PaymentMethodsArr
                BookingVC.paymentComingType = "ExperienceBooking"
                BookingVC.TotalAmount = TotalAMOUNT
                BookingVC.enquiryid = "\(Enquiry)"
                BookingVC.PropertId = self.expId
                BookingVC.ServiceFee = self.servicePrice
                BookingVC.SecurityDeposit = self.securityDeposit
                BookingVC.currency_cron_id = self.CurrencyCornId
                
                self.navigationController?.pushViewController(BookingVC, animated: true)
               
                
                
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
    
    //MARK: table datasource and delegate:
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "informationOnBookingIdTableViewCell", for: indexPath) as! informationOnBookingIdTableViewCell
                let attributedString = NSMutableAttributedString()
                let str = "Information on booking id:  "
                let attributed = NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
                let attributedTwo = NSAttributedString(string: self.bookingID, attributes: [NSAttributedStringKey.foregroundColor : AppSecondColor])
                attributedString.append(attributed)
                attributedString.append(attributedTwo)
                cell.labelInformationonBooking.attributedText = attributedString
                
                cell.labelBoatName.text = self.nameOfBoat
                cell.labelNoOfGuests.text = self.noOfGuest
                cell.labelDate.text = self.dateOfBooking
                let wishlistImgUrl = URL(string: self.ImageStr)
                if wishlistImgUrl != nil {
                    
                    cell.imageViewProfile.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "test"), options: nil, progressBlock: nil, completionHandler: nil)
                }
                
                
                cell.selectionStyle = .none
                return cell
            }
            else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
                cell.labelLocation.text = self.locationPlace
                cell.selectionStyle = .none
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TimingsHeadingTableViewCell", for: indexPath) as! TimingsHeadingTableViewCell
                cell.selectionStyle = .none
                return cell
            }
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimingsValueTableViewCell", for: indexPath) as! TimingsValueTableViewCell
            cell.selectionStyle = .none
            
            cell.labelSubHeading.text = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_title") as? String ?? ""

            cell.labelDate.text = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_schedule_date") as? String ?? ""
            
            let StartTime = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_start_time") as? String ?? ""
                let EndTime = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_end_time") as? String ?? ""
            cell.labelTime.text = StartTime + " - " + EndTime
          

            return cell
        }
        else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PriceTableViewCell", for: indexPath) as! PriceTableViewCell
                cell.labelUnitPriceValue.text = self.CurrencySymbol + self.unitPrice
                cell.labelServiceFeeValue.text = self.CurrencySymbol + self.servicePrice
                cell.labelValueSecurityDeposit.text = self.CurrencySymbol + self.securityDeposit
                cell.selectionStyle = .none
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TotalTableViewCell", for: indexPath) as! TotalTableViewCell
                cell.selectionStyle = .none
                cell.cancelLbl.font = UIFont(name: SemiBoldFont, size: 14)
                cell.labelTotalValue.text = self.CurrencySymbol + self.totalAmount
                cell.buttonBookNow.addTarget(self, action:#selector(BookNowAct), for: .touchUpInside)
                cell.cancelLbl.text = "You can cancel your Experience before \(self.daycount) days from check in date..!"
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else if section == 1 {
            return self.ChooseTimeArray.count
        }
        else {
            return 2
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 150.0
            }
            else if indexPath.row == 1 {
                return 44.0
            }
            else {
                return 35.0
            }
        }
        else if indexPath.section == 1 {
            return 95.0
        }
        else {
            if indexPath.row == 0 {
                return 105.0
            }
            else {
                return UITableViewAutomaticDimension
            }
        }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
