//
//  MyBookingsVC.swift
//  HomeStay
//
//  Created by apple on 18/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import SideMenu

protocol MyBookingVCPrototcol {
    func reloadMybookinglist()
}
class MyBookingsVC: BaseViewController {
    
    @IBOutlet weak var colView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var AddonsTable: UITableView!
    @IBOutlet weak var grayView: UIView!


    var bookings = [ [String: Any]]()
    var isLoading:Bool = true
    var currentPage = 1
    var AddonsArray = NSMutableArray()
    var add_on_amount = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.grayView.isHidden = true

        AddonsTable.cornerRadius = 10
        AddonsTable.layer.shadowColor = UIColor.lightGray.cgColor
        AddonsTable.layer.shadowOffset = CGSize(width: 3, height: 3)
        AddonsTable.layer.shadowOpacity = 0.7
        AddonsTable.layer.shadowRadius = 4.0
        self.AddonsTable.isHidden = true
        self.TitleLbl.font = UIFont(name: SemiBoldFont, size: 18)
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "page_type": "",
             "page_no":1, "currency_code": "USD"
            ]
        self.getBookingApiResponse(params: parameters)

        // Do any additional setup after loading the view.
    }
    @IBAction func act_GrayViewtapped(_ sender: UITapGestureRecognizer) {
        self.grayView.isHidden = true
        self.AddonsTable.isHidden = true
}
    @IBAction func actionBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenu") as! SideMenuNavigationController
            menu.menuWidth = self.view.bounds.width - 100
           // menu.delegate = self
            present(menu, animated: true, completion: nil)
            //                    if sender.tag == 0 {
            //                        sender.tag = 1
            //                        self.view.layoutIfNeeded()
            //                        rotateMenuButton()
            //                        UIView.animate(withDuration: 0.3) {
            //                            self.greyView.isHidden = false
            //                           // self.menuLeadingConstant.constant = 0.0
            //                            self.img_Menu.image = UIImage(named: "backBlack")
            //                            self.viewMenu.isHidden = false
            //                            self.view.layoutIfNeeded()
            //                        }
            //                    } else {
            //                        sender.tag = 0
            //                        self.view.layoutIfNeeded()
            //                        rotateMenuButton()
            //                        UIView.animate(withDuration: 0.3) {
            //                         //   self.menuLeadingConstant.constant = -500 backBlack
            //                            self.img_Menu.image = UIImage(named: "Menu_PR")
            //                            self.greyView.isHidden = true
            //                           self.viewMenu.isHidden = true
            //                            self.view.layoutIfNeeded()
            //                        }
            //                    }
        }else{

            showSimpleAlert()
            // self.LoginView.isHidden = false
        }
        
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Closest", message: "Are you sure want to login ?",         preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { _ in
            //Cancel Action
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Login",
                                      style: UIAlertActionStyle.default,
                                      handler: {(_: UIAlertAction!) in
                                        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
                                        self.navigationController?.pushViewController(navgt!, animated: true)
                                        
                                        
                                        //Sign out action
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionInvoice(_ sender: UIButton) {
        
        self.AddonsTable.isHidden = false
        self.AddonsTable.reloadData()
        let refreshAlert = UIAlertController(title: "Closest", message: "Please login to website for invoice details", preferredStyle: UIAlertControllerStyle.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
            
            
        }))

        self.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    func getBookingApiResponse(params: [String:Any]){
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            APIManager.apiPostWithHeaders(serviceName: MYBOOKINGS, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Info", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    self.isLoading = false
                    let data = responseDict.object(forKey: "data") as! [String:Any]
                    self.bookings.append(contentsOf: data["booking_details"] as! [[String:Any]]) //=  data["booking_details"] as! [[String:Any]]
                    
                   
                    self.tblView.reloadData()
                }
                else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                    if self.isLoading == false {
                    self.bookings.removeAll()
                    self.tblView.reloadData()
                    }
                   
                   // self.showInformation(title: "Info", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
            }
        }
        else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
        
    }
    
    //MARK:- ADD/REMOVE Wishlist API
    
    @objc func wishListApi(sender: UIButton) {
     
        let model = self.bookings[sender.tag]
        print(model)
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
                
            let parameters:[String : Any] =  ["lang_code" : lanuguage_selection.value(forKey: "language") ?? "en",
                       "property_id": model["property_id"] as? Int ?? 0
                        ]
        print(parameters)
         
            APIManager.apiPostWithHeadersCodable(serviceName: ADD_WISHLIST, parameters:parameters) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }

               
                do {
                    
                    let successModel = try JSONDecoder().decode(SuccessModel.self, from: data)
        
                    if let responseCode = successModel.code, responseCode == 200 {
                     
                        self.bookings[sender.tag]["is_favourite"] = (model["is_favourite"] as? Bool ?? false ? false  : true)
                        self.tblView.reloadData()
                        
                        
                        
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                   
                    
                   
                } catch {
                    print("error reading JSON: \(error)")
                }
               
                
            }
            
        } else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
        
        
        
    }
    
    @objc func AddonsButtonTapped(sender: UIButton) {
       
         let Row = sender.tag
        let bookingsObj = self.bookings[Row]
        self.AddonsArray.removeAllObjects()
        self.AddonsArray.addObjects(from: (bookingsObj["add_on_details"] as! NSArray) as! [Any])
        self.add_on_amount = "\(bookingsObj["add_on_amount"] as AnyObject)"
        if self.AddonsArray.count == 0 {
            self.showInformation(title: "Info", message: "We don't have any Addons to display")

        }else{
            self.grayView.isHidden = false
            self.AddonsTable.isHidden = false
            self.AddonsTable.reloadData()
        }
    }
    
    @objc func reviewButtonTapped(sender: UIButton) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyInvoiceVC") as! MyInvoiceVC
        vc.review_details = self.bookings[sender.tag]
        vc.delegate = self
                vc.modalPresentationStyle = .overCurrentContext
                vc.modalTransitionStyle = .crossDissolve
                present(vc, animated: true, completion: nil)
    }
    
    
    
}




extension MyBookingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == AddonsTable {
            if self.bookings.count == 0{
                return 0
            }else{
                return self.AddonsArray.count + 1
            }
        }else{
            return self.bookings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == AddonsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddonsTableViewCell") as! AddonsTableViewCell
            if indexPath.row == 0 {
                cell.AddonsLbl.textColor = AppSecondColor
                cell.AddonsLbl.text = "Addons Total Amount - \(self.add_on_amount)"
            }else{
                cell.AddonsLbl.textColor = .black
                cell.AddonsLbl.text = "\((self.AddonsArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "name") as! String) - \(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.AddonsArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "id") as AnyObject)"
            }
            cell.AddonsLbl.font = UIFont(name: SemiBoldFont, size: 15)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingListTVCell") as! BookingListTVCell
            
            cell.viewShadow.layer.cornerRadius = 10
            let bookingsObj = self.bookings[indexPath.item]
            let imgURL = (bookingsObj["ren_image"] as? String ?? "")
            
            cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 15)
            cell.lblPropertyName.font = UIFont(name: SemiBoldFont, size: 16)
            cell.lblBookingDate.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblPickupDate.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 16)
            cell.lblReqID.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblLoc.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblDats.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblStatus.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblGuestCount.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblDropDate.font = UIFont(name: SemiBoldFont, size: 14)
            cell.lblOwnerName.font = UIFont(name: SemiBoldFont, size: 15)
            cell.bookingDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.pickUpLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.DropLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.totalAmtLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.btn1.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
            cell.btn2.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)

            cell.imgProperty.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
            cell.lblLoc.text = bookingsObj["pickup_location"] as? String ?? ""
            cell.lblBookingDate.text =  bookingsObj["booked_date"] as? String ?? ""
            cell.lblGuestCount.text =  "\(bookingsObj["num_of_guests"] as AnyObject) Guests"

            cell.lblPickupDate.text =  bookingsObj["check_in"] as? String ?? ""
            cell.lblDropDate.text = bookingsObj["check_out"] as? String ?? ""
            cell.lblPrice.text = "$" + (bookingsObj["total_amt"] as? String ?? "")
            cell.lblReqID.text = "Request ID: " + (bookingsObj["booking_num"] as? String ?? "")
            cell.lblPropertyName.text = bookingsObj["ren_title"] as? String ?? ""
            cell.lblDats.text = " \(countBtnTwoDates(mStartDate:  (bookingsObj["check_in"] as? String ?? "").toDate(format: "dd MMM,yyyy"), mEndDate: (bookingsObj["check_out"] as? String ?? "").toDate(format: "dd MMM,yyyy")))" + " Days"
            
//             if (bookingsObj["add_on_details"] as! NSArray).count == 0 {
//                cell.btn1.isHidden = true
//            }else{
//                cell.btn1.isHidden = false
//            }
            cell.btnWishlist.tag = indexPath.row
            cell.btnWishlist.addTarget(self, action: #selector(wishListApi(sender:)), for: .touchUpInside)
            
            if (bookingsObj["add_on_details"] as! NSArray).count == 0 {
                cell.btn1.isHidden = true
            }else{
                cell.btn1.isHidden = false
            }
            
            cell.btn1.tag = indexPath.row
            cell.btn1.addTarget(self, action: #selector(AddonsButtonTapped(sender:)), for: .touchUpInside)
            
            cell.btn2.tag = indexPath.row
            cell.btn2.addTarget(self, action: #selector(reviewButtonTapped(sender:)), for: .touchUpInside)
            cell.imgHeart.image = (bookingsObj["is_favourite"] as? Bool ?? false ? UIImage(named: "heart-fill")  : UIImage(named: "heart") )
            cell.btn2.isHidden = (bookingsObj["reviewed_sts"] as? Bool ?? false ? false  : true  )
            
    //        reviewed_sts
    //        cell.btn2.isHidden =  ((bookingsObj["is_favourite"] as? Int ?? 0 ? 0  : 1 != nil))
            return cell
        }
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == AddonsTable{
            return UITableViewAutomaticDimension
        }else{
            return 650

        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableView == AddonsTable {
            self.AddonsTable.isHidden = true
        }else{
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == self.bookings.count - 1 && !self.isLoading{
            self.isLoading = true
            currentPage += 1
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "page_type": "",
                 "page_no":currentPage, "currency_code": "USD"
                ]
            self.getBookingApiResponse(params: parameters)
            //callAPI(page: currentPage)
        }
    }
    
}

extension MyBookingsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingListCVCell", for: indexPath) as? BookingListCVCell
        cell?.lblSegment.font = UIFont(name: SemiBoldFont, size: 16)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 44)
    }
    
}

//extension UIView {
//
//    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
//        layer.masksToBounds = false
//        layer.shadowOffset = offset
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = radius
//        layer.shadowOpacity = opacity
//
//        let backgroundCGColor = backgroundColor?.cgColor
//        backgroundColor = nil
//        layer.backgroundColor =  backgroundCGColor
//    }
//}

//extension Date {

    func countBtnTwoDates(mStartDate: Date, mEndDate: Date) -> Int {
        var daysListArray = [String]()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        var newDate = mStartDate
        daysListArray.removeAll()

        while newDate <= mEndDate {
            formatter.dateFormat = "yyyy-MM-dd"
            daysListArray.append(formatter.string(from: newDate))
            newDate = calendar.date(byAdding: .day, value: 1, to: newDate)!
        }
       // print("daysListArray: \(daysListArray)") // if you want to print list between start date and end date
        return daysListArray.count
    }


extension MyBookingsVC: MyBookingVCPrototcol {
    func reloadMybookinglist() {
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "page_type": "",
             "page_no":1, "currency_code": "USD"
            ]
        self.bookings.removeAll()
        self.getBookingApiResponse(params: parameters)
    }
    
    
}
