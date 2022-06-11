//
//  YourTripsViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Kingfisher
import MIBlurPopup
import DropDown
import AFNetworking

class YourTripsViewController: BaseViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var viewYellow: UIView!
    @IBOutlet weak var btnPastTrip: UIButton!
    @IBOutlet weak var btnFutureTrip: UIButton!
    @IBOutlet weak var tblTrips: UITableView!
    @IBOutlet weak var lblNoTripsAvilable: UILabel!
    @IBOutlet weak var view_gray: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var view_PastFuture: UIView!
    
    @IBOutlet weak var EmptyImg: UIImageView!
    
    @IBOutlet weak var InvoiceTable: UITableView!
    
    
    var chek =  String()
    var currency_cron_idss : String = ""
    var enquiryidss : String = ""
    var restaurant_idss : String = ""
    var moreOptionStatusButton  = UIButton()
    
    var tripDict = NSMutableDictionary()
    var tripSelectedInt : Int = 0
    var cancelOkaySelectedInt : Int = 0
    var messageOkaySelectedInt : Int = 0
    var disputeOkaySelectedInt : Int = 0
    var reviewOkaySelectedInt : Int = 0
    
    
    //MARK:- Popupviews
    @IBOutlet weak var grayBGView: UIView!
    
    //Review
    @IBOutlet weak var ReviewPopUpView: UIView!
    @IBOutlet weak var ReviewHeaderLbl: UILabel!
    @IBOutlet weak var ReviewDescLbl: UILabel!
    @IBOutlet weak var ReviewMessageTextView: UITextView!
    @IBOutlet weak var ReviewFloatRatingView: FloatRatingView!
    @IBOutlet weak var ReviewCloseButton: UIButton!
    @IBOutlet weak var ReviewSubmitButton: UIButton!
    @IBOutlet weak var ReviewBookingno: UILabel!
    @IBOutlet weak var ReviewHeadName: UILabel!
    @IBOutlet weak var ReviewHeadImg: UIImageView!
    @IBOutlet weak var ReviewmessageCount: UILabel!
    
    //Already Reviewed show popup
    @IBOutlet weak var showReviewBGGrayView: UIView!
    @IBOutlet weak var showReviewPopUpView: UIView!
    @IBOutlet weak var showReviewDateLbl: UILabel!
    @IBOutlet weak var showReviewTxtLbl: UILabel!
    @IBOutlet weak var showReviewImageView: UIImageView!
    @IBOutlet weak var showReviewPropertyName: UILabel!
    
    @IBOutlet weak var showReviewBookingNum: UILabel!
    
    @IBOutlet weak var showReviewFloatView: FloatRatingView!
    
    @IBOutlet weak var showReviewTitleLbl: UILabel!
    @IBOutlet weak var showReviewpropertyTitleLbl: UILabel!
    @IBOutlet weak var showReviewlocationvalueIdLbl: UILabel!
    
    @IBOutlet weak var showReviewbookingIdLbl: UILabel!
    @IBOutlet weak var showReviewLocationLblLbl: UILabel!
    
    @IBOutlet weak var showReviewcancelBtn: UIButton!
    
    
    //Common BG gray View for dispute and message
    @IBOutlet weak var dispute_Message_grayBGView: UIView!
    
    
    //Dispute
    @IBOutlet weak var DisputePopUpView: UIView!
    @IBOutlet weak var DisputeHeaderLbl: UILabel!
    @IBOutlet weak var DisputeMessageTextField: UITextField!
    @IBOutlet weak var DisputeOkayButton: UIButton!
    
    //Message
    @IBOutlet weak var MessagePopUpView: UIView!
    @IBOutlet weak var MessageHeaderLbl: UILabel!
    @IBOutlet weak var MessageTextField: UITextField!
    @IBOutlet weak var MessageOkayButton: UIButton!
    @IBOutlet weak var MessageCanceButton: UIButton!
    @IBOutlet weak var MessageTitleLbl: UILabel!
    
    
    
    //BG gray View for cancel
    @IBOutlet weak var cancel_Message_grayBGView: UIView!
    
    //Cancel
    @IBOutlet weak var CancelPopUpView: UIView!
    @IBOutlet weak var CancelHeaderLbl: UILabel!
    @IBOutlet weak var CancelMessageTextField: UITextField!
    @IBOutlet weak var CancelOkayButton: UIButton!
    
    
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
    
    
    
    
    /////////////// INVOICE///////////////////////
    @IBOutlet weak var InvoiceDetailsLbl: UILabel!
    
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
    
    
    
    @IBOutlet weak var PastColor: UILabel!
    @IBOutlet weak var FutureColor: UILabel!
    @IBOutlet weak var CancelCountLbl: UILabel!
    
    
    
    @IBOutlet weak var ShowReviewView: UIView!
    @IBOutlet weak var ExtraShowReviewDateLbl: UILabel!
    @IBOutlet weak var ExtraShowReviewImage: UIImageView!
    @IBOutlet weak var ExtraShowReviewMessageLbl: UILabel!
    @IBOutlet weak var ExtraReviewFloatRatingView: FloatRatingView!
    @IBOutlet weak var ExtraShowReviewPropertyNameLbl: UILabel!
    @IBOutlet weak var ExtraShowReviewBookingNumLbl: UILabel!
    @IBOutlet weak var ExtraShowReviewcancelBtn: UIButton!
    
    
    
    //MARK:- LifecycleMethods
    var futureTrip = [Mytrip]()
    var pastTrip = [Mytrip]()
    var moreOptions = [Mytrip]()
    var isFuture = true
    var currentDateTime : String = ""
    var canceldetail = [Mytrip]()
    var yourTripModel: YourTripModel!
    var myTripsArr = [Mytrip]()
    var hostID:Int!
    var API : String = ""
    var Options_Chosen : String = ""
    var OPTIONS_MODE : String = ""
    var cancelDispute : String = ""
    var houseIn : String = ""
    var houseDate : String = ""
    var houseHost : String = ""
    var houseBooking : String = ""
    var housePayment : String = ""
    var houseApproval : String = ""
    var HideShowArr : NSMutableArray = []
    var cancelDisputeShow : String = ""
    var canceldDiputedShow : String = ""
    
    var pastTripsArray : NSMutableArray = []
    var futureTripsArray : NSMutableArray = []
    
    var fromDateString : String = ""
    var toDateString : String = ""
    var startDateString : String = ""
    
    var futureBookingID : String = ""
    var pastBookingID : String = ""
    
    
    var selectedAvailableStatus:String = ""
    var selectedStatusCode : String = ""
    
    var DropDownShowStatusArray : NSMutableArray = []
    
    var availableStatusArr = NSArray()
    let statusAvailableDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.statusAvailableDropDown
        ]
    }()
    let maxLength = 320
    
    
    var AddreviewPropertyId : String = ""
    var AddreviewPropertyBookingNum : String = ""
    
    
    var messagePropertyId : String = ""
    var messageBookingNum : String = ""
    
    var DisputePropertyId : String = ""
    var DisputeBookingNum : String = ""
    
    var DiputeCanceklApi : String = ""
    
    
    
    var InvoiceDetails = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.FutureColor.isHidden = false
        self.PastColor.isHidden = true
        CancelCountLbl.text = " 0 / 320"
        ReviewmessageCount.text = " 0 / 320"
        
        
        
        self.btnFutureTrip.setTitleColor(AppSecondColor, for: .normal)
        self.btnPastTrip.setTitleColor(.black, for: .normal)
        self.ReviewMessageTextView.layer.borderWidth = 1.0
        self.ReviewMessageTextView.layer.borderColor = hexStringToUIColor(hex: "#F1F1F1").cgColor
        
        
        self.CancelMessage.layer.borderWidth = 1.0
        self.CancelMessage.layer.borderColor = hexStringToUIColor(hex: "#EEEEEE").cgColor
        self.CancelMessage.layer.shadowColor = hexStringToUIColor(hex: "#EEEEEE").cgColor
        self.CancelMessage.layer.cornerRadius = 5
        self.CancelMessage.layer.shadowOffset = CGSize.zero
        self.CancelMessage.layer.shadowOpacity = 0.6
        self.CancelMessage.delegate = self
        self.CancelMessage.keyboardType = .default
        self.CancelMessage.returnKeyType = .done
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.tblTrips.isHidden = true
        self.invoiceBGGrayView.isHidden = true
        tblTrips.tableFooterView = UIView()
        self.view_gray.isHidden = true
        self.lblNoTripsAvilable.isHidden = true
        self.grayBGView.isHidden = true
        self.showReviewBGGrayView.isHidden = true
        self.cancel_Message_grayBGView.isHidden  = true
        invoiceReceiptLbl.layer.cornerRadius = 5.0
        invoiceReceiptLbl.layer.masksToBounds = true
        ReviewMessageTextView.set(placeHolder: "Type your Review Message")
        ReviewMessageTextView.delegate = self
        isFuture = true
        //        if Reachability()!.isReachable
        //        {
        //            self.showActivityIndicator(uiView: self.view)
        //            let id = Singleton.sharedInstance.selectedCategory
        //            print(login_session.value(forKey: "Email") as? String ?? "")
        //            print(id)
        //            print(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")
        //            print(lanuguage_selection.value(forKey: "language") ?? "en")
        //
        //            let parametrStr = "email=\(login_session.value(forKey: "Email") as? String ?? "")&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
        //            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: REQ_YOUR_TRIPS, APIKEY: "REQ_YOUR_TRIPS")
        //            print(parametrStr)
        //        }
        //        else {
        //            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        //        }
        YourTripsApi()
        
        self.showReviewImageView.layer.cornerRadius = 30.0
        self.showReviewImageView.layer.masksToBounds = true
        
        // function which is triggered when handleTap is called
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        dispute_Message_grayBGView.addGestureRecognizer(tap)
        dispute_Message_grayBGView.isUserInteractionEnabled = true
        self.view.addSubview(dispute_Message_grayBGView)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        showReviewBGGrayView.addGestureRecognizer(tap1)
        showReviewBGGrayView.isUserInteractionEnabled = true
        self.view.addSubview(showReviewBGGrayView)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        cancel_Message_grayBGView.addGestureRecognizer(tap2)
        cancel_Message_grayBGView.isUserInteractionEnabled = true
        self.view.addSubview(cancel_Message_grayBGView)
        
        
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
    func YourTripsApi(){
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["email": login_session.value(forKey: "Email") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","base_id":1]
        print(params)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(REQ_YOUR_TRIPS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                self.futureTrip = [Mytrip]()
                self.pastTrip = [Mytrip]()
                
                let tripsArray:NSArray = responseDict.value(forKey: "mytrips") as! NSArray
                self.futureTripsArray.removeAllObjects()
                self.pastTripsArray.removeAllObjects()
                
                for i in 0..<tripsArray.count {
                    let dict:NSDictionary = tripsArray[i] as! NSDictionary
                    if dict.value(forKey: "is_previous") as? Int ?? 0 == 0 {
                        self.futureTripsArray.add(dict)
                    }
                    else {
                        self.pastTripsArray.add(dict)
                    }
                }
                print(self.futureTripsArray)
                print(self.pastTripsArray)
                
                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.yourTripModel = mod
                for items in mod.mytrips
                {
                    if items.isPrevious == true{
                        self.pastTrip.append(items)
                    } else {
                        self.futureTrip.append(items)
                    }
                    
                }
                if self.futureTripsArray.count == 0 {
                    self.tblTrips.isHidden = true
                    self.lblNoTripsAvilable.isHidden = false
                    self.EmptyImg.isHidden = false
                }
                else {
                    self.tblTrips.isHidden = false
                    self.lblNoTripsAvilable.isHidden = true
                    self.EmptyImg.isHidden = true
                }
                self.tblTrips.reloadData()
            }
            
            else {
                if self.futureTripsArray.count == 0 {
                    self.tblTrips.isHidden = true
                    self.lblNoTripsAvilable.isHidden = false
                    self.EmptyImg.isHidden = false
                }
                else {
                    self.tblTrips.isHidden = false
                    self.lblNoTripsAvilable.isHidden = true
                    self.EmptyImg.isHidden = true
                }
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.YourTripsApi()
        self.CouponValueLbl.font = UIFont(name: SemiBoldFont, size: 14)
        
        
        
        self.showReviewTitleLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.showReviewpropertyTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showReviewbookingIdLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showReviewLocationLblLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.showReviewcancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        self.showReviewlocationvalueIdLbl.font =  UIFont(name: SemiBoldFont, size: 14)
        self.showReviewTitleLbl.textColor = AppColor
        self.ExtraShowReviewcancelBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        
        self.MessageTitleLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.ReviewmessageCount.font = UIFont(name: SemiBoldFont, size: 14)
        self.InvoiceDetailsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.InvoiceDetailsLbl.textColor = AppColor
        self.RentalNameLbl.font =  UIFont(name: RegularFont, size: 13)
        self.BookingLbl.font =  UIFont(name: RegularFont, size: 13)
        self.Location.font = UIFont(name: RegularFont, size: 13)
        self.AddDispute.font = UIFont(name: SemiBoldFont, size: 18)
        self.CancelMessage.font = UIFont(name: RegularFont, size: 13)
        self.DisputeRentalName.font = UIFont(name: SemiBoldFont, size: 13)
        self.DisputeLocation.font = UIFont(name: SemiBoldFont, size: 12)
        self.DisputeBookingLbl.font = UIFont(name: SemiBoldFont, size: 12)
        self.Cancel.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.Submit.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.CancelCountLbl.font =  UIFont(name: SemiBoldFont, size: 13)
        self.viewTitle.font = UIFont(name: SemiBoldFont, size: 18)
        self.btnPastTrip.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.btnFutureTrip.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.ReviewHeadName.font =  UIFont(name: SemiBoldFont, size: 15)
        self.ReviewBookingno.font =  UIFont(name: SemiBoldFont, size: 13)
        self.lblNoTripsAvilable.font = UIFont(name: RegularFont, size: 16)
        self.DisputeHeaderLbl.font = UIFont(name: SemiBoldFont, size: 18)
        self.DisputeMessageTextField.font = UIFont(name: RegularFont, size: 15)
        self.DisputeOkayButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.DisputeOkayButton.titleLabel?.textColor = AppSecondColor
        self.MessageHeaderLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.MessageTextField.font = UIFont(name: RegularFont, size: 15)
        self.MessageOkayButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.MessageOkayButton.titleLabel?.textColor = AppSecondColor
        self.ReviewDescLbl.font = UIFont(name: RegularFont, size: 15)
        self.ReviewMessageTextView.font = UIFont(name: RegularFont, size: 14)
        self.ReviewHeaderLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.ReviewSubmitButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.showReviewDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.showReviewTxtLbl.font = UIFont(name: RegularFont, size: 14)
        //  self.ReviewSubmitButton.backgroundColor = AppColor
        self.invoiceReceiptLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.propertyNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.bookingIdLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.checkOutLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.checkInLbl.font = UIFont(name: RegularFont, size: 15)
        self.nightLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.guestLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.locationLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.cancellationPolicyLbl.font = UIFont(name: RegularFont, size: 15)
        self.subTotalLbl.font = UIFont(name: RegularFont, size: 15)
        self.securityDepositLbl.font = UIFont(name: RegularFont, size: 15)
        self.serviceFeeLbl.font = UIFont(name: RegularFont, size: 15)
        self.totalAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.walletAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.PaymentDetailsLbl.font = UIFont(name: SemiBoldFont, size: 18)
        self.PaymentDetailsLbl.textColor = AppColor
        self.paidAmountLbl.font = UIFont(name: RegularFont, size: 15)
        self.CancelHeaderLbl.font = UIFont(name: SemiBoldFont, size: 19)
        self.CancelMessageTextField.font = UIFont(name: RegularFont, size: 15)
        self.CancelOkayButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.MessageCanceButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
        self.CancelOkayButton.titleLabel?.textColor = AppSecondColor
        self.CancelHeaderLbl.textColor = AppColor
        self.DisputeRentalName.textColor = AppColor
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.viewTitle.text = LocalizeHelper().localizedStringForKey("yourtrips")
            self.btnPastTrip.setTitle(LocalizeHelper().localizedStringForKey("pasttrip"), for: .normal)
            self.btnFutureTrip.setTitle(LocalizeHelper().localizedStringForKey("futuretrip"), for: .normal)
            self.houseIn = LocalizeHelper().localizedStringForKey("housein")
            self.houseDate = LocalizeHelper().localizedStringForKey("date")
            self.houseHost = LocalizeHelper().localizedStringForKey("hostedby")
            self.houseBooking = LocalizeHelper().localizedStringForKey("bookingno")
            self.housePayment = LocalizeHelper().localizedStringForKey("paymentstatus")
            self.houseApproval = LocalizeHelper().localizedStringForKey("hostapproval")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        self.dispute_Message_grayBGView.isHidden = true
    }
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer)
    {
        self.showReviewBGGrayView.isHidden = true
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer)
    {
        self.cancel_Message_grayBGView.isHidden = true
    }
    
    
    func reCallTheReqAPI()
    {
        
        if Reachability()!.isReachable
        {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            print(login_session.value(forKey: "Email") as? String ?? "")
            print(id)
            print(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")
            print(lanuguage_selection.value(forKey: "language") ?? "en")
            
            let parametrStr = "email=\(login_session.value(forKey: "Email") as? String ?? "")&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: REQ_YOUR_TRIPS, APIKEY: "REQ_YOUR_TRIPS")
            print(parametrStr)
        }
        else {
            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
        
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
            self.selectedAvailableStatus = item
            
            
            if self.isFuture == true
            {
                
                if item == "Review" {
                    self.selectedStatusCode = "0"
                    self.grayBGView.isHidden = false
                    self.ReviewHeadName.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                    self.ReviewBookingno.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    
                    let img = URL(string: (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_image") as? String ?? "")
                    
                    self.ReviewHeadImg.setImageWith(img!)
                    
                    self.AddreviewPropertyId = "\((self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.AddreviewPropertyBookingNum = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    
                }else if item == "Your Review" {
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
                    
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(HOTEL_YOUR_REVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
                            self.ShowReviewView.isHidden = false
                            if (reviewDetails?.count)! > 0
                            {
                                let hotelDict = reviewDetails![0] as! NSDictionary
                                
                                self.ExtraShowReviewBookingNumLbl.text = hotelDict.value(forKey: "booking_no") as? String
                                self.ExtraShowReviewMessageLbl.text = hotelDict.value(forKey: "review") as? String
                                self.ExtraReviewFloatRatingView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                                let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                                self.ExtraShowReviewImage.kf.setImage(with: url)
                                
                                self.ExtraShowReviewDateLbl.text = hotelDict.value(forKey: "review_date") as? String
                                self.ExtraShowReviewPropertyNameLbl.text = hotelDict.value(forKey: "name") as? String
                                
                                
                            }
                            else
                            {
                                self.ShowReviewView.isHidden = true
                                self.showInformation(title: "Closest", message:"Review is not available now!!!")
                            }
                            
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
                    
                }else if item == "Cancel" {
                    //  self.grayBGView.isHidden = false
                    //                    self.selectedStatusCode = "1"
                    //                    self.dispute_Message_grayBGView.isHidden = true
                    //                    self.DisputePopUpView.isHidden = true
                    //                    self.MessagePopUpView.isHidden = true
                    //
                    //                    self.selectedStatusCode = "1"
                    self.AddDispute.text = "Cancel Booking"
                    self.DisputeRentalName.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                    self.DisputeBookingLbl.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    self.DisputeLocation.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                    
                    
                    self.DiputeCanceklApi = CANCELLATION_API
                    
                    self.Cancel.isHidden = false
                    self.Submit.isHidden = false
                    self.CancelCountLbl.isHidden = false
                    self.AddDisputeView.isHidden = false
                }else if item == "Cancelled" {
                    
                    
                    let cancelby = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "cancelled_by") as? String ?? ""
                    
                    var params = NSMutableDictionary()
                    
                    if cancelby == "Cancelled By User"
                    {
                        params = ["product_id":"\((self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)","bookingno":(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"user"]
                        
                        
                    }else{
                        params = ["product_id":"\((self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)","bookingno":(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"host"]
                    }
                    
                    self.showActivityIndicator(uiView: self.view)
                    //params = ["booking_no":self.futureBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PROPERTY_CANCEL_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            
                            self.AddDispute.text = "Cancelled"
                            
                            
                            
                            self.DisputeRentalName.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                            self.DisputeBookingLbl.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                            self.DisputeLocation.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                            self.CancelMessage.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "message") as? String ?? ""
                            
                            self.showReviewTitleLbl.text = "Cancelled"
                            
                            self.showReviewDateLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "cancelled_date") as? String ?? ""
                            self.showReviewTxtLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "message") as? String ?? ""
                            //                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                            //                            let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                            //                            self.showReviewImageView.kf.setImage(with: url)
                            
                            self.showReviewBookingNum.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Booking_no") as? String ?? ""
                            
                            self.showReviewPropertyName.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "name") as? String ?? ""
                            
                            self.showReviewlocationvalueIdLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "address") as? String ?? ""
                            
                            
                            self.showReviewBGGrayView.isHidden = false
                            
                            
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
                }else if item == "Dispute" {
                    self.DisputeRentalName.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                    self.DisputeBookingLbl.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "" //Singleton.sharedInstance.yourTripModel.mytrips[self.tripSelectedInt].bookingno
                    self.DisputeLocation.text = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""//Singleton.sharedInstance.yourTripModel.mytrips[self.tripSelectedInt].propertyAddress!
                    
                    
                    self.DisputePropertyId = "\((self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.DisputeBookingNum = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    
                    self.grayBGView.isHidden = true
                    self.selectedStatusCode = "1"
                    self.dispute_Message_grayBGView.isHidden = true
                    self.AddDisputeView.isHidden = false
                    self.MessagePopUpView.isHidden = true
                    
                    self.DiputeCanceklApi = DISPUTE_API
                    
                }else if item == "Disputed" {
                    
                    
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
                    
                    
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(DISPUTEVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            let reviewDetails = responseDict.value(forKey: "your_dispute") as? NSArray
                            self.showReviewBGGrayView.isHidden = false
                            if (reviewDetails?.count)! > 0
                            
                            
                            
                            {
                                let hotelDict = reviewDetails![0] as! NSDictionary
                                self.showReviewTitleLbl.text = "Disputed"
                                
                                self.showReviewDateLbl.text = hotelDict.value(forKey: "dispute_date") as? String
                                self.showReviewTxtLbl.text = hotelDict.value(forKey: "dispute") as? String
                                //                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                                let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                                self.showReviewImageView.kf.setImage(with: url)
                                
                                self.showReviewBookingNum.text = hotelDict.value(forKey: "booking_no") as? String
                                self.showReviewPropertyName.text = hotelDict.value(forKey: "product_name") as? String
                                self.showReviewPropertyName.text = hotelDict.value(forKey: "product_name") as? String
                                self.showReviewlocationvalueIdLbl.text = hotelDict.value(forKey: "product_address") as? String
                                
                                
                            }
                            else
                            {
                                self.showReviewBGGrayView.isHidden = true
                                self.showInformation(title: "Closest", message:"Dispute is not available now!!!")
                            }
                            
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
                    
                    
                    
                    //  self.showInformation(title: "Info", message: "Already Disputed")
                }else if item == "Message"{
                    self.grayBGView.isHidden = true
                    self.selectedStatusCode = "2"
                    self.dispute_Message_grayBGView.isHidden = false
                    self.DisputePopUpView.isHidden = true
                    self.MessagePopUpView.isHidden = false
                    self.messagePropertyId = "\((self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.messageBookingNum = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                }else if item ==  "Invoice/Receipt"{
                    self.selectedStatusCode = "3"
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":self.futureBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    print(params)
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(INVOICE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            self.InvoiceDetails.removeAllObjects()
                            self.InvoiceDetails.addEntries(from: responseDict as! [AnyHashable : Any])
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
                            
                            self.InvoiceTable.reloadData()
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
            else
            {
                
                
                if item == "Review" {
                    self.selectedStatusCode = "0"
                    self.grayBGView.isHidden = false
                    self.ReviewHeadName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                    self.ReviewBookingno.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    
                    let img = URL(string: (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_image") as? String ?? "")
                    
                    
                    self.AddreviewPropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.AddreviewPropertyBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    self.ReviewHeadImg.setImageWith(img!)
                    
                }else if item == "Your Review" {
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
                    
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(HOTEL_YOUR_REVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
                            self.ShowReviewView.isHidden = false
                            if (reviewDetails?.count)! > 0
                            {
                                let hotelDict = reviewDetails![0] as! NSDictionary
                                
                                self.ExtraShowReviewBookingNumLbl.text = hotelDict.value(forKey: "booking_no") as? String
                                self.ExtraShowReviewMessageLbl.text = hotelDict.value(forKey: "review") as? String
                                self.ExtraReviewFloatRatingView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                                let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                                self.ExtraShowReviewImage.setImageWith(url!, placeholderImage: UIImage(named: "user")) //kf.setImage(with: url)
                                
                                self.ExtraShowReviewDateLbl.text = hotelDict.value(forKey: "review_date") as? String
                                self.ExtraShowReviewPropertyNameLbl.text = hotelDict.value(forKey: "name") as? String
                                
                                
                            }
                            else
                            {
                                self.ShowReviewView.isHidden = true
                                self.showInformation(title: "Closest", message:"Review is not available now!!!")
                            }
                            
                            
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
                    
                }else if item == "Cancel" {
                    //  self.grayBGView.isHidden = false
                    //                    self.selectedStatusCode = "1"
                    //                    self.dispute_Message_grayBGView.isHidden = true
                    //                    self.DisputePopUpView.isHidden = true
                    //                    self.MessagePopUpView.isHidden = true
                    //
                    //                    self.selectedStatusCode = "1"
                    
                    self.DiputeCanceklApi = CANCELLATION_API
                    
                    self.AddDispute.text = "Cancel Booking"
                    self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                    self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                    self.Cancel.isHidden = false
                    self.Submit.isHidden = false
                    self.CancelCountLbl.isHidden = false
                    self.AddDisputeView.isHidden = false
                }else if item == "Cancelled" {
                    
                    let cancelby = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "cancelled_by") as? String ?? ""
                    
                    var params = NSMutableDictionary()
                    
                    if cancelby == "Cancelled By User"
                    {
                        params = ["product_id":"\((self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)","bookingno":(self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"user"]
                    }else{
                        params = ["product_id":"\((self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)","bookingno":(self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","user_id":login_session.value(forKey: "UserId")!,"cancel_by":"host"]
                    }
                    
                    self.showActivityIndicator(uiView: self.view)
                    //params = ["booking_no":self.futureBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(PROPERTY_CANCEL_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            
                            self.AddDispute.text = "Cancelled"
                            self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                            self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                            self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                            self.CancelMessage.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "message") as? String ?? ""
                            //                            self.Cancel.isHidden = true
                            //                            self.Submit.isHidden = true
                            //                            self.CancelCountLbl.isHidden = true
                            
                            self.showReviewDateLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "cancelled_date") as? String ?? ""
                            self.showReviewTxtLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "message") as? String ?? ""
                            //                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                            //                            let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                            //                            self.showReviewImageView.kf.setImage(with: url)
                            
                            self.showReviewBookingNum.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Booking_no") as? String ?? ""
                            
                            self.showReviewPropertyName.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "name") as? String ?? ""
                            
                            self.showReviewlocationvalueIdLbl.text = ((responseDict.object(forKey: "Cancel_details") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "address") as? String ?? ""
                            
                            
                            self.showReviewBGGrayView.isHidden = false
                            
                            //   self.AddDisputeView.isHidden = false
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
                }else if item == "Dispute" {
                    self.DisputeRentalName.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_title") as? String ?? ""
                    self.DisputeBookingLbl.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "" //Singleton.sharedInstance.yourTripModel.mytrips[self.tripSelectedInt].bookingno
                    self.DisputeLocation.text = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_address") as? String ?? ""
                    
                    self.DisputePropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.DisputeBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    self.DiputeCanceklApi = DISPUTE_API
                    
                    self.grayBGView.isHidden = true
                    self.selectedStatusCode = "1"
                    self.dispute_Message_grayBGView.isHidden = true
                    self.AddDisputeView.isHidden = false
                    self.MessagePopUpView.isHidden = true
                    
                    
                }else if item == "Disputed" {
                    //self.showInformation(title: "Info", message: "Already Disputed")
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":(self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!]
                    
                    
                    print(params)
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(DISPUTEVIEW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            let reviewDetails = responseDict.value(forKey: "your_dispute") as? NSArray
                            self.showReviewBGGrayView.isHidden = false
                            if (reviewDetails?.count)! > 0
                            
                            
                            
                            {
                                let hotelDict = reviewDetails![0] as! NSDictionary
                                self.showReviewTitleLbl.text = "Disputed"
                                
                                self.showReviewDateLbl.text = hotelDict.value(forKey: "dispute_date") as? String
                                self.showReviewTxtLbl.text = hotelDict.value(forKey: "dispute") as? String
                                //                                self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                                let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                                self.showReviewImageView.kf.setImage(with: url)
                                
                                self.showReviewBookingNum.text = hotelDict.value(forKey: "booking_no") as? String
                                self.showReviewPropertyName.text = hotelDict.value(forKey: "product_name") as? String
                                self.showReviewPropertyName.text = hotelDict.value(forKey: "product_name") as? String
                                self.showReviewlocationvalueIdLbl.text = hotelDict.value(forKey: "product_address") as? String
                                
                                
                            }
                            else
                            {
                                self.showReviewBGGrayView.isHidden = true
                                self.showInformation(title: "Closest", message:"Dispute is not available now!!!")
                            }
                            
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
                }else if item == "Message"{
                    self.grayBGView.isHidden = true
                    self.selectedStatusCode = "2"
                    self.dispute_Message_grayBGView.isHidden = false
                    self.DisputePopUpView.isHidden = true
                    self.MessagePopUpView.isHidden = false
                    
                    self.messagePropertyId = "\((self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "property_id") as AnyObject)"
                    self.messageBookingNum = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.object(forKey: "bookingno") as? String ?? ""
                    
                    
                }else if item ==  "Invoice/Receipt"{
                    self.selectedStatusCode = "3"
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    params = ["booking_no":self.pastBookingID,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    print(params)
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(INVOICE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            
                            print("INVOICE_API RESPONSE:",responseDict)
                            self.invoiceBGGrayView.isHidden = false
                            self.invoiceView.isHidden = false
                            self.InvoiceDetails.removeAllObjects()
                            self.InvoiceDetails.addEntries(from: responseDict as! [AnyHashable : Any])
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
                            self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                            
                            self.checkOutLbl.textColor = AppColor
                            
                            self.BookedDaysCount.text = String(format: "Booked for %@ Days/Hours  ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                            
                            let BookingType = hotelDict!.value(forKey: "booking_type") as? String ?? ""
                            
                            if BookingType == "hourly" {
                                
                                self.BookedDaysCount.text = String(format: "Booked for %@ Hours  ",hotelDict!.value(forKey: "numofhours") as! CVarArg)
                                self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofhours") as! CVarArg )
                                
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofhours") as AnyObject) Hours"
                                
                            }else{
                                self.BookedDaysCount.text = String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                                
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofdates") as AnyObject) Days"
                            }
                            self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                            self.securityDepositLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                            self.serviceFeeLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "servicefee") as! CVarArg )
                            
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
                            
                            
                            
                            self.totalAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                            //     self.walletAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                            self.paidAmountLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                            self.cancellationPolicyLbl.text = String(format: "Cancelled Status : %@",hotelDict!.value(forKey: "cancelled_status") as! CVarArg )
                            self.InvoiceTable.reloadData()
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
        
    }
    
    
    
    //MARK:- UITextView Delegate Methods
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Type your Review Message"
        {
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
        return true
    }
    
    //    func textViewDidChange(_ textView: UITextView)
    //    {
    //        if textView.text.isEmpty
    //        {
    //            textView.set(placeHolder: "Type your Review Message")
    //            textView.resignFirstResponder()
    //
    //        }
    //
    //    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool
    {
        if textView.text.isEmpty
        {
            textView.set(placeHolder: "Type your Review Message")
            textView.resignFirstResponder()
            
        }
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == CancelMessage {
            CancelCountLbl.text = "\(textView.text.count)/ 320"
            
        }
        else if textView == ReviewMessageTextView{
            ReviewmessageCount.text = "\(textView.text.count)/ 320"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == CancelMessage {
            CancelCountLbl.text = "\(textView.text.count)/ 320"
            return textView.text.count + (text.count - range.length) <= maxLength
            
        }else if textView == ReviewMessageTextView{
            ReviewmessageCount.text = "\(textView.text.count)/ 320"
            return textView.text.count + (text.count - range.length) <= maxLength
        }
        else{
            return true
        }
    }
    
    
    //MARK:- Button Actions
    
    @IBAction func act_reviewCloseButtonTapped(_ sender: UIButton)
    {
        self.grayBGView.isHidden = true
        // ReviewMessageTextView.set(placeHolder: "Type your Review Message")
    }
    
    
    @IBAction func act_DisputeCloseButtonTapped(_ sender: UIButton)
    {
        self.grayBGView.isHidden = true
        self.AddDisputeView.isHidden = true
    }
    
    @IBAction func ShowReviewCancelAct(_ sender: UIButton)
    {
        self.ShowReviewView.isHidden = true
        
    }
    
    @IBAction func act_messageCloseButtonTapped(_ sender: UIButton)
    {
        self.grayBGView.isHidden = true
        self.AddDisputeView.isHidden = true
        self.dispute_Message_grayBGView.isHidden = true
    }
    
    @IBAction func showReviewcancelBtnTapped(_ sender: UIButton)
    {
        self.showReviewBGGrayView.isHidden = true
    }
    
    @IBAction func act_DisputeSubmitTapped(_ sender: UIButton)
    {
        print(futureTripsArray.object(at: cancelOkaySelectedInt))
        print(cancelOkaySelectedInt)
        let HostStr = (futureTripsArray.object(at: cancelOkaySelectedInt) as? NSDictionary)?.value(forKey: "host_id") as? Int ?? 0
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
                
                params = ["base_id":1,"email":login_session.value(forKey: "Email") as? String ?? "","property_id":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].propertyId,"bookingno":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].bookingno,"cancel_percentage":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].cancelPercentage,"user_id":login_session.value(forKey: "UserId")!,"disputer_id":HostStr,"message":self.CancelMessage.text!]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(self.DiputeCanceklApi, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.yourTripModel = mod
                        self.grayBGView.isHidden = true
                        self.AddDisputeView.isHidden = true
                        self.CancelMessageTextField.text = ""
                        self.YourTripsApi()
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
    
    
    
    @IBAction func act_DisputeOkayButtonTapped(_ sender: UIButton)
    {
        
        if (self.DisputeMessageTextField.text?.isEmpty)!
        {
            showInformation(title: "Info", message: "Please enter dispute message")
            
        }
        else
        {
            
            if Reachability()!.isReachable {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":self.DisputePropertyId,"bookingno":self.DisputeBookingNum,"message":self.DisputeMessageTextField.text!,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
                print(params)
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(DISPUTE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        self.dispute_Message_grayBGView.isHidden = true
                        self.DisputeMessageTextField.text = ""
                        
                        self.YourTripsApi()
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
                //            let id = Singleton.sharedInstance.selectedCategory
                //            let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[disputeOkaySelectedInt].propertyId)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[disputeOkaySelectedInt].bookingno)&message=\(self.DisputeMessageTextField.text!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
                //            print("Dispute message parameters:",parameterStr)
                //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_API, APIKEY: "DISPUTE_API")
            }
            else {
                showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            }
        }
    }
    
    @IBAction func act_CancelOkayButtonTapped(_ sender: UIButton)
    {
        print(futureTripsArray.object(at: cancelOkaySelectedInt))
        print(cancelOkaySelectedInt)
        let HostStr = (futureTripsArray.object(at: cancelOkaySelectedInt) as? NSDictionary)?.value(forKey: "host_id") as? Int ?? 0
        print(HostStr)
        
        if (self.CancelMessageTextField.text?.isEmpty)!
        {
            showInformation(title: "Info", message: "Please add your comment")
            
        }
        else
        {
            if Reachability()!.isReachable {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                params = ["base_id":1,"email":login_session.value(forKey: "Email") as? String ?? "","property_id":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].propertyId,"bookingno":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].bookingno,"cancel_percentage":Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].cancelPercentage,"user_id":login_session.value(forKey: "UserId")!,"disputer_id":HostStr,"message":self.CancelMessageTextField.text!]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(CANCELLATION_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.yourTripModel = mod
                        self.cancel_Message_grayBGView.isHidden = true
                        self.CancelMessageTextField.text = ""
                        self.YourTripsApi()
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
                
                
                
                
                
                //                self.showActivityIndicator(uiView: self.view)
                //                let id = Singleton.sharedInstance.selectedCategory
                //                let parametrStr = "base_id=\(id)&email=\(login_session.value(forKey: "Email") as? String ?? "")&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].propertyId)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].bookingno)&cancel_percentage=\(Singleton.sharedInstance.yourTripModel.mytrips[cancelOkaySelectedInt].cancelPercentage)&user_id=\(login_session.value(forKey: "UserId")!)&disputer_id=\(HostStr)&message=\(self.CancelMessageTextField.text!)"
                //
                //                Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: CANCELLATION_API, APIKEY: "CANCELLATION_API")
                //                print(parametrStr)
                //txtview_Cancellation.text = "Cancelled"
            }
            else {
                showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
                //txtview_Cancellation.text = "Cancel"
            }
            
        }
        
    }
    
    @IBAction func act_MessageOkayButtonTapped(_ sender: UIButton)
    {
        
        print(futureTripsArray.object(at: messageOkaySelectedInt))
        print(messageOkaySelectedInt)
        let HostStr = (futureTripsArray.object(at: messageOkaySelectedInt) as? NSDictionary)?.value(forKey: "host_id") as? Int ?? 0
        print(HostStr)
        
        if (self.MessageTextField.text?.isEmpty)!
        {
            showInformation(title: "Info", message: "Please enter some text message")
            
        }
        else
        {
            if Reachability()!.isReachable {
                self.showActivityIndicator(uiView: self.view)
//                let id = Singleton.sharedInstance.selectedCategory
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["sender_id":login_session.value(forKey: "UserId")!,"property_id":self.messagePropertyId,"bookingno":self.messageBookingNum,"subject":self.messageBookingNum,"message":self.MessageTextField.text!,"currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","device_type":"iphone","receiver_id":HostStr]
                
                print(params)
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(SEND_MESSAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        self.dispute_Message_grayBGView.isHidden = true
                        self.MessageTextField.text = ""
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
    
    @IBAction func act_reviewSubmitButtonTapped(_ sender: UIButton)
    {
        
        if ReviewMessageTextView.text == "Type your Review Message"
        {
            showInformation(title: "Info", message: "Please add your review")
            
        }
        else if (self.ReviewFloatRatingView.rating) == 0
        {
            showInformation(title: "Info", message: "Please add rating")
        }
        else
        {
            
            if Reachability()!.isReachable
            {
                self.showActivityIndicator(uiView: self.view)
                let id = Singleton.sharedInstance.selectedCategory
                
                
                //            let parametrStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&review=\(self.reviewTxtFld.text!)&property_id=\(self.propertyId)&star_rating=\(self.reviewRating.rating)&base_id=\(id)&bookingno=\(self.bookingNum)&user_id=\(login_session.value(forKey: "UserId")!)"
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                
                params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","review":self.ReviewMessageTextView.text!,"property_id":self.AddreviewPropertyId,"star_rating":self.ReviewFloatRatingView.rating,"base_id":1,"bookingno":self.AddreviewPropertyBookingNum,"user_id":login_session.value(forKey: "UserId")!]
                print(params)
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(ADD_REVIEW_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        self.grayBGView.isHidden = true
                        self.YourTripsApi()
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
                
                
                
                //            let parametrStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&review=\(self.ReviewMessageTextView.text!)&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[reviewOkaySelectedInt].propertyId)&star_rating=\(self.ReviewFloatRatingView.rating)&base_id=\(id)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[reviewOkaySelectedInt].bookingno)&user_id=\(login_session.value(forKey: "UserId")!)"
                //
                //            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: ADD_REVIEW_API, APIKEY: "ADD_REVIEW_API")
                //            print(parametrStr)
            }
            else {
                showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            }
        }
    }
    
    
    
    @IBAction func act_PastTrip(_ sender: UIButton) {
        
        self.FutureColor.isHidden = true
        self.PastColor.isHidden = false
        
        self.btnFutureTrip.setTitleColor(.black, for: .normal)
        self.btnPastTrip.setTitleColor(AppSecondColor, for: .normal)
        isFuture = false
        if pastTrip.count == 0 {
            self.tblTrips.isHidden = true
            self.lblNoTripsAvilable.isHidden = false
        } else {
            self.tblTrips.isHidden = false
            self.lblNoTripsAvilable.isHidden = true
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.viewYellow.frame = CGRect(x: self.view.frame.width / 2, y: self.viewYellow.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
        self.tblTrips.reloadData()
        
        
    }
    
    @IBAction func act_Back(_ sender: UIButton)
    {
        if isFromBookingDetails == true
        {
            isFromBookingDetails = false
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
            self.navigationController?.pushViewController(nav!, animated: true)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func act_invoice_Back(_ sender: UIButton)
    {
        self.invoiceBGGrayView.isHidden = true
        self.invoiceView.isHidden = true
    }
    
    @objc func CancelTrip()
    {
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory
            let parametrStr = "base_id=\(id)&email=\(login_session.value(forKey: "Email") as? String ?? "")&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].propertyId)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[0].bookingno)&cancel_percentage=\(Singleton.sharedInstance.yourTripModel.mytrips[0].cancelPercentage)&user_id=\(login_session.value(forKey: "UserId")!)&disputer_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].hostId)&message="
            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: CANCELLATION_API, APIKEY: "CANCELLATION_API")
            print(parametrStr)
            //txtview_Cancellation.text = "Cancelled"
        }
        else {
            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            //txtview_Cancellation.text = "Cancel"
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func act_grayView(_ sender: UITapGestureRecognizer)
    {
        self.view_gray.isHidden = true
        self.AddDisputeView.isHidden = true
        
    }
    
    @IBAction func act_AddDisputeGeasture(_ sender: UITapGestureRecognizer)
    {
        self.view_gray.isHidden = true
        self.AddDisputeView.isHidden = true
        
    }
    
    @IBAction func act_FutureTrip(_ sender: UIButton) {
        
        self.FutureColor.isHidden = false
        self.PastColor.isHidden = true
        
        self.btnFutureTrip.setTitleColor(AppSecondColor, for: .normal)
        self.btnPastTrip.setTitleColor(.black, for: .normal)
        isFuture = true
        if futureTrip.count == 0 {
            self.tblTrips.isHidden = true
            self.lblNoTripsAvilable.isHidden = false
            self.EmptyImg.isHidden = false
        } else {
            self.tblTrips.isHidden = false
            self.lblNoTripsAvilable.isHidden = true
            self.EmptyImg.isHidden = true
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.viewYellow.frame = CGRect(x: 0, y: self.viewYellow.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
        
        
        
        self.tblTrips.reloadData()
    }
    
    
    @objc func payBalanceAmount(sender:UIButton){
        var mytrip: Mytrip!
        mytrip = futureTrip[sender.tag]
        if mytrip!.approvalStatus == "Pending"
        {
            self.showToast(forMessage: "Host need to accept")
        }
        else if mytrip!.approvalStatus == "Accept" && mytrip!.bookingStatus == "Booked"
        {
            if mytrip!.isBookingAllowed == "not allowed" {
                
            }else{
                
                let PaymentMethodsArr : NSMutableArray = []
                
                let StripeStatus = mytrip.stripeStatus
                let PaypalStatus = mytrip.paypalStatus
                let CreditCardStatus = mytrip.creditCardStatus
                let Enquiry = mytrip.id
                
                if StripeStatus == "Enable" {
                    PaymentMethodsArr.add("Stripe")
                }else{
                }
                if PaypalStatus == "Enable" {
                    PaymentMethodsArr.add("PayPal")
                }else{
                }
                if CreditCardStatus == "Enable" {
                    PaymentMethodsArr.add("Credit Card")
                }else{
                }
                print(PaymentMethodsArr)
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as? NewPaymentViewController
                
                
                nav!.paymentComingType = "RentalBooking"
                nav!.PaymentFor = "RentalBooking"
                nav!.PaymentsArray = PaymentMethodsArr
                nav!.subTotal = "\(mytrip.subTotal!)"
                nav!.TotalAmount = "\(mytrip.pay_later_balance_amount!)"
                nav!.enquiryid = "\(Enquiry)"
                nav!.ServiceFee = "\(mytrip.serviceFee!)"
                nav!.SecurityDeposit = "\(mytrip.securityDeposit!)"
                nav!.choosed_option = "pay_later"
                nav!.pay_balance = 1
                nav!.PropertId = "\(mytrip.propertyId)"
                self.navigationController?.pushViewController(nav!, animated: true)
            }
        } else {
            
        }
        
    }
    @objc func selectMoreOptions(sender: UIButton)
    {
        
        let buttonRow = sender.tag
        print(buttonRow)
        tripSelectedInt = buttonRow
        cancelOkaySelectedInt = buttonRow
        messageOkaySelectedInt = buttonRow
        disputeOkaySelectedInt = buttonRow
        reviewOkaySelectedInt = buttonRow
        
        if isFuture == true
        {
            futureBookingID = (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "bookingno") as? String ?? ""
            
            
            if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "review_show_status") as? Int ?? 0 == 1 {
                if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_review") as? Int ?? 0 == 1 {
                    if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0
                    {
                        if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                        {
                            availableStatusArr = ["View your Review","Already Cancelled","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }else{
                            availableStatusArr = ["View your Review","Cancel","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }
                        
                    }
                    
                    else  if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                    {
                        availableStatusArr = ["View your Review","Already Cancelled","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                        
                        
                    }
                    
                    
                    else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1
                    {
                        if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                        {
                            availableStatusArr = ["View your Review","Disputed","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }else{
                            availableStatusArr = ["View your Review","Dispute","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }
                    }
                    
                    else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                    {
                        
                        availableStatusArr = ["View your Review","Disputed","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                        
                    }
                    
                    else{
                        availableStatusArr = ["Happy Staying!","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }
                    
                }else{
                    if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0
                    {
                        if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                        {
                            availableStatusArr = ["Review","Already Cancelled","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }else{
                            availableStatusArr = ["Review","Cancel","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }
                        
                    }
                    else  if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                    {
                        availableStatusArr = ["View your Review","Already Cancelled","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                        
                        
                    }
                    
                    else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1
                    {
                        if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                        {
                            availableStatusArr = ["Review","Disputed","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }else{
                            availableStatusArr = ["Review","Dispute","Message","Invoice/Receipt"]
                            setupStatusAvailableDropDown()
                        }
                    }
                    
                    else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                    {
                        
                        availableStatusArr = ["View your Review","Disputed","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                        
                    }
                    else{
                        availableStatusArr = ["Review","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }
                }
                
            }else {
                if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0
                {
                    if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                    {
                        availableStatusArr = ["Already Cancelled","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }else{
                        availableStatusArr = ["Cancel","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }
                    
                }
                
                else  if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1
                {
                    availableStatusArr = ["Already Cancelled","Message","Invoice/Receipt"]
                    setupStatusAvailableDropDown()
                    
                    
                }
                
                else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1
                {
                    if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                    {
                        availableStatusArr = ["Disputed","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }else{
                        availableStatusArr = ["Dispute","Message","Invoice/Receipt"]
                        setupStatusAvailableDropDown()
                    }
                }
                
                else if(self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 0 && (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1
                {
                    
                    availableStatusArr = ["Disputed","Message","Invoice/Receipt"]
                    setupStatusAvailableDropDown()
                    
                }
                
                else{
                    availableStatusArr = ["Happy Staying!","Message","Invoice/Receipt"]
                    setupStatusAvailableDropDown()
                }
            }
            
            self.DropDownShowStatusArray.removeAllObjects()
            
            
            if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 {
                if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Cancelled")
                }else{
                    self.DropDownShowStatusArray.add("Cancel")
                }
                
            }
            
            
            
            if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "review_show_status") as? Int ?? 0 == 1 {
                
                if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_review") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Your Review")
                    
                }else{
                    self.DropDownShowStatusArray.add("Review")
                    
                }
                
            }
            
            if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1 {
                
                if (self.futureTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Disputed")
                    
                }else{
                    self.DropDownShowStatusArray.add("Dispute")
                    
                }
                
            }
            
            self.DropDownShowStatusArray.add("Message")
            self.DropDownShowStatusArray.add("Invoice/Receipt")
            
            
            setupStatusAvailableDropDown()
            
            
            
            
        }
        else
        {
            pastBookingID = (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "bookingno") as? String ?? ""
            
            availableStatusArr = ["Invoice/Receipt"]
            setupStatusAvailableDropDown()
            
            self.DropDownShowStatusArray.removeAllObjects()
            
            
            if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "cancel_show_status") as? Int ?? 0 == 1 {
                if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_canceled") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Cancelled")
                }else{
                    self.DropDownShowStatusArray.add("Cancel")
                }
                
            }
            
            
            
            if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "review_show_status") as? Int ?? 0 == 1 {
                
                if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_review") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Your Review")
                    
                }else{
                    self.DropDownShowStatusArray.add("Review")
                    
                }
                
            }
            
            if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "dispute_show_status") as? Int ?? 0 == 1 {
                
                if (self.pastTripsArray.object(at: self.tripSelectedInt) as? NSDictionary)?.value(forKey: "is_dispute") as? Int ?? 0 == 1 {
                    self.DropDownShowStatusArray.add("Disputed")
                    
                }else{
                    self.DropDownShowStatusArray.add("Dispute")
                    
                }
                
            }
            
            self.DropDownShowStatusArray.add("Message")
            self.DropDownShowStatusArray.add("Invoice/Receipt")
            
            
            setupStatusAvailableDropDown()
            
            
            
        }
        
        statusAvailableDropDown.anchorView = sender
        statusAvailableDropDown.direction = .bottom
        statusAvailableDropDown.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
        statusAvailableDropDown.show()
        self.tblTrips.reloadData()
        
        
        
    }
}

extension YourTripsViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == InvoiceTable {
            return 4
            
        }else{
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == InvoiceTable {
            if InvoiceDetails.count != 0
            {
                if section == 0 || section == 3 {
                    return 1
                    
                }else if section == 1 {
                    if ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray).count == 0 {
                        return 0
                    }else{
                        return ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray).count + 1
                    }
                    
                    
                }else{
                    if ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).count == 0 {
                        return 0
                    }else{
                        return ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).count + 3
                    }
                    
                    
                }
            }
            else
            {
                return 0
            }
        }else{
            if Singleton.sharedInstance.yourTripModel != nil
            {
                if isFuture == true
                {
                    return futureTrip.count
                }
                else
                {
                    return pastTrip.count
                }
            }
            else
            {
                return 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == InvoiceTable {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceFirstTableViewCell") as? InvoiceFirstTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceFirstTableViewCell") as! InvoiceFirstTableViewCell
                cell.RemntalNameValueLbl.text = (self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "product_title") as? String ?? ""
                
                let Address = "\((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "state") as? String ?? "") \((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "city") as? String ?? "") \((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "street") as? String ?? "")"
                
                cell.RemntalAddressValueLbl.text = Address
                
                let BookingType = (InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "booking_type") as? String ?? ""
                
                if BookingType == "hourly" {
                    
                    cell.DaysHoursValueLbl.text = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "numofhours") as? String ?? "") Hours"
                }else{
                    cell.DaysHoursValueLbl.text = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "numofdates") as? String ?? "") Days"
                }
                cell.GuestValueLbl.text = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "NoofGuest") as AnyObject)"
                
                cell.DurationValueLbl.text = String(format: "%@",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "checkindate") as? String ?? "" ) + "\n\(String(format: "%@",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "checkoutdate") as? String ?? "" ))"
                cell.BookingNumLbl.text = String(format: "Booking No : %@",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "booking_no") as? String ?? "")
                cell.CancellationPolicyLbl.text = String(format: "Cancelled Status :%@",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "cancelled_status") as? String ?? "" )
                
                return cell
            }
            else if indexPath.section == 1{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                if indexPath.row == 0 {
                    cell.BaseTitle.text = "Addons Details"
                    cell.BaseTitle.textColor = .black
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 15)
                }else{
                    cell.BaseTitle.textColor = .darkGray
                    cell.BaseTitle.font = UIFont(name: RegularFont, size: 14)
                    let Name = (((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray).object(at: indexPath.row-1) as? NSDictionary)?.object(forKey: "name") as? String ?? ""
                    let Cost = (((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray).object(at: indexPath.row-1) as? NSDictionary)?.object(forKey: "amount") as AnyObject
                    cell.BaseTitle.text = "\(indexPath.row). \(Name) $ \(Cost)"
                }
                return cell
            }else if indexPath.section == 2 {
                
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.text = "Bundle Details"
                    cell.BaseTitle.textColor = .black
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 15)
                    return cell
                    
                }else if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.textColor = .darkGray
                    cell.BaseTitle.font = UIFont(name: RegularFont, size: 14)
                    
                    let Name = ((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_checkindate") as? String ?? "")
                    cell.BaseTitle.text = "Bundle CheckIn Date : \(Name)"
                    return cell
                    
                    
                }else if indexPath.row == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.textColor = .darkGray
                    cell.BaseTitle.font = UIFont(name: RegularFont, size: 14)
                    
                    let Name = ((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_checkoutdate") as? String ?? "")
                    cell.BaseTitle.text = "Bundle CheckOut Date : \(Name)"
                    return cell
                    
                }
                else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceMiddleTableViewCell") as! InvoiceMiddleTableViewCell
                    cell.BundleLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.BundleValueLbl.font = UIFont(name: RegularFont, size: 14)
                    
                    let Name = (((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).object(at: indexPath.row - 3) as? NSDictionary)?.object(forKey: "bundle_name") as? String ?? ""
                    
                    let Guest = (((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).object(at: indexPath.row - 3) as? NSDictionary)?.object(forKey: "No_of_Guests") as AnyObject
                    
                    let Cost = (((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).object(at: indexPath.row - 3) as? NSDictionary)?.object(forKey: "total_amount") as AnyObject
                    let Currency = (InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "currency_code") as? String ?? ""
                    cell.BundleLbl.text = "Bundle Name : \n \nNoOfGuest :  \n \nAmount :"
                    cell.BundleValueLbl.text = "\(Name)  \n \n\(Guest) \n \n\(Currency) \(Cost)"
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceLastTableViewCell") as! InvoiceLastTableViewCell
                
                
                let BookingType = (InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "booking_type") as? String ?? ""
                
                if BookingType == "hourly" {
                    
                    cell.BookedDaysLbl.text = String(format: "Booked for %@ Hours  ",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "numofhours") as? String ?? "")
                    
                }else{
                    cell.BookedDaysLbl.text = String(format: "Booked for %@ Days  ",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "numofdates") as? String ?? "")
                    
                }
                
                let Currency = (InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "currency_code") as? String ?? ""
                
                cell.BookedDaysLblValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "TotalwithoutService") as! CVarArg)
                if ((InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray).count != 0 {
                    cell.Addonsiew.isHidden = false
                    cell.AddonsHeight.constant = 30
                    cell.AddonsValueLbl.text = " \(Currency) \((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_amount") as AnyObject)"
                }else{
                    cell.Addonsiew.isHidden = true
                    cell.AddonsHeight.constant = 0
                    
                }
                
                if ((InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).count != 0 {
                    cell.BundleView.isHidden = false
                    cell.BundleHeight.constant = 30
                    cell.BundleValueLbl.text = "\(Currency) \((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_amount") as AnyObject)"
                    
                }else{
                    cell.BundleView.isHidden = true
                    cell.BundleHeight.constant = 0
                    
                    
                }
                let CouponUsed = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "is_coupon_used") as AnyObject)"
                let WalletUsed = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "is_wallet_used") as AnyObject)"
                
                if CouponUsed == "No" {
                    cell.CouponView.isHidden = true
                    cell.CouponHeight.constant = 0
                    
                }else{
                    cell.CouponView.isHidden = false
                    cell.CouponHeight.constant = 40
                }
                if WalletUsed == "No" {
                    cell.WalletView.isHidden = true
                    cell.WalletHeight.constant = 0
                    
                }else{
                    cell.WalletView.isHidden = false
                    cell.WalletHeight.constant = 40
                }
                
                if "\(((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "pay_later_balance_amount") as AnyObject))" == "0.00" {
                    cell.PayLater.isHidden = true
                    cell.PayLaterHeight.constant = 0
                }else{
                    cell.PayLater.isHidden = false
                    cell.PayLaterHeight.constant = 30
                }
                
                cell.PayLaterValueLbl.text = "\(Currency) \((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "pay_later_balance_amount") as AnyObject)"
                cell.CouponValueLbl.text = "\(Currency) \((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "couponDiscount") as AnyObject)"
                
                
                cell.WalletValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "wallet_Amount") as! CVarArg  )
                cell.PaidValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "paidTotal") as! CVarArg )
                cell.TotalValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "TotalAmt") as! CVarArg )
                cell.ServiceFeeValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "servicefee") as! CVarArg)
                
                cell.SecurityDepositValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "securityDeposite") as! CVarArg)
                
                return cell
            }
        }else{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? YourTripsCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? YourTripsCell
            var mytrip: Mytrip!
            
            
            cell.lblTripAmount.font = UIFont(name: RegularFont, size: 15)
            cell.lblTripHostedBy.font = UIFont(name: RegularFont, size: 13)
            cell.lblTripDate.font = UIFont(name: RegularFont, size: 13)
            cell.lblTripBookingNo.font = UIFont(name: RegularFont, size: 13)
            cell.lblTripPaymentStatus.font = UIFont(name: RegularFont, size: 13)
            cell.lblTripHostApproved.font = UIFont(name: RegularFont, size: 13)
            cell.CouponLbl.font = UIFont(name: RegularFont, size: 13)
            cell.BalanceLbl.font = UIFont(name: RegularFont, size: 13)
            
            cell.lblTripName.font = UIFont(name: SemiBoldFont, size: 13)
            cell.lblTripPropertyName.font = UIFont(name: SemiBoldFont, size: 16)
            
            cell.PayBalanceBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
            
            if isFuture == true {
                //  cell.btn_moreOptions.isHidden = false
                mytrip = futureTrip[indexPath.row]
                cell.PayBalance.isHidden = true
                cell.PayBalanceHeight.constant = 0
            } else {
                cell.PayBalance.isHidden = true
                cell.PayBalanceHeight.constant = 0
                // cell.btn_moreOptions.isHidden = true
                mytrip = pastTrip[indexPath.row]
            }
            cell.lblTripBookingNo.isHidden = false
            cell.lblTripAmount.isHidden = false
            cell.lblTripPaymentStatus.isHidden = false
            cell.lblTripHostApproved.isHidden = false
            let url = URL(string: mytrip.propertyImage)
            //  cell.imgTrip.kf.setImage(with: url)
            cell.imgTrip.setImageWith(url!, placeholderImage: UIImage(named: "picture-frame"))
            cell.lblTripPropertyName.text = mytrip.propertyTitle
            cell.lblTripName.text = houseIn + " " + mytrip.propertyAddress
            cell.lblTripHostedBy.text = houseHost + " " + mytrip.hostName
            
            
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd, yyyy HH:mm"
            dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
            let orderDateStringPasser = mytrip.checkin
            
            if let date = dateFormatterGet.date(from: orderDateStringPasser)
            {
                print(dateFormatterPrint.string(from: date))
                fromDateString = dateFormatterPrint.string(from: date)
            }
            else
            {
                print("There was an error decoding the string")
            }
            
            
            //Current Date
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let currentDateResult = formatter.string(from: date)
            
            
            let dateFormatterCurrentGet = DateFormatter()
            dateFormatterCurrentGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatterCurrentGet.locale = Locale(identifier: "en_US_POSIX")
            
            let currentDateFormatterPrint = DateFormatter()
            currentDateFormatterPrint.dateFormat = "MMM dd, yyyy HH:mm"
            currentDateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
            
            
            let currentDateStringPasser = currentDateResult
            
            if let date = dateFormatterCurrentGet.date(from: currentDateStringPasser)
            {
                print(currentDateFormatterPrint.string(from: date))
                startDateString = currentDateFormatterPrint.string(from: date)
                
            }
            else
            {
                print("There was an error decoding the string")
            }
            
            
            //Delivery Date format
            let dateFormatterPrint1 = DateFormatter()
            // dateFormatterPrint1.dateFormat = "dd-MM-yyyy hh:mm a"
            dateFormatterPrint1.dateFormat = "MMM dd, yyyy HH:mm"
            dateFormatterPrint1.locale = Locale(identifier: "en_US_POSIX")
            
            let deliveryDateStringPasser = mytrip.checkout
            
            if let date = dateFormatterGet.date(from: deliveryDateStringPasser)
            {
                print(dateFormatterPrint1.string(from: date))
                toDateString = dateFormatterPrint1.string(from: date)
                
            }
            else
            {
                print("There was an error decoding the string")
            }
            
            if isFuture != true
            {
                let strCurrentDate = startDateString
                let strServerDate = toDateString
                let datePickerFormat = DateFormatter()
                datePickerFormat.dateFormat = "MM/dd/yyyy HH:mm"
                datePickerFormat.locale = Locale(identifier: "en_US_POSIX")
                let currentDate: Date? = datePickerFormat.date(from: strCurrentDate)
                let serverDate: Date? = datePickerFormat.date(from: strServerDate)
                
                if let currentDate = currentDate {
                    print("date \(currentDate)")
                }
                if let serverDate = serverDate {
                    print("date \(serverDate)")
                }
                
                var result: ComparisonResult?
                
                if let serverDate = serverDate {
                    result = currentDate?.compare(serverDate)
                } // comparing two dates
                
                
                
                
                if result == .orderedAscending {
                    print("current date is less")
                    cell.lblTripDate.text =  houseDate + " : " + fromDateString + " - " + String(describing: toDateString)
                    cell.lblTripBookingNo.isHidden = false
                    cell.lblTripAmount.isHidden = false
                    cell.lblTripPaymentStatus.isHidden = false
                    cell.lblTripHostApproved.isHidden = false
                    
                    
                } else if result == .orderedDescending {
                    print("server date is less")
                    cell.lblTripPaymentStatus.text =  "Expired"
                    cell.lblTripBookingNo.isHidden = true
                    cell.lblTripAmount.isHidden = true
                    cell.lblTripPaymentStatus.isHidden = false
                    cell.lblTripHostApproved.isHidden = true
                    
                } else if result == .orderedSame {
                    print("Both dates are same")
                    cell.lblTripDate.text =  houseDate + " : " + fromDateString + " - " + String(describing: toDateString)
                    cell.lblTripBookingNo.isHidden = false
                    cell.lblTripAmount.isHidden = false
                    cell.lblTripPaymentStatus.isHidden = false
                    cell.lblTripHostApproved.isHidden = false
                } else {
                    print("Date cannot be compared")
                }
                
            }
            else
            {
                cell.lblTripDate.text =  houseDate + " : " + fromDateString + " - " + String(describing: toDateString)
                
            }
            cell.lblTripBookingNo.isHidden = false
            
            let CouponStatus = mytrip.isCouponUsed
            if CouponStatus == "No" {
                cell.CouponLblHeight.constant = 0
                
            }else{
                cell.CouponLblHeight.constant = 25
                
            }
            
            if "\(mytrip.pay_later_availabe!)" == "0" {
                cell.PayBalance.isHidden = true
                cell.PayBalanceHeight.constant = 0
                
            }else{
                cell.PayBalance.isHidden = false
                cell.PayBalanceHeight.constant = 65
                cell.BalanceLbl.text = "Amount to be paid : \(mytrip.pay_later_balance_amount!)"
            }
            
            cell.PayBalanceBtn.tag = indexPath.row
            cell.PayBalanceBtn.addTarget(self, action: #selector(payBalanceAmount), for: .touchUpInside)
            cell.CouponLbl.text = "Coupon : " + mytrip.couponAmount + " \(mytrip.userCurrencySymbol)"
            cell.lblTripDate.text =  houseDate + " : " + fromDateString + " - " + String(describing: toDateString)
            
            cell.lblTripBookingNo.text = houseBooking + " : "  + mytrip.bookingno
            print("\(mytrip.total!)")
            cell.lblTripAmount.text =  mytrip.userCurrencyCode + " \(mytrip.total!)"
            cell.btn_moreOptions.tag = indexPath.row
            cell.btn_moreOptions.addTarget(self, action: #selector(selectMoreOptions), for: .touchUpInside)
            moreOptionStatusButton.frame = cell.btn_moreOptions.frame
            if isFuture == true
            {
                if mytrip.bookingStatus == "Pending" {
                    if mytrip.isBookingAllowed == "not allowed" {
                        cell.btn_moreOptions.isHidden = true
                        cell.lblTripPaymentStatus.textColor = UIColor.darkGray
                        cell.lblTripPaymentStatus.attributedText =  NSAttributedString().changeColor(text1: "Pay Status" + " : ", text2: "Date Unavailable", color1: UIColor.darkGray, color2: UIColor.red)
                    }else{
                        cell.btn_moreOptions.isHidden = true
                        cell.lblTripPaymentStatus.attributedText =  NSAttributedString().changeColor(text1: housePayment + " : ", text2: mytrip!.bookingStatus, color1: UIColor.darkGray, color2: UIColor.red)
                    }
                }
                else if mytrip.bookingStatus == "Accept" {
                    cell.btn_moreOptions.isHidden = false
                    cell.lblTripPaymentStatus.attributedText =  NSAttributedString().changeColor(text1: housePayment + " : ", text2: mytrip!.bookingStatus, color1: UIColor.darkGray, color2: ForestGreen)
                }
                else if mytrip.bookingStatus == "Pay" {
                    cell.lblTripPaymentStatus.attributedText =  NSAttributedString().changeColor(text1: housePayment + " : ", text2: mytrip!.bookingStatus, color1: UIColor.darkGray, color2: UIColor.blue)
                }
                else
                {
                    cell.lblTripPaymentStatus.attributedText =  NSAttributedString().changeColor(text1: housePayment + " : ", text2: mytrip!.bookingStatus, color1: UIColor.darkGray, color2: UIColor.red)
                }
                if mytrip.approvalStatus == "Pending" {
                    cell.lblTripHostApproved.attributedText =  NSAttributedString().changeColor(text1: houseApproval + " : ", text2: mytrip!.approvalStatus, color1: UIColor.darkGray, color2: UIColor.red)
                }
                else if mytrip.approvalStatus == "Accept" {
                    cell.lblTripHostApproved.attributedText =  NSAttributedString().changeColor(text1: houseApproval + " : " , text2: mytrip!.approvalStatus, color1: UIColor.darkGray, color2: UIColor.green)
                }
                else
                {
                    
                }
            }else{
                cell.lblTripPaymentStatus.isHidden = false
                cell.lblTripPaymentStatus.text = "Expired"
                cell.lblTripHostApproved.isHidden = true
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblTrips
        {
            var mytrip: Mytrip!
            if isFuture == true {
                mytrip = futureTrip[indexPath.row]
                if mytrip!.approvalStatus == "Pending"
                {
                    self.showToast(forMessage: "Host need to accept")
                }
                else if mytrip!.approvalStatus == "Accept" && mytrip!.bookingStatus == "Pending"
                {
                    if mytrip!.isBookingAllowed == "not allowed" {
                        
                    }else{
                        
                        let PaymentMethodsArr : NSMutableArray = []
                        
                        let StripeStatus = mytrip.stripeStatus
                        let PaypalStatus = mytrip.paypalStatus
                        let CreditCardStatus = mytrip.creditCardStatus
                        let Enquiry = mytrip.id
                        
                        if StripeStatus == "Enable" {
                            PaymentMethodsArr.add("Stripe")
                        }else{
                        }
                        if PaypalStatus == "Enable" {
                            PaymentMethodsArr.add("PayPal")
                        }else{
                        }
                        if CreditCardStatus == "Enable" {
                            PaymentMethodsArr.add("Credit Card")
                        }else{
                        }
                        print(PaymentMethodsArr)
                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as? NewPaymentViewController
                        
                        
                        nav!.paymentComingType = "RentalBooking"
                        nav!.PaymentFor = "RentalBooking"
                        nav!.PaymentsArray = PaymentMethodsArr
                        nav!.subTotal = "\(mytrip.subTotal!)"
                        nav!.TotalAmount = "\(mytrip.pay_later_balance_amount!)"
                        nav!.enquiryid = "\(Enquiry)"
                        nav!.ServiceFee = "\(mytrip.serviceFee!)"
                        nav!.SecurityDeposit = "\(mytrip.securityDeposit!)"
                        nav!.choosed_option = ""
                        nav!.pay_balance = 1
                        nav!.PropertId = "\(mytrip.propertyId)"
                        self.navigationController?.pushViewController(nav!, animated: true)
                        
                        
                        //                        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController
                        //                        nav!.property_id = String(mytrip!.propertyId)
                        //                        nav!.total_price = mytrip!.total as AnyObject
                        //                        nav!.enquiryid = String(mytrip!.id)
                        //                        if mytrip.serviceFee != nil
                        //                        {
                        //                            nav!.totalserviceFee = NSDecimalNumber(string: "\(mytrip!.serviceFee!)")
                        //                        }
                        //                        else {
                        //                            nav!.totalserviceFee = NSDecimalNumber(string: "\(0.0)")
                        //                        }
                        //
                        //                        if mytrip.securityDeposit != nil {
                        //                            nav!.totalDeposit = NSDecimalNumber(string: "\(mytrip!.securityDeposit!)")
                        //                        }
                        //                        else {
                        //                            nav!.totalDeposit = NSDecimalNumber(string: "\(0.0)")
                        //                        }
                        //
                        //                        if mytrip.propertyPrice != nil {
                        //                            nav!.totalproductPrice = NSDecimalNumber(string: "\(mytrip!.propertyPrice!)")
                        //                        }
                        //                        else {
                        //                            nav!.totalproductPrice = NSDecimalNumber(string: "\(0.0)")
                        //                        }
                        //
                        //                        if mytrip.subTotal != nil {
                        //                            nav!.totalsubtotal = NSDecimalNumber(string: "\(mytrip!.subTotal!)")
                        //                        }
                        //                        else {
                        //                            nav!.totalsubtotal = NSDecimalNumber(string: "\(0.0)")
                        //                        }
                        //
                        //                        nav!.totalamount = mytrip!.total as AnyObject
                        //                        nav!.PaymentFor = "Booking"
                        //
                        //                        nav!.stripe_Status = mytrip.stripeStatus!
                        //                        nav!.card_Status = mytrip.creditCardStatus!
                        //                        nav!.paypal_status = mytrip.paypalStatus!
                        //                        self.navigationController?.pushViewController(nav!, animated: true)
                    }
                } else {
                    
                }
            } else {
                mytrip = pastTrip[indexPath.row]
            }
        }
    }
    
}

extension YourTripsViewController : HTTP_POST_STRING_REQUEST_PROTOCOL{
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        
        if APIKEY == "REQ_YOUR_TRIPS"
        {
            print("REQ_YOUR_TRIPS responseDict:",responseDict)
            if errorDict.count == 0 {
                futureTrip = [Mytrip]()
                pastTrip = [Mytrip]()
                
                let tripsArray:NSArray = responseDict.value(forKey: "mytrips") as! NSArray
                futureTripsArray.removeAllObjects()
                pastTripsArray.removeAllObjects()
                
                for i in 0..<tripsArray.count {
                    let dict:NSDictionary = tripsArray[i] as! NSDictionary
                    if dict.value(forKey: "is_previous") as? Int ?? 0 == 0 {
                        futureTripsArray.add(dict)
                    }
                    else {
                        pastTripsArray.add(dict)
                    }
                }
                print(futureTripsArray)
                print(pastTripsArray)
                
                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.yourTripModel = mod
                for items in mod.mytrips
                {
                    if items.isPrevious == true{
                        self.pastTrip.append(items)
                    } else {
                        self.futureTrip.append(items)
                    }
                    
                }
                if futureTrip.count == 0 {
                    self.tblTrips.isHidden = true
                    self.lblNoTripsAvilable.isHidden = false
                }
                else {
                    self.tblTrips.isHidden = false
                    self.lblNoTripsAvilable.isHidden = true
                }
                self.tblTrips.reloadData()
            }
            else {
                print("No data")
            }
            self.tblTrips.reloadData()
        }
        
        else if APIKEY == "CANCELLATION_API" {
            if errorDict.count == 0 {
                print(responseDict)
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.yourTripModel = mod
                self.cancel_Message_grayBGView.isHidden = true
                self.CancelMessageTextField.text = ""
                reCallTheReqAPI()
            }
            else {
                print("No data")
            }
        }
        else if APIKEY == "ADD_REVIEW_API" {
            if errorDict.count == 0 {
                print(responseDict)
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                self.grayBGView.isHidden = true
                reCallTheReqAPI()
                //                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                //                Singleton.sharedInstance.yourTripModel = mod
                
            }
            else {
                print("No Data")
            }
        }
        else if APIKEY == "HOTEL_YOUR_REVIEW"
        {
            if errorDict.count == 0 {
                print("HOTEL_YOUR_REVIEW_responseDict:",responseDict)
                let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
                self.showReviewBGGrayView.isHidden = false
                if (reviewDetails?.count)! > 0
                {
                    let hotelDict = reviewDetails![0] as! NSDictionary
                    
                    self.showReviewDateLbl.text = hotelDict.value(forKey: "review_date") as? String
                    self.showReviewTxtLbl.text = hotelDict.value(forKey: "review") as? String
                    self.showReviewFloatView.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                    let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                    self.showReviewImageView.kf.setImage(with: url)
                }
                else
                {
                    self.showReviewBGGrayView.isHidden = true
                    showInformation(title: "Closest", message:"Review is not available now!!!")
                }
            }
        }
        
        else if APIKEY == "DISPUTE_API" {
            if errorDict.count == 0 {
                print(responseDict)
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                self.dispute_Message_grayBGView.isHidden = true
                self.DisputeMessageTextField.text = ""
                reCallTheReqAPI()
                //                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                //                Singleton.sharedInstance.yourTripModel = mod
            }
            else {
                print("No Data")
            }
        }
        else if APIKEY == "SEND_MESSAGE" {
            if errorDict.count == 0 {
                print(responseDict)
                showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                self.dispute_Message_grayBGView.isHidden = true
                self.MessageTextField.text = ""
                //                let mod = YourTripModel(fromDictionary: responseDict as! [String : Any])
                //                Singleton.sharedInstance.yourTripModel = mod
            }
            else {
                print("No Data")
            }
        }
        else if APIKEY == "INVOICE_API"
        {
            if errorDict.count == 0
            {
                print("INVOICE_API RESPONSE:",responseDict)
                self.invoiceBGGrayView.isHidden = false
                self.invoiceView.isHidden = false
                
                let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                self.propertyNameLbl.text = String(format: "Property Name : %@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                self.bookingIdLbl
                    .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                let street =    hotelDict!.value(forKey: "street") as! CVarArg
                let state = hotelDict!.value(forKey: "state") as! CVarArg
                let country = hotelDict!.value(forKey: "country") as! CVarArg
                
                self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
                
                self.checkInLbl.text = String(format: "Check_in : %@",hotelDict!.value(forKey: "checkindate") as! CVarArg )
                self.checkOutLbl.text = String(format: "Check_out : %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg )
                self.guestLbl.text = String(format: "Guest : %@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                self.nightLbl.text = String(format: "Nights : %@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                
                
                self.subTotalLbl.text = String(format: "Booked for %@ Days : %@ %@",hotelDict!.value(forKey: "numofdates") as! CVarArg,hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                self.securityDepositLbl.text = String(format: "Security Deposit : %@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                self.serviceFeeLbl.text = String(format: "Service Fee : %@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "servicefee") as! CVarArg )
                self.totalAmountLbl.text = String(format: "Total : %@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                self.walletAmountLbl.text = String(format: "WalletAmount : %@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                self.paidAmountLbl.text = String(format: "Paid : %@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                self.cancellationPolicyLbl.text = String(format: "Cancelled Status : %@",hotelDict!.value(forKey: "cancelled_status") as! CVarArg )
                
            }
            
            
        }
        
        else {
            print("No Data")
        }
        hideActivityIndicator(uiView: self.view)
    }
}

