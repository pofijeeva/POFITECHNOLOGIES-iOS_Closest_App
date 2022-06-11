//
//  NewProductDetailViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 28/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit



class NewProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var DetailTable: UITableView!
    
    @IBOutlet weak var AminitiesDetailTable: UITableView!
    @IBOutlet weak var AminitiyTab: UIView!
    @IBOutlet weak var AminitiyViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AminitiyLbl: UILabel!

    
    @IBOutlet weak var ReviewsCollection: UICollectionView!
    @IBOutlet weak var grayView: UIView!
    
    @IBOutlet weak var ReviewsView: UIView!
    @IBOutlet weak var ReviewsLbl: UILabel!
    @IBOutlet weak var OverAllReviewsLbl: UILabel!
    
    @IBOutlet weak var ReviewsRatingView: FloatRatingView!
    
    
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var LoginMessageLbl: UILabel!
    @IBOutlet weak var LoginMessagetxtLbl: UILabel!
    @IBOutlet weak var LoginOkBtn: UIButton!
    
    // WishList
    
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var btn_addWishlist: UIButton!
    @IBOutlet weak var collectnviewWishlist: UICollectionView!
    @IBOutlet weak var viewWishlisttitlePopup: UIView!
    @IBOutlet weak var txf_Wishlistitle: UITextField!
    @IBOutlet weak var btn_Okay: UIButton!
    @IBOutlet weak var wishlistLbl: UILabel!
    @IBOutlet weak var choosewishlistLbl: UILabel!
    @IBOutlet weak var WishListCancelBtn: UIButton!
    
    @IBOutlet weak var RequestBookBtn: UIButton!
    @IBOutlet weak var InstantPayBtn: UIButton!

    
    
    
    var PropertyID: String = ""
    
    var NoOfLines : String = ""
    let newPin = MKPointAnnotation()
    var instantPayStatusValue : String = ""
    var reqToBookStatusValue : String = ""
    var payLaterStatusValue : String = ""
    
    var currencySymbol : String = ""
    var booking_type : String = ""
    var CounponShow  = 1
    var timeEnd : Date?
    var DatesMutable : NSMutableArray = []
    var detailsleftSideNamesArr : NSMutableArray = []
    var detailsDescArr : NSMutableArray = []
    
    var AminitiesArray : NSMutableArray = []
    var wishListId : String = ""
    var wishPropertyid : Int = 0
    
    var clicked : String = ""
    
    var AddonsArray : NSMutableArray = []
    var prop_slug : String = ""
    
    var ProperdyDetails = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DetailTable.isHidden = true
        self.ReviewsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.ReviewsLbl.textColor = AppColor
        self.RequestBookBtn.backgroundColor = AppColor
        self.InstantPayBtn.backgroundColor = AppColor
        
        self.RequestBookBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_request2Book") as? String ?? "", for: .normal)
        self.InstantPayBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_instantPay") as? String ?? "", for: .normal)
        self.LoginMessageLbl.text = GlobalLanguageDictionary.object(forKey: "message") as? String ?? ""
        self.LoginMessagetxtLbl.text = GlobalLanguageDictionary.object(forKey: "Key_pleaselogin") as? String ?? ""
        self.LoginOkBtn.setTitle(GlobalLanguageDictionary.object(forKey: "ok") as? String ?? "", for: .normal)
        self.LoginOkBtn.backgroundColor = AppColor
        self.LoginOkBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
        self.LoginMessageLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.LoginMessagetxtLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.OverAllReviewsLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.WishListCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.AminitiyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        self.grayView.isHidden = true
        self.ReviewsView.isHidden = true
        self.NoOfLines = "Two"
        PropertyDetail()
        detailsleftSideNamesArr = [GlobalLanguageDictionary.object(forKey: "key_othersNote") as? String ?? "",GlobalLanguageDictionary.object(forKey: "key_rentalRules") as? String ?? "",GlobalLanguageDictionary.object(forKey: "key_guestAccess") as? String ?? "",GlobalLanguageDictionary.object(forKey: "key_rental") as? String ?? "",GlobalLanguageDictionary.object(forKey: "Key_interactionGuest") as? String ?? ""]
        
        detailsDescArr = ["","","","","","",""]
        self.RequestBookBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.InstantPayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        
        //
        // Do any additional setup after loading the view.
    }
    @IBAction func act_ScrollBGtapped(_ sender: UITapGestureRecognizer) {
        self.AminitiyTab.isHidden = true
    }
    
    @IBAction func act_Reviewtapped(_ sender: UITapGestureRecognizer) {
        self.grayView.isHidden = true
        self.ReviewsView.isHidden = true
        self.viewBottom.isHidden = true
        self.viewWishlisttitlePopup.isHidden = true
    }
    @IBAction func LoginView_CancelAct(_ sender: UIButton)
    {
        self.LoginView.isHidden = true
    }
    @IBAction func LoginView_OkAct(_ sender: UIButton)
    {
        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
        self.navigationController?.pushViewController(navgt!, animated: true)
    }
    @IBAction func act_addWishlist(_ sender: UIButton)
    {
        self.viewWishlisttitlePopup.isHidden = false
        self.grayView.isHidden = false
    }
    
    func PropertyDetail() {
        
        
        
        
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params =  ["prod_id": PropertyID,"page_Id":"1","lang_code":"en","user_id":UserID,"prop_slug":self.prop_slug,"currency_code":"USD"]
       print(params)
        APIManager.apiPostWithHeaders(serviceName: SHOW_PROPERTY_DETAIL, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                        self.hideActivityIndicator(uiView: self.view)

                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.DetailTable.isHidden = false
                        
                        let mod = PropertyDetails(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.PropertyDetail = mod
                        self.AddonsArray.removeAllObjects()
                        BundleArray.removeAllObjects()
                        self.AddonsArray.addObjects(from: (((responseDict.object(forKey: "data") as? NSDictionary)?.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "addon_details") as! NSArray as! [Any]))
                    
                        self.ProperdyDetails.removeAllObjects()
                        self.ProperdyDetails.addEntries(from: (responseDict.value(forKey: "data") as? NSDictionary) as? [AnyHashable : Any] ?? [:])
                        self.detailsDescArr = ["\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "other_things_to_note") as AnyObject)","\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "house_rules") as AnyObject)","\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "guest_access") as AnyObject)","\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "product_space") as AnyObject)","",""]
                       
                        self.instantPayStatusValue = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "instant_pay_status") as AnyObject)"
                        self.reqToBookStatusValue = "true"
                          self.AminitiesArray.removeAllObjects()
                         self.DatesMutable.removeAllObjects()
                        let Dates = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice.count
                        
                        for i in 0..<Dates{
                            let dateString = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].date
                            let dateStatus = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].status
                            let datePrice = Singleton.sharedInstance.PropertyDetail.seasonalCalendarPrice[i].price
                            let datesArray = NSMutableDictionary()
                            datesArray.setValue(dateString, forKey: "DateString")
                            datesArray.setValue(dateStatus, forKey: "DateStatus")
                            datesArray.setValue(datePrice, forKey: "DatePrice")
                            self.DatesMutable.add(datesArray)
                        }
                        print(self.DatesMutable)
                        
                        self.DetailTable.reloadData()
                        self.AminitiesDetailTable.reloadData()
                        
                        if Singleton.sharedInstance.PropertyDetail.couponDetails.count == 0 {
                            
                        }else{
                            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.printTime), userInfo: nil, repeats: true)
                            timer.fire()
                        }

                        
                    }
                    else {
                        if responseDict.value(forKey: "message") as? String ?? "" == "No Property available" {
                            
                            
                            let refreshAlert = UIAlertController(title: "Closest", message: "No Property available", preferredStyle: UIAlertControllerStyle.alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            
                            self.present(refreshAlert, animated: true, completion: nil)
                            
                        }else{
                            
                        }
                        
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                  
    }
        
        
//        showActivityIndicator(uiView: self.view)
//        var params = NSMutableDictionary()
//
//        params =  ["prod_id": PropertyID!,"page_Id":"1","lang_code":"en","user_id":UserID,"prop_slug":self.prop_slug,"currency_code":"USD"]
//       print(params)
//        let manager = AFHTTPSessionManager()
//        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//        manager.post(SHOW_PROPERTY_DETAIL, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//            DispatchQueue.main.async {
//
//            }
//            let responseDict:NSDictionary = responseObject as! NSDictionary
//            print(responseDict)
//            self.hideActivityIndicator(uiView: self.view)
//            if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
//
//            }
//
//            else {
//                if responseDict.value(forKey: "message") as? String ?? "" == "No Property available" {
//
//
//                    let refreshAlert = UIAlertController(title: "Closest", message: "No Property available", preferredStyle: UIAlertControllerStyle.alert)
//
//                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                        self.navigationController?.popViewController(animated: true)
//                    }))
//
//                    self.present(refreshAlert, animated: true, completion: nil)
//
//                }else{
//
//                }
//
//                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
//            }
//        }, failure: { (operation, error) -> Void in
//            DispatchQueue.main.async {
//
//            }
//            print(error)
//            self.showInformation(title: "Closest", message: error.localizedDescription)
//        })
    }
    @objc func printTime(){
        self.DetailTable.reloadData()
    }
    //MARK:- Button Actions
    @IBAction func act_Back(_ sender: UIButton)
    {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func act_wishListCancel(_ sender: UIButton)
    {
        self.viewWishlisttitlePopup.isHidden = true
         
    }
    
    @IBAction func act_InstantPay(_ sender: UIButton)
    {
        
        
        print(BundleSelectedDictValues)
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            
            let hostStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""//Singleton.sharedInstance.PropertyDetail.host_status!
//            let GuestStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""
            
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_id") as AnyObject//Singleton.sharedInstance.PropertyDetail.hostId
            
            if hostStatus == "Inactive"  {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_hostnotAva") as? String ?? "")
            }
//            else if GuestStatus == "Inactive" {
//                self.showInformation(title: "Closest", message: "User is inactive.Please contact Admin")
//            }
            else if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_unableBookOwnRental") as? String ?? "")
            }
//            else if HostIdVerified == "No" {
//                self.showInformation(title: "Closest", message: " Host is not verified yest ..!")
//            }
            else{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewBookingViewController") as? NewBookingViewController
                nav!.currencySymbol = self.currencySymbol
                nav!.PropertyId = self.PropertyID
                nav!.DatesMutable = self.DatesMutable
                nav!.PaymentType = "instant_pay"
                nav!.ProperdyDetails = self.ProperdyDetails
                //self.present(nav!, animated: true, completion: nil)
                navigationController?.pushViewController(nav!, animated: true)
            }
        }else{
            self.LoginView.isHidden = false
        }

    }
    @IBAction func act_RequestBook(_ sender: UIButton)
    {
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            
            let hostStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""
            let GuestStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""
 
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_id") as AnyObject
            
            if hostStatus == "Inactive" {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_hostnotAva") as? String ?? "")
            }else if GuestStatus == "Inactive" {
                self.showInformation(title: "Closest", message: "User is inactive.Please contact Admin")
            }
            else if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_unableBookOwnRental") as? String ?? "")
            }
//            else if HostIdVerified == "No" {
//                self.showInformation(title: "Closest", message: " Host is not verified yest ..!")
//            }
            else{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewBookingViewController") as? NewBookingViewController
                nav!.currencySymbol = self.currencySymbol
                nav!.PropertyId = self.PropertyID
                nav!.PaymentType = "RequestToBook"
                nav!.DatesMutable = self.DatesMutable
                nav!.ProperdyDetails = self.ProperdyDetails

                self.navigationController?.pushViewController(nav!, animated: true)
            }
        }else{
            self.LoginView.isHidden = false
        }
      
    }
    @IBAction func act_OkayBtn(_ sender: UIButton) {
        if txf_Wishlistitle.text == "" {
            showInformation(title: "Closest", message: "Wishlist title cannot be empty")
        }
        else {
            
            if (Reachability()?.isReachable ?? false)
            {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                params = ["base_id":1,"userid":login_session.value(forKey: "UserId")!,"wishlist_title":self.txf_Wishlistitle.text!,"property_id":Singleton.sharedInstance.PropertyDetail.rentalId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? ""]
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(CREATE_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        self.viewWishlisttitlePopup.isHidden = true
                        self.grayView.isHidden = true
                        self.viewBottom.isHidden = true
                        print("GET_WISHLIST_API Response:::",responseDict)
                        
                        let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.wishListModel = mod
                        
                        
                        self.collectnviewWishlist.reloadData()
                        
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
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
    }
    
    func AddWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"property_id":self.wishPropertyid]
        print(params)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(ADD_WISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                print("GET_WISHLIST_API Response:::",responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                self.PropertyDetail()
                
                if mod.wishlist.count != 0
                {
                    
                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    
                    
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
extension NewProductDetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    @objc func favTapped(sender: UIButton)
    {
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            let btnRow = sender.tag
            print("btnRow is :", btnRow)
            if sender.isSelected == true {
                print("btnRow is :", btnRow)
            }
            else {
                print("btnRow is :", btnRow)
            }
 
            let favid = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "is_favourite") as AnyObject)"
            if favid == "1"  {
               // RemoveWishList()
                WishListApiCall()
                
            }else {
 
                
                if (Reachability()?.isReachable ?? false)
                {
                    
                    WishListApiCall()
                    
                }
                else
                {
                    self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
                }
            }
        }else{
            self.LoginView.isHidden = false
        }
 }
    
    func WishListApiCall() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","property_id":self.PropertyID]
        
        print(params)
        APIManager.apiPostWithHeaders(serviceName: ADD_WISHLIST, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
                
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    
                    self.PropertyDetail()
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
        
 
    }
    

    func RemoveWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"user_id":login_session.value(forKey: "UserId")!,"property_id":self.wishPropertyid]
        
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(REMOVE_WISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                print("GET_WISHLIST_API Response:::",responseDict)
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                self.PropertyDetail()
                
                if mod.wishlist.count != 0
                {
                    
                    self.collectnviewWishlist.reloadData()
                }
                else
                {
                    
                    
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
    }
    
    
    
    
    
    @objc func starredbtnClick(sender: UIButton) {
        if self.NoOfLines == "Two"
        {
            self.NoOfLines = "More"
            
        }else{
            self.NoOfLines = "Two"
        }
        self.DetailTable.reloadData()
    }
    
    @objc func OverAllbtnClick(sender: UIButton) {
        self.grayView.isHidden = false
        self.ReviewsView.isHidden = false
        self.ReviewsCollection.reloadData()
    }
    
    @objc func AddonsBtnClicked(sender: UIButton) {
        
        if self.AddonsArray.count == 0 {
            self.showInformation(title: "Closest", message: " Addons are not available")

        }else{
            self.clicked = "Addons"
            self.DetailTable.reloadData()
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "AddonsViewController") as? AddonsViewController
            nav!.AddonsArray = self.AddonsArray
//            for i in 0..<AddonsSelectedDictValues.count{
//                let BundleId = "\((AddonsSelectedDictValues.object(at: i) as? NSDictionary)?.object(forKey: "id") as AnyObject)"
//                nav!.AddonsSelectedArray.add(BundleId)
//            }
            self.navigationController?.pushViewController(nav!, animated: true)
        }
    }
    @objc func BundleBtnClicked(sender: UIButton) {
        
        if BundleArray.count == 0 {
            self.showInformation(title: "Closest", message: " We don't have any Bundles to display")

        }else{
            self.clicked = "Bundle"
            self.DetailTable.reloadData()
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BundleAndSaveViewController") as? BundleAndSaveViewController
            nav!.BundleSelectedDict = BundleSelectedDictValues
            self.navigationController?.pushViewController(nav!, animated: true)
        }
    }
    @objc func PayLater(sender: UIButton) {
        
        
        print(AddonsSelectedDictValues)
        print(BundleSelectedDictValues)
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            
            let hostStatus = Singleton.sharedInstance.PropertyDetail.host_status
            let GuestStatus = Singleton.sharedInstance.PropertyDetail.guest_status
            let HostIdVerified = Singleton.sharedInstance.PropertyDetail.idVerified
            
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = Singleton.sharedInstance.PropertyDetail.hostId
            
            if hostStatus == "Inactive"  {
                self.showInformation(title: "Closest", message: "Host is not available")
            }else if GuestStatus == "Inactive" {
                self.showInformation(title: "Closest", message: "User is inactive.Please contact Admin")
            }
            else if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "You are not able to book your own Rental")
            }else if HostIdVerified == "No" {
                self.showInformation(title: "Closest", message: " Host is not verified yest ..!")
            }
            else{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewBookingViewController") as? NewBookingViewController
                nav!.currencySymbol = self.currencySymbol
                nav!.PropertyId = self.PropertyID
                nav!.DatesMutable = self.DatesMutable
                nav!.PaymentType = "pay_later"
                self.navigationController?.pushViewController(nav!, animated: true)
            }
        }else{
            self.LoginView.isHidden = false
        }
    }
    
    @objc func InstantPay(sender: UIButton) {
        
        
        print(AddonsSelectedDictValues)
        print(BundleSelectedDictValues)
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            
            let hostStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""//Singleton.sharedInstance.PropertyDetail.host_status!
            let GuestStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? "" //Singleton.sharedInstance.PropertyDetail.guest_status!
           // let HostIdVerified = Singleton.sharedInstance.PropertyDetail.idVerified!
            
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_id") as AnyObject//Singleton.sharedInstance.PropertyDetail.hostId
            
            if hostStatus == "Inactive"  {
                self.showInformation(title: "Closest", message: "Host is not available")
            }
//            else if GuestStatus == "Inactive" {
//                self.showInformation(title: "Closest", message: "User is inactive.Please contact Admin")
//            }
            else if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "You are not able to book your own Rental")
            }
//            else if HostIdVerified == "No" {
//                self.showInformation(title: "Closest", message: " Host is not verified yest ..!")
//            }
            else{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewBookingViewController") as? NewBookingViewController
                nav!.currencySymbol = self.currencySymbol
                nav!.PropertyId = self.PropertyID
                nav!.DatesMutable = self.DatesMutable
                nav!.PaymentType = "instant_pay"
                nav!.ProperdyDetails = self.ProperdyDetails
                //self.present(nav!, animated: true, completion: nil)
                navigationController?.pushViewController(nav!, animated: true)
            }
        }else{
            self.LoginView.isHidden = false
        }
    }
    
    @objc func RequestBook(sender: UIButton) {
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
            
            let hostStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""
            let GuestStatus = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_status") as? String ?? ""
         //   let HostIdVerified = Singleton.sharedInstance.PropertyDetail.idVerified!
            
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "host_id") as AnyObject
            
            if hostStatus == "Inactive" {
                self.showInformation(title: "Closest", message: "Host is not available")
            }else if GuestStatus == "Inactive" {
                self.showInformation(title: "Closest", message: "User is inactive.Please contact Admin")
            }
            else if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: "You are not able to book your own Rental")
            }
//            else if HostIdVerified == "No" {
//                self.showInformation(title: "Closest", message: " Host is not verified yest ..!")
//            }
            else{
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewBookingViewController") as? NewBookingViewController
                nav!.currencySymbol = self.currencySymbol
                nav!.PropertyId = self.PropertyID
                nav!.PaymentType = "RequestToBook"
                nav!.DatesMutable = self.DatesMutable
                nav!.ProperdyDetails = self.ProperdyDetails

                self.navigationController?.pushViewController(nav!, animated: true)
            }
        }else{
            self.LoginView.isHidden = false
        }
    }
    
    @objc func AminitiesViewAllAct(sender: UIButton) {
        
        self.clicked = "Aminities"
        self.DetailTable.reloadData()
        self.AminitiyTab.isHidden = false
        //self.AminitiesTableView.isHidden = false
        
        if ((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "list_details") as! NSArray).count > 10 {
            self.AminitiyViewHeight.constant = 450
        }else{
            self.AminitiyViewHeight.constant = CGFloat(((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "list_details") as! NSArray).count * 50) + 46
        }
        self.AminitiesDetailTable.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.AminitiesDetailTable {
            return 1
        }
        
        return 8
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.PropertyDetail != nil
        {
            
            if tableView == AminitiesDetailTable  {
                return 0
            }else{
                
                if self.ProperdyDetails.count == 0 {
                    return 0
                }else{
                    if section == 0 || section == 7
                    {
                        if self.ProperdyDetails.count == 0 {
                            return 0
                        }else{
                            return 1
                        }
                    }
                    else if section == 2 {
                        if Singleton.sharedInstance.PropertyDetail.couponDetails.count == 0 {
                            return 2
                        }else{
                            return 3
                        }
                    }else if section == 3 {
                        return detailsleftSideNamesArr.count + 2
                    }else if section == 5 {
                        if self.ProperdyDetails.count == 0 {
                            return 0
                        }else{
                            if (self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).count == 0{
                                return 7
                            }else{
                                return 7
                            }
                        }
                       
                    }else if section == 6 {
                        return 4
                    }
                    else
                    {
                        return 2
                    }
                }                }
                
                

            
        }else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.AminitiesDetailTable {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AminitiesDetailsTableViewCell") as? AminitiesDetailsTableViewCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "AminitiesDetailsTableViewCell") as? AminitiesDetailsTableViewCell
            cell.selectionStyle = .none
            cell.AminitiesNameLbl.font =  UIFont(name: RegularFont, size: 14)
            cell.AminitiesNameLbl.text = (((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "list_details") as! NSArray).object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_name") as? String ?? ""
            
            if "\((((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "list_details") as! NSArray).object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_available") as AnyObject)" == "1"{
                cell.AminitiesNameLbl.textColor = AppColor
            }else{
                cell.AminitiesNameLbl.textColor = .gray
            }
 
             return cell
        }else{
            if indexPath.section == 0
            {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdectDetailImageTableViewCell") as? ProdectDetailImageTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProdectDetailImageTableViewCell") as? ProdectDetailImageTableViewCell
                cell.selectionStyle = .none
                 
                cell.PriceLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell.ProductRating.font = UIFont(name: SemiBoldFont, size: 15)
                cell.ProductName.font = UIFont(name: SemiBoldFont, size: 18)
                cell.StartsLbl.font = UIFont(name: RegularFont, size: 16)
                cell.ProductLocation.font = UIFont(name: RegularFont, size: 15)
                cell.StartsLbl.font = UIFont(name: RegularFont, size: 15)
                cell.GuestCountLbl.font = UIFont(name: RegularFont, size: 15)
                 cell.ProductName.textColor = AppColor
                
                cell.LocImage.setImageColor(color: AppColor)
                cell.PriceLbl.textColor = AppColor
                
                cell.ProductRating.text =  "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "total_review_count") as AnyObject)"
                 if "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "total_review_count") as AnyObject)" == "0" {
                    cell.ProductRating.isHidden = true
                    cell.RatingImage.isHidden = true
                }else{
                    cell.ProductRating.isHidden = true
                    cell.RatingImage.isHidden = true
                }
                cell.GuestCountLbl.text = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "total_review_count") as AnyObject) Review"
                cell.ProductName.text =  "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "ren_title") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.defaultproducttitle
                cell.ProductLocation.text = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "address") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.address
                
                let price = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "productprice") as AnyObject)"
                cell.PriceLbl.text = "\(currencySymbol) \(price)/ day "
                
 
                
                let imgUpdated =  URL(string:"\((((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "product_image") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "product_image") as? String ?? "")")
                
                cell.ProductImage.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                
                let isfav = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "is_favourite") as! Bool
                
                if (isfav == true)
                {
                    cell.FavImg.image = UIImage(named: "FavNew")
                }
                else
                {
                    cell.FavImg.image = UIImage(named: "like-1")
                }
                 cell.FavBtn.tag = indexPath.row
                cell.FavBtn.addTarget(self, action:#selector(favTapped), for: .touchUpInside)
                
                
               
                return cell
            }else if indexPath.section == 2 {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_aboutSpace") as? String ?? ""
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else if indexPath.row == 1{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDescriptionTableViewCell") as? ProductDetailDescriptionTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDescriptionTableViewCell") as? ProductDetailDescriptionTableViewCell
                    cell.LaodMoreBtn.titleLabel?.font =  UIFont(name: RegularFont, size: 12)
                    cell.DescLbl.text = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "productdesc") as AnyObject)"
                    //Singleton.sharedInstance.PropertyDetail.productdesc
                    let count = cell.DescLbl.numberOfVisibleLines
                    print("NoOfLines",count)
                    
                    if self.NoOfLines == "2" {
                        cell.DescLbl.numberOfLines = 2
                        cell.LaodMoreBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_viewMore") as? String ?? "", for: .normal)
                    }else{
                        cell.DescLbl.numberOfLines = 0
                        cell.LaodMoreBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_viewless") as? String ?? "", for: .normal)
                    }
                    cell.LaodMoreBtn.isHidden = true
                    
                    if count <= 2 {
                        cell.LaodMoreBtn.isHidden = true
                    }else{
                        cell.LaodMoreBtn.isHidden = false
                    }
                    cell.selectionStyle = .none
                    cell.DescLbl.font = UIFont(name: RegularFont, size: 13)
                    cell.LaodMoreBtn.addTarget(self, action: #selector(starredbtnClick), for: .touchUpInside)
                    return cell
                }else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell") as? CouponTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell") as? CouponTableViewCell
                    cell.selectionStyle = .none
                    cell.CouponAvaLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.couponCodeLbl.font = UIFont(name: SemiBoldFont, size: 14)
                    cell.couponName.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.couponTimeLimit.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.daysLbl.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.hoursLbl.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.minLbl.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.secLbl.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.days.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.hours.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.min.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.sec.font = UIFont(name: SemiBoldFont, size: 15)
                    
                    
                    
                    
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd"
                    dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
                    cell.couponName.text =  String(format: " Coupon offer : %@ %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponPriceValue,"%")
                    cell.couponCodeLbl.text =  String(format: " Coupon code : %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponCode)
                    UIPasteboard.general.string = cell.couponCodeLbl.text
                    cell.couponTimeLimit.text =  String(format: "Time Limit : %@ to %@",Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDatefrom,Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDateto)
                    
                    let fromdate = Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDatefrom
                    let todate = Singleton.sharedInstance.PropertyDetail.couponDetails[0].couponDateto
                    //  let FromdateObj = dateFormatter1.date(from: fromdate)
                    let TodateObj = dateFormatter1.date(from: todate)
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
                    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
                    //according to date format your date string
                    guard let FromdateObj = dateFormatter.date(from: fromdate) else {
                        fatalError()
                    }
                    print(FromdateObj) //Convert String to Date
                    
                    
                    let dateFo : DateFormatter = DateFormatter()
                    dateFo.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFo.locale = Locale(identifier: "en_US_POSIX")
                    let dateString = dateFo.string(from: TodateObj!)
                    
                    
                    
                    
                    timeEnd = Date(timeInterval: dateString.toDate(format: "yyyy-MM-dd HH:mm:ss").timeIntervalSince(Date()), since: Date())
                    
                    let timeNow = Date()
                    let timeNoww = FromdateObj
                    if timeEnd?.compare(timeNow) == ComparisonResult.orderedDescending {
                        
                        
                        
                        let interval = timeEnd?.timeIntervalSince(timeNow)
                        let interval1 = timeEnd?.timeIntervalSince(timeNoww)
                        
                        let days =  (interval! / (60*60*24)).rounded(.down)
                        
                        let daysRemainder = interval?.truncatingRemainder(dividingBy: 60*60*24)
                        
                        let hours = (daysRemainder! / (60 * 60)).rounded(.down)
                        
                        let hoursRemainder = daysRemainder?.truncatingRemainder(dividingBy: 60 * 60).rounded(.down)
                        
                        let minites  = (hoursRemainder! / 60).rounded(.down)
                        
                        let minitesRemainder = hoursRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
                        
                        let scondes = minitesRemainder?.truncatingRemainder(dividingBy: 60).rounded(.down)
                        
                        
                        let formatter = NumberFormatter()
                        formatter.minimumIntegerDigits = 2
                        
                        
                        
                        cell.daysLbl.text = formatter.string(from: NSNumber(value:days + 1))
                        cell.hoursLbl.text =  formatter.string(from: NSNumber(value:hours))
                        cell.minLbl.text =  formatter.string(from: NSNumber(value:minites))
                        cell.secLbl.text =  formatter.string(from: NSNumber(value:scondes!))
                    }
                    else
                    {
                        cell.daysLbl.text = "00"
                        cell.hoursLbl.text =  "00"
                        cell.minLbl.text =  "00"
                        cell.secLbl.text =  "00"
                    }
                    
                    return cell
                }
                
            }
            else if indexPath.section == 1
            {
                
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_specification") as? String ?? ""
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProdctDetailSpeceficationsTableViewCell") as? ProdctDetailSpeceficationsTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProdctDetailSpeceficationsTableViewCell") as? ProdctDetailSpeceficationsTableViewCell
                    cell.selectionStyle = .none
                    
                    cell.YearLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.BathroomLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.lengthLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.speedLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.guestLbl.font = UIFont(name: RegularFont, size: 14)
                    cell.cabinsLbl.font = UIFont(name: RegularFont, size: 14)
                    
                    
                    let listingInfo = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "listing_info") as! NSArray
                    
                    let attrs1 = [NSAttributedStringKey.font : UIFont(name: SemiBoldFont, size: 18), NSAttributedStringKey.foregroundColor : UIColor.black]

                        let attrs2 = [NSAttributedStringKey.font : UIFont(name: SemiBoldFont, size: 16), NSAttributedStringKey.foregroundColor : UIColor.lightGray]

                    
                    if listingInfo.count != 0 {
                        
                            let attributedString1 = NSMutableAttributedString(string:"\(((listingInfo.object(at: 0) as? NSDictionary)?.object(forKey: "value") as? String ?? ""))", attributes:attrs1)

                            let attributedString2 = NSMutableAttributedString(string:"\n\(((listingInfo.object(at: 0) as? NSDictionary)?.object(forKey: "label") as? String ?? ""))", attributes:attrs2)

                         cell.YearLbl.numberOfLines = 0
                        attributedString1.append(attributedString2)
                        cell.YearLbl.textAlignment = .left

                            cell.YearLbl.attributedText = attributedString1
                    }
                    
                  
                    if listingInfo.count >= 2 {
                        let attributedString3 = NSMutableAttributedString(string:"\(((listingInfo.object(at: 1) as? NSDictionary)?.object(forKey: "value") as? String ?? ""))", attributes:attrs1)

                        let attributedString4 = NSMutableAttributedString(string:"\n\(((listingInfo.object(at: 1) as? NSDictionary)?.object(forKey: "label") as? String ?? ""))", attributes:attrs2)

                        attributedString3.append(attributedString4)
                        cell.BathroomLbl.numberOfLines = 0
                        cell.BathroomLbl.textAlignment = .left

                        cell.BathroomLbl.attributedText = attributedString3
                    }
                   
                    if listingInfo.count >= 3 {
                        let attributedString5 = NSMutableAttributedString(string:"\(((listingInfo.object(at: 2) as? NSDictionary)?.object(forKey: "value") as? String ?? ""))", attributes:attrs1)

                        let attributedString6 = NSMutableAttributedString(string:"\n\(((listingInfo.object(at: 2) as? NSDictionary)?.object(forKey: "label") as? String ?? ""))", attributes:attrs2)
                        
                        
                        attributedString5.append(attributedString6)
                        cell.lengthLbl.numberOfLines = 0
                        cell.lengthLbl.textAlignment = .left

                        cell.lengthLbl.attributedText = attributedString5
                    }

                   
                    if listingInfo.count >= 4 {
                        let attributedString7 = NSMutableAttributedString(string:"\(((listingInfo.object(at: 3) as? NSDictionary)?.object(forKey: "value") as? String ?? ""))", attributes:attrs1)

                        let attributedString8 = NSMutableAttributedString(string:"\n\(((listingInfo.object(at: 3) as? NSDictionary)?.object(forKey: "label") as? String ?? ""))", attributes:attrs2 as [NSAttributedStringKey : Any])
                        cell.speedLbl.textAlignment = .left

                        
                        attributedString7.append(attributedString8)
                        cell.speedLbl.numberOfLines = 0

                        cell.speedLbl.attributedText = attributedString7
                    }
                    
                    
                 
                    cell.fifthView.isHidden = true
                    cell.SixthView.isHidden = true


                    return cell
                }
            }
            else if indexPath.section == 3
            {
                if indexPath.row == 0 {
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_details") as? String ?? ""
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else if indexPath.row == 6 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPagePriceTableViewCell") as? DetailPagePriceTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPagePriceTableViewCell") as? DetailPagePriceTableViewCell
                    cell.selectionStyle = .none
                    cell.PriceHeader.text = GlobalLanguageDictionary.object(forKey: "key_priceDetails") as? String ?? ""
                    cell.PriceHeader.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.PriceLbl.font = UIFont(name: SemiBoldFont, size: 14)
                    cell.SecurityDepositLbl.font = UIFont(name: SemiBoldFont, size: 14)

                    let price = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "productprice") as AnyObject)"
                    
                    cell.PriceLbl.text = "\(GlobalLanguageDictionary.object(forKey: "Key_sprice") as? String ?? "") : \(currencySymbol) \(price) / \(GlobalLanguageDictionary.object(forKey: "Key_day") as? String ?? "")"
                    let secDep = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "security_deposit") as AnyObject)"


                    cell.SecurityDepositLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_securityDeposit") as? String ?? "") : \(currencySymbol) \(secDep)"
                    return cell
                }else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFeatureTableViewCell") as? DetailFeatureTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "DetailFeatureTableViewCell") as? DetailFeatureTableViewCell
                    cell.selectionStyle = .none
                    cell.FeatureTitle.text = self.detailsleftSideNamesArr[indexPath.row-1] as? String ?? ""
                    cell.FeatureDesc.text = self.detailsDescArr[indexPath.row-1] as? String
                    return cell
                }
            }
            else if indexPath.section == 4
            {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_PhotoGallery") as? String ?? ""
                    cell.BaseTitle.textColor = .black

                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailGalleryTableViewCell") as? ProductDetailGalleryTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailGalleryTableViewCell") as? ProductDetailGalleryTableViewCell
                    cell.selectionStyle = .none
                    let ImagesArr = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "product_image") as! NSArray
                    cell.DataReload(array: ImagesArr)
                    cell.GalleryCollection.reloadData()
                    return cell
                }
            }
            else if indexPath.section == 5
            {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_AllAminities") as? String ?? ""
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 18)
                    return cell
                }
                else if indexPath.row == 1 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewAminitiesTableViewCell") as? NewAminitiesTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewAminitiesTableViewCell") as? NewAminitiesTableViewCell
                    cell.selectionStyle = .none
                    let Aminities : NSMutableArray = []
                     Aminities.addObjects(from: ((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "list_details") as? NSArray) as? [Any] ?? [])
                    cell.Aminities(Name: Aminities)
 
                    return cell
                }
                else if indexPath.row == 2 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewAminitiesCell") as? NewAminitiesCell else { return UITableViewCell() }

//                                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewAminitiesCell") as? NewAminitiesCell
                                    cell.selectionStyle = .none
                                    cell.AddonsView.addShadow()
                    cell.AddonsView.backgroundColor = AppColor
                                    cell.AddonsView.layer.borderWidth = 1
                                    cell.AddonsView.layer.borderColor = AppSecondColor.cgColor
                                    cell.AddonsTitleLbl.font = UIFont(name: SemiBoldFont, size: 16)
                                    cell.AddonsViewLbl.font = UIFont(name: SemiBoldFont, size: 15)
                    cell.AddonsTitleLbl.text = GlobalLanguageDictionary.object(forKey: "key_addons") as? String ?? ""
                    cell.AddonsViewLbl.text = GlobalLanguageDictionary.object(forKey: "key_select") as? String ?? ""

                                    cell.AddonsLbl.font = UIFont(name: SemiBoldFont, size: 12)
                                    cell.AddonsBtn.addTarget(self,action:#selector(AddonsBtnClicked), for: .touchUpInside)
                                    return cell
                
                                }
                else if indexPath.row == 3 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "Key_location") as? String ?? ""
                    cell.BaseTitle.textColor = .black

                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else if indexPath.row == 4{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailMapTableViewCell") as? ProductDetailMapTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailMapTableViewCell") as? ProductDetailMapTableViewCell
                    cell.selectionStyle = .none
                    let lat = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "latitude") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.latitude
                    let long = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "longitude") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.longitude
                    let center = CLLocationCoordinate2D(latitude: Double(lat)! , longitude: Double(long)!)
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    cell.mapLocation.setRegion(region, animated: true)
                    newPin.coordinate =  center
                    cell.mapLocation.addAnnotation(newPin)
                    
                    return cell
                }else if indexPath.row == 5 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "Key_reviews") as? String ?? ""
                    cell.BaseTitle.textColor = .black

                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }
                else{
                    if (self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).count == 0{
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                        cell.selectionStyle = .none
                        cell.BaseTitle.textAlignment = .center
                        cell.BaseTitle.textColor = .gray

                        cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "Key_NoResultsFound") as? String ?? ""
                        cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 15)
                        return cell
                    }else{
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewDetailPageReviewTableViewCell") as? NewDetailPageReviewTableViewCell else { return UITableViewCell() }

//                        let cell = tableView.dequeueReusableCell(withIdentifier: "NewDetailPageReviewTableViewCell") as! NewDetailPageReviewTableViewCell
                        cell.selectionStyle = .none
                        cell.ReviewTitle.font = UIFont(name: SemiBoldFont, size: 15)
                        cell.OverAllRatLbl.font = UIFont(name: SemiBoldFont, size: 15)
                        cell.OverAllReviewBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
                        
                        let hitCount = "\(((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "over_all_rating") as AnyObject))"
                        let data :AnyObject = hitCount as AnyObject //sometime Xcode will ask value type
                        let score = Int(data as? String ?? "") ?? 0
                        cell.RatingView.rating = Float(score)
                        
                        self.ReviewsRatingView.rating = Float(score)
                        cell.ReviewMsg.font = UIFont(name: SemiBoldFont, size: 13)
                        cell.ReviewerName.font = UIFont(name: SemiBoldFont, size: 16)
                        cell.ReviewDate.font = UIFont(name: SemiBoldFont, size: 13)
                        
                        cell.ReviewerName.textColor = AppColor
                        
                        
                        
                        cell.ReviewMsg.text = "\((((self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "review_comment") as AnyObject))"
                        cell.ReviewerName.text = "\((((self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "review_user_name") as AnyObject))".uppercased()
                        cell.ReviewDate.text = "\((((self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "review_added_date") as AnyObject))"
                        
                        let ImageUrl = URL(string: "\((((self.ProperdyDetails.object(forKey: "property_reviews") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "review_user_img") as AnyObject))")
                        
                        cell.ReviewImg.setImageWith(ImageUrl!, placeholderImage: UIImage(named: "user"))
                        
                      
                        
                        cell.OverAllReviewBtn.addTarget(self,action:#selector(OverAllbtnClick), for: .touchUpInside)
                        cell.ReviewCollectionView.reloadData()
                        
                        cell.ReviewCollectionViewHeight.constant = cell.ReviewCollectionView.collectionViewLayout.collectionViewContentSize.height
                        
                        
                        return cell

                    }
                }
                
                
            }
            else if indexPath.section == 6
            {
                if indexPath.row == 0 {
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "Key_cancellationPolicy") as? String ?? ""
                    cell.BaseTitle.textColor = .black

                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else if indexPath.row == 1 {
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "cancel_policy_desc") as AnyObject)"
                    cell.BaseTitle.textColor = .gray
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 14)
                    return cell
                }
                if indexPath.row == 2 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailTitleTableViewCell") as? ProductDetailTitleTableViewCell
                    cell.selectionStyle = .none
                    cell.BaseTitle.text = GlobalLanguageDictionary.object(forKey: "key_host") as? String ?? ""
                    cell.BaseTitle.font = UIFont(name: SemiBoldFont, size: 16)
                    return cell
                }else{
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailHostTableViewCell") as? ProductDetailHostTableViewCell else { return UITableViewCell() }

//                    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailHostTableViewCell") as? ProductDetailHostTableViewCell
                    cell.selectionStyle = .none
                    cell.HostImage.contentMode = .scaleToFill
                    cell.HostImage.layer.cornerRadius = 45.0
                    cell.HostedByLbl.font = UIFont(name: RegularFont, size: 13)
                    cell.HostNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                    cell.JoinDateLbl.font = UIFont(name: RegularFont, size: 13)
                    cell.JoinDateLbl.backgroundColor = AppColor
                    cell.HostNameLbl.textColor = AppColor
                    cell.HostedByLbl.text = GlobalLanguageDictionary.object(forKey: "key_hostedBy") as? String ?? ""
                    cell.HostNameLbl.text = "\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "hostname") as AnyObject)"//Singleton.sharedInstance.PropertyDetail.hostname
                    
                    cell.selectionStyle = .none
                    
                    if Singleton.sharedInstance.PropertyDetail.hostimg != nil
                    {
                        
                        
                        let imgUpdated = URL(string:"\((self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "hostimg") as AnyObject)")
                        cell.HostImage.kf.setImage(with: imgUpdated, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                        
                        cell.HostImage.layer.masksToBounds = true
                    }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
 
                    
                    return cell
                }
            }
            else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBookingTypeTableViewCell") as? ProductDetailBookingTypeTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailBookingTypeTableViewCell") as? ProductDetailBookingTypeTableViewCell
                cell.selectionStyle = .none
                
                
 
                
                if self.instantPayStatusValue == "1"
                {
                    cell.InstantPayBtn.isHidden = false
                }else{
                    cell.InstantPayBtn.isHidden = true

                }
                
                if self.reqToBookStatusValue == "true" {
                    cell.RequestBtn.isHidden = false
                    cell.PayLaterViewHeight.constant = 50


                }else{
                    cell.RequestBtn.isHidden = true
                    cell.PayLaterViewHeight.constant = 0


                }
                
                if self.payLaterStatusValue == "1" {
                 }else{
                    cell.PayLaterBtn.isHidden = true
                }
                      
                cell.PayBtn.isHidden = true

                
                cell.InstantPayBtn.setTitle("BOOK & PAY NOW", for: .normal)
                cell.PayLaterBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                
                cell.RequestBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                cell.InstantPayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                cell.PayBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                cell.InstantPayBtn.addTarget(self, action: #selector(InstantPay), for: .touchUpInside)
                cell.PayLaterBtn.addTarget(self, action: #selector(PayLater), for: .touchUpInside)
                
                cell.RequestBtn.addTarget(self, action: #selector(RequestBook), for: .touchUpInside)
                return cell
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            if indexPath.row == 0 {
                return 0
            }
            else if indexPath.row == 8 {
                return UITableViewAutomaticDimension
            }else{
                if self.detailsDescArr[indexPath.row-1] as? String ?? "" == "" {
                    return 0
                }else{
                    return UITableViewAutomaticDimension
                }
            }
        }else if indexPath.section == 1 {
            let listingInfo = (self.ProperdyDetails.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "listing_info") as! NSArray
            
            if listingInfo.count == 0 {
                return 0
            }else if listingInfo.count >= 2{
                return 115
            }else{
                return 185
            }
        }
        else if indexPath.section == 7 {
//            if self.reqToBookStatusValue == "true" {
//                return 120
//            }else{
//                    return 60
//                }
            return 0
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 0
            }else{
                return UITableViewAutomaticDimension
            }
        }
        return UITableViewAutomaticDimension
    }
}
extension NewProductDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectnviewWishlist {
            if Singleton.sharedInstance.wishListModel != nil
            {
                return Singleton.sharedInstance.wishListModel.wishlist.count
            }
            else
            {
                return 0
            }
        }else{
            if Singleton.sharedInstance.PropertyDetail != nil {
                return Singleton.sharedInstance.PropertyDetail.propertyReviews.count
            }else{
                return 0
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectnviewWishlist {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
            cell.lbl_WishlistName.text = Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistTitle
            cell.lbl_WishlistName.font = UIFont(name: SemiBoldFont, size: 13)
            cell.lbl_wishlistcount.font = UIFont(name: SemiBoldFont, size: 13)
            let wishlistImgUrl = URL(string: Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistImage)
            if wishlistImgUrl != nil {
                //cell.img_Wishlist.kf.setImage(with: wishlistImgUrl!)
                cell.img_Wishlist.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPageReviewsCollectionViewCell", for: indexPath) as! DetailPageReviewsCollectionViewCell
            
            cell.ReviewMsg.font = UIFont(name: SemiBoldFont, size: 13)
            cell.ReviewerName.font = UIFont(name: SemiBoldFont, size: 16)
            cell.ReviewDate.font = UIFont(name: SemiBoldFont, size: 13)
            
            cell.ReviewerName.textColor = AppColor
            
            cell.ReviewMsg.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].review
            
            
            
            cell.ReviewerName.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userName.uppercased()
            cell.ReviewDate.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].reviewDate
            
            let ImageUrl = URL(string: Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userImage)
            
            cell.ReviewImg.setImageWith(ImageUrl!, placeholderImage: UIImage(named: "user"))
            
            cell.RatingView.rating = Float(Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].starRating! as! NSNumber)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == collectnviewWishlist {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
            self.wishListId = "\(Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistId)"
            AddWishList()
            self.viewBottom.isHidden = true
            self.grayView.isHidden = true
            self.collectnviewWishlist.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectnviewWishlist {
            return CGSize(width: 150, height: collectionView.contentSize.height)
            
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.contentSize.height)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 20
    }
}
extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

