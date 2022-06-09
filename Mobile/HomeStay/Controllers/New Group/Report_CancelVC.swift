//
//  Report_CancelVC.swift
//  HomeStay
//
//  Created by apple on 22/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class Report_CancelVC: BaseViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet var colView: UICollectionView!
    var selectedSegmentedIndex = 0
    var details = [[String:Any]]()
    var type = "host"
    var isLoading:Bool = true
    var currentPage = 1
    
    let titlesArr = [GlobalLanguageDictionary.object(forKey: "key_myPropertyReport") as! String, GlobalLanguageDictionary.object(forKey: "key_myBookingReport") as! String, GlobalLanguageDictionary.object(forKey: "key_myPropertyCancel") as! String, GlobalLanguageDictionary.object(forKey: "key_myBookingCancel") as! String]
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": "host", "page_no":1
            ]
        self.getReportApiResponse(params: parameters)
        
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- REPORT Api
    
    
    func getReportApiResponse(params: [String:Any]) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            APIManager.apiPostWithHeaders(serviceName: DISPUTEDETAILS, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Info", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if let code = responseDict.value(forKey: "code") as? NSNumber {
                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.isLoading = false
                        self.details.removeAll()
                        let data = responseDict.object(forKey: "data") as! [String:Any]
                        self.details.append(contentsOf: data["dispute_details"] as! [[String:Any]])
                        self.colView.reloadData()
                        //self.tblView.scrollToBottom()
                        self.tblView.reloadData()
                    }
                    else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                        if self.isLoading == false {
                            self.colView.reloadData()
                            self.details.removeAll()
                            self.tblView.reloadData()
                        }
                    }
                }
                else {
                    self.showInformation(title: "Info", message: "Something went wrong!")
                }
            }
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
        
    }
    
    
    //MARK:- CANCEL API
    
    
    func getCancelpiResponse(params: [String:Any]) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            APIManager.apiPostWithHeaders(serviceName: CANCELDETAILS, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Info", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if let code = responseDict.value(forKey: "code") as? NSNumber {
                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
                        self.isLoading = false
                        self.details.removeAll()
                        let data = responseDict.object(forKey: "data") as! [String:Any]
                        self.details.append(contentsOf: data["cancel_details"] as! [[String:Any]])
                        self.colView.reloadData()
                        self.tblView.scrollToBottom()
                        self.tblView.reloadData()
                    }
                    else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                        if self.isLoading == false {
                            self.details.removeAll()
                            self.tblView.reloadData()
                        }
                    }
                }
                else {
                    self.showInformation(title: "Info", message: "Something went wrong!")
                }
            }
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
        
    }

}

extension Report_CancelVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if details.count == 0 {
            self.tblView.EmptyMessage(message: GlobalLanguageDictionary.object(forKey: "key_nodatafound") as! String, tableView: tblView)
        }
        else {
            self.tblView.EmptyMessage(message: "", tableView: tblView)
        }
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTVCell", for: indexPath) as? MyReviewTVCell
        cell?.imgProfile.layer.cornerRadius = 30
        cell?.imgProfile.layer.borderWidth = 1
        cell?.imgProfile.layer.borderColor = UIColor.systemOrange.cgColor
        cell?.lblName.font = UIFont(name: SemiBoldFont, size: 16)
        cell?.lblDate.font = UIFont(name: SemiBoldFont, size: 14)
        
        let obj = details[indexPath.row]
        if self.selectedSegmentedIndex == 0 || self.selectedSegmentedIndex == 1 {
            cell?.bottomView.isHidden = true
            let imgURL = (obj["user_image"] as? String ?? "")
            let normalString =  NSMutableAttributedString(string: "\(GlobalLanguageDictionary.object(forKey: "key_at") as! String) ")
            let bookingNumString =  NSMutableAttributedString(string: " \(GlobalLanguageDictionary.object(forKey: "key_forBookingNo") as! String):  " + (obj ["booking_no"] as? String ?? ""))
            let attrs = [NSAttributedString.Key.font : UIFont(name: SemiBoldFont, size: 17)]
            let boldString = NSMutableAttributedString(string: (obj ["rental_name"] as? String ?? ""), attributes:attrs)
            normalString.append(boldString)
            normalString.append(bookingNumString)
            cell?.lblDate.attributedText = normalString
            cell?.imgProfile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
            let reportMsg = (obj["message"] as? String ?? "") + " \(GlobalLanguageDictionary.object(forKey: "key_at") as! String) " + (obj["host_name"] as? String ?? "")
            cell?.lblName.text = reportMsg + "" + (obj["created_date"] as? String ?? "")
        }
        
        
        else {
            cell?.bottomView.isHidden = false
            let imgURL = (obj["user_image"] as? String ?? "")
            let normalString =  NSMutableAttributedString(string: "\(GlobalLanguageDictionary.object(forKey: "key_at") as! String) ")
            let bookingNumString =  NSMutableAttributedString(string: " \(GlobalLanguageDictionary.object(forKey: "key_forBookingNo") as! String):  " + (obj ["booking_no"] as? String ?? ""))
            let attrs = [NSAttributedString.Key.font : UIFont(name: RegularFont, size: 15)]
            let boldString = NSMutableAttributedString(string: (obj ["property_name"] as? String ?? ""), attributes:attrs)
            normalString.append(boldString)
            normalString.append(bookingNumString)
            cell?.lblDate.attributedText = normalString
            cell?.imgProfile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
            let hostName = "\(obj["host_name"] as? String ?? "")  \(obj["created_date"] as? String ?? "")"
            cell?.lblName.text = hostName
            cell?.thirdDescriptionLbl.text = obj["message"] as? String ?? ""
            cell?.cancelByGuestLbl.text = "   \(obj["cancelled_by"] as? String ?? "")   "
            cell?.totalBookingAmountLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_totalBookingCount") as! String): $\(obj["total_amt"] as? String ?? "") "
            cell?.cancelPerCentLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_cancelPercent") as! String): \(obj["cancelled_percent"] as? Int ?? 0) % "
            cell?.refundAmountLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_refund_amount") as! String): \(obj["total_amt"] as? String ?? "") "
            cell?.cancelByGuestLbl.layer.borderColor = AppColor.cgColor
            cell?.cancelByGuestLbl.layer.borderWidth = 3
            cell?.cancelByGuestLbl.layer.cornerRadius = 6
            cell?.hostAmountLbl.isHidden = (self.selectedSegmentedIndex == 2) ? false : true
            cell?.hostAmountLbl.text = "\(GlobalLanguageDictionary.object(forKey: "key_hostAmount") as! String): \(obj["total_amt"] as? String ?? "") "
           

        }
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.selectedSegmentedIndex == 0 || self.selectedSegmentedIndex == 1 {
            return 240
        } else {
            return 400
        }
       
    }
    
    
    
}


extension Report_CancelVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Report_CancelSegmentCVCell", for: indexPath) as! Report_CancelSegmentCVCell
        cell.lbltitle.text  = titlesArr[indexPath.item]
        cell.lblUnderline.backgroundColor = selectedSegmentedIndex == indexPath.item ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : .none
        
        
        cell.lbltitle.font = UIFont(name: SemiBoldFont, size: 16)
       
        cell.lbltitle.textColor = selectedSegmentedIndex == indexPath.item ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSegmentedIndex = indexPath.item
       
        if indexPath.item == 0  {
            type = "host"
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": type, "page_no":1
                ]
            self.getReportApiResponse(params: parameters)
        }
        
        else if indexPath.item == 1  {
            type = "guest"
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": type, "page_no":1
                ]
            self.getReportApiResponse(params: parameters)
        }
        
        else if indexPath.item == 2  {
            type = "host"
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": type, "page_no":1, "currency_code" : "USD"
                ]
            self.getCancelpiResponse(params: parameters)
        }
        
        else if indexPath.item == 3  {
            type = "guest"
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": type, "page_no":1, "currency_code" : "USD"
                ]
            self.getCancelpiResponse(params: parameters)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 44)
    }
    
}
