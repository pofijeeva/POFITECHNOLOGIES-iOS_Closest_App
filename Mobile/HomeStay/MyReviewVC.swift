//
//  MyReviewVC.swift
//  HomeStay
//
//  Created by apple on 22/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MyReviewVC: BaseViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var btnPropertyReview: UIButton!
    @IBOutlet weak var btnBookingReview: UIButton!
    @IBOutlet var lblUnderline1: UILabel!
    @IBOutlet var lblUnderline2: UILabel!
    
    var review_details = [ [String: Any]]()
    var isLoading:Bool = true
    var currentPage = 1
    var msgDIct = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPropertyReview.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        lblUnderline2.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        lblUnderline2.isHidden = true
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": "host", "page_no":1
            ]
        self.getReviewApiResponse(params: parameters)

        
    }
    
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionPropertyReviews(_ sender: UIButton) {
        lblUnderline1.isHidden = false
        lblUnderline2.isHidden = true
        
        btnPropertyReview.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        btnBookingReview.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": "host","page_no":1
            ]
        self.getReviewApiResponse(params: parameters)

    }
    @IBAction func actionBookingReviews(_ sender: UIButton) {
        lblUnderline1.isHidden = true
        lblUnderline2.isHidden = false
        
        btnBookingReview.setTitleColor(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), for: .normal)
        btnPropertyReview.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type": "guest","page_no":1
            ]
        self.getReviewApiResponse(params: parameters)

    }
    
    
    
    func getReviewApiResponse(params: [String:Any]) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            APIManager.apiPostWithHeaders(serviceName: REVIEWDETAILS, parameters: params) { (json:NSDictionary?, error:NSError?) in
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
                        self.review_details.removeAll()
                        let data = responseDict.object(forKey: "data") as! [String:Any]
                        self.review_details.append(contentsOf: data["review_details"] as! [[String:Any]])
                        
                        self.tblView.scrollToBottom()
                        self.tblView.reloadData()
                    }
                    else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                        if self.isLoading == false {
                            self.review_details.removeAll()
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
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
        
    }
    
}


extension MyReviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review_details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewTVCell", for: indexPath) as? MyReviewTVCell
       
        cell?.lblName.font = UIFont(name: SemiBoldFont, size: 14)
        cell?.lblDate.font = UIFont(name: SemiBoldFont, size: 16)
        cell?.lblName_Date.font = UIFont(name: SemiBoldFont, size: 15)
        
        let reviewObj = review_details[indexPath.row]
        let imgURL = (reviewObj["reviwer_image"] as? String ?? "")
        cell?.imgProfile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        cell?.lblName.text = reviewObj["reviewer_comments"] as? String ?? ""
//        "\(msgObj["ren_title"] as? String ?? ""):\(msgObj["bookingno"] as? String ?? "")"
        
        cell?.lblDate.text = "\("at " +  (reviewObj["review_property_name"] as? String ?? "")):\("for Booking No: " +  (reviewObj["review_booking_no"] as? String ?? ""))"
        cell?.lblName_Date.text = "\("by " + (reviewObj["reviewer_name"] as? String ?? "")):\("- " + (reviewObj["review_date"] as? String ?? ""))"
        cell?.ratingView.rating = Double(reviewObj["reviewer_rating"] as? Int ?? 0)
                                        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
