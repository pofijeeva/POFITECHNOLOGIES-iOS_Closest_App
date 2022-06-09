//
//  NewSideMenuDetailController.swift
//  HomeStay
//
//  Created by CIFCL on 02/01/22.
//  Copyright © 2022 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit


struct MenuDetailModel {
    let title: String
    let imageName: String
    let menuType: Menu
}
protocol NewSideMenuProtocol {
    func showPopUp(type: Menu)
    
}
class NewSideMenuDetailController: BaseViewController {
    
    @IBOutlet weak var slideMenuTableView: UITableView!
    var detailArray = [MenuDetailModel]()
    var delegate: NewSideMenuProtocol?
    
    var idProofVerify = String()
    var emailVerify = String()
    var phoneVerify = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        constructArray()
        self.getUserInfo()
        self.slideMenuTableView.delegate = self
        self.slideMenuTableView.dataSource = self
        self.slideMenuTableView.register(UINib(nibName: "NewSideMenuDetailCell", bundle: nil), forCellReuseIdentifier: "NewSideMenuDetailCell")
        self.slideMenuTableView.register(UINib(nibName: "NewSideMenuHeaderCell", bundle: nil), forCellReuseIdentifier: "NewSideMenuHeaderCell")
        // Do any additional setup after loading the view.
    }
    
    // USER_INFO_API
     func getUserInfo() {
         let parameters:[String : Any] =
                     ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en"]
                 print(parameters)
                         APIManager.apiPostWithHeaders(serviceName: USER_INFO_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                     DispatchQueue.main.async {  }
                     if error != nil {
                         print(error!.localizedDescription)
                         self.showInformation(title: "Closest", message: error!.localizedDescription)
                         return
                     }
                     let responseDict:NSDictionary = json!
                     print(responseDict)
                     if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.phoneVerify = "\(((responseDict.value(forKey: "data") as! NSDictionary).object(forKey: "user_details") as! NSDictionary).object(forKey: "phone_verified") as AnyObject)"
                        self.emailVerify = "\(((responseDict.value(forKey: "data") as! NSDictionary).object(forKey: "user_details") as! NSDictionary).object(forKey: "email_id_verified") as AnyObject)"
                        self.idProofVerify = "\(((responseDict.value(forKey: "data") as! NSDictionary).object(forKey: "user_details") as! NSDictionary).object(forKey: "u_idproof_verified_status") as AnyObject)"
                     
                     }
                     else
                     {
                         
                          self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                      }
                     
                 
     }
     }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_AddlistingInfo") as! String,         preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as! String, style: UIAlertActionStyle.default, handler: { _ in
            //Cancel Action
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "key_verifyNow") as! String,
                                      style: UIAlertActionStyle.default,
                                      handler: {(_: UIAlertAction!) in
                                        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "NewProfileViewController") as? NewProfileViewController
                                        self.navigationController?.pushViewController(navgt!, animated: true)
                                        
                                        
                                        //Sign out action
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    func constructArray() {
        
        
        let home = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_home") as! String, imageName: "Group 3700", menuType: .HOME)
        let profile = MenuDetailModel(title: "My Profile", imageName: "Group 3700", menuType: .MYPROFILE)
        let inbox = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_inbox") as! String, imageName: "journalText", menuType: .INBOX)
        let listing = MenuDetailModel(title: "Add Listing", imageName: "journalText", menuType: .ADDLISTING)
        let listings = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_mylisting") as! String, imageName: "journalText", menuType: .MYLISTING)
        let booking = MenuDetailModel(title: "My Bookings", imageName: "journalText", menuType: .MYBOOKINGS)
        let property = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_propertyReservation") as! String, imageName: "journalText", menuType: .MYPROPERTYRES)
        let wishList = MenuDetailModel(title: "Wishlist", imageName: "journalText", menuType: .WISHLIST)
        let reportAndCancel = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_reportCancel") as! String, imageName: "journalText", menuType: .REPORTORCANCEL)
        let myReview = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_review") as! String, imageName: "journalText", menuType: .MYREVIEW)
        let paymentDetail = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_paymentDetails") as! String, imageName: "cardListNew", menuType: .PAYMENTDETAILS)
        let coupons = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_coupons") as! String, imageName: "GiftNew", menuType: .COUPONS)
        let language = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_language") as! String, imageName: "journalText", menuType: .LANGUAGE)
        let currency = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_currency") as! String, imageName: "journalText", menuType: .CURRENCY)
        let contactUs = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_contactUs") as! String, imageName: "cardListNew", menuType: .CONTACTUS)
        let logout = MenuDetailModel(title: GlobalLanguageDictionary.object(forKey: "key_logout") as! String, imageName: "logoutNew", menuType: .LOGOUT)
        self.detailArray = [home, inbox, listings , property,  reportAndCancel, myReview, paymentDetail, coupons, language, currency , contactUs , logout]
        
        
    }
    func LogoutApi()  {
        self.showActivityIndicator(uiView: self.view)
        //self.showHUD(progressLabel: "")
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "type":"ios"]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: REQ_LOGOUT, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
            
            DispatchQueue.main.async {
                self.hideActivityIndicator(uiView: self.view)
            }
            if error != nil {
                print(error!.localizedDescription)
                self.showInformation(title: "Closest", message: error!.localizedDescription)
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
                
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    
                    
                    login_session.set(false, forKey: "IS_USER_LOGGEDIN")
                    let Currency = "\(login_session.value(forKey: "APP_CURRENCY"))"
                    let CurrencySymbol = "\(login_session.value(forKey: "APP_CURRENCY_SYMBOL"))"
                    let langKey = "\(login_session.value(forKey: "Language") as AnyObject)"

                    let isRemembred =  UserDefaults.standard.bool(forKey: "isRememberPassword")
                    if UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") != nil{
                        let UserName = UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") as! String
                        let Password = UserDefaults.standard.value(forKey: "APP_LOGIN_PASSWORD") as! String
                        let Fcmkey = UserDefaults.standard.value(forKey: "fcmToken") as! String
                        
                        
                        clearUserSession()
                        
                        login_session.setValue(langKey, forKey: "Language")

                        login_session.setValue(Currency, forKey: "APP_CURRENCY")
                        login_session.setValue(CurrencySymbol , forKey: "APP_CURRENCY_SYMBOL")
                        UserDefaults.standard.setValue(isRemembred, forKey: "isRememberPassword")
                        UserDefaults.standard.set(UserName, forKey: "APP_LOGIN_EMAIL")
                        UserDefaults.standard.set(Password, forKey: "APP_LOGIN_PASSWORD")
                        UserDefaults.standard.set(Fcmkey, forKey: "fcmToken")
                        
                    }else{
                        clearUserSession()
                        login_session.setValue(langKey, forKey: "Language")

                    }
                    
                    let AppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    AppDelegate.LogOut()
                    
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
    }
    
    
    
    
}
extension NewSideMenuDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return detailArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "NewSideMenuHeaderCell", for: indexPath) as? NewSideMenuHeaderCell else { return UITableViewCell() }
            headerCell.userImage?.image = UIImage(named: "accommodates")
            headerCell.userImage?.setImageColor(color: AppColor)
            
            headerCell.nameLbl.text  = login_session.string(forKey: "Firstname")
            headerCell.emailLbl.text = login_session.string(forKey: "Email")
            return headerCell
        default:
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "NewSideMenuDetailCell", for: indexPath) as? NewSideMenuDetailCell else { return UITableViewCell() }
            let model = detailArray[indexPath.row]
            detailCell.imageName?.image = UIImage(named: model.imageName)
            detailCell.titleLbl?.text = model.title
            return detailCell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = detailArray[indexPath.row]
        switch  model.menuType{
        
        case .LOGOUT:
            
            let refreshAlert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_logoutSuccessfully") as! String, preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "ok") as! String, style: .default, handler: { [self] (action: UIAlertAction!) in
                LogoutApi()
                
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            
            
            
        case .HOME:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabBarViewController") as? HomeTabBarViewController
            self.navigationController?.pushViewController(nav!, animated: true)
            
            
        case .MYPROFILE:
            let npStoryboard = UIStoryboard(name: "NewProfile", bundle: nil)
            guard let nav = npStoryboard.instantiateInitialViewController() as? NewProfileViewController else { return  }
            self.navigationController?.pushViewController(nav, animated: true)
            
            
            
        case .INBOX:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "InboxMessagesVC") as? InboxMessagesVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
            
        case .ADDLISTING:
            if self.phoneVerify == "1" && self.emailVerify == "1" && self.idProofVerify == "1" {
                let nav = self.storyboard?.instantiateViewController(withIdentifier: "RentYourSpaceViewController") as? RentYourSpaceViewController
                self.navigationController?.pushViewController(nav!, animated: true)
            }else{
                self.showSimpleAlert()
            }
           
            
            
        case .MYLISTING:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyListingViewController") as? PropertyListingViewController
            self.navigationController?.pushViewController(nav!, animated: true)
            
            
        case .MYBOOKINGS:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "MyBookingsVC") as? MyBookingsVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
            
        case .MYPROPERTYRES:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyReservationVC") as? PropertyReservationVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
            
        case .WISHLIST:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "WishlistVC") as? WishlistVC
            self.navigationController?.pushViewController(nav!, animated: true)
            //nav?.SelectedId = 1
            break
            
        case .REPORTORCANCEL:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "Report_CancelVC") as? Report_CancelVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
        case .MYREVIEW:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "MyReviewVC") as? MyReviewVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
        case .PAYMENTDETAILS:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDetailsVC") as? PaymentDetailsVC
            self.navigationController?.pushViewController(nav!, animated: true)
            
        case .COUPONS:
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "CouponsViewController") as? CouponsViewController
            self.navigationController?.pushViewController(nav!, animated: true)
        case .LANGUAGE:
            
            
                let theme = YBTextPickerAppearanceManager.init(
                    pickerTitle         : GlobalLanguageDictionary.object(forKey: "key_language")as? String,
                    titleFont           : UIFont(name: SemiBoldFont, size: 15),
                    titleTextColor      : .white,
                    titleBackground     : AppColor,
                    searchBarFont       : UIFont(name: SemiBoldFont, size: 15),
                    searchBarPlaceholder: GlobalLanguageDictionary.object(forKey: "key_search_language")as? String,
                    closeButtonTitle    : GlobalLanguageDictionary.object(forKey: "Key_cancel")as? String,
                    closeButtonColor    : .darkGray,
                    closeButtonFont     : UIFont(name: SemiBoldFont, size: 15),
                    doneButtonTitle     : GlobalLanguageDictionary.object(forKey: "ok")as? String,
                    doneButtonColor     : AppColor,
                    doneButtonFont      : UIFont(name: SemiBoldFont, size: 15),
                    checkMarkPosition   : .Right,
                    itemCheckedImage    :  UIImage(named:"radiobtnselected"),
                    itemUncheckedImage  : UIImage(named:"radiobtndeselected"),
                    itemColor           : .black,
                    itemFont            : UIFont(name: SemiBoldFont, size: 15)
                )
                
                let arrTheme = [GlobalLanguageDictionary.object(forKey: "key_english") as! String,GlobalLanguageDictionary.object(forKey: "key_arabic") as! String]
                let picker = YBTextPicker.init(with: arrTheme, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
                    if let selectedValue = selectedValues.first{
                        print(selectedValue)
                        var langCode = String()

                        if selectedValue == GlobalLanguageDictionary.object(forKey: "key_english") as! String{
                             langCode = "en"

                            login_session.setValue("en", forKey: "Language")
                            //languageString = "en"
                        }else if selectedValue == GlobalLanguageDictionary.object(forKey: "key_arabic") as! String{
                            login_session.setValue("ar", forKey: "Language")
                            langCode = "ar"
                        }
                        
                       
                         login_session.setValue(langCode, forKey: "Language")
                        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                        appDelegate?.languageUpdate1()
                        }else{
                    }
                }, onCancel: {
                })
                picker.show(withAnimation: .FromBottom)

            
            
//            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {
//                nav.type = .language
//                self.navigationController?.pushViewController(nav, animated: true)
//            }
        case .CURRENCY:
            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {
                
                nav.type = .currency
                
                self.navigationController?.pushViewController(nav, animated: true)
                
            }
        case .CONTACTUS:
            break
//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController
//            self.navigationController?.pushViewController(nav!, animated: true)
        }
    }
}
