//
//  ExperienceHistoryViewController.swift
//  HomeStay
//
//  Created by Apple7 on 05/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown

class ExperienceHistoryViewController: BaseViewController,UITextViewDelegate {

    
    @IBOutlet weak var HeaderTitleLbl: UILabel!
    @IBOutlet weak var HistoryDetailsTable: UITableView!
    @IBOutlet weak var PastbookingBtn: UIButton!
    @IBOutlet weak var FuturebookingBtn: UIButton!
    @IBOutlet weak var FutureColorLbl: UILabel!
    @IBOutlet weak var PastColorLbl: UILabel!
    
    @IBOutlet weak var ExperienceTable: UITableView!
    @IBOutlet weak var AvailableDates: UILabel!
    @IBOutlet weak var ExpDatesView: UIView!
    @IBOutlet weak var ExpDatesTableView: UIView!
    
    @IBOutlet weak var EmptyScree: UIView!
    @IBOutlet weak var EmptyLbl: UILabel!
    
    var isFuture = true
    var SelectedRow = Int()
    let maxLength = 320

    
    
    
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
    
    
    //Message
    @IBOutlet weak var MessagePopUpView: UIView!
    @IBOutlet weak var MessageHeaderLbl: UILabel!
    @IBOutlet weak var MessageTextField: UITextField!
    @IBOutlet weak var MessageOkayButton: UIButton!
    @IBOutlet weak var MessageCanceButton: UIButton!
    @IBOutlet weak var MessageTitleLbl: UILabel!
    
    
    /////////////// INVOICE///////////////////////
    @IBOutlet weak var InvoiceDetailsLbl: UILabel!
    
    @IBOutlet weak var invoiceBGGrayView: UIView!
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


    // Cancelled View
    
    @IBOutlet weak var CancelledView: UIView!
    @IBOutlet weak var CancelledImg: UIImageView!
    @IBOutlet weak var CancelledTitle: UILabel!
    @IBOutlet weak var CancelledExpTitle: UILabel!
    @IBOutlet weak var CancelledMsg: UILabel!
    @IBOutlet weak var CancelledDate: UILabel!

    
    
    
    var HistoryShowArray = NSMutableArray()
    var HistoryDetailsDict = NSMutableDictionary()
    var ExpScghedules = NSMutableArray()
    
    var selectdType = String()
    
    var DropDownShowStatusArray = NSMutableArray()

    
    let statusAvailableDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.statusAvailableDropDown
        ]
    }()
    var moreOptionStatusButton  = UIButton()
    var AddreviewPropertyId = String()
    var AddreviewPropertyBookingNum = String()
    
//    var AddreviewPropertyId = String()
//    var AddreviewPropertyBookingNum = String()
    
    
    
    // SHOW REVIEW
    
    @IBOutlet weak var ShowReviewView: UIView!
    @IBOutlet weak var ShowReviewDateLbl: UILabel!
    @IBOutlet weak var ShowReviewImage: UIImageView!
    @IBOutlet weak var ShowReviewMessageLbl: UILabel!
    @IBOutlet weak var ReviewFloatRatingView: FloatRatingView!

    @IBOutlet weak var ShowReviewPropertyNameLbl: UILabel!

    @IBOutlet weak var ShowReviewBookingNumLbl: UILabel!

    @IBOutlet weak var ExtraShowReviewcancelBtn: UIButton!


    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.self.HistoryDetailsTable.isHidden = true
        
        CancelCountLbl.text = " 0 / 320"
        
        self.ExperienceHistoryAPI()
        self.FutureColorLbl.isHidden = false
        self.PastColorLbl.isHidden = true
        self.HeaderTitleLbl.font =  UIFont(name: SemiBoldFont, size: 16)
        self.AvailableDates.font =  UIFont(name: SemiBoldFont, size: 16)
        self.EmptyLbl.font =  UIFont(name: SemiBoldFont, size: 16)
        self.FuturebookingBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.PastbookingBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.FuturebookingBtn.setTitleColor(AppSecondColor, for: .normal)
        self.PastbookingBtn.setTitleColor(.darkGray, for: .normal)
        self.selectdType = "present_experience"
        
        self.CancelMessage.layer.borderWidth = 1.0
        self.CancelMessage.layer.borderColor = UIColor(hex: 0xBFBFC2).cgColor
        self.CancelMessage.layer.shadowColor = UIColor(hex: 0xBFBFC2).cgColor
        self.CancelMessage.layer.cornerRadius = 5
        self.CancelMessage.layer.shadowOffset = CGSize.zero
        self.CancelMessage.layer.shadowOpacity = 0.6
        self.CancelMessage.delegate = self
        self.CancelMessage.keyboardType = .default
        self.CancelMessage.returnKeyType = .done
        self.CouponValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        
       
        
        self.CancelledTitle.font =  UIFont(name: SemiBoldFont, size: 14)
        self.CancelledExpTitle.font =  UIFont(name: SemiBoldFont, size: 15)
        self.CancelledMsg.font =  UIFont(name: SemiBoldFont, size: 14)
        self.CancelledDate.font =  UIFont(name: SemiBoldFont, size: 14)


        self.RentalNameLbl.font =  UIFont(name: RegularFont, size: 13)
        self.BookingLbl.font =  UIFont(name: RegularFont, size: 13)
        self.Location.font = UIFont(name: RegularFont, size: 13)
        self.AddDispute.font = UIFont(name: SemiBoldFont, size: 17)
        self.CancelMessage.font = UIFont(name: RegularFont, size: 13)
        self.DisputeRentalName.font = UIFont(name: SemiBoldFont, size: 13)
        self.DisputeLocation.font = UIFont(name: SemiBoldFont, size: 12)
        self.DisputeBookingLbl.font = UIFont(name: SemiBoldFont, size: 12)
        self.Cancel.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.Submit.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.CancelCountLbl.font =  UIFont(name: SemiBoldFont, size: 13)
        self.MessageHeaderLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.MessageTextField.font = UIFont(name: RegularFont, size: 15)
        self.MessageOkayButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.MessageCanceButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.MessageCanceButton.titleLabel?.textColor = AppSecondColor
        self.ExtraShowReviewcancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.MessageOkayButton.titleLabel?.textColor = AppSecondColor
        self.MessageTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.InvoiceDetailsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.InvoiceDetailsLbl.textColor = AppColor
        self.invoiceReceiptLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.propertyNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.bookingIdLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.checkOutLbl.font = UIFont(name: RegularFont, size: 13)
        self.checkInLbl.font = UIFont(name: RegularFont, size: 15)
        self.nightLbl.font = UIFont(name: RegularFont, size: 13)
        self.guestLbl.font = UIFont(name: RegularFont, size: 13)
        self.locationLbl.font = UIFont(name: RegularFont, size: 13)
        self.cancellationPolicyLbl.font = UIFont(name: RegularFont, size: 15)
        self.subTotalLbl.font = UIFont(name: RegularFont, size: 15)
        self.securityDepositLbl.font = UIFont(name: RegularFont, size: 15)
        self.serviceFeeLbl.font = UIFont(name: RegularFont, size: 15)
        self.totalAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.walletAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.PaymentDetailsLbl.font = UIFont(name: SemiBoldFont, size: 18)
        self.PaymentDetailsLbl.textColor = AppColor
        self.paidAmountLbl.font = UIFont(name: RegularFont, size: 18)
        self.ShowReviewDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.ShowReviewMessageLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.ShowReviewPropertyNameLbl.font = UIFont(name: SemiBoldFont, size: 18)
        self.ShowReviewBookingNumLbl.font = UIFont(name: SemiBoldFont, size: 18)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShowReviewCancelAct(_ sender: UIButton)
    {
        self.ShowReviewView.isHidden = true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == CancelMessage {
            CancelCountLbl.text = "\(textView.text.count)/ 320"
            
        }
       
    }
    @IBAction func act_Cancelledtapped(_ sender: UITapGestureRecognizer) {
        self.CancelledView.isHidden = true
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
    func ExperienceHistoryAPI()
    {
        
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type": "ios"]
        print(params)
       
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(ExperienceHistory, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                self.self.HistoryDetailsTable.isHidden = false

                self.HistoryDetailsDict.removeAllObjects()
                self.HistoryDetailsDict.addEntries(from:  responseDict as! [AnyHashable : Any])
                self.HistoryShowArray.removeAllObjects()
                self.HistoryShowArray.addObjects(from: (responseDict.object(forKey: "present_experience") as! NSArray) as! [Any])
                if self.HistoryShowArray.count == 0 {
                    self.EmptyScree.isHidden = false
                    
                }else{
                    self.EmptyScree.isHidden = true
                }
               
              
                self.HistoryDetailsTable.reloadData()
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
        
  }
    
    
    @IBAction func BackBtnAct(_ sender: UIButton) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
        self.navigationController?.pushViewController(nav!, animated: true)    }
    
    @IBAction func PresentBookigAct(_ sender: UIButton) {
        isFuture = true
        
        self.selectdType = "present_experience"
        self.FuturebookingBtn.setTitleColor(AppSecondColor, for: .normal)
        self.PastbookingBtn.setTitleColor(.darkGray, for: .normal)
        self.FutureColorLbl.isHidden = false
        self.PastColorLbl.isHidden = true
        
        self.HistoryShowArray.removeAllObjects()
        self.HistoryShowArray.addObjects(from: (self.HistoryDetailsDict.object(forKey: "present_experience") as! NSArray) as! [Any])
        if self.HistoryShowArray.count == 0 {
            self.EmptyScree.isHidden = false
            
        }else{
            self.EmptyScree.isHidden = true
        }
        self.HistoryDetailsTable.reloadData()
    }
    
    @IBAction func PastBookingAct(_ sender: UIButton) {
        isFuture = true
        self.selectdType = "past_experience"
        self.FuturebookingBtn.setTitleColor(.darkGray, for: .normal)
        self.PastbookingBtn.setTitleColor(AppSecondColor, for: .normal)
        self.FutureColorLbl.isHidden = true
        self.PastColorLbl.isHidden = false
        self.HistoryShowArray.removeAllObjects()
        self.HistoryShowArray.addObjects(from: (self.HistoryDetailsDict.object(forKey: "past_experience") as! NSArray) as! [Any])
        
        if self.HistoryShowArray.count == 0 {
            self.EmptyScree.isHidden = false
            
        }else{
            self.EmptyScree.isHidden = true
        }
        self.HistoryDetailsTable.reloadData()
    }
    @objc func AvailableBtnAct(sender:UIButton){
        
        let index = sender.tag
        self.ExpScghedules.removeAllObjects()
        self.ExpScghedules.addObjects(from: ((((self.HistoryDetailsDict.object(forKey: self.selectdType) as! NSArray).object(at: index)) as! NSDictionary).object(forKey: "ExpSchedules") as! NSArray) as! [Any])
        self.ExpDatesView.isHidden = false
        self.ExpDatesTableView.isHidden = false
        self.ExperienceTable.reloadData()
        
    }
    
    @objc func HostBtnAct(sender:UIButton){
        let Index = sender.tag
       
        let hostId =  ((((self.HistoryDetailsDict.object(forKey: self.selectdType) as! NSArray).object(at: Index)) as! NSDictionary).object(forKey: "HostId") as AnyObject)
        let nav = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        nav?.hostID = "\(hostId)"

        self.navigationController?.pushViewController(nav!, animated: true)
        
    }
    
    @objc func PayBtnAct(sender:UIButton){
        let Index = sender.tag
       
        let TotalAmount =  ((((self.HistoryDetailsDict.object(forKey: self.selectdType) as! NSArray).object(at: Index)) as! NSDictionary).object(forKey: "Total_Amount") as AnyObject)
        let EnquiryId =  ((((self.HistoryDetailsDict.object(forKey: self.selectdType) as! NSArray).object(at: Index)) as! NSDictionary).object(forKey: "Booking_id") as AnyObject)
        
        let PropertId =  ((((self.HistoryDetailsDict.object(forKey: self.selectdType) as! NSArray).object(at: Index)) as! NSDictionary).object(forKey: "ExpId") as AnyObject)
        
        let nav = storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as? NewPaymentViewController
        nav!.paymentComingType = "ExperienceBooking"
        var PaymentMethodsArr = NSMutableArray()
        PaymentMethodsArr.add("Stripe")
        PaymentMethodsArr.add("PayPal")
        PaymentMethodsArr.add("Credit Card")
        print(PaymentMethodsArr)
        nav!.PaymentsArray = PaymentMethodsArr
     //   nav!.subTotal = ""
            nav!.TotalAmount = "\(TotalAmount)"
            nav!.enquiryid = "\(EnquiryId)"
     //   nav!.ServiceFee = ""
       // nav!.SecurityDeposit = self.SecurityDeposit
        nav!.PropertId = "\(PropertId)"

        self.navigationController?.pushViewController(nav!, animated: true)
        
    }
    
    @IBAction func act_ScrollBGtapped(_ sender: UITapGestureRecognizer) {
        self.ExpDatesView.isHidden = true
        self.ExpDatesTableView.isHidden = true
    }
    
    @IBAction func act_DisputeCloseButtonTapped(_ sender: UIButton)
    {
        self.AddDisputeView.isHidden = true
    }
    @IBAction func act_DisputeSubmitTapped(_ sender: UIButton)
    {
        print(self.HistoryShowArray.object(at: SelectedRow))
        let HostStr = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "HostId") as AnyObject)"
        
        let bookingNum = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "BookingNo") as AnyObject)"
        
        let PropertyId = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "ExpId") as AnyObject)"
        
        let cancelPercentage = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "CancelPercentage") as AnyObject)"
        
        
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
                
                params = ["base_id":1,"email":login_session.value(forKey: "Email") as! String,"prd_id":PropertyId,"bookingNo":bookingNum,"cancellation_percentage":cancelPercentage,"user_id":login_session.value(forKey: "UserId")!,"disputer_id":HostStr,"message":self.CancelMessage.text!]
                print(params)
                
              

                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EXPERIENCECANCEL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.yourTripModel = mod
                        self.AddDisputeView.isHidden = true
                        self.CancelMessage.text = ""
                        self.ExperienceHistoryAPI()
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
            }
            else {
                showInformation(title: "Info", message: "Please check your internet connection.")
            }
            
        }
        
        
    }
    
    @IBAction func act_MessageOkayButtonTapped(_ sender: UIButton)
    {
        
       
        let HostStr = (HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).value(forKey: "HostId") as! AnyObject
        
        let bookingNum = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "BookingNo") as AnyObject)"
        
        let PropertyId = "\((HistoryShowArray.object(at: SelectedRow) as! NSDictionary).value(forKey: "ExpId") as AnyObject)"
        print(HostStr)
        
        if (self.MessageTextField.text?.isEmpty)!
        {
            showInformation(title: "Info", message: "Please enter some text message")
            
        }
        else
        {
            if Reachability()!.isReachable {
                self.showActivityIndicator(uiView: self.view)
                let id = Singleton.sharedInstance.selectedCategory!
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["sender_id":login_session.value(forKey: "UserId")!,"rental_id":PropertyId,"bookingno":bookingNum,"message":self.MessageTextField.text!,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","device_type":"ios","receiver_id":HostStr]
                
//                {bookingno=XP1503158, receiver_id=178, device_type=android, message=sgtwjwjwtjwtwtj, sender_id=12, currency_code=USD, rental_id=518}
              
                
                print(params)
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(EXPERIENCESENDMESSAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        self.MessagePopUpView.isHidden = true
                        self.MessageTextField.text = ""
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
               
            }
            else {
                showInformation(title: "Info", message: "Please check your internet connection.")
            }
        }
    }
    
    @IBAction func act_MessageCancelButtonTapped(_ sender: UIButton)
    {
        self.MessagePopUpView.isHidden = true
    }
    @IBAction func act_invoice_Back(_ sender: UIButton)
    {
        self.invoiceBGGrayView.isHidden = true
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
extension ExperienceHistoryViewController: UITableViewDelegate ,UITableViewDataSource {
   
    
    
    @objc func selectMoreOptions(sender: UIButton)
    {
        
        let buttonRow = sender.tag
        print(buttonRow)
        self.SelectedRow = buttonRow
        
        
      
            let BookingId = (self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "BookingNo") as! String
            
            
           
            self.DropDownShowStatusArray.removeAllObjects()
        
        if isFuture == true {
            if "\((self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "cancel_show_status") as AnyObject)" == "true" {
                if "\((self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "isCancelled") as AnyObject)" == "true" {
                    self.DropDownShowStatusArray.add("Cancelled")
                }else{
                    self.DropDownShowStatusArray.add("Cancel")

                }

            }else if "\((self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "isCancelled") as AnyObject)" == "true" {
                self.DropDownShowStatusArray.add("Cancelled")
            }
        }
            
            
           
            
            
            
            if "\((self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "review_show_status") as AnyObject)" == "true" {
                self.DropDownShowStatusArray.add("Review")
            }else if "\((self.HistoryShowArray.object(at: buttonRow) as! NSDictionary).value(forKey: "isReviewed") as AnyObject)" == "1" {
                self.DropDownShowStatusArray.add("View your Review")

            }
            
            self.DropDownShowStatusArray.add("Message")
            self.DropDownShowStatusArray.add("Invoice/Receipt")

               
            setupStatusAvailableDropDown()

            
            
            
        
        
        
        
        statusAvailableDropDown.anchorView = sender
        statusAvailableDropDown.direction = .bottom
        statusAvailableDropDown.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        statusAvailableDropDown.show()
        self.HistoryDetailsTable.reloadData()
        
        
        
    }
    
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
//            self.selectedAvailableStatus = item
        
//
//
           if self.isFuture == true
            {

                if item == "Review" {
//                    self.selectedStatusCode = "0"
//                    self.grayBGView.isHidden = false
//                    self.ReviewHeadName.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_title") as! String
//                    self.ReviewBookingno.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//
//                    let img = URL(string: (self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_image") as! String)
//
//                    self.ReviewHeadImg.setImageWith(img!)
//
//                    self.AddreviewPropertyId = "\((self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)"
//                    self.AddreviewPropertyBookingNum = (self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String

                }else if item == "View your Review" {
                   // self.showActivityIndicator(uiView: self.view)
//                    var params = NSMutableDictionary()
//                    params = ["booking_no":(self.futureTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
//
//                    print(params)
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(HOTEL_YOUR_REVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//                        self.hideActivityIndicator(uiView: self.view)
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//
//                            let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
//                            self.showReviewBGGrayView.isHidden = false
//                            if (reviewDetails?.count)! > 0
//                            {
//                                let hotelDict = reviewDetails![0] as! NSDictionary
//
//                                self.showReviewDateLbl.text = hotelDict.value(forKey: "booking_no") as? String
//                                self.showReviewTxtLbl.text = hotelDict.value(forKey: "review") as? String
//                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as! Int)
//                                let url = URL(string: hotelDict.value(forKey: "user_image") as! String)
//                                self.showReviewImageView.kf.setImage(with: url)
//
//                                self.showReviewBookingNum.text = hotelDict.value(forKey: "review_date") as? String
//                                self.showReviewPropertyName.text = hotelDict.value(forKey: "rental_name") as? String
//
//
//                            }
//                            else
//                            {
//                                self.showReviewBGGrayView.isHidden = true
//                                self.showInformation(title: "Closest", message:"Review is not available now!!!")
//                            }
//
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })

                }else if item == "Cancel" {
                   
                    self.AddDispute.text = "Cancel Booking"
                    self.DisputeRentalName.text = (self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "expName") as! String
                    self.DisputeBookingLbl.text = (self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "BookingNo") as! String
                    self.DisputeLocation.text = (self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "Address") as! String




                    self.Cancel.isHidden = false
                    self.Submit.isHidden = false
                    self.CancelCountLbl.isHidden = false
                    self.AddDisputeView.isHidden = false
                }else if item == "Cancelled" {

                   

                    var params = NSMutableDictionary()

                   
                    params = ["exp_id":"\((self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "ExpId") as AnyObject)","bookingNo":(self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "BookingNo") as! String,"user_id":login_session.value(forKey: "UserId")!,"device_type":"ios","currency_code":login_session.value(forKey: "APP_CURRENCY")as! String]

                    self.showActivityIndicator(uiView: self.view)
                   
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>

                    manager.post(EXPERIENCEVIEWCANCELLATION, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {

                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {

                            print("INVOICE_API RESPONSE:",responseDict)


                            self.CancelledExpTitle.text = ((responseDict.object(forKey: "your_dispute") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "experience_title") as! String

                            self.CancelledMsg.text = ((responseDict.object(forKey: "your_dispute") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "message") as! String
                            self.CancelledDate.text = ((responseDict.object(forKey: "your_dispute") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "dispute_date") as! String
                            
                            let imgurl = URL(string: ((responseDict.object(forKey: "your_dispute") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "experience_image") as! String)
                            self.CancelledImg.setImageWith(imgurl!)
                                                              
                                                              
                            self.CancelledImg.layer.cornerRadius = 40
                         


                            self.CancelledView.isHidden = false
                            
                           

                            

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

                 //   self.showInformation(title: "Info", message: "Already Cancelled")
                }else if item == "Message"{
                   self.MessagePopUpView.isHidden = false

                }else if item ==  "Invoice/Receipt"{
                    
                    
                    
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "BookingNo") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    
                   
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>

                    manager.post(EXPERIENCEINVOICE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {

                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {

                            print("INVOICE_API RESPONSE:",responseDict)
                            self.invoiceBGGrayView.isHidden = false

                            let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                            self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                            self.propertyNameLbl.textColor = AppColor
                            self.propertyNameLbl.textColor = AppColor
                            self.bookingIdLbl
                                .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                           

                            self.locationLbl.text = (self.HistoryShowArray.object(at: self.SelectedRow) as! NSDictionary).object(forKey: "Address") as! String
                            self.locationLbl.textColor = AppColor

                            self.checkInLbl.text = "Duration"
                            self.checkOutLbl.text = String(format: "%@",hotelDict!.value(forKey: "checkindate") as! CVarArg ) + "\n \(String(format: " %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg ))"
                            self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                            self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )

                            self.checkOutLbl.textColor = AppColor

                            self.BookedDaysCount.text = String(format: "Booked for %@ Days/Hours : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                            self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                            self.securityDepositLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_symbol") as! CVarArg,hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                            self.serviceFeeLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_symbol") as! CVarArg,hotelDict!.value(forKey: "servicefee") as! CVarArg )
                            self.totalAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_symbol") as! CVarArg,hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                            self.walletAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_symbol") as! CVarArg,hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                            
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
                            self.paidAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_symbol") as! CVarArg,hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                            self.cancellationPolicyLbl.text = String(format: "Cancelled Status : %@",hotelDict!.value(forKey: "cancelled_status") as! CVarArg )
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
                }else{

                }


            }
        }
//            else
//            {
//
//
//                if item == "Review" {
//                    self.selectedStatusCode = "0"
//                    self.grayBGView.isHidden = false
//                    self.ReviewHeadName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_title") as! String
//                    self.ReviewBookingno.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//
//                    let img = URL(string: (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_image") as! String)
//
//
//                    self.AddreviewPropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)"
//                    self.AddreviewPropertyBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//                    self.ReviewHeadImg.setImageWith(img!)
//
//                }else if item == "View your Review" {
//                    self.showActivityIndicator(uiView: self.view)
//                    var params = NSMutableDictionary()
//                    params = ["booking_no":(self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
//
//                    print(params)
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(HOTEL_YOUR_REVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//                        self.hideActivityIndicator(uiView: self.view)
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//
//                            let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
//                            self.showReviewBGGrayView.isHidden = false
//                            if (reviewDetails?.count)! > 0
//                            {
//                                let hotelDict = reviewDetails![0] as! NSDictionary
//
//                                self.showReviewDateLbl.text = hotelDict.value(forKey: "booking_no") as? String
//                                self.showReviewTxtLbl.text = hotelDict.value(forKey: "review") as? String
//                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as! Int)
//                                let url = URL(string: hotelDict.value(forKey: "user_image") as! String)
//                                self.showReviewImageView.kf.setImage(with: url)
//
//                                self.showReviewBookingNum.text = hotelDict.value(forKey: "review_date") as? String
//                                self.showReviewPropertyName.text = hotelDict.value(forKey: "rental_name") as? String
//
//
//                            }
//                            else
//                            {
//                                self.showReviewBGGrayView.isHidden = true
//                                self.showInformation(title: "Closest", message:"Review is not available now!!!")
//                            }
//
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })
//
//                }else if item == "Cancel" {
//                    //  self.grayBGView.isHidden = false
//                    //                    self.selectedStatusCode = "1"
//                    //                    self.dispute_Message_grayBGView.isHidden = true
//                    //                    self.DisputePopUpView.isHidden = true
//                    //                    self.MessagePopUpView.isHidden = true
//                    //
//                    //                    self.selectedStatusCode = "1"
//                    self.AddDispute.text = "Cancel Booking"
//                    self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_address") as! String
//                    self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//                    self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_address") as! String
//                    self.Cancel.isHidden = false
//                    self.Submit.isHidden = false
//                    self.CancelCountLbl.isHidden = false
//                    self.AddDisputeView.isHidden = false
//                }else if item == "Already Cancelled" {
//
//                    let cancelby = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "cancelled_by") as! String
//
//                    var params = NSMutableDictionary()
//
//                    if cancelby == "Cancelled By User"
//                    {
//                        params = ["product_id":"\((self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)","bookingno":(self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String,"user_id":login_session.value(forKey: "UserId")!,"cancel_by":"user"]
//                    }else{
//                        params = ["product_id":"\((self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)","bookingno":(self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String,"user_id":login_session.value(forKey: "UserId")!,"cancel_by":"host"]
//                    }
//
//                    self.showActivityIndicator(uiView: self.view)
//                    //params = ["booking_no":self.futureBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
//                    print(params)
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(PROPERTY_CANCEL_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//                        self.hideActivityIndicator(uiView: self.view)
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//
//                            print("INVOICE_API RESPONSE:",responseDict)
//
//                            self.AddDispute.text = "Already Cancelled"
//                            self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_title") as! String
//                            self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//                            self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_address") as! String
//                            self.CancelMessage.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "message") as! String
//                            self.Cancel.isHidden = true
//                            self.Submit.isHidden = true
//                            self.CancelCountLbl.isHidden = true
//
//
//                            self.AddDisputeView.isHidden = false
////
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })
//
//                 //   self.showInformation(title: "Info", message: "Already Cancelled")
//                }else if item == "Dispute" {
//                    self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_title") as! String
//                    self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String //Singleton.sharedInstance.yourTripModel.mytrips[self.tripSelectedInt].bookingno!
//                    self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_address") as! String
//
//                    self.DisputePropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)"
//                    self.DisputeBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//
//                    self.grayBGView.isHidden = true
//                    self.selectedStatusCode = "1"
//                    self.dispute_Message_grayBGView.isHidden = true
//                    self.AddDisputeView.isHidden = false
//                    self.MessagePopUpView.isHidden = true
//
//
//                }else if item == "Disputed" {
//                    self.showInformation(title: "Info", message: "Already Disputed")
//                }else if item == "Message"{
//                    self.grayBGView.isHidden = true
//                    self.selectedStatusCode = "2"
//                    self.dispute_Message_grayBGView.isHidden = false
//                    self.DisputePopUpView.isHidden = true
//                    self.MessagePopUpView.isHidden = false
//
//                    self.messagePropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "property_id") as AnyObject)"
//                    self.messageBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as! NSDictionary).object(forKey: "bookingno") as! String
//
//
//                }else if item ==  "Invoice/Receipt"{
//                    self.selectedStatusCode = "3"
//                    self.showActivityIndicator(uiView: self.view)
//                    var params = NSMutableDictionary()
//                    params = ["booking_no":self.pastBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as! String,"device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
//
//                    let manager = AFHTTPSessionManager()
//                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                    manager.post(INVOICE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        let responseDict:NSDictionary = responseObject as! NSDictionary
//                        print(responseDict)
//                        self.hideActivityIndicator(uiView: self.view)
//                        if responseDict.value(forKey: "status") as! Int == 1 {
//
//                            print("INVOICE_API RESPONSE:",responseDict)
//                            self.invoiceBGGrayView.isHidden = false
//                            self.invoiceView.isHidden = false
//
//                            let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
//                            self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
//                            self.propertyNameLbl.textColor = AppColor
//                            self.propertyNameLbl.textColor = AppColor
//                            self.bookingIdLbl
//                                .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
//                            let street =    hotelDict!.value(forKey: "city") as! CVarArg
//                            let state = hotelDict!.value(forKey: "state") as! CVarArg
//                            let country = hotelDict!.value(forKey: "country") as! CVarArg
//
//                            self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
//                            self.locationLbl.textColor = AppColor
//
//                            self.checkInLbl.text = "Duration"
//                            self.checkOutLbl.text = String(format: "%@",hotelDict!.value(forKey: "checkindate") as! CVarArg ) + "\n \(String(format: " %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg ))"
//                            self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
//                            self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
//
//                            self.checkOutLbl.textColor = AppColor
//
//                            self.BookedDaysCount.text = String(format: "Booked for %@ Days/Hours : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
//                            self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
//                            self.securityDepositLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
//                            self.serviceFeeLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "servicefee") as! CVarArg )
//                            self.totalAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
//                            self.walletAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
//                            self.paidAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "paidTotal") as! CVarArg )
//                            self.cancellationPolicyLbl.text = String(format: "Cancelled Status : %@",hotelDict!.value(forKey: "cancelled_status") as! CVarArg )
//                        }
//
//                        else {
//                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                        }
//                    }, failure: { (operation, error) -> Void in
//                        DispatchQueue.main.async {
//
//                        }
//                        print(error)
//                        self.showInformation(title: "Closest", message: error.localizedDescription)
//                    })
//                }else{
//
//                }
//
//
//
//            }
//        }
        
    }
    
    
    
   func numberOfSections(in tableView: UITableView) -> Int
   {
       return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
    if tableView == self.ExperienceTable {
        return self.ExpScghedules.count
    }
    return self.HistoryShowArray.count
       
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
    if tableView == self.ExperienceTable {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseTimeTableViewCell") as! ChooseTimeTableViewCell
        cell.ChooseBtn.isHidden = true
        
        cell.DateLbl .font = UIFont(name: SemiBoldFont, size: 14)
        cell.TimeLbl .font = UIFont(name: SemiBoldFont, size: 14)
        cell.NameLbl .font = UIFont(name: SemiBoldFont, size: 16)
        
        
        
        let attributedString = NSMutableAttributedString()
        let attributedTime = NSMutableAttributedString()
        let attributedTitle = NSMutableAttributedString()
        
        let start = "Starts On :  "
        let timing = "Timing :  "
        let name = "Schedule Title :  \n"
        
        let attributed = NSAttributedString(string: start, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let timingStr = NSAttributedString(string: timing, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let titleStr = NSAttributedString(string: name, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedTwo = NSAttributedString(string: (self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleDate") as! String, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        let attributedTiming = NSAttributedString(string: (self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleTime") as! String, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
        
        let attributedname = NSAttributedString(string: (self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleTitle") as! String, attributes: [NSAttributedStringKey.foregroundColor : AppColor])
        
        attributedString.append(attributed)
        attributedString.append(attributedTwo)
        
        attributedTime.append(timingStr)
        attributedTime.append(attributedTiming)
        
        attributedTitle.append(titleStr)
        attributedTitle.append(attributedname)
        
        cell.DateLbl.attributedText = attributedString
        cell.TimeLbl.attributedText = attributedTime
        cell.NameLbl.attributedText = attributedTitle
        
        
        
//        cell.DateLbl.text = " Starts On: \((self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleDate") as! String)"
//        cell.TimeLbl.text = "Timing:  \((self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleTime") as! String)"
//        cell.NameLbl.text = "\((self.ExpScghedules.object(at: indexPath.row) as! NSDictionary).object(forKey: "ScheduleTitle") as! String)"
        return cell
    }
    
    
       let cell = tableView.dequeueReusableCell(withIdentifier: "ExperincyHistoryTableViewCell") as! ExperincyHistoryTableViewCell
      
       cell.ExpNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
    cell.AvailableTimesBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
    cell.PayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
    cell.ExpDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpLocation.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpPayStatusLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpPayStatusValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpHostApprovalStatusLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpHostApprovalStatusValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpBookingIdLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpBookingIdValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpBookedOnLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpBookedOnValueLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpPriceLbl.font = UIFont(name: SemiBoldFont, size: 16)
    cell.ExpHostedByLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpHostNameLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.ExpHostNameLbl.textColor = AppSecondColor
//    cell.ExpPriceLbl.textColor = AppSecondColor
    
    let ImageStr = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "expImage") as! String
    
    let wishlistImgUrl = URL(string: ImageStr)
    if wishlistImgUrl != nil {
        
        cell.ExpImage.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "picture-frame"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    cell.ExpNameLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "expName") as! String
    
    cell.ExpDateLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "EventDate") as! String
    cell.ExpLocation.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "Address") as! String
    cell.ExpPayStatusValueLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "BookingStatus") as! String
    cell.ExpHostApprovalStatusValueLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "HostApproval") as! String
    
    if (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "HostApproval") as! String == "Approved" {
        cell.ExpHostApprovalStatusValueLbl.textColor = .green
        
    }else {
        cell.ExpHostApprovalStatusValueLbl.textColor = .darkGray
    }
    
    
    cell.ExpBookedOnValueLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "BookedOn") as! String
    cell.ExpBookingIdValueLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "BookingNo") as! String
    cell.ExpHostNameLbl.text = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "HostName") as! String
    cell.ExpPriceLbl.text = "\((self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "CurrencySymbol") as! String) \((self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "Total_Amount") as! AnyObject)"
    
    let PayStatus = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "BookedOn") as! AnyObject
    
    if "\(PayStatus)" == "1"  {
        cell.PayBtn.isHidden = false
        cell.ThreeDotsBtn.isHidden = true

    }else{
        cell.PayBtn.isHidden = true
        cell.ThreeDotsBtn.isHidden = false
    }
    
    let threedots = (self.HistoryShowArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "BookingStatus") as! String
    
    if threedots == "Booked"  {
        cell.ThreeDotsBtn.isHidden = false

    }else{
        cell.ThreeDotsBtn.isHidden = true
    }
    
    cell.AvailableTimesBtn.tag = indexPath.row
           cell.AvailableTimesBtn.addTarget(self, action:#selector(AvailableBtnAct), for: .touchUpInside)
    
    cell.HostBtn.tag = indexPath.row
           cell.HostBtn.addTarget(self, action:#selector(HostBtnAct), for: .touchUpInside)
    
    cell.PayBtn.tag = indexPath.row
           cell.PayBtn.addTarget(self, action:#selector(PayBtnAct), for: .touchUpInside)
    cell.ThreeDotsBtn.tag = indexPath.row
    cell.ThreeDotsBtn.addTarget(self, action: #selector(selectMoreOptions), for: .touchUpInside)
    moreOptionStatusButton.frame = cell.ThreeDotsBtn.frame
    
//       cell!.lblPrice.font = UIFont(name: SemiBoldFont, size: 17)
    
       return cell
   }
   
   
   
   
   
}
