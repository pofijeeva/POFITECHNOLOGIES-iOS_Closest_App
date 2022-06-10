//
//  ReviewsShowViewController.swift
//  HomeStay
//
//  Created by Apple3 on 11/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class ReviewsShowViewController: BaseViewController {
    @IBOutlet weak var lbl_noReviews: UILabel!
    @IBOutlet weak var lbl_header: UILabel!
    @IBOutlet weak var btn_ReviewsAbt: UIButton!
    @IBOutlet weak var btn_Reviewsby: UIButton!
    @IBOutlet weak var tbl_reviewList: UITableView!
    @IBOutlet weak var view_Indicator: UIView!
    @IBOutlet weak var lbl_noReviewsImg: UIImageView!
    
    var headerTitle = String()
    var aboutyou = String()
    var byYou = String()
    var reviewAbt = NSArray()
    var reviewBy = NSArray()
    var isReviewabtYou = true
    var selectId = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_reviewList.tableFooterView = UIView()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.lbl_header.font = UIFont(name: SemiBoldFont, size: 16)
        self.lbl_noReviews.font = UIFont(name: RegularFont, size: 16)
        self.btn_ReviewsAbt.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.btn_Reviewsby.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.view_Indicator.backgroundColor = AppSecondColor
        userInfo()
    }
    func userInfo(){
        if (Reachability()?.isReachable)!
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            params = ["language":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "","currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","userid":login_session.value(forKey: "UserId")!]
            
            print(params)
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(USER_INFO_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.tbl_reviewList.isHidden = false
                    let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.userInfoModel = mod
                    if Singleton.sharedInstance.userInfoModel.reviewsAboutYou.count == 0
                    {
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.isHidden = false
                        self.lbl_noReviews.text = "No review(s) Found"
                        self.lbl_noReviewsImg.isHidden = false
                        
                    }
                    else
                    {
                        self.tbl_reviewList.isHidden = false
                        self.lbl_noReviews.isHidden = true
                        self.lbl_noReviewsImg.isHidden = true
                    }
                    
                    
                    self.tbl_reviewList.reloadData()
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
            
            
            
            
            //            self.showActivityIndicator(uiView: self.view)
            //            let parameterStr = "language=\(login_session.value(forKey: "APP_LANGUAGE") as? String ?? "")&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as? String ?? "")&userid=\(login_session.value(forKey: "UserId")!)"
            //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: USER_INFO_API, APIKEY: "USER_INFO_API")
            //            print(parameterStr)
        } else
        {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
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
    
    @IBAction func act_ReviewsAbt(_ sender: UIButton) {
        isReviewabtYou = true
        
        if Singleton.sharedInstance.userInfoModel.reviewsAboutYou.count == 0
        {
            self.tbl_reviewList.isHidden = true
            self.lbl_noReviews.text = "No review(s) Found"
            self.lbl_noReviews.isHidden = false
            self.lbl_noReviewsImg.isHidden = false
        }
        else {
            self.tbl_reviewList.isHidden = false
            self.lbl_noReviews.isHidden = true
            self.lbl_noReviewsImg.isHidden = true
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view_Indicator.frame = CGRect(x: 0, y: self.view_Indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
        
        
        
        self.tbl_reviewList.reloadData()
    }
    @IBAction func act_Reviewsby(_ sender: UIButton)
    {
        isReviewabtYou = false
        
        if Singleton.sharedInstance.userInfoModel.reviewsByYou.count == 0
        {
            self.tbl_reviewList.isHidden = true
            self.lbl_noReviews.text = "No review(s) Found"
            self.lbl_noReviews.isHidden = false
            self.lbl_noReviewsImg.isHidden = false
        }
        else {
            self.tbl_reviewList.isHidden = false
            self.lbl_noReviews.isHidden = true
            self.lbl_noReviewsImg.isHidden = true
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.view_Indicator.frame = CGRect(x: self.view.frame.width / 2, y: self.view_Indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
        
        
        self.tbl_reviewList.reloadData()
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension ReviewsShowViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isReviewabtYou == true
        {
            if Singleton.sharedInstance.userInfoModel != nil
            {
                return Singleton.sharedInstance.userInfoModel.reviewsAboutYou.count
            } else {
                return 0
            }
        }
        else
        {
            if Singleton.sharedInstance.userInfoModel != nil
            {
                return Singleton.sharedInstance.userInfoModel.reviewsByYou.count
            } else {
                return 0
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        
        if isReviewabtYou == true
        {
            if Singleton.sharedInstance.userInfoModel != nil
            {
                return 1
            } else {
                return 0
            }
        }
        else
        {
            if Singleton.sharedInstance.userInfoModel != nil
            {
                return 1
            } else {
                return 0
            }
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isReviewabtYou == true
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell else { return UITableViewCell() }
            
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell
            cell.selectionStyle = .none
            let dict = Singleton.sharedInstance.userInfoModel.reviewsAboutYou[indexPath.section]
            
            cell.lbl_reviewComments.font = UIFont(name: RegularFont, size: 14)
            cell.rentalNameButton.titleLabel?.font =  UIFont(name: RegularFont, size: 14)
            cell.reviewBookNoLbl.font = UIFont(name: RegularFont, size: 11)
            cell.lbl_userName.font = UIFont(name: RegularFont, size: 13)
            
            cell.lbl_reviewComments.text = dict.reviewerComments!
            cell.img_user.layer.masksToBounds = true
            cell.img_user.layer.cornerRadius = 30
            let imgURL = URL(string: Singleton.sharedInstance.userInfoModel.reviewsAboutYou[indexPath.section].reviwerImage!)
            cell.img_user.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
            cell.lbl_userName.text = "By " + dict.reviewerName!
            cell.rentalNameButton.setTitle(dict.reviewPropertyName!, for: .normal)
            cell.reviewBookNoLbl.text = String(format: "%@",dict.reviewBookingNo!)
            cell.reviewRatings.rating = Float(dict.reviewerRating)!
            cell.bookingDateLabel.text = dict.reviewDate!
            
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ByCell") as? ReviewsByTableViewCell else { return UITableViewCell() }
            
            //                let cell = tableView.dequeueReusableCell(withIdentifier: "ByCell") as? ReviewsByTableViewCell
            cell.selectionStyle = .none
            let dict = Singleton.sharedInstance.userInfoModel.reviewsByYou[indexPath.section]
            
            cell.lbl_reviews.font = UIFont(name: RegularFont, size: 14)
            cell.rentalNameButton.titleLabel?.font =  UIFont(name: RegularFont, size: 14)
            cell.rentalBookingLbl.font = UIFont(name: RegularFont, size: 11)
            cell.lbl_username.font = UIFont(name: RegularFont, size: 13)
            
            
            cell.lbl_reviews.text = dict.reviewerComments!
            cell.img_User.layer.masksToBounds = true
            cell.img_User.layer.cornerRadius = 30
            let imgURL = URL(string: Singleton.sharedInstance.userInfoModel.reviewsByYou[indexPath.section].reviwerImage!)
            cell.img_User.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
            cell.lbl_username.text = String(format: "To %@", dict.reviewerName!)
            cell.rentalNameButton.setTitle(dict.reviewPropertyName!, for: .normal)
            cell.rentalBookingLbl.text = dict.reviewBookingNo!
            cell.reviewDateLbl.text = dict.reviewDate!
            //String(format: "Booking No :%@" , dict.reviewBookingNo!)
            cell.reviewsRatingView.rating = Float(dict.reviewerRating)!
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white//hexStringToUIColor(hex: "#F1F1F1")
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableViewAutomaticDimension
    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if isReviewabtYou == true
    //        {
    //            return 120
    //        }
    //        else
    //        {
    //            return 120
    //        }
    //    }
    
}
