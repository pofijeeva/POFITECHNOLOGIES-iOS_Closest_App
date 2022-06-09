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
    override func viewDidLoad() {
        super.viewDidLoad()
        constructArray()
        self.slideMenuTableView.delegate = self
        self.slideMenuTableView.dataSource = self
        self.slideMenuTableView.register(UINib(nibName: "NewSideMenuDetailCell", bundle: nil), forCellReuseIdentifier: "NewSideMenuDetailCell")
        self.slideMenuTableView.register(UINib(nibName: "NewSideMenuHeaderCell", bundle: nil), forCellReuseIdentifier: "NewSideMenuHeaderCell")
       

        // Do any additional setup after loading the view.
    }
    

    func constructArray() {
//        menuArray = ["My Profile","Inbox","Add Listing","My Listing","My Bookings", "My Property Reservtion","Wishlist","Report/Cancel","My Review","Payment Details"
//                     ,"Coupons","Language","Currency","Logout"]
//        self.menuImageArray = ["mailboxNew","journalText","journalText","journalText","journalText", "journalText","journalText","journalText","journalText","cardListNew","GiftNew","journalText","journalText","logoutNew"]
        
        let home = MenuDetailModel(title: "home", imageName: "Group 3700", menuType: .HOME)
        let profile = MenuDetailModel(title: "My Profile", imageName: "Group 3700", menuType: .MYPROFILE)
        let inbox = MenuDetailModel(title: "Inbox", imageName: "journalText", menuType: .INBOX)
        let listing = MenuDetailModel(title: "Add Listing", imageName: "journalText", menuType: .ADDLISTING)
        let listings = MenuDetailModel(title: "My Listing", imageName: "journalText", menuType: .MYLISTING)
        let booking = MenuDetailModel(title: "My Bookings", imageName: "journalText", menuType: .MYBOOKINGS)
        let property = MenuDetailModel(title: "My Property Reservtion", imageName: "journalText", menuType: .MYPROPERTYRES)
        let wishList = MenuDetailModel(title: "Wishlist", imageName: "journalText", menuType: .WISHLIST)
        let reportAndCancel = MenuDetailModel(title: "Report/Cancel", imageName: "journalText", menuType: .REPORTORCANCEL)
        let myReview = MenuDetailModel(title: "My Review", imageName: "journalText", menuType: .MYREVIEW)
        let paymentDetail = MenuDetailModel(title: "Payment Details", imageName: "cardListNew", menuType: .PAYMENTDETAILS)
        let coupons = MenuDetailModel(title: "Coupons", imageName: "GiftNew", menuType: .COUPONS)
        let language = MenuDetailModel(title: "Language", imageName: "journalText", menuType: .LANGUAGE)
        let currency = MenuDetailModel(title: "Currency", imageName: "journalText", menuType: .CURRENCY)
        let logout = MenuDetailModel(title: "LogOut", imageName: "logoutNew", menuType: .LOGOUT)
        self.detailArray = [home, inbox, listings , property,  reportAndCancel, myReview, paymentDetail, coupons, language, currency, logout]
        
        
    }
    func LogoutApi()  {
        self.showActivityIndicator(uiView: self.view)
            //self.showHUD(progressLabel: "")
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "type":"ios"
                 
            ]
        
//        "device_id":"23232323","type":"ios","token":"BearereyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL1dlYl9SZW50YWxfUHJvZHVjdFwvYXBpXC92XzFfMFwvYXBwbGVfbG9naW4iLCJpYXQiOjE2MjY2OTMxNDIsImV4cCI6MTYyNjc3OTU0MiwibmJmIjoxNjI2NjkzMTQyLCJqdGkiOiJnenVTY3cyM1JmYkE2b254Iiwic3ViIjo1OSwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.3CVW2CYve1trvxmGSjo8HECs1g0w7Xb0Gsdb8rrP2vg"
        
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

                    let isRemembred =  UserDefaults.standard.bool(forKey: "isRememberPassword")
                    if UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") != nil{
                        let UserName = UserDefaults.standard.value(forKey: "APP_LOGIN_EMAIL") as! String
                        let Password = UserDefaults.standard.value(forKey: "APP_LOGIN_PASSWORD") as! String
                        let Fcmkey = UserDefaults.standard.value(forKey: "fcmToken") as! String


                                   clearUserSession()
                        login_session.setValue(Currency, forKey: "APP_CURRENCY")
                        login_session.setValue(CurrencySymbol , forKey: "APP_CURRENCY_SYMBOL")
                        UserDefaults.standard.setValue(isRemembred, forKey: "isRememberPassword")
                        UserDefaults.standard.set(UserName, forKey: "APP_LOGIN_EMAIL")
                        UserDefaults.standard.set(Password, forKey: "APP_LOGIN_PASSWORD")
                        UserDefaults.standard.set(Fcmkey, forKey: "fcmToken")
                        
                    }else{
                        clearUserSession()
                    }
                    
                    
                    //self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                    
                    
                    
                    
                  //  let resData = responseDict["data"] as! [String:Any]
                    let AppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    AppDelegate.LogOut()
                    
                   // let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                   // Singleton.sharedInstance.homeModel = mod
                    
                    
                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as! String)
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

            let refreshAlert = UIAlertController(title: "Closest", message: "Logged out Successfully", preferredStyle: UIAlertControllerStyle.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                LogoutApi()

            }))

            self.present(refreshAlert, animated: true, completion: nil)

//            let nav = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
//            self.navigationController?.pushViewController(nav!, animated: true)

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
            let nav = self.storyboard?.instantiateViewController(withIdentifier: "RentYourSpaceViewController") as? RentYourSpaceViewController
            self.navigationController?.pushViewController(nav!, animated: true)

            
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
 
                if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {

                    nav.type = .language
//                    if self.presentedViewController == nil {
//                        present(nav, animated: true, completion: nil)
//                    } else {
//                        self.presentedViewController?.dismiss(animated: true, completion: {
//                            self.present(nav, animated: true, completion: nil)
//                        })
//
//                    }
                    //self.present(nav, animated: true, completion: nil)
                    self.navigationController?.pushViewController(nav, animated: true)

                }
            
    
          
            
        
            
        case .CURRENCY:
            if let nav = self.storyboard?.instantiateViewController(withIdentifier: "currencyVC") as? currencyVC {

                nav.type = .currency
//                if self.presentedViewController == nil {
//                    present(nav, animated: true, completion: nil)
//                } else {
//                    self.presentedViewController?.dismiss(animated: true, completion: {
//                        self.present(nav, animated: true, completion: nil)
//                    })
//
//                }
                self.navigationController?.pushViewController(nav, animated: true)

            }
     
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
//        case .MYPROFILE:
//            <#code#>
        }


      
    }
    
}
