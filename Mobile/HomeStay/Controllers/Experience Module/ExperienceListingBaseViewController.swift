//
//  ExperienceListingBaseViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 07/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown

class ExperienceListingBaseViewController: BaseViewController,UITextViewDelegate {

    
    @IBOutlet weak var viewHeading: UIView!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var buttonMyExperience: UIButton!
    @IBOutlet weak var labelBorderMyExperience: UILabel!
    @IBOutlet weak var labelYourReservation: UILabel!
    @IBOutlet weak var buttonReservation: UIButton!
    @IBOutlet weak var tableList: UITableView!
    @IBOutlet weak var EmptyScree: UIView!
    @IBOutlet weak var EmptyLbl: UILabel!
    
    
    
    var ListingsArray : NSMutableArray = []
    var ReservationArray : NSMutableArray = []
    var isFromList = false
    var SelectedType : String = ""
    var moreOptionStatusButton  = UIButton()
    let statusAvailableDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.statusAvailableDropDown
        ]
    }()
    var DropDownShowStatusArray : NSMutableArray = []
    let maxLength = 320
    var tripSelectedInt : Int = 0

    
    // Invoice  @IBOutlet weak var InvoiceDetailsLbl: UILabel!
    
    @IBOutlet weak var invoiceBGGrayView: UIView!
    @IBOutlet weak var invoiceView: UIView!
    @IBOutlet weak var propertyNameLbl: UILabel!
    @IBOutlet weak var invoiceReceiptLbl: UILabel!
    @IBOutlet weak var bookingIdLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var checkInLbl: UILabel!
    @IBOutlet weak var checkOutLbl: UILabel!
    @IBOutlet weak var cancellationPolicyLbl: UILabel!
    @IBOutlet weak var nightLbl: UILabel!
    @IBOutlet weak var guestLbl: UILabel!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var securityDepositLbl: UILabel!
    @IBOutlet weak var serviceFeeLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var walletAmountLbl: UILabel!
    @IBOutlet weak var paidAmountLbl: UILabel!
    @IBOutlet weak var invoiceBackButton: UIButton!
    @IBOutlet weak var PaymentDetailsLbl: UILabel!
    @IBOutlet weak var BookedDaysCount: UILabel!
    
    @IBOutlet weak var WalletLbl: UILabel!
    @IBOutlet weak var CouponLbl: UILabel!
    @IBOutlet weak var CouponValueLbl: UILabel!
    @IBOutlet weak var WalletViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CouponViewHeight: NSLayoutConstraint!
    @IBOutlet weak var WalletView: UIView!

    @IBOutlet weak var CouponView: UIView!
    
    
    //Add Dispute
    
    @IBOutlet weak var AddDisputeView: UIView!
    @IBOutlet weak var RentalNameLbl: UILabel!
    @IBOutlet weak var BookingLbl: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var CancelMessage: UITextView!
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var Submit: UIButton!
    
    @IBOutlet weak var DisputeRentalName: UILabel!
    @IBOutlet weak var DisputeBookingLbl: UILabel!
    @IBOutlet weak var DisputeLocation: UILabel!
    @IBOutlet weak var AddDispute: UILabel!
    @IBOutlet weak var CancelCountLbl: UILabel!


    // Show Cancel
    
    //Already Reviewed show popup
    @IBOutlet weak var showCancelBGGrayView: UIView!
    @IBOutlet weak var showCancelDateLbl: UILabel!
    @IBOutlet weak var showCancelRentalNameLbl: UILabel!
    @IBOutlet weak var showCancelRentalNameValueLbl: UILabel!
    @IBOutlet weak var showCancelBookingIdValueLbl: UILabel!
    @IBOutlet weak var showCancelLocationValueLbl: UILabel!
    @IBOutlet weak var showCancelTitleLbl: UILabel!
    @IBOutlet weak var showCancelMessageLbl: UILabel!

    @IBOutlet weak var showCancelBookingIdLbl: UILabel!
    @IBOutlet weak var showCancelLocationLbl: UILabel!
    
    @IBOutlet weak var ShowCancelBtn: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CancelCountLbl.text = " 0 / 320"

        self.SelectedType = "Listing"
        self.CancelMessage.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelTitleLbl.font = UIFont(name: SemiBoldFont, size: 16)

        self.showCancelLocationValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelLocationLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.showCancelDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelRentalNameLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.showCancelRentalNameValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelBookingIdValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelBookingIdLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showCancelMessageLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.ShowCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.labelHeading.font = UIFont(name: SemiBoldFont, size: 16)
        self.EmptyLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.CancelCountLbl.font =  UIFont(name: SemiBoldFont, size: 13)

        self.buttonMyExperience.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.buttonReservation.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.buttonMyExperience.setTitleColor(AppSecondColor, for: .normal)
        self.buttonReservation.setTitleColor(.darkGray, for: .normal)
        self.labelBorderMyExperience.isHidden = false
        self.labelYourReservation.isHidden = true
        self.ManageListingApi()
        
        self.CancelMessage.layer.borderWidth = 1.0
        self.CancelMessage.layer.borderColor = BorderColor.cgColor
        self.CancelMessage.layer.shadowColor = BorderColor.cgColor
        self.CancelMessage.layer.cornerRadius = 5
        self.CancelMessage.layer.shadowOffset = CGSize.zero
        self.CancelMessage.layer.shadowOpacity = 0.6
        self.CancelMessage.delegate = self
        self.CancelMessage.keyboardType = .default
        self.CancelMessage.returnKeyType = .done
        
        // Do any additional setup after loading the view.
    }
    @IBAction func act_back(_ sender: UIButton) {
      //  if !isFromList {
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
            self.navigationController?.pushViewController(nav!, animated: true)
//        }
//        else {
//            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    @IBAction func act_MyListing(_ sender: UIButton) {
        self.SelectedType = "Listing"
        self.buttonMyExperience.setTitleColor(AppSecondColor, for: .normal)
        self.buttonReservation.setTitleColor(.darkGray, for: .normal)
        self.labelBorderMyExperience.isHidden = false
        self.labelYourReservation.isHidden = true
        if self.ListingsArray.count == 0 {
             self.EmptyScree.isHidden = false
         }else{
             self.EmptyScree.isHidden = true
         }
        self.tableList.reloadData()
        
    }
    @IBAction func act_MyReservation(_ sender: UIButton) {
        self.SelectedType = "Reservation"
        self.buttonMyExperience.setTitleColor(.darkGray, for: .normal)
        self.buttonReservation.setTitleColor(AppSecondColor, for: .normal)
        self.labelBorderMyExperience.isHidden = true
        self.labelYourReservation.isHidden = false
        if self.ReservationArray.count == 0 {
             self.EmptyScree.isHidden = false
         }else{
             self.EmptyScree.isHidden = true
         }
        self.tableList.reloadData()
        
    }
    @IBAction func act_invoice_Back(_ sender: UIButton)
    {
        self.invoiceBGGrayView.isHidden = true
        self.invoiceView.isHidden = true
    }
    @IBAction func act_DisputeCloseButtonTapped(_ sender: UIButton)
    {
        self.AddDisputeView.isHidden = true
    }
    @IBAction func showReviewcancelBtnTapped(_ sender: UIButton)
    {
        self.showCancelBGGrayView.isHidden = true
    }
    @IBAction func act_DisputeSubmitTapped(_ sender: UIButton)
    {
        print(ReservationArray.object(at: self.tripSelectedInt))
        let HostStr = "\((self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "renter_id") as AnyObject)"
        print(HostStr)

        if (self.CancelMessage.text?.isEmpty)!
        {
            showInformation(title: "Info", message: "Please add your comment")

        }
        else
        {
            if Reachability()!.isReachable {

                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()

                params = ["base_id":1,"email":login_session.value(forKey: "Email") as? String ?? "","prd_id":(self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "experience_id") as? String ?? "","Bookingno":(self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","cancellation_percentage":"0","user_id":login_session.value(forKey: "UserId")!,"disputer_id":HostStr,"message":self.CancelMessage.text!,"currency_code":""]


                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>

                manager.post(EXPERIENCEHOSTCANCEL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {

                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {

                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.yourTripModel = mod
                        self.AddDisputeView.isHidden = true
                        self.CancelMessage.text = ""
                        self.ManageListingApi()
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
            else {
                showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            }

        }
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == CancelMessage {
            CancelCountLbl.text = "\(textView.text.count)/ 320"
            
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == CancelMessage {
            CancelCountLbl.text = "\(textView.text.count)/ 320"
            return textView.text.count + (text.count - range.length) <= maxLength
            
        }
        else{
            return true
        }
    }
    
    
    func ManageListingApi() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        
       print(params)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post("https://www.bensonboat.pofirentals.in/json/mobile_experiencelistview", parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                self.ListingsArray.removeAllObjects()
                self.ListingsArray.addObjects(from: (responseDict.object(forKey: "experience_listing") as? NSArray) as? [Any] ?? [])
                self.ReservationArray.removeAllObjects()
                self.ReservationArray.addObjects(from: (responseDict.object(forKey: "my_reservation") as? NSArray) as? [Any] ?? [])
                
               if self.ListingsArray.count == 0 {
                    self.EmptyScree.isHidden = false
                }else{
                    self.EmptyScree.isHidden = true
                }
                self.tableList.reloadData()
               
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
    
    @objc func selectMoreOptions(sender: UIButton)
    {
        
        let buttonRow = sender.tag
        print(buttonRow)
        self.tripSelectedInt = buttonRow
        
      //  futureBookingID = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "bookingno") as? String ?? ""
            
            
      
            self.DropDownShowStatusArray.removeAllObjects()
            
            
            if (self.ReservationArray.object(at: buttonRow) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 {
                if (self.ReservationArray.object(at: buttonRow) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Cancelled")
                }else{
                    self.DropDownShowStatusArray.add("Cancel")
                }
                
            }
            
            
            
//            if (self.ReservationArray.object(at: buttonRow) as? NSDictionary)?.value(forKey: "review_show_status") as? Int ?? 0 == 1 {
//
//                if (self.ReservationArray.object(at: buttonRow) as? NSDictionary)?.value(forKey: "is_review") as? Int ?? 0 == 1 {
//                    self.DropDownShowStatusArray.add("Your Review")
//
//                }else{
//                    self.DropDownShowStatusArray.add("Review")
//
//                }
//
//            }
            
//            if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1 {
//
//                if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1 {
//                    self.DropDownShowStatusArray.add("Disputed")
//
//                }else{
//                    self.DropDownShowStatusArray.add("Dispute")
//
//                }
//
//            }
            
           // self.DropDownShowStatusArray.add("Message")
            self.DropDownShowStatusArray.add("Invoice/Receipt")

               
            setupStatusAvailableDropDown()

            
            
            
        

        
        statusAvailableDropDown.anchorView = sender
        statusAvailableDropDown.direction = .bottom
        statusAvailableDropDown.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        statusAvailableDropDown.show()
        self.tableList.reloadData()
        
        
        
    }
    
    //MARK: - DropDown Setup
    func setupStatusAvailableDropDown() {
        statusAvailableDropDown.anchorView = moreOptionStatusButton
        statusAvailableDropDown.bottomOffset = CGPoint(x: 0, y: moreOptionStatusButton.bounds.height)
        //        statusAvailableDropDown.textFont = UIFont.init(name: "Trueno", size: 15)!
        statusAvailableDropDown.textFont.withSize(15.0)
        statusAvailableDropDown.dataSource = DropDownShowStatusArray as! [String]
        statusAvailableDropDown.backgroundColor = UIColor.white
        // Action triggered on selection
        statusAvailableDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
          //  self.selectedAvailableStatus = item
           
            
           
                
                if item == "Cancel" {
                    
                    self.DisputeRentalName.text = (self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "experience_title") as? String ?? ""
                    self.DisputeBookingLbl.text = (self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    self.DisputeLocation.text = (self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "experience_address") as? String ?? ""
                    self.AddDisputeView.isHidden = false
                }else if item == "Cancelled" {

                  
                   let cancelby = (self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "cancelled_by") as? String ?? ""
//
                    var params = NSMutableDictionary()
//
                    if cancelby != "Cancelled By Boat Owner"
                    {
                        params = ["product_id":"\((self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "experience_id") as AnyObject)","bookingno":(self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"user"]


                    }else{
                        params = ["product_id":"\((self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "experience_id") as AnyObject)","bookingno":(self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"host"]
                    }
                   
                    self.showActivityIndicator(uiView: self.view)
                  
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(ExPERIENCEMOBILECANCELVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            
                            
                            

                            self.showCancelMessageLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "message") as? String ?? ""


                            self.showCancelBookingIdValueLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Booking_no") as? String ?? ""

                            self.showCancelRentalNameValueLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "name") as? String ?? ""

                            self.showCancelLocationValueLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "address") as? String ?? ""
                            self.showCancelDateLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "cancelled_date") as? String ?? ""


                            self.showCancelBGGrayView.isHidden = false

                          
//
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
                    
                 //   self.showInformation(title: "Info", message: "Already Cancelled")
                }else if item ==  "Invoice/Receipt"{
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.ReservationArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
           
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(EXPERIENCEINVOICE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            self.invoiceBGGrayView.isHidden = false
                            self.invoiceView.isHidden = false
                            
                            let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                            self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                            self.propertyNameLbl.textColor = AppColor
                            self.propertyNameLbl.textColor = AppColor
                            self.bookingIdLbl
                                .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                            let street =    hotelDict!.value(forKey: "city") as! CVarArg
                            let state = hotelDict!.value(forKey: "state") as! CVarArg
                            let country = hotelDict!.value(forKey: "country") as! CVarArg
                            
                            self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
                            self.locationLbl.textColor = AppColor
                            
                            self.checkInLbl.text = "Duration"
                            self.checkOutLbl.text = String(format: "%@",hotelDict!.value(forKey: "checkindate") as! CVarArg ) + "\n \(String(format: " %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg ))"
                            self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                           
                            
                            self.checkOutLbl.textColor = AppColor
                            
                            let BookingType = hotelDict!.value(forKey: "booking_type") as? String ?? ""
                            
                            if BookingType == "hourly" {
                                
                                self.BookedDaysCount.text = String(format: "Booked for %@ Hours  ",hotelDict!.value(forKey: "numofhours") as! CVarArg)
                                self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofhours") as! CVarArg )
                            
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofhours") as AnyObject) Hours"

                            }else{
                                self.BookedDaysCount.text = String(format: "Booked for %@ Days  ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                            //   self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofdates") as AnyObject) Days"
                            }
                            
                            
                            
                            
                            self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                            self.securityDepositLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                            self.serviceFeeLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "servicefee") as! CVarArg )
                            self.totalAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                            let CouponUsed = "\(hotelDict!.value(forKey: "is_coupon_used") as AnyObject)"
                            let WalletUsed = "\(hotelDict!.value(forKey: "is_wallet_used") as AnyObject)"

                            if CouponUsed == "No" {
                                self.CouponView.isHidden = true
                                self.CouponViewHeight.constant = 0
                                
                            }else{
                                self.CouponView.isHidden = false
                                self.CouponViewHeight.constant = 40
                            }
                            if WalletUsed == "No" {
                                self.WalletView.isHidden = true
                                self.WalletViewHeight.constant = 0
                                
                            }else{
                                self.WalletView.isHidden = false
                                self.WalletViewHeight.constant = 40
                            }
                            
                            self.CouponValueLbl.text = "\(hotelDict!.value(forKey: "currency_code") as AnyObject) \(hotelDict!.value(forKey: "couponDiscount") as AnyObject)"
                            
                            
                            self.walletAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                            self.paidAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                            self.cancellationPolicyLbl.text = String(format: "Cancelled Status : %@",hotelDict!.value(forKey: "cancelled_status") as! CVarArg )
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
                }else{
                    
                }
                
                
            

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
extension ExperienceListingBaseViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.SelectedType == "Listing" {
            return self.ListingsArray.count
        }else{
            return self.ReservationArray.count
        }
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.SelectedType == "Listing" {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ExperienceListingBaseTableViewCell") as! ExperienceListingBaseTableViewCell
        cell.selectionStyle = .none
        
        let ImageStr = (self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_image") as? String ?? ""
        
        let urlString = ImageStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        let imageUrl = URL(string: urlString)
        cell.imageViewMain.setImageWith(imageUrl!, placeholderImage: UIImage(named: "picture-frame"))
        cell.labelTitle.textColor = AppColor
        cell.labelTitle.font = UIFont(name: SemiBoldFont, size: 16)
        cell.labelStatus.font = UIFont(name: SemiBoldFont, size: 13)
        cell.labelDateAndTime.font = UIFont(name: SemiBoldFont, size: 13)
            cell.Statuslbl.font = UIFont(name: SemiBoldFont, size: 13)
        
        cell.labelTitle.text = (self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_title") as? String ?? ""
        
        
        let attributedString = NSMutableAttributedString()
        
        
        let start = "Status :  "
        
        
        let attributed = NSAttributedString(string: start, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        
       
        let attributedTwo = NSAttributedString(string: "\((self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "remaining_steps") as AnyObject) steps to list", attributes: [NSAttributedString.Key.foregroundColor : AppColor])
        
        attributedString.append(attributed)
        attributedString.append(attributedTwo)
         cell.labelStatus.text = "\((self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_status") as AnyObject)" //attributedString
        
        cell.labelDateAndTime.text = (self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "created_date") as? String ?? ""
        
        if (self.ListingsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_status") as? String ?? "" == "Pay" {
            cell.buttonPayNow.isHidden = false
            
//            let attributedStrings = NSMutableAttributedString()
//
//
//            let starts = "Status :  "
//
//
//            let attributeds = NSAttributedString(string: starts, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
//
//           
//            let attributedTwos = NSAttributedString(string: "Pay", attributes: [NSAttributedString.Key.foregroundColor : UIColor.orange])
//
//            attributedStrings.append(attributeds)
//            attributedStrings.append(attributedTwos)
//             cell.labelStatus.attributedText = attributedStrings
            
            
            
            
        }else{
            cell.buttonPayNow.isHidden = true
        }
        
        cell.buttonPayNow.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        cell.buttonManage.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
            cell.buttonManage.tag = indexPath.row
            cell.buttonPayNow.tag = indexPath.row
        cell.buttonManage.backgroundColor = AppColor
            cell.buttonManage.addTarget(self, action: #selector(updateManageAction), for: .touchUpInside)
            cell.buttonPayNow.addTarget(self, action: #selector(PayNowAction), for: .touchUpInside)
      
        return cell
        }else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "ExperienceReservationTableViewCell") as! ExperienceReservationTableViewCell
            
            cell.selectionStyle = .none
            cell.ExpNameLbl.font = UIFont(name: SemiBoldFont, size: 15)
            cell.ExpNameLbl.textColor = AppColor
            cell.ExpDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpaddressLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpHostAppLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpPayStatusValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExppayStatusLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpHostAppValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpBookingIdLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpBookingIDValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpHostNameLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ExpPriceLbl.font = UIFont(name: SemiBoldFont, size: 16)
            
            cell.ThreeDots.tag = indexPath.row
            cell.ThreeDots.addTarget(self, action: #selector(selectMoreOptions), for: .touchUpInside)
            moreOptionStatusButton.frame = cell.ThreeDots.frame
            
             cell.ExpNameLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_title") as? String ?? ""
            
            cell.ExpDateLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "booking_dates") as? String ?? ""
            
            cell.ExpaddressLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_address") as? String ?? ""

            cell.ExpPayStatusValueLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "payment_status") as? String ?? ""
            
            if (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "approval_status") as? String ?? "" == "Accepted" {
                cell.ExpHostAppValueLbl.textColor = .green
            }else{
                cell.ExpHostAppValueLbl.textColor = .black
            }
            
            cell.ExpHostAppValueLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "approval_status") as? String ?? ""
            
            cell.ExpBookingIDValueLbl.text = "\((self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "bookingno") as! AnyObject)"
            
            cell.ExpHostNameLbl.text = (self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "user_name") as? String ?? ""
            
            cell.ExpPriceLbl.text = "\((self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "paid_currency_symbol") as? String ?? "") \((self.ReservationArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "experience_price") as! AnyObject)"
           return cell
        }
   }
    
    @objc func updateManageAction(sender: UIButton) {
        let ind = sender.tag
        currentExpId = "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "experience_id") as AnyObject)"
        let vc = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceBaseViewController") as! ExperienceBaseViewController
        isFromManage = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func PayNowAction(sender: UIButton) {
        let ind = sender.tag
       let TotalAmount =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "App_Currency_Admin_Amount") as AnyObject)"
        let TotalPrice =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "Admin_Amount_In_USD") as AnyObject)"
        
        let HostId =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "host_id") as AnyObject)"
        
        let HostingPrice =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "Admin_Amount_In_USD") as AnyObject)"
        
        let commission =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "commission") as AnyObject)"
        
        let commissionType =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "commission_type") as AnyObject)"
        
       
        
        let PropertId =  "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "experience_id") as AnyObject)"
        
        let nav = storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as! NewPaymentViewController
        nav.paymentComingType = "ExperienceListing"
        var PaymentMethodsArr : NSMutableArray = []
        PaymentMethodsArr.add("Stripe")
        PaymentMethodsArr.add("PayPal")
        //PaymentMethodsArr.add("Credit Card")
        print(PaymentMethodsArr)
        nav.PaymentsArray = PaymentMethodsArr
            nav.TotalAmount = "\(TotalAmount)"
            nav.enquiryid = ""
//        nav!.ServiceFee = ""
//        nav!.SecurityDeposit = self.SecurityDeposit
        nav.PropertId = "\(PropertId)"
        nav.HostId = HostId
        nav.Commission = commission
        nav.CommissionType = commissionType
        nav.TotalPrice = TotalPrice
        nav.TotalAmount = TotalAmount
        nav.PropertId = PropertId
        nav.HostingPrice = HostingPrice
        nav.WalletShow = 0
        nav.CouponShow = 0
//        nav.currency_cron_id = "\((self.ListingsArray.object(at: ind) as? NSDictionary)?.object(forKey: "experience_id") as AnyObject)"
        self.navigationController?.pushViewController(nav, animated: true)
  }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
       
    }
    
    
}
