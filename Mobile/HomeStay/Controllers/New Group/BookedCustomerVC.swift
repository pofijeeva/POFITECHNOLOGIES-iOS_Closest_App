//
//  BookedCustomerVC.swift
//  HomeStay
//
//  Created by pofiapple10 on 21/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookedCustomerVC: BaseViewController {

    @IBOutlet weak var listTableview: UITableView!
    
    @IBOutlet weak var AddonsTable: UITableView!
    @IBOutlet weak var GrayView: UIView!
    @IBOutlet weak var headrerLbl: UILabel!

    var properytId: Int?
    var  currentPage: Int = 1
    var isLoading = false
    var bookingCustomerList = [BookingList]()
    var ReservationData = NSMutableDictionary()
    
    var AddonsDetails = NSMutableArray()
    var AddonsAmount = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.headrerLbl.text = GlobalLanguageDictionary.object(forKey: "key_bookedCust") as? String ?? ""
        self.GrayView.isHidden = true
        self.AddonsTable.isHidden = true
        self.listTableview.isHidden = true
        listTableview.delegate = self
        listTableview.dataSource = self
        self.getNotificationListApiCall()
    }
    
    @IBAction func act_ScrollBGtapped(_ sender: UITapGestureRecognizer) {
        self.GrayView.isHidden = true
        self.AddonsTable.isHidden = true
}
    
    func getNotificationListApiCall() {
            //self.showHUD(progressLabel: "")
        showActivityIndicator(uiView: self.view)

         let pid = properytId
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "page_no": 1,
             "property_id": pid ?? 0,
             "currency_code": "USD"
            ]
            print(parameters)
            APIManager.apiPostWithHeaders(serviceName: PROPERTY_DETAILS, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                DispatchQueue.main.async { self.hideActivityIndicator(uiView: self.view) }
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Closest", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    self.listTableview.isHidden = false

                    self.ReservationData.removeAllObjects()
                    self.ReservationData.addEntries(from: (responseDict.object(forKey: "data") as? NSDictionary) as? [AnyHashable : Any] ?? [:])
                    self.isLoading = false
                   // self.bookingCustomerList.append(contentsOf:model )
                    self.listTableview.reloadData()

                }
                else
                {
                    
                    self.hideActivityIndicator(uiView: self.view)
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
                
            }
        }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)    }

    
    
    func getPropertyDetailsResponse(params: [String:Any]){
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
                
            APIManager.apiPostWithHeadersCodable(serviceName: PROPERTY_DETAILS, parameters:params) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }

               
                do {
                    
                    let propertyModel = try JSONDecoder().decode(propertyDetailsModel.self, from: data)
        
                    if let responseCode = propertyModel.code, responseCode == 200 {
                        if let model =  propertyModel.data?.booking_list, model.count != 0 {
                            self.isLoading = false
                            self.bookingCustomerList.append(contentsOf:model )
                            self.listTableview.reloadData()
//                            self.detailResponseModel = propertyDetailModel
//                            self.populateData()
                        }
                        
                    } else {
                        self.isLoading = false
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
    
    @objc func  approvedApiCall(sender: UIButton) {
        if let id =   bookingCustomerList[sender.tag].booking_id {
            gethost_RejectApiResponse(bookingStatus: "1", bookingId: String (id))
        }
       
    }
    @objc func  AddonsAct(sender: UIButton) {
        self.AddonsDetails.removeAllObjects()
        self.AddonsAmount = ((self.ReservationData.object(forKey: "booking_list") as! NSArray).object(at: sender.tag) as? NSDictionary)?.object(forKey: "add_on_amount") as? String ?? ""
        self.AddonsDetails.addObjects(from: (((self.ReservationData.object(forKey: "booking_list") as! NSArray).object(at: sender.tag) as? NSDictionary)?.object(forKey: "add_on_details") as! NSArray) as! [Any])
        if self.AddonsDetails.count == 0 {
            self.GrayView.isHidden = true
            self.AddonsTable.isHidden = true
            self.showInformation(title: "Info", message: "We don't have any addons")

         }else{
            self.GrayView.isHidden = false
            self.AddonsTable.isHidden = false
            self.AddonsTable.reloadData()
        }
      
       
    }
    
    @objc func rejectApiCall(sender: UIButton) {
        if let id = bookingCustomerList[sender.tag].booking_id {
            gethost_RejectApiResponse(bookingStatus: "2", bookingId: String( id))
        }
    }
       
    
    
    func  gethost_RejectApiResponse(bookingStatus: String, bookingId: String){
        //showActivityIndicator(uiView: self.view)
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "booking_id": bookingId,
                 "booking_status":bookingStatus //1-Approve,2-Reject
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: APPROVE_REJECT_BOOKING, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    let successModel = try JSONDecoder().decode(CommonSuccessModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        self.showInformation(title:"", message: successModel.message ?? "")
                        self.listTableview.reloadData()
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    print("error reading JSON: \(error)")
                    let successModel = try? JSONDecoder().decode(CommonSuccessModel.self, from: data)
                   
                    if let responseCode = successModel?.code, responseCode == 200 {
                        self.showInformation(title:"", message: successModel?.message ?? "")
                        self.listTableview.reloadData()
                    } else {
                        self.showInformation(title: "Error", message: successModel?.message ?? "")
                    }
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
    }

    
    
}

extension BookedCustomerVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        if self.ReservationData.count == 0 {
            return 0
        }else{
            if tableView == AddonsTable {
                return self.AddonsDetails.count + 1

            }else{
                return (self.ReservationData.object(forKey: "booking_list") as! NSArray).count

            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == AddonsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddonsTableViewCell") as! AddonsTableViewCell
            if indexPath.row == 0 {
                cell.AddonsLbl.textColor = AppSecondColor
               
                cell.AddonsLbl.text = "Addons Total Amount - \(self.AddonsAmount)"
            }else{
                cell.AddonsLbl.textColor = .black
                cell.AddonsLbl.text = "\((self.AddonsDetails.object(at: indexPath.row-1) as? NSDictionary)?.object(forKey: "name") as? String ?? "") - \(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.AddonsDetails.object(at: indexPath.row-1) as? NSDictionary)?.object(forKey: "id") as AnyObject)"
            }
            cell.AddonsLbl.font = UIFont(name: SemiBoldFont, size: 15)
            return cell
        }else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell") as! NewTableViewCell

            cell.CheckIn.text = GlobalLanguageDictionary.object(forKey: "key_checkIn") as? String ?? ""
            cell.CheckOut.text = GlobalLanguageDictionary.object(forKey: "key_checkOut") as? String ?? ""
            cell.BookingStatus.text = GlobalLanguageDictionary.object(forKey: "key_bookingStatus") as? String ?? ""
            cell.Transactiontype.text = GlobalLanguageDictionary.object(forKey: "key_transactionType") as? String ?? ""
            cell.Amount.text = GlobalLanguageDictionary.object(forKey: "key_amount") as? String ?? ""
            cell.hostApprovallbl.text = GlobalLanguageDictionary.object(forKey: "key_hostApproval") as? String ?? ""
            cell.AddonsLbl.text = GlobalLanguageDictionary.object(forKey: "key_clickhereforAddons") as? String ?? ""
            cell.AddonsBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_addons") as? String ?? "", for: .normal)
            cell.bokkingno.text = GlobalLanguageDictionary.object(forKey: "key_bookingNumber") as? String ?? ""
            
         cell.bookingStatusLbl.layer.cornerRadius = 6
        cell.hostApprovallbl.layer.cornerRadius = 6
        let DataDict = (self.ReservationData.object(forKey: "booking_list") as! NSArray).object(at: indexPath.row) as! NSDictionary
        cell.bookingaNOlBL.text = DataDict.object(forKey: "booking_num") as? String ?? ""
        cell.nameLbl.text = "\(DataDict.object(forKey: "prop_title") as? String ?? "") "
        cell.locNameLbl.text = DataDict.object(forKey: "pickup_location") as? String ?? ""
        cell.checkInLbl.text = DataDict.object(forKey: "check_in") as? String ?? ""
        cell.checkOutLbl.text = DataDict.object(forKey: "check_out") as? String ?? ""
        cell.transactiontypeLbl.text = "\(DataDict.object(forKey: "pmt_type") as AnyObject)"
        cell.amountLbl.text = "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \(DataDict.object(forKey: "total_amnt") as AnyObject)"
            
 
            if (DataDict.object(forKey: "add_on_details") as! NSArray).count == 0 {
                cell.AddonsLblHeight.constant = 0
                cell.AddonsBtn.isHidden = true
                cell.AddonsLbl.isHidden = true
            }else{
                cell.AddonsLblHeight.constant = 25
                cell.AddonsBtn.isHidden = false
                cell.AddonsLbl.isHidden = false
            }
            
            cell.QtyLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_Qty") as? String ?? "") * \(DataDict.object(forKey: "booking_qty") as AnyObject)"
            
        cell.AddonsBtn.tag = indexPath.row
//        cell.rejectBtn.tag = indexPath.row
        cell.AddonsBtn.addTarget(self, action: #selector(AddonsAct), for: .touchUpInside)
     //   cell.rejectBtn.addTarget(self, action: #selector(rejectApiCall), for: .touchUpInside)
        if let cancelledStataus = DataDict.object(forKey: "cancelled_status") as? Int, cancelledStataus == 1 {
            cell.bookingStatusLbl.text = "Cancelled By Host"
            cell.bookingStatusLbl.backgroundColor = UIColor.red
        } else {
            if let paidStatus = DataDict.object(forKey: "paid_status") as? Int, paidStatus == 0 {
                cell.bookingStatusLbl.text = "Pending"
                cell.bookingStatusLbl.backgroundColor = UIColor.systemYellow
            } else {
                cell.bookingStatusLbl.text = "Completed"
                cell.bookingStatusLbl.backgroundColor = UIColor.systemGreen
            }
        }
       
        if let hostApprovalStatus = DataDict.object(forKey: "host_approve_status") as? Int, hostApprovalStatus == 0 {
           // cell.approveBtn.isHidden = false
           // cell.rejectBtn.isHidden = false
        } else {
           if  let hostApprovalStatus = DataDict.object(forKey: "host_approve_status") as? Int, hostApprovalStatus == 1{
//               cell.approveBtn.isHidden = true
//               cell.rejectBtn.isHidden = true
               cell.hostApprovalStatusLbl.text = "Approved"
               cell.hostApprovalStatusLbl.backgroundColor = UIColor.systemGreen
           } else {
//               cell.approveBtn.isHidden = true
//               cell.rejectBtn.isHidden = true
               cell.hostApprovalStatusLbl.text = "Cancelled"
               cell.hostApprovalStatusLbl.backgroundColor = UIColor.red
               
           }
        }
        
     return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == self.bookingCustomerList.count - 1 && !self.isLoading{
            self.isLoading = true
            currentPage += 1
            if  let pid = properytId {
                let parameters:[String : Any] =
                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                     "page_no": currentPage,
                     "property_id": pid,
                     "currency_code": "USD"
                    ]
                self.getPropertyDetailsResponse(params: parameters)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
}
