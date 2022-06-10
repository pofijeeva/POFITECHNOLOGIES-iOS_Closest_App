//
//  CouponAvailabilityViewController.swift
//  HomeStay
//
//  Created by Apple3 on 04/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


class CouponAvailabilityViewController: BaseViewController {
  
    @IBOutlet weak var noLabel: UILabel!
      @IBOutlet weak var NavTitle: UILabel!
     @IBOutlet weak var WalletBtn: UIButton!
     @IBOutlet weak var CouponBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
   
    @IBOutlet weak var view_indicator: UILabel!
    var productId = String()
      var totalwallet = String()
      var balenceWallet = String()
      var usedWallet = String()
    var iswallet = true
  var iswalletvalue = Bool()
    var iscouponvalue = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NavTitle.font = UIFont(name: SemiBoldFont, size: 18)
          self.noLabel.font = UIFont(name: RegularFont, size: 16)
        self.WalletBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.CouponBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
        self.view_indicator.backgroundColor = AppSecondColor
        
        self.showActivityIndicator(uiView: self.view)
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        tableView.tableFooterView = UIView()

        self.iswallet = false
        self.CouponApi()
         self.WalletApi()
       
        
//
//        if (Reachability()?.isReachable)!
//        {
//
//            showActivityIndicator(uiView: self.view)
////            print(login_session.value(forKey: "UserId")!)
////            let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)"
////            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: COUPON_DETAILS_API, APIKEY: "COUPON_DETAILS_API")
////            print(parameterStr)
//
//
//            let parameterStr1 = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&user_id=\(login_session.value(forKey: "UserId")!)"
//
//            Network.shared.POSTRequest(withParameterString: parameterStr1, serviceURL: WALLET_AVAILABLE_API, APIKEY: "WALLET_AVAILABLE_API")
//            print(parameterStr1)
//
//
//        }
//        else
//        {
//            self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
//        }
        // Do any additional setup after loading the view.
    }
    func WalletApi(){
        
        if (Reachability()?.isReachable)!
        {
           showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
         
            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","user_id":login_session.value(forKey: "UserId")!]
            print(params)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(WALLET_AVAILABLE_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print("Coupon",responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                 
                    let userDetailsArr = responseDict.value(forKey: "user_wallet") as! NSArray
                  if  userDetailsArr.count == 0
                    {
                        
                            self.tableView.isHidden = true
                            self.noLabel.isHidden = false
                        self.iswalletvalue = false
                    }
                  else
                  {
                            self.tableView.isHidden = false
                            self.noLabel.isHidden = true
                    self.iswalletvalue = true
                 }
                    
                    let userDetails = userDetailsArr[0] as? NSDictionary
                    
                
                    
                   
                    let totalWalletAmout = userDetails?.value(forKey: "total_wallet_amount") as! NSNumber
                    self.totalwallet = String(format: "%@",totalWalletAmout)
                    let usdeWalletAmout = userDetails?.value(forKey: "used_from_wallet") as! NSNumber
                    self.usedWallet = String(format: "%@",usdeWalletAmout)
                    let balenceWalletAmout = userDetails?.value(forKey: "balance_from_wallet") as! NSNumber
                    self.balenceWallet = String(format: "%@",balenceWalletAmout)
                    
                    self.tableView.reloadData()
                    
                    
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
            
            
            //            showActivityIndicator(uiView: self.view)
            //            print(login_session.value(forKey: "UserId")!)
            //            let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") as? String ?? "en")&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&userid=\(login_session.value(forKey: "UserId")!)"
            //            Network.shared.GetRequest(withParameterString: parameterStr, serviceURL: REQ_HOMEPAGE, APIKEY: "HOME_API")
            //            print(parameterStr)
            
        } else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    
    func CouponApi(){
        
        if (Reachability()?.isReachable)!
        {
           showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
         
            params = ["currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? "","user_id":login_session.value(forKey: "UserId")!]
            print(params)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(COUPON_DETAILS_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print("Coupon",responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    
                    let mod = CouponDetailsJson(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.couponDetailsJson = mod
                    if Singleton.sharedInstance.couponDetailsJson.couponDetails.count == 0
                    {
                        self.iscouponvalue = false
                        self.tableView.isHidden = true
                        self.noLabel.isHidden = false
                        self.noLabel.text = "No Coupon Available"
                    } else {
                        self.iscouponvalue = true
                        self.tableView.isHidden = false
                        self.noLabel.isHidden = true
                    }
                    self.tableView.reloadData()
                 
                    
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
            
            
            //            showActivityIndicator(uiView: self.view)
            //            print(login_session.value(forKey: "UserId")!)
            //            let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") as? String ?? "en")&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&userid=\(login_session.value(forKey: "UserId")!)"
            //            Network.shared.GetRequest(withParameterString: parameterStr, serviceURL: REQ_HOMEPAGE, APIKEY: "HOME_API")
            //            print(parameterStr)
            
        } else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    
    
    @IBAction func act_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func wallet(_ sender: UIButton) {
     iswallet = true

        UIView.animate(withDuration: 0.25, animations: {
            self.view_indicator.frame = CGRect(x: 0, y: self.view_indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
       
        if iswalletvalue == true{
            self.tableView.isHidden = false
            self.noLabel.isHidden = true
        }
        else{
            self.tableView.isHidden = true
            self.noLabel.isHidden = false
             self.noLabel.text = "No Wallet Available"
        }
        self.tableView.reloadData()
    }
    
    
    @IBAction func coupon(_ sender: UIButton)
    {
      iswallet = false
        UIView.animate(withDuration: 0.25, animations: {
            self.view_indicator.frame = CGRect(x: self.view.frame.width / 2, y: self.view_indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
       if iscouponvalue == true
       {
        self.tableView.isHidden = false
        self.noLabel.isHidden = true
        
        }
       else{
        self.tableView.isHidden = true
        self.noLabel.isHidden = false
         self.noLabel.text = "No Coupon Available"
        }
       
        self.tableView.reloadData()
    }
        
    
        

    
    
}



extension CouponAvailabilityViewController : UITableViewDataSource,UITableViewDelegate,delegateForCategorySearch {
   
    

    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

if iswallet == true
{
    return 1
}
        
else{
    if Singleton.sharedInstance.couponDetailsJson != nil
    {
        return Singleton.sharedInstance.couponDetailsJson.couponDetails.count
    } else {
        return 0
    }

    
    }
   
       
        

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if iswallet == true
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellnew") as? SearchCell
             cell!.selectionStyle = .none
            
           
            
               cell!.YourEarings.font = UIFont(name: SemiBoldFont, size: 15)
             cell!.walletAmount.font = UIFont(name: SemiBoldFont, size: 15)
             cell!.usedWalletLabel.font = UIFont(name: SemiBoldFont, size: 15)
             cell!.balenceWallet.font = UIFont(name: SemiBoldFont, size: 15)
            
                cell!.walletAmount.font = UIFont(name: RegularFont, size: 14)
                cell!.usedWalletLabel.font = UIFont(name: RegularFont, size: 14)
            cell!.balenceWallet.font = UIFont(name: RegularFont, size: 14)
            
            cell!.walletAmount.text = self.totalwallet
              cell!.usedWalletLabel.text = self.usedWallet
              cell!.balenceWallet.text = self.balenceWallet
             return cell!
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewCouponTableViewCell") as? NewCouponTableViewCell
            cell!.selectionStyle = .none
            let dict = Singleton.sharedInstance.couponDetailsJson.couponDetails[indexPath.row]
            
           cell!.PropertyNameLbl.font = UIFont(name: SemiBoldFont, size: 14)
                cell!.PropertyPerLbl.font = UIFont(name: SemiBoldFont, size: 20)
          
            
                cell!.offLbl.font = UIFont(name: SemiBoldFont, size: 13)
                 cell!.CouponCodeLbl.font = UIFont(name: SemiBoldFont, size: 14)
              cell!.ExpiryLbl.font = UIFont(name: SemiBoldFont, size: 14)
               cell!.ExpiryDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
                cell!.LimitLbl.font = UIFont(name: RegularFont, size: 14)
             cell!.limitValLbl.font = UIFont(name: RegularFont, size: 15)
             cell!.PropertyNameLbl.font = UIFont(name: RegularFont, size: 15)
           
             
            let dateFormatter = DateFormatter()
                  dateFormatter.dateFormat = "yyyy-MM-dd"
                  let startingDate = dateFormatter.date(from: dict.couponDateto)
                 
                  let newformat = DateFormatter()
                  newformat.dateFormat =  "E, d MMM"
                  newformat.string(from: startingDate!)
                  
            
            
            
    cell!.CouponCodeLbl.text = "CODE :" + dict.couponCode!
            let dataArray = dict.couponAssignedProducts!
            
            if dataArray.count == 1{
                cell!.PropertyNameLbl.text = dataArray[0].productTitle
                cell?.bgImgView.isHidden = false
                cell?.BaseView.layer.borderWidth = 0
                cell?.BaseView.layer.cornerRadius = 0
                    //(dataArray![0] as? NSDictionary)?.object(forKey: "product_title")as? String
            }else{
                var tempStr = String()
                for i in 0..<dataArray.count{
                    if i == 0{
                        tempStr = dataArray[i].productTitle
                    }else if i == dataArray.count{
                        let str = dataArray[i].productTitle
                        tempStr = tempStr + str!
                    }else{
                        let str = dataArray[i].productTitle
                        tempStr = tempStr + "\n" + str!
                    }
                    cell?.bgImgView.isHidden = true
                }
                cell!.PropertyNameLbl.text = tempStr
                cell?.BaseView.layer.cornerRadius = 5.0
                cell?.BaseView.layer.borderWidth = 0.1
                cell?.BaseView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
            }
            
    cell!.PropertyPerLbl.text = String(format: "%@", dict.couponPriceValue)
            
            cell!.limitValLbl.text = String(format: "%@", dict.couponAvailableCount as! CVarArg)
    cell!.ExpiryDateLbl.text = String(format: "%@", newformat.string(from: startingDate!))
       
        
            return cell!
   
        }
    
        }

        


    func showItemsBasedOnCategory(nameStr: String)
    
   
    {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailViewController") as? PropertyDetailViewController
         nav!.PropertyID =  nameStr
        
        self.navigationController?.pushViewController(nav!, animated: true)
    }

    

    //self.stateDropDowns.show()
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//     if iswallet == true
//     {
//        return 235
//        }
//       else
//     {
//        return 255
//        }
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}





extension CouponAvailabilityViewController : HTTP_POST_STRING_REQUEST_PROTOCOL{
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "COUPON_DETAILS_API" {

            print(responseDict)
            
            if (responseDict.value(forKey: "status")  as? Int) == 1{
                
                let mod = CouponDetailsJson(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.couponDetailsJson = mod
                if Singleton.sharedInstance.couponDetailsJson.couponDetails.count == 0
                {
                    iscouponvalue = false
                    self.tableView.isHidden = true
                    self.noLabel.isHidden = false
                } else {
                     iscouponvalue = true
                    self.tableView.isHidden = false
                    self.noLabel.isHidden = true
                }
                self.tableView.reloadData()
             
                
            } else {
               
            }
}
        
        else if APIKEY == "WALLET_AVAILABLE_API" {
            
            print(responseDict)
            
      self.hideActivityIndicator(uiView: self.view)
            if (responseDict.value(forKey: "status")  as? Int) == 1{
             
                let userDetailsArr = responseDict.value(forKey: "user_wallet") as! NSArray
              if  userDetailsArr.count == 0
                {
                    
                        self.tableView.isHidden = true
                        self.noLabel.isHidden = false
                       iswalletvalue = false
                }
              else
              {
                        self.tableView.isHidden = false
                        self.noLabel.isHidden = true
                   iswalletvalue = true
             }
                
                let userDetails = userDetailsArr[0] as? NSDictionary
                
            
                
               
                let totalWalletAmout = userDetails?.value(forKey: "total_wallet_amount") as! NSNumber
                self.totalwallet = String(format: "%@",totalWalletAmout)
                let usdeWalletAmout = userDetails?.value(forKey: "used_from_wallet") as! NSNumber
                self.usedWallet = String(format: "%@",usdeWalletAmout)
                let balenceWalletAmout = userDetails?.value(forKey: "balance_from_wallet") as! NSNumber
                self.balenceWallet = String(format: "%@",balenceWalletAmout)
                
                self.tableView.reloadData()
                
                
            } else {
                
            }
        }
        
}
}
