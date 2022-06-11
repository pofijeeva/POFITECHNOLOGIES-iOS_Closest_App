//
//  CouponsViewController.swift
//  HomeStay
//
//  Created by apple on 17/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CouponsViewController: BaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnAvailable: UIButton!
    @IBOutlet weak var btnUpcomming: UIButton!
    @IBOutlet weak var lblUnderLine1: UILabel!
    @IBOutlet weak var lblUnderline2: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var coupons = [ [String: Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = GlobalLanguageDictionary.object(forKey: "key_coupons") as? String ?? ""
        self.btnAvailable.setTitle(GlobalLanguageDictionary.object(forKey: "key_available") as? String ?? "", for: .normal)
        self.btnUpcomming.setTitle(GlobalLanguageDictionary.object(forKey: "key_commingSoon") as? String ?? "", for: .normal)
        self.lblTitle.font = UIFont(name: SemiBoldFont, size: 17)
        self.lblUnderline2.backgroundColor = AppColor
        self.lblUnderLine1.backgroundColor = AppColor
        self.btnAvailable.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)
        self.btnUpcomming.titleLabel?.font = UIFont(name: SemiBoldFont, size: 16)

        self.tblView.delegate = self
        self.tblView.dataSource = self
        btnAvailable.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": 1,
             "page_no":1
            ]
        self.getCouponsApiResponse(params: parameters)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblUnderline2.isHidden = true
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAvailable(_ sender: UIButton) {
        lblUnderLine1.isHidden = false
        lblUnderline2.isHidden = true
        
        btnAvailable.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        btnUpcomming.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": 1,
             "page_no":1
            ]
        self.getCouponsApiResponse(params: parameters)
    }
    
    @IBAction func actionUpcomming(_ sender: UIButton) {
        lblUnderLine1.isHidden = true
        lblUnderline2.isHidden = false
        
        btnUpcomming.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        btnAvailable.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": 2,
             "page_no":1
            ]
        self.getCouponsApiResponse(params: parameters)
    }
    
    func getCouponsApiResponse(params: [String:Any]){
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable ?? false) {
            APIManager.apiPostWithHeaders(serviceName: COUPONS, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Info", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    let data = responseDict.object(forKey: "data") as! [String:Any]
                    self.coupons =  data["coupon_list"] as! [[String:Any]]
                    
                    self.tblView.reloadData()
                }
                else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                    self.coupons.removeAll()
                    self.tblView.reloadData()
                   // self.showInformation(title: "Info", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
            }
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
    }

}


extension CouponsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if coupons.count == 0 {
            self.tblView.EmptyMessage(message: GlobalLanguageDictionary.object(forKey: "key_nodatafound") as? String ?? "", tableView: tblView)
        }
        else {
            self.tblView.EmptyMessage(message: "", tableView: tblView)
        }
        return self.coupons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponsTVCell") as? CouponsTVCell
        let couponObj = self.coupons[indexPath.item]
        cell?.lblCodeTitle.font = UIFont(name: SemiBoldFont, size: 14)
        cell?.lblCarName.font = UIFont(name: SemiBoldFont, size: 15)
        cell?.lblCode.font = UIFont(name: SemiBoldFont, size: 15)
        cell?.lblValidDate.font = UIFont(name: SemiBoldFont, size: 15)
        
        cell?.lblCodeTitle.text = couponObj["coupon_code"] as? String
        cell?.lblCarName.text = "\(GlobalLanguageDictionary.object(forKey: "key_forProperty") as? String ?? ""):" + " " + (couponObj["ren_title"] as? String ?? "")
        cell?.lblCode.text = "\(GlobalLanguageDictionary.object(forKey: "key_code") as? String ?? ""):" + " " + (couponObj["coupon_code"] as? String ?? "")
        cell?.lblValidDate.text = "\(GlobalLanguageDictionary.object(forKey: "key_validto") as? String ?? ""): " + (couponObj["dateto"] as? String ?? "").stringToDateFormatter(toFormate: "yyyy-MM-dd", fromFormate: "dd MMM,yyyy")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
}


extension String{
    func stringToDateFormatter(toFormate : String = "dd-MM-yyyy",fromFormate : String = "dd-MM-yyyy") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = toFormate
        let date = formatter.date(from: self)
        formatter.dateFormat = fromFormate
        return formatter.string(from: date ?? Date())
    }
}



extension UIView {
     func EmptyMessage(message:String, tableView :UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: SemiBoldFont, size: 15)
        messageLabel.sizeToFit()

        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none
    }
}
