//  PropertyListingViewController.swift
//  IHost
//  Created by POFI TECHNOLOGIES on 17/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import Kingfisher
import DropDown
import AFNetworking

class PropertyListingViewController: BaseViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var lblNoDatasFound: UILabel!
    @IBOutlet weak var lblNoDatas: UIImageView!
    @IBOutlet weak var tblPropertyListing: UITableView!
    @IBOutlet weak var viewMoveableBar: UIView!
    @IBOutlet weak var btnYourReserv: UIButton!
    @IBOutlet weak var btnManageList: UIButton!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var cancelMessageView: UIView!
    
    @IBOutlet weak var rentalNameCancel: UILabel!
    @IBOutlet weak var bookingNoCancel: UILabel!
    @IBOutlet weak var locationCancel: UILabel!
    @IBOutlet weak var cancelMsgTxtFld: UITextField!
    @IBOutlet weak var okayBtn: UIButton!
    @IBOutlet weak var ratingView: FloatRatingView!
    
    
    @IBOutlet weak var viewCancelMessage: UIView!
    @IBOutlet weak var cancelMsg: UILabel!
    @IBOutlet weak var cancelDate: UILabel!
    @IBOutlet weak var cancelLocation: UILabel!
    @IBOutlet weak var cancelBooking: UILabel!
    @IBOutlet weak var cancelTitle: UILabel!
    
    @IBOutlet weak var cancelRentalTitle: UILabel!
    @IBOutlet weak var cancelRentalLocation: UILabel!
    @IBOutlet weak var cancelRentalId: UILabel!
    
    @IBOutlet weak var cancelMsgTxtView: UITextView!
    
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    
    /////////////// INVOICE///////////////////////
    @IBOutlet weak var invoiceView: UIView!
    @IBOutlet weak var propertyNameLbl: UILabel!
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
     @IBOutlet weak var BookedDaysCount: UILabel!
     @IBOutlet weak var CancelledLbl: UILabel!
    @IBOutlet weak var receiptLbl: UILabel!
     @IBOutlet weak var PaymentDetailsLbl: UILabel!
    
    @IBOutlet weak var InvoiceTable: UITableView!

    
    @IBOutlet weak var WalletLbl: UILabel!
    @IBOutlet weak var CouponLbl: UILabel!
    @IBOutlet weak var CouponValueLbl: UILabel!
    @IBOutlet weak var WalletViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CouponViewHeight: NSLayoutConstraint!
    @IBOutlet weak var WalletView: UIView!

    @IBOutlet weak var CouponView: UIView!

    var InvoiceDetails = NSMutableDictionary()

     var moreOptionStatusButton  = UIButton()
    //MARK:- Variables
    var property_listing_ARR = NSArray()
    var my_reservation_ARR = NSArray()
    var isMyListing = true
    var manageCalender : String = ""
    var houseIn : String = ""
    var houseBooking : String = ""
    var housePayment : String = ""
    var houseApproval : String = ""
    var CarIn : String = ""
    var dropDownArr : NSMutableArray = []
    var creditcard_Stat : String = ""
    var cancellation : String = ""
    var selectedInt : Int = 0
    var selectedInvoice : Int = 0
    var cancelShowStatus : Bool = false
    var Stripe_status : String = ""
    var Paypal_Status : String = ""
    //MARK:- Lifecycle Methods
    let stateDropDowns = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.stateDropDowns,
            
            ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnManageList.setTitleColor(AppSecondColor, for: .normal)
              self.btnYourReserv.setTitleColor(.black, for: .normal)
        self.grayView.isHidden = true
        self.viewCancelMessage.isHidden = true
        self.cancelMessageView.isHidden = true
        self.cancelButton.isHidden = true
        self.invoiceView.isHidden = true
       // self.setData()
      
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        self.tblPropertyListing.isHidden = true
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        tblPropertyListing.tableFooterView = UIView()
        
        self.cancelMsgTxtView.layer.borderWidth = 1.0
                       self.cancelMsgTxtView.layer.borderColor = BorderColor.cgColor
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            viewTitle.textAlignment = .left
        }else{
            viewTitle.textAlignment = .right
        }
        
    }
    
    
    func setData ()
    {
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let userID = login_session.value(forKey: "UserId")!
            let  parameterDict = "userid=\(userID)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") as? String ?? "en")&base_id=\(Singleton.sharedInstance.selectedCategory)"
            Network.shared.POSTRequest(withParameterString: parameterDict, serviceURL: SHOW_PROPERTY_LISTING, APIKEY: "SHOW_PROPERTY_LISTING")
        } else {
            showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
    }
   
        
    
    
    override func viewWillAppear(_ animated: Bool) {
          
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = .white
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        }
        else
        {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .white
        }
            
            
        self.lblNoDatasFound.font = UIFont(name: RegularFont, size: 15)
        self.viewTitle.font = UIFont(name: RegularFont, size: 15)
        self.btnManageList.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
            self.btnYourReserv.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
         self.cancelButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
      //  self.cancelButton.backgroundColor = AppSecondColor
        self.cancelBooking.font = UIFont(name: SemiBoldFont, size: 17)
        self.cancelMsgTxtFld.font = UIFont(name: RegularFont, size: 15)
        
         self.cancelMsgTxtView.font = UIFont(name: RegularFont, size: 14)
        
        self.cancelRentalTitle.font = UIFont(name: RegularFont, size: 13)
         self.cancelRentalLocation.font = UIFont(name: RegularFont, size: 13)
         self.cancelRentalId.font = UIFont(name: RegularFont, size: 13)
          self.okayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.rentalNameCancel.font = UIFont(name: SemiBoldFont, size: 15)
          self.rentalNameCancel.font = UIFont(name: SemiBoldFont, size: 14)
          self.bookingNoCancel.font = UIFont(name: RegularFont, size: 13)
          self.locationCancel.font = UIFont(name: RegularFont, size: 13)
        self.CancelledLbl.font = UIFont(name: SemiBoldFont, size: 15)
          self.cancelTitle.font = UIFont(name: SemiBoldFont, size: 14)
         self.cancelBooking.font = UIFont(name: RegularFont, size: 14)
        self.cancelLocation.font = UIFont(name: RegularFont, size: 14)
         self.cancelMsg.font = UIFont(name: RegularFont, size: 14)
          self.cancelDate.font = UIFont(name: RegularFont, size: 15)
       // self.receiptLbl.font = UIFont(name: RegularFont, size: 18)
          self.propertyNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
         self.bookingIdLbl.font = UIFont(name: SemiBoldFont, size: 15)
         self.checkOutLbl.font = UIFont(name: RegularFont, size: 13)
            self.checkInLbl.font = UIFont(name: RegularFont, size: 15)
         self.nightLbl.font = UIFont(name: RegularFont, size: 15)
         self.guestLbl.font = UIFont(name: RegularFont, size: 15)
          self.locationLbl.font = UIFont(name: RegularFont, size: 15)
         self.cancellationPolicyLbl.font = UIFont(name: RegularFont, size: 15)
          self.subTotalLbl.font = UIFont(name: RegularFont, size: 15)
        self.securityDepositLbl.font = UIFont(name: RegularFont, size: 15)
           self.serviceFeeLbl.font = UIFont(name: RegularFont, size: 15)
         self.totalAmountLbl.font = UIFont(name: RegularFont, size: 15)
         self.walletAmountLbl.font = UIFont(name: RegularFont, size: 15)
       //  self.couponLbl.font = UIFont(name: RegularFont, size: 15)
        self.paidAmountLbl.font = UIFont(name: RegularFont, size: 16)
      self.PaymentDetailsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.CouponValueLbl.font = UIFont(name: SemiBoldFont, size: 14)

        self.viewTitle.text = GlobalLanguageDictionary.object(forKey: "key_mylisting") as? String ?? ""
        
        
          let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
          if choose == "en"
          {
              self.lblNoDatasFound.text = LocalizeHelper().localizedStringForKey("therenoproperty")
              self.manageCalender = LocalizeHelper().localizedStringForKey("listingsandcalendar")
              self.viewTitle.text = LocalizeHelper().localizedStringForKey("propertylisting")
              self.btnManageList.setTitle(LocalizeHelper().localizedStringForKey("managelisting"), for: .normal)
              self.btnYourReserv.setTitle(LocalizeHelper().localizedStringForKey("yourreserve"), for: .normal)
              self.houseIn = LocalizeHelper().localizedStringForKey("housein")
              
              self.houseBooking = LocalizeHelper().localizedStringForKey("bookingno")
              self.housePayment = LocalizeHelper().localizedStringForKey("paymentstatus")
              self.houseApproval = LocalizeHelper().localizedStringForKey("hostapproval")
              
          }
          else
          {
              self.lblNoDatasFound.text = LocalizeHelper().localizedStringForKey("therenoproperty")
              self.manageCalender = LocalizeHelper().localizedStringForKey("listingsandcalendar")
              self.viewTitle.text = LocalizeHelper().localizedStringForKey("propertylisting")
              self.btnManageList.setTitle(LocalizeHelper().localizedStringForKey("managelisting"), for: .normal)
              self.btnYourReserv.setTitle(LocalizeHelper().localizedStringForKey("yourreserve"), for: .normal)
              self.houseIn = LocalizeHelper().localizedStringForKey("housein")
              
              self.houseBooking = LocalizeHelper().localizedStringForKey("bookingno")
              self.housePayment = LocalizeHelper().localizedStringForKey("paymentstatus")
              self.houseApproval = LocalizeHelper().localizedStringForKey("hostapproval")
          }
            self.propertyListing()
          
      }
    func propertyListing(){
        self.showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
        
        params = [ "lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                   "page_no":"1",
                   "currency_code":"USD" ]

        print(params)
        
 
        APIManager.apiPostWithHeaders(serviceName: SHOW_PROPERTY_LISTING, parameters: params as? [String : Any]) { response, error in
                DispatchQueue.main.async {
//                self.ListingActivityDelegate.hideActivity()
            }
            print(SHOW_PROPERTY_LISTING)
                    let responseDict:NSDictionary = response as! NSDictionary
                    print(responseDict)
            
                     self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
                        let mod = PropertyListingModel(fromDictionary: responseDict.value(forKey: "data") as! [String : Any])
                        Singleton.sharedInstance.PropertyListingModel =  mod
                        self.tblPropertyListing.isHidden = false
                        if Singleton.sharedInstance.PropertyListingModel.propertyListing.count == 0 {
                            self.tblPropertyListing.isHidden = true
                            self.lblNoDatasFound.isHidden = false
                            self.lblNoDatas.isHidden = false
                        } else
                        {   self.tblPropertyListing.isHidden = false
                            self.lblNoDatasFound.isHidden = true
                             self.lblNoDatas.isHidden = true
                        }
                        self.tblPropertyListing.reloadData()
                    }
        
                    else {
                        
                        let mod = PropertyListingModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.PropertyListingModel =  mod
                        if Singleton.sharedInstance.PropertyListingModel.propertyListing.count == 0 {
                            self.tblPropertyListing.isHidden = true
                            self.lblNoDatasFound.isHidden = false
                            self.lblNoDatas.isHidden = false
                        } else
                        {   self.tblPropertyListing.isHidden = false
                            self.lblNoDatasFound.isHidden = true
                             self.lblNoDatas.isHidden = true
                        }
                    }
                }
            }
    
    
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Button Actions
    
    @IBAction func act_ManageListing(_ sender: UIButton) {
        isMyListing = true
        self.btnManageList.setTitleColor(AppSecondColor, for: .normal)
        self.btnYourReserv.setTitleColor(.black, for: .normal)
        if Singleton.sharedInstance
        .PropertyListingModel != nil {
        if Singleton.sharedInstance.PropertyListingModel.propertyListing.count == 0 {
            self.lblNoDatasFound.isHidden = false
            self.tblPropertyListing.isHidden = true
             self.lblNoDatas.isHidden = false
        } else {
            self.lblNoDatasFound.isHidden = true
            self.tblPropertyListing.isHidden = false
             self.lblNoDatas.isHidden = true
        }
        self.tblPropertyListing.reloadData()
        }
    }
    
    
    @IBAction func act_YourReservation(_ sender: UIButton) {
        isMyListing = false
        self.btnManageList.setTitleColor(.black, for: .normal)
        self.btnYourReserv.setTitleColor(AppSecondColor, for: .normal)
        if Singleton.sharedInstance
        .PropertyListingModel != nil {
        if Singleton.sharedInstance.PropertyListingModel.myReservation.count == 0 {
            self.tblPropertyListing.isHidden = true
            self.lblNoDatasFound.isHidden = false
             self.lblNoDatas.isHidden = false
        } else {
            self.tblPropertyListing.isHidden = false
            self.lblNoDatasFound.isHidden = true
             self.lblNoDatas.isHidden = true
        }
        self.tblPropertyListing.reloadData()
        }
    }
    
    @IBAction func act_Back(_ sender: UIButton) {
          let AppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        AppDelegate.PropertyListing()
     }
    @IBAction func act_invoice_Back(_ sender: UIButton)
       {
           self.grayView.isHidden = true
           self.invoiceView.isHidden = true
       }
       
    @IBAction func cancelButton_Act(_ sender: Any)
    {
        self.grayView.isHidden = true
        self.cancelMessageView.isHidden = true
        self.viewCancelMessage.isHidden = true
        self.cancelButton.isHidden = true
        self.invoiceView.isHidden = true
    }
    
    @IBAction func okay_act(_ sender: UIButton)
    {
        
        if Reachability()!.isReachable
        {
            if cancelMsgTxtView.text == ""
            {
                showInformation(title: "Rental Product", message: "Please enter cancel message.")
            }
                
                
                
            else
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                params = ["email":login_session.value(forKey: "Email") as? String ?? "","prd_id":Singleton.sharedInstance.PropertyListingModel.myReservation[selectedInt].propertyId,"Bookingno":Singleton.sharedInstance.PropertyListingModel.myReservation[selectedInt].bookingno,"cancellation_percentage":"0","user_id":Singleton.sharedInstance.PropertyListingModel.myReservation[selectedInt].guestId,"disputer_id":login_session.value(forKey: "UserId")!,"message":self.cancelMsgTxtView.text!]
               
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(HOST_CANCEL_BOOKING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        self.hideActivityIndicator(uiView: self.view)
                        print(responseDict)
                      
                        self.propertyListing()
                        
                        self.grayView.isHidden = true
                        self.cancelMessageView.isHidden = true
                        self.viewCancelMessage.isHidden = true
                        self.cancelButton.isHidden = true
                        self.invoiceView.isHidden = true
                    }
                        
                    else {
                        self.showInformation(title: "Rental Product", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Rental Product", message: error.localizedDescription)
                })
                
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.viewMoveableBar.frame = CGRect(x: self.view.frame.width / 2, y: self.viewMoveableBar.frame.origin.y, width: self.view.frame.width / 2, height: 3)
                })
            }
        }
    }
    
}

extension PropertyListingViewController: UITableViewDelegate ,UITableViewDataSource {
    
    
    
    @objc func ManageListBtnAct(_ sender: UIButton) {
        let Tag = sender.tag
        
        let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[Tag]
        if dict.propertyStatus == true {
            UserDefaults.standard.set("YES", forKey: "Listed")
        }
        else {
            UserDefaults.standard.set("NO", forKey: "Listed")
        }
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as?  ListingViewControllersBundle
        nav!.ListingBundleFrom = "PropertyListing"
        nav!.PropertyId = dict.propertyId
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    @objc func HostBtnAct(_ sender: UIButton) {
        let Tag = sender.tag
        let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[Tag]
        let hostId =  dict.propertyId
        let Currency =  dict.propertyCurrencySymbol

        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
       nav!.PropertyID = "\(hostId)"
        nav!.currencySymbol = "\(Currency)"
        self.navigationController?.pushViewController(nav!, animated: true)
        
//        let nav = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
//        nav?.hostID = "\(hostId)"
//
//        self.navigationController?.pushViewController(nav!, animated: true)

    }
    @objc func emailIdBtnAct(_ sender: UIButton) {
        let Tag = sender.tag
        let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[Tag]
        let hostId =  dict.hostId
        let nav = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController
        nav?.hostID = "\(hostId)"

        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
    
    
    
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
                    if ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as? NSArray)?.count ?? 0 == 0 {
                        return 0
                    }else{
                        return ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "add_on_details") as? NSArray)?.count ?? 0 + 1
                    }
                    
                    
                }else{
                    if ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as! NSArray).count == 0 {
                        return 0
                    }else{
                        return ((self.InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_details") as? NSArray)?.count ?? 0 + 3
                    }
                    
                    
                }
            }
            else
            {
                return 0
            }
        }else{

        if isMyListing == true {
            if Singleton.sharedInstance
                .PropertyListingModel != nil {
                return Singleton.sharedInstance
                    .PropertyListingModel.propertyListing.count
            } else {
                return 0
            }
        } else {
            if Singleton.sharedInstance
                .PropertyListingModel != nil {
                return Singleton.sharedInstance
                    .PropertyListingModel.myReservation.count
            } else {
                return 0
            }
        }
    }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == InvoiceTable {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceFirstTableViewCell") as? InvoiceFirstTableViewCell else {
                    return UITableViewCell()
                }
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
                cell.CancellationPolicyLbl.text = String(format: "Cancelled Status : %@",(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "cancelled_status") as? String ?? "" )
                
                return cell
            }
            else if indexPath.section == 1{
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else {
                    return UITableViewCell()
                }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                if indexPath.row == 0 {
                    cell.BaseTitle.text = "Addons Details"
                    cell.BaseTitle.textColor = .black
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
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
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else {
                        return UITableViewCell()
                    }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.text = "Bundle Details"
                    cell.BaseTitle.textColor = .black
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                    
                }else if indexPath.row == 1 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else {
                        return UITableViewCell()
                    }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.textColor = .darkGray
                    cell.BaseTitle.font = UIFont(name: RegularFont, size: 14)
                    
                    let Name = ((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_checkindate") as? String ?? "")
                    cell.BaseTitle.text = "Bundle CheckIn Date : \(Name)"
                    return cell
                    
                    
                }else if indexPath.row == 2 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else {
                        return UITableViewCell()
                    }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as! ProductDetailTitleTableViewCell
                    cell.BaseTitle.textColor = .darkGray
                    cell.BaseTitle.font = UIFont(name: RegularFont, size: 14)
                    
                    let Name = ((self.InvoiceDetails.object(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "bundle_checkoutdate") as? String ?? "")
                    cell.BaseTitle.text = "Bundle CheckOut Date : \(Name)"
                    return cell
                    
                }
                else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceMiddleTableViewCell") as? InvoiceMiddleTableViewCell else {
                        return UITableViewCell()
                    }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceMiddleTableViewCell") as! InvoiceMiddleTableViewCell
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
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceLastTableViewCell") as? InvoiceLastTableViewCell else {
                    return UITableViewCell()
                }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceLastTableViewCell") as! InvoiceLastTableViewCell
                
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
                
                let PayLaterAmount = "\((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "pay_later_balance_amount") as AnyObject)"
                
                if let distanceDb = Double(PayLaterAmount) {
                   cell.PayLaterValueLbl.text = "\(Currency) \(distanceDb.round(to:2))"
                }
                
                
//                let doubleVal = Double(PayLaterAmount)
//                    print(String(format: "%.2f", doubleVal))
//
//                let first3 = String(PayLaterAmount.prefix(2))
//
//                cell.PayLaterValueLbl.text = "\(Currency) \(first3)"
                cell.CouponValueLbl.text = "\(Currency) \((InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "couponDiscount") as AnyObject)"
                
                
                cell.WalletValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "wallet_Amount") as! CVarArg  )
                cell.PaidValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "paidTotal") as! CVarArg )
                cell.TotalValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "TotalAmt") as! CVarArg )
                cell.ServiceFeeValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "servicefee") as! CVarArg)
                
                cell.SecurityDepositValueLbl.text = String(format: "%@ %@",Currency,(InvoiceDetails.value(forKey: "invoice_details") as? NSDictionary)?.object(forKey: "securityDeposite") as! CVarArg)
                
                return cell
            }
        }else{
            if isMyListing == true {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PropertyListingCell else { return UITableViewCell()}
//                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? PropertyListingCell
                let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row]
                let url = URL(string: Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row].propertyImage)
    //            cell.img_Profile.kf.setImage(with: url!)
                cell.img_Profile.kf.setImage(with: url, placeholder: UIImage.init(named: "picture-frame"), options: nil, progressBlock: nil, completionHandler: nil)
                cell.lbl_Name.font = UIFont(name: SemiBoldFont, size: 14.0)
                 cell.lbl_PayOrManage.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.payLabel.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.bookingLabel.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.cancelLabel.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.ratingLabel.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.reviewLabel.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_Status.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_TotalBooking.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_Cancellation.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_Rating.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_ReviewCount.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_Cancellation.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_Rating.font = UIFont(name: SemiBoldFont, size: 14.0)
                cell.lbl_ReviewCount.font = UIFont(name: SemiBoldFont, size: 14.0)
//                cell.EmailIdVerifyBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
//                cell.lbl_statusfield.font = UIFont(name: SemiBoldFont, size: 14)
                
                cell.payLabel.text = "\(GlobalLanguageDictionary.object(forKey: "key_status") as? String ?? "") :"
                cell.bookingLabel.text = GlobalLanguageDictionary.object(forKey: "key_totalBooking") as? String ?? ""
                cell.cancelLabel.text = GlobalLanguageDictionary.object(forKey: "key_cancellation") as? String ?? ""
                cell.ratingLabel.text = GlobalLanguageDictionary.object(forKey: "key_rating") as? String ?? ""
                cell.reviewLabel.text = GlobalLanguageDictionary.object(forKey: "key_reaviewCount") as? String ?? ""
                
                cell.lbl_statusfield.font = UIFont(name: SemiBoldFont, size: 14.0)
                if dict.propertyStatus == true {
                    cell.lbl_statusfield.text = GlobalLanguageDictionary.object(forKey: "key_published") as? String ?? ""
                }else{
                    cell.lbl_statusfield.text = GlobalLanguageDictionary.object(forKey: "key_waitingforPublish") as? String ?? ""
                }
                cell.lbl_statusfield.backgroundColor = UIColor(red: 232/255.0, green: 62/255.0, blue: 50/255.0, alpha: 1.0)
                cell.lbl_Name.text = dict.propertyTitle
                cell.lbl_Status.text = GlobalLanguageDictionary.object(forKey: "key_manageListingCalender") as? String ?? ""
                cell.lbl_TotalBooking.text = String(format: "%d", dict.totalBooking)
                cell.lbl_Cancellation.text = String(format: "%d", dict.cancelBooking)
                cell.lbl_Rating.text = dict.ratingss
                cell.lbl_ReviewCount.text = (String(format: "%d", dict.reviewCount))
                cell.lbl_Status.textColor = UIColor.red
                let isPayable = dict.payable
                if isPayable == true {
                    cell.lbl_PayOrManage.text = " Pay "
                    cell.lbl_PayOrManage.textAlignment = .left
                    cell.lbl_PayOrManage.textColor = UIColor(red: 232/255.0, green: 62/255.0, blue: 50/255.0, alpha: 1.0)
                    cell.lbl_PayOrManage.backgroundColor = AppSecondColor1
                
 
                } else {
                    
                    
//                    cell.lbl_PayOrManage.text = "Paid"
//                    cell.lbl_PayOrManage.text = (dict.propertyStatus == true) ? "YES" : "NO"
                    cell.lbl_PayOrManage.text = dict.stepstoComplete
                    cell.lbl_PayOrManage.textAlignment = .left

                    cell.lbl_PayOrManage.textColor = .black
           //         cell.lbl_PayOrManage.backgroundColor = AppSecondColor1
                }
                
                let Complete = dict.stepstoComplete
                if Complete == "" {
                    cell.lbl_PayOrManage.text = GlobalLanguageDictionary.object(forKey: "key_Paid") as? String ?? ""
                    cell.lbl_PayOrManage.textColor = UIColor(red: 232/255.0, green: 62/255.0, blue: 50/255.0, alpha: 1.0)
//                    cell.lbl_PayOrManage.backgroundColor = AppSecondColor1
                    cell.lbl_PayOrManage.cornerRadius = 4
                }else{
                    cell.lbl_PayOrManage.text = dict.stepstoComplete
                    cell.lbl_PayOrManage.textAlignment = .left

                    cell.lbl_PayOrManage.textColor = UIColor(red: 232/255.0, green: 62/255.0, blue: 50/255.0, alpha: 1.0)
                //    cell.lbl_PayOrManage.backgroundColor = AppSecondColor1
                }
                
                let ptitle = dict.propertyTitle
                
                if ptitle == "" {
                    cell.lbl_Name.text = GlobalLanguageDictionary.object(forKey: "key_noName") as? String ?? ""
                }
                            
 
                
                if dict.host_id_verified == "not verified" {
//                    cell.EmailIdVerifyBtn.isHidden = false
//                    cell.EmailIdVerifyBtn.setTitle("Verify your email id.", for: .normal)

                }else{
//                    cell.EmailIdVerifyBtn.isHidden = true
    //                cell.lbl_PayOrManage.text = dict.propertyStatus!
    //                cell.lbl_PayOrManage.textAlignment = .left


                }
 
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell") as? YourReservationCell else { return UITableViewCell()}
//                let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell") as? YourReservationCell
                let dict = Singleton.sharedInstance.PropertyListingModel.myReservation[indexPath.row]
                cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.size.width / 2
                let url = URL(string: Singleton.sharedInstance.PropertyListingModel.myReservation[indexPath.row].userImage)
               // cell.imgProfile.kf.setImage(with: url!)
                cell.imgProfile.kf.setImage(with: url, placeholder: UIImage.init(named: "picture-frame"), options: nil, progressBlock: nil, completionHandler: nil)
                
                 cell.lblPropertyTitle.font = UIFont(name: SemiBoldFont, size: 14.0)
                 cell.lblPropertyLocation.font = UIFont(name: RegularFont, size: 12)
                 cell.lblBookingNumber.font = UIFont(name: RegularFont, size: 12)
                   cell.lblPaymentStatus.font = UIFont(name: RegularFont, size: 12)
                  cell.lblHostApproval.font = UIFont(name: RegularFont, size: 12)
                 cell.lblAmount.font = UIFont(name: SemiBoldFont, size: 15)
                  cell.lblBookingdate.font = UIFont(name: RegularFont, size: 12)
                
                
                cell.lblPropertyTitle.text = dict.propertyTitle
                
                cell.lblBookingdate.text = dict.bookingDates
                cell.lblPropertyLocation.text = houseIn + "\(dict.propertyAddress)"
                cell.lblPaymentStatus.attributedText = NSAttributedString().changeColor(text1: housePayment + " : ", text2: "\(dict.paymentStatus)", color1: UIColor.darkGray, color2: ForestGreen)
                cell.lblHostApproval.attributedText = NSAttributedString().changeColor(text1: houseApproval + " : ", text2: "\(dict.approvalStatus)", color1: UIColor.darkGray, color2: ForestGreen)
                //cell.lblAmount.text = "\(dict.paidCurrencySymbol!)" + " " +   String(describing: dict.total! )
                cell.lblAmount.text = String(format: "%@ %@", dict.paidCurrencyCode,dict.total as! CVarArg)
                cell.lblBookingNumber.text = houseBooking + " : " + "\(dict.bookingno)"
                
                if dict.paymentStatus == "Paid"
                {
                    cell.dotsButton.isHidden = false
                    cell.dotsButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
                    
                    cell.dotsButton.tag = indexPath.row
                    
                }
                else
                {
                    cell.dotsButton.isHidden = true
                    
                    
                }
                
                 moreOptionStatusButton.frame = cell.dotsButton.frame
                
                
                return cell
            }
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let button = sender
        let buttonRow = sender.tag
        selectedInt = sender.tag
        print(buttonRow)
        _ = button.superview?.superview as? YourReservationCell
        
       
        
        self.rentalNameCancel.text = String(format: "%@",Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].propertyTitle)
        self.bookingNoCancel.text = String(format: "%@",Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].bookingno)
        let Location = Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].city + "  " + Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].state + "  "  + Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].country
        self.cancellation = Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].cancellationPolicy
        self.locationCancel.text =  String(format: "%@", Location)
        
        
        if isMyListing == false
        {
            if (Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].cancelShowStatus) as Bool == true
            {
                dropDownArr = ["Cancel","Invoice/Receipts"]
                resultVal.set("Cancel", forKey: "CHECKKEY")
                
                resultVal.set("CancelbyNo", forKey: "CANCELLEDBY")
            }
            else
            {
                dropDownArr = ["Invoice/Receipts"]
                resultVal.set("Invoice/Receipts", forKey: "CANCELLEDBY")
                
            }
            
            
            
            
            
            if (Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].isCanceled) as Bool == false
            {
            }
            else{
                
                dropDownArr.removeAllObjects()
                resultVal.set("canceled", forKey: "CHECKKEY")
                if (Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].cancelledBy) == "Cancelled By Host"
                {
                    dropDownArr = ["Cancelled By Boat Owner","Invoice/Receipts"]
                    
                    resultVal.set("hostcancel", forKey: "CANCELLEDBY")
                }
                else
                {
                    dropDownArr = ["Cancelled By User","Invoice/Receipts"]
                    resultVal.set("usercancel", forKey: "CANCELLEDBY")
                }
                
                
            }
            
            var type = [String]()
            type = dropDownArr as! [String]
            stateDropDowns.anchorView = sender
         
            
            
            
            stateDropDowns.bottomOffset = CGPoint(x: 0, y: sender.bounds.height)
            stateDropDowns.dataSource = type
            stateDropDowns.backgroundColor = UIColor.white
            // Action triggered on selection
            stateDropDowns.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                if index == 0
                {
                    let cancelby = resultVal.value(forKey: "CANCELLEDBY") as? String
                    if cancelby == "Invoice/Receipts"
                    {
                        
                        self.showActivityIndicator(uiView: self.view)
                        var params = NSMutableDictionary()
                        
                         params = ["booking_no":String(describing: Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].bookingno),"currency_code":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].paidCurrencyCode,"device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                        
                      
                        
                        let manager = AFHTTPSessionManager()
                        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                        
                        manager.post(INVOICE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                            DispatchQueue.main.async {
                                
                            }
                            let responseDict:NSDictionary = responseObject as! NSDictionary
                            print(responseDict)
                            self.hideActivityIndicator(uiView: self.view)
                            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                                self.invoiceView.isHidden = false
                                self.grayView.isHidden = false
                                self.cancelMessageView.isHidden = true
                                self.viewCancelMessage.isHidden = true
                                self.cancelButton.isHidden = false
                                self.InvoiceDetails.removeAllObjects()
                                self.InvoiceDetails.addEntries(from: responseDict as! [AnyHashable : Any])
                                let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                                //                for detail in 0..<invoiceDetails!.count
                                //                {
                                
                                //let hotelDict = invoiceDetails![detail] as! NSDictionary
                                // print(hotelDict)
                                self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                                self.bookingIdLbl
                                    .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                                let street =    hotelDict!.value(forKey: "street") as! CVarArg
                                let state = hotelDict!.value(forKey: "state") as! CVarArg
                                let country = hotelDict!.value(forKey: "country") as! CVarArg
                                
                                self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
                                
                            self.checkInLbl.text = "Duration"
                               // self.checkOutLbl.text = String(format: "%@,%@",hotelDict!.value(forKey: "checkindate") as! CVarArg,hotelDict!.value(forKey: "checkoutdate") as! CVarArg )
                                self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                                self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                                self.checkOutLbl.text = String(format: "%@",hotelDict!.value(forKey: "checkindate") as! CVarArg ) + "\n \(String(format: " %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg ))"
                               
                                
                                self.checkOutLbl.textColor = AppColor
                                
                                
                                self.BookedDaysCount.text = String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                                                           self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
//                                self.subTotalLbl.text = String(format: "Booked for %@ Days : %@",hotelDict!.value(forKey: "numofdates") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                                let BookingType = hotelDict!.value(forKey: "booking_type") as? String ?? ""
                                
                                if BookingType == "hourly" {
                                    
                                    self.BookedDaysCount.text = String(format: "Booked for %@ Hours  ",hotelDict!.value(forKey: "numofhours") as! CVarArg)
                                    self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofhours") as! CVarArg )
                                   
                                    self.nightLbl.text = "\(hotelDict!.value(forKey: "numofhours") as AnyObject) Hours"

                                }else{
                                    self.BookedDaysCount.text = String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                                    
                                    self.nightLbl.text = "\(hotelDict!.value(forKey: "numofdates") as AnyObject) Days"
                                }
                                
                                self.securityDepositLbl.text = String(format: " %@",hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                                self.serviceFeeLbl.text = String(format: " %@",hotelDict!.value(forKey: "servicefee") as! CVarArg )
                                self.totalAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                                self.walletAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                                self.paidAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                                
                                
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
                                
                                
                             //   self.couponLbl.text = String(format: "Coupon : %@",hotelDict!.value(forKey: "couponDiscount") as! CVarArg )//*************************
                                self.cancellationPolicyLbl.text = String(format: "Cancellation Policy : %@",self.cancellation)
                                
                                self.InvoiceTable.reloadData()

                            }
                                
                            else {
                                self.showInformation(title: "Rental Product", message: responseDict.value(forKey: "message") as? String ?? "")
                            }
                        }, failure: { (operation, error) -> Void in
                            DispatchQueue.main.async {
                                
                            }
                            print(error)
                            self.showInformation(title: "Rental Product", message: error.localizedDescription)
                        })

                    }
                    else{
                        
                        if cancelby == "hostcancel"
                        {
                            if Reachability()!.isReachable
                            {
                                
                                
                                self.showActivityIndicator(uiView: self.view)
                                var params = NSMutableDictionary()
                                 params = ["product_id":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].propertyId,"bookingno":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].bookingno,"user_id":login_session.value(forKey: "UserId")!,"cancel_by":"host"]
//                                params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
//
                                let manager = AFHTTPSessionManager()
                                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                                
                                manager.post(PROPERTY_CANCEL_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                                    DispatchQueue.main.async {
                                        
                                    }
                                    let responseDict:NSDictionary = responseObject as! NSDictionary
                                    print(responseDict)
                                    self.hideActivityIndicator(uiView: self.view)
                                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                                        self.grayView.isHidden = false
                                        self.cancelMessageView.isHidden = true
                                        self.viewCancelMessage.isHidden = false
                                        self.cancelButton.isHidden = false
                                        
                                        let cancelDetails = responseDict.value(forKey: "Cancel_details") as? NSArray
                                        for detail in 0..<cancelDetails!.count
                                        {
                                            let hotelDict = cancelDetails![detail] as! NSDictionary
                                            self.cancelTitle.text = String(format: "Rental Name: %@",  hotelDict.value(forKey: "name") as! CVarArg)
                                            self.cancelBooking.text = String(format: "Booking No: %@", hotelDict.value(forKey: "Booking_no") as! CVarArg)
                                            self.cancelLocation.text = String(format: "Location: %@",hotelDict.value(forKey: "address") as! CVarArg)
                                            
                                            
                                            let date = hotelDict.value(forKey: "cancelled_date") as? String
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                                            dateFormatter.dateFormat = "dd-MM-yyyy"
                                            let datenew = dateFormatter.string(from: dateFromString as Date)
                                            
                                            self.cancelDate.text = datenew
                                            self.cancelMsg.text = hotelDict.value(forKey: "message") as? String
                                        }
                                        
                                    }
                                        
                                    else {
                                        self.showInformation(title: "Rental Product", message: responseDict.value(forKey: "message") as? String ?? "")
                                    }
                                }, failure: { (operation, error) -> Void in
                                    DispatchQueue.main.async {
                                        
                                    }
                                    print(error)
                                    self.showInformation(title: "Rental Product", message: error.localizedDescription)
                                })

                            }
                        }
                        else if  cancelby == "CancelbyNo"
                        {
                            self.grayView.isHidden = false
                            self.cancelMessageView.isHidden = false
                            self.viewCancelMessage.isHidden = true
                            self.cancelButton.isHidden = false
                        }
                        else
                        {
                            if Reachability()!.isReachable
                            {
                                
                                
                                self.showActivityIndicator(uiView: self.view)
                                var params = NSMutableDictionary()
                                
                                 params = ["product_id":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].propertyId,"bookingno":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].bookingno,"user_id":login_session.value(forKey: "UserId")!,"cancel_by":"user"]
                                
                            
                                
                                let manager = AFHTTPSessionManager()
                                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                                
                                manager.post(PROPERTY_CANCEL_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                                    DispatchQueue.main.async {
                                        
                                    }
                                    let responseDict:NSDictionary = responseObject as! NSDictionary
                                    print(responseDict)
                                    self.hideActivityIndicator(uiView: self.view)
                                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                                        self.grayView.isHidden = false
                                        self.cancelMessageView.isHidden = true
                                        self.viewCancelMessage.isHidden = false
                                        self.cancelButton.isHidden = false
                                        
                                        let cancelDetails = responseDict.value(forKey: "Cancel_details") as? NSArray
                                        for detail in 0..<cancelDetails!.count
                                        {
                                            let hotelDict = cancelDetails![detail] as! NSDictionary
                                            self.cancelTitle.text = String(format: "Rental Name: %@",  hotelDict.value(forKey: "name") as! CVarArg)
                                            self.cancelBooking.text = String(format: "Booking No: %@", hotelDict.value(forKey: "Booking_no") as! CVarArg)
                                            self.cancelLocation.text = String(format: "Location: %@",hotelDict.value(forKey: "address") as! CVarArg)
                                            
                                            
                                            let date = hotelDict.value(forKey: "cancelled_date") as? String
                                            let dateFormatter = DateFormatter()
                                             dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                                            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                                            dateFormatter.dateFormat = "dd-MM-yyyy"
                                            let datenew = dateFormatter.string(from: dateFromString as Date)
                                            
                                            self.cancelDate.text = datenew
                                            self.cancelMsg.text = hotelDict.value(forKey: "message") as? String
                                        }
                                        
                                    }
                                        
                                    else {
                                        self.showInformation(title: "Rental Product", message: responseDict.value(forKey: "message") as? String ?? "")
                                    }
                                }, failure: { (operation, error) -> Void in
                                    DispatchQueue.main.async {
                                        
                                    }
                                    print(error)
                                    self.showInformation(title: "Rental Product", message: error.localizedDescription)
                                })

                            }
                        }
                   }
              }
                else
                {
                    
                    self.showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                     params = ["booking_no":String(describing: Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].bookingno),"currency_code":Singleton.sharedInstance.PropertyListingModel.myReservation[buttonRow].paidCurrencyCode,"device_type":"ios","user_id":login_session.value(forKey: "UserId")!]
                    
                    
                    
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(INVOICE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                            self.invoiceView.isHidden = false
                            self.grayView.isHidden = false
                            self.cancelMessageView.isHidden = true
                            self.viewCancelMessage.isHidden = true
                            self.cancelButton.isHidden = false
                            
                            self.InvoiceDetails.removeAllObjects()
                            self.InvoiceDetails.addEntries(from: responseDict as! [AnyHashable : Any])
                            
                            let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                            //                for detail in 0..<invoiceDetails!.count
                            //                {
                            
                            //let hotelDict = invoiceDetails![detail] as! NSDictionary
                            // print(hotelDict)
                            self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                            self.bookingIdLbl
                                .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                            let street =    hotelDict!.value(forKey: "street") as! CVarArg
                            let state = hotelDict!.value(forKey: "state") as! CVarArg
                            let country = hotelDict!.value(forKey: "country") as! CVarArg
                            
                            self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
                            
                          self.checkInLbl.text = "Duration"
                            self.checkOutLbl.text = String(format: "%@,%@",hotelDict!.value(forKey: "checkindate") as! CVarArg,hotelDict!.value(forKey: "checkoutdate") as! CVarArg )
                            self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                            self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                            self.BookedDaysCount.text =  String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                             self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                            self.checkOutLbl.textColor = AppColor
                            
                            
                            self.BookedDaysCount.text = String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                                                       self.subTotalLbl.text = String(format: "%@ %@",hotelDict!.value(forKey: "currency_code") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
//                                self.subTotalLbl.text = String(format: "Booked for %@ Days : %@",hotelDict!.value(forKey: "numofdates") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                            let BookingType = hotelDict!.value(forKey: "booking_type") as? String ?? ""
                            
                            if BookingType == "hourly" {
                                
                                self.BookedDaysCount.text = String(format: "Booked for %@ Hours  ",hotelDict!.value(forKey: "numofhours") as! CVarArg)
                                self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofhours") as! CVarArg )
                               
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofhours") as AnyObject) Hours"

                            }else{
                                self.BookedDaysCount.text = String(format: "Booked for %@ Days : ",hotelDict!.value(forKey: "numofdates") as! CVarArg)
                                
                                self.nightLbl.text = "\(hotelDict!.value(forKey: "numofdates") as AnyObject) Days"
                            }
                            self.securityDepositLbl.text = String(format: " %@",hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                            self.serviceFeeLbl.text = String(format: " %@",hotelDict!.value(forKey: "servicefee") as! CVarArg )
                            self.totalAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                            self.walletAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                            self.paidAmountLbl.text = String(format: " %@",hotelDict!.value(forKey: "paidTotal") as! CVarArg )
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
                            
                           // self.couponLbl.text = String(format: "Coupon : %@",hotelDict!.value(forKey: "couponDiscount") as! CVarArg )
                            self.cancellationPolicyLbl.text = String(format: "Cancellation Policy : %@",self.cancellation)
                            self.InvoiceTable.reloadData()

                            
                            
                        }
                            
                        else {
                            self.showInformation(title: "Rental Product", message: responseDict.value(forKey: "message") as? String ?? "")
                        }
                    }, failure: { (operation, error) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        print(error)
                        self.showInformation(title: "Rental Product", message: error.localizedDescription)
                    })

                }
            }
        }
        self.stateDropDowns.show()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == InvoiceDetails {
            return  UITableView.automaticDimension
        }else{
            if isMyListing == true {
                return  175
            }
            else {
                return  UITableView.automaticDimension
            }
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        if isMyListing == true {
    //            let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row]
    //            let isPayable = dict.payable!
    //            if isPayable == true {
    //                let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as?  PaymentViewController
    //                nav!.PaymentFor = "Listing"
    //                nav!.property_id = String(dict.propertyId)
    //                nav!.total_price = dict.propertyPrice!
    //                nav!.enquiryid = String(dict.propertyId)
    //                self.navigationController?.pushViewController(nav!, animated: true)
    //            } else {
    //                if dict.propertyStatus == "Listed" {
    //                    UserDefaults.standard.set("YES", forKey: "Listed")
    //                }
    //                else {
    //                    UserDefaults.standard.set("NO", forKey: "Listed")
    //                }
    //                let nav = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as?  ListingViewControllersBundle
    //                nav!.ListingBundleFrom = "PropertyListing"
    //                nav!.PropertyId = dict.propertyId
    //                self.navigationController?.pushViewController(nav!, animated: true)
    //            }
    //        }
    //        else {
    //
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == InvoiceTable {
            
        }else{
            if isMyListing == true {
                let dict = Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row]
                let isPayable = dict.payable
                if isPayable == true {
                    
                    self.Stripe_status = "Enable"//Singleton.sharedInstance.PeropertyListingModel.propertyListing[indexPath.row].stripeStatus
                    self.Paypal_Status = "Enable"//Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row].paypalStatus
                    self.creditcard_Stat = "Enable"//Singleton.sharedInstance.PropertyListingModel.propertyListing[indexPath.row].creditCardStatus
                    
                    var PaymentMethodsArr : NSMutableArray = []
                    
                    if self.Stripe_status == "Enable" {
                        PaymentMethodsArr.add("Stripe")
                    }else{
                        
                    }
                    if self.Paypal_Status == "Enable" {
                                                   PaymentMethodsArr.add("PayPal")
                                               }else{
                                                   
                                               }
                    if self.creditcard_Stat == "Enable" {
                                                //   PaymentMethodsArr.add("Credit Card")
                                               }else{
                                                   
                                               }
                    print(PaymentMethodsArr)

                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewPaymentViewController") as? NewPaymentViewController
                    nav!.PaymentsArray = PaymentMethodsArr
                    nav!.paymentComingType = "RentalListing"
                    nav!.subTotal = ""
                    nav!.TotalAmount = "\(dict.propertyPrice)"
                        nav!.enquiryid = String(dict.propertyId)
                    nav!.ServiceFee = ""
                    nav!.SecurityDeposit = ""
                    nav!.PropertId = String(dict.propertyId)
                    nav!.WalletShow = 0
                    nav!.CouponShow = 0
                    nav!.currency_cron_id = String(dict.propertyCurrencyCode)
                    self.navigationController?.pushViewController(nav!, animated: true)
                }
                else {
                    if dict.propertyStatus == true {
                        UserDefaults.standard.set("YES", forKey: "Listed")
                    }
                    else {
                        UserDefaults.standard.set("NO", forKey: "Listed")
                    }
                    let nav = self.storyboard?.instantiateViewController(withIdentifier: "ListingViewControllersBundle") as?  ListingViewControllersBundle
                    nav!.ListingBundleFrom = "PropertyListing"
                    nav!.PropertyId = dict.propertyId
                    self.navigationController?.pushViewController(nav!, animated: true)
                }
            }
            else {
                
            }
        }
    
    }
}

extension PropertyListingViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "SHOW_PROPERTY_LISTING" {
            if errorDict.count == 0 {
                print(responseDict)
                let mod = PropertyListingModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.PropertyListingModel =  mod
                
                if Singleton.sharedInstance.PropertyListingModel.propertyListing.count == 0 {
                    self.tblPropertyListing.isHidden = true
                    self.lblNoDatasFound.isHidden = false
                     self.lblNoDatas.isHidden = false
                } else
                {   self.tblPropertyListing.isHidden = false
                    self.lblNoDatasFound.isHidden = true
                     self.lblNoDatas.isHidden = true
                    self.Stripe_status = Singleton.sharedInstance.PropertyListingModel.propertyListing[0].stripeStatus
                    self.Paypal_Status = Singleton.sharedInstance.PropertyListingModel.propertyListing[0].paypalStatus
                    self.creditcard_Stat = Singleton.sharedInstance.PropertyListingModel.propertyListing[0].creditCardStatus
                    self.tblPropertyListing.isHidden = false
                }
                self.tblPropertyListing.reloadData()
            }
        }
        else if APIKEY == "PROPERTY_CANCEL_API"
        {
            if errorDict.count == 0
            {
                self.hideActivityIndicator(uiView: self.view)
                print(responseDict)
                
                self.grayView.isHidden = false
                self.cancelMessageView.isHidden = true
                self.viewCancelMessage.isHidden = false
                self.cancelButton.isHidden = false
                
                let cancelDetails = responseDict.value(forKey: "Cancel_details") as? NSArray
                for detail in 0..<cancelDetails!.count
                {
                    let hotelDict = cancelDetails![detail] as! NSDictionary
                    self.cancelTitle.text = String(format: "Rental Name: %@",  hotelDict.value(forKey: "name") as! CVarArg)
                    self.cancelBooking.text = String(format: "Booking No: %@", hotelDict.value(forKey: "Booking_no") as! CVarArg)
                    self.cancelLocation.text = String(format: "Location: %@",hotelDict.value(forKey: "address") as! CVarArg)
                    
                    
                    let date = hotelDict.value(forKey: "cancelled_date") as? String
                    let dateFormatter = DateFormatter()
                     dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                    dateFormatter.dateFormat = "dd-MM-yyyy"
                    let datenew = dateFormatter.string(from: dateFromString as Date)
                    
                    self.cancelDate.text = datenew
                    self.cancelMsg.text = hotelDict.value(forKey: "message") as? String
                }
                
                
                
            }
        }
        else if APIKEY == "HOST_CANCEL_BOOKING"
        {
            if errorDict.count == 0
            {
                
                self.hideActivityIndicator(uiView: self.view)
                print(responseDict)
                self.setData()
                
                self.grayView.isHidden = true
                self.cancelMessageView.isHidden = true
                self.viewCancelMessage.isHidden = true
                self.cancelButton.isHidden = true
                self.invoiceView.isHidden = true
                
                
                //self.tblPropertyListing.reloadData()
                
                
                
            }
        }
        else if APIKEY == "INVOICE_API"
        {
            if errorDict.count == 0
            {
                print(responseDict)
                if responseDict.value(forKey: "status") as? Int == 0
                {
                    self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as? String ?? "")
                }
                else
                {
                    self.invoiceView.isHidden = false
                    self.grayView.isHidden = false
                    self.cancelMessageView.isHidden = true
                    self.viewCancelMessage.isHidden = true
                    self.cancelButton.isHidden = false
                    
                    let hotelDict = responseDict.value(forKey: "invoice_details") as? NSDictionary
                    //                for detail in 0..<invoiceDetails!.count
                    //                {
                    
                    //let hotelDict = invoiceDetails![detail] as! NSDictionary
                    // print(hotelDict)
                    self.propertyNameLbl.text = String(format: "%@",  hotelDict!.value(forKey: "product_title") as! CVarArg )
                    self.bookingIdLbl
                        .text = String(format: "Booking No : %@",hotelDict!.value(forKey: "booking_no") as! CVarArg)
                    let street =    hotelDict!.value(forKey: "street") as! CVarArg
                    let state = hotelDict!.value(forKey: "state") as! CVarArg
                    let country = hotelDict!.value(forKey: "country") as! CVarArg
                    
                    self.locationLbl.text = String(format: "%@,%@,%@", street,state,country)
                    
                    self.checkInLbl.text = String(format: "Check_in : %@",hotelDict!.value(forKey: "checkindate") as! CVarArg )
                    self.checkOutLbl.text = String(format: "Check_out : %@",hotelDict!.value(forKey: "checkoutdate") as! CVarArg )
                    self.guestLbl.text = String(format: "%@",hotelDict!.value(forKey: "NoofGuest") as! CVarArg )
                    self.nightLbl.text = String(format: "%@",hotelDict!.value(forKey: "numofdates") as! CVarArg )
                    
                    
                    self.subTotalLbl.text = String(format: "Booked for %@ Days : %@",hotelDict!.value(forKey: "numofdates") as! CVarArg,hotelDict!.value(forKey: "TotalwithoutService") as! CVarArg )
                    self.securityDepositLbl.text = String(format: "%@",hotelDict!.value(forKey: "securityDeposite") as! CVarArg )
                    self.serviceFeeLbl.text = String(format: "%@",hotelDict!.value(forKey: "servicefee") as! CVarArg )
                    self.totalAmountLbl.text = String(format: "%@",hotelDict!.value(forKey: "TotalAmt") as! CVarArg )
                    self.walletAmountLbl.text = String(format: "%@",hotelDict!.value(forKey: "wallet_Amount") as! CVarArg )
                    self.paidAmountLbl.text = String(format: "%@",hotelDict!.value(forKey: "paidTotal") as! CVarArg )
                   // self.couponLbl.text = String(format: "%@",hotelDict!.value(forKey: "couponDiscount") as! CVarArg )
                    self.cancellationPolicyLbl.text = String(format: "Cancellation Policy : %@",cancellation)
                    
                }
            }
            
            
        }
        else
        {
            print("No Data")
        }
    }
}

extension NSAttributedString {
    func changeColor(text1: String, text2:String, color1: UIColor, color2: UIColor) -> NSMutableAttributedString {
        let textAttributesOne = [NSAttributedString.Key.foregroundColor: color1]
        let textAttributesTwo = [NSAttributedString.Key.foregroundColor: color2]
        let textPartOne = NSMutableAttributedString(string: text1, attributes: textAttributesOne)
        let textPartTwo = NSMutableAttributedString(string: text2, attributes: textAttributesTwo)
        let textCombination = NSMutableAttributedString()
        textCombination.append(textPartOne)
        textCombination.append(textPartTwo)
        return textCombination
    }
}
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


