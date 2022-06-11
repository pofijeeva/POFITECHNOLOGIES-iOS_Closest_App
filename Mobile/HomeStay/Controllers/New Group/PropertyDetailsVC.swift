//
//  PropertyDetailsVC.swift
//  HomeStay
//
//  Created by pofiapple10 on 21/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit


class PropertyDetailsVC: BaseViewController {
    
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var dayPriceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var Locimg: UIImageView!
    
    @IBOutlet weak var inameLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var ilocationLbl: UILabel!
    @IBOutlet weak var totalBookingsLbl: UILabel!
    @IBOutlet weak var cancelledLbl: UILabel!
    @IBOutlet weak var receivedLbl: UILabel!
    @IBOutlet weak var totalEarningsLbl: UILabel!
    @IBOutlet weak var earningpermonthLbl: UILabel!
    @IBOutlet weak var earningTitle: UILabel!
    
    @IBOutlet weak var bookedCustomeersBtn: UIButton!
    var isLoading:Bool = true
    var currentPage = 1
    var ReservationData = NSMutableDictionary()
    
    var propertyModel: MyreservationDetailModel?
    var detailResponseModel: property_detailsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Locimg.setImageColor(color: AppColor)
        self.bookedCustomeersBtn.backgroundColor = AppColor
        self.headerLbl.font = UIFont(name: SemiBoldFont, size: 20)
        
        self.dayPriceLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.nameLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.textLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.inameLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.ilocationLbl.font = UIFont(name: SemiBoldFont, size: 11)
        self.totalBookingsLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.cancelledLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.receivedLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.totalEarningsLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.receivedLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.earningTitle.font = UIFont(name: SemiBoldFont, size: 15)
        self.bookedCustomeersBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17
        )
        self.headerLbl.text = GlobalLanguageDictionary.object(forKey: "key_myPropertyDetails") as? String ?? ""
        self.bookedCustomeersBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_viewBookedCust") as? String ?? "", for: .normal)
        
        self.dayPriceLbl.textColor = AppColor
        bookedCustomeersBtn.layer.cornerRadius = 6
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.black.cgColor
        img.layer.cornerRadius = img.frame.height/2
        img.clipsToBounds = true
        self.earningTitle.text = GlobalLanguageDictionary.object(forKey: "key_earingsmonth") as? String ?? ""
        
        self.getNotificationListApiCall()
        
        // Do any additional setup after loading the view.
    }
    
    func populateData() {
        
        
        let imgURL =  (self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "ren_image") as? String ?? ""
        
        self.proImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.dayPriceLbl.text = "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "price_list") as AnyObject)"
        self.dayPriceLbl.attributedText  = totalBookingAttributeString(harcodName: "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "price_list") as AnyObject)", name: "  / \(GlobalLanguageDictionary.object(forKey: "Key_day") as? String ?? "")", firstStringColor: AppColor)
        
        self.nameLbl.text = "\((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "ren_title") as AnyObject)"
        self.textLbl.text = (self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "ren_summary") as? String ?? ""
        
        //            let imggURL =  model.ren_image ?? ""
        self.img.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        self.inameLbl.text = (self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "name") as? String ?? ""
        self.ilocationLbl.text = "\((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "address") as AnyObject)"
        self.totalBookingsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.cancelledLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.receivedLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.totalEarningsLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.totalBookingsLbl.attributedText =  totalBookingAttributeString(harcodName: "\(GlobalLanguageDictionary.object(forKey: "key_totalBooking") as? String ?? "")  ", name: "\((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "booking_count") as AnyObject)")
        self.cancelledLbl.attributedText = totalBookingAttributeString(harcodName: "\(GlobalLanguageDictionary.object(forKey: "key_CcancelledBooking") as? String ?? "")  ", name: "\((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "cancel_bk_count") as AnyObject)")
        self.receivedLbl.attributedText = totalBookingAttributeString(harcodName: "\(GlobalLanguageDictionary.object(forKey: "key_received") as? String ?? ""):  ", name: "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "received_amnt") as AnyObject)", secondStringColor: AppColor)
        self.totalEarningsLbl.attributedText =  totalBookingAttributeString(harcodName: "\(GlobalLanguageDictionary.object(forKey: "key_totalEarnings") as? String ?? ""):  ", name: "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "total_amnt") as AnyObject)")
        self.earningpermonthLbl.text =  "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.ReservationData.object(forKey: "property_details") as? NSDictionary)?.object(forKey: "month_amnt") as AnyObject)"
        
    }
    func totalBookingAttributeString(harcodName: String, name: String, firstStringColor: UIColor =  UIColor.black, secondStringColor: UIColor = UIColor.black) -> NSAttributedString {
        let finalAttributeString = NSMutableAttributedString()
        let attributedString = NSAttributedString(string: harcodName,
                                                  attributes:[NSAttributedString.Key.foregroundColor: firstStringColor,
                                                              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13) as Any])
        finalAttributeString.append(attributedString)
        let secondString = NSAttributedString(string:name,
                                              attributes:[NSAttributedString.Key.foregroundColor: secondStringColor,
                                                          
                                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11) as Any])
        finalAttributeString.append(secondString)
        return finalAttributeString
    }
    func getNotificationListApiCall() {
        showActivityIndicator(uiView: self.view)
        
        //self.showHUD(progressLabel: "")
        let model = self.propertyModel
        let pid = model?.property_id
        let parameters:[String : Any] =
        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
         "page_no": 1,
         "property_id": pid ?? 0,
         "currency_code": "USD"
        ]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: PROPERTY_DETAILS, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  self.hideActivityIndicator(uiView: self.view) }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json ?? [:]
            print(responseDict)
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                self.ReservationData.removeAllObjects()
                self.ReservationData.addEntries(from: (responseDict.object(forKey: "data") as? NSDictionary) as? [AnyHashable : Any] ?? [:])
                self.populateData()
                
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
            
        }
    }
    func getPropertyDetailsResponse(params: [String:Any]){
        
        if (Reachability()?.isReachable ?? false) {
            showActivityIndicatorFullScreen(uiView: self.view)
            print(params)
            APIManager.apiPostWithHeadersCodable(serviceName: PROPERTY_DETAILS, parameters:params) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    let propertyModel = try JSONDecoder().decode(propertyDetailsModel.self, from: data)
                    
                    if let responseCode = propertyModel.code, responseCode == 200 {
                        if let propertyDetailModel =  propertyModel.data?.property_details {
                            self.detailResponseModel = propertyDetailModel
                            self.populateData()
                        }
                    } else {
                        //                        self.isLoading = false
                        self.showInformation(title: "Error", message: propertyModel.message ?? "")
                    }
                } catch {
                    print("error reading JSON: \(error)")
                }
            }
            
        } else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookedCustomersAct(_ sender: Any) {
        if (self.ReservationData.object(forKey: "booking_list") as! NSArray).count == 0 {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_donthavebookedcust") as? String ?? "")
        }else{
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "BookedCustomerVC") as? BookedCustomerVC
            if let model = self.propertyModel, let pid = model.property_id {
                nav?.properytId = pid
                self.navigationController?.pushViewController(nav!, animated: true)
            }
        }
    }
}
