
//  ReviewsViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 30/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Kingfisher
import DropDown
import AFNetworking

class ReviewsViewController: BaseViewController
{
    @IBOutlet weak var lbl_noReviews: UILabel!
    @IBOutlet weak var lbl_header: UILabel!
    @IBOutlet weak var btn_ReviewsAbt: UIButton!
    @IBOutlet weak var btn_Reviewsby: UIButton!
    @IBOutlet weak var tbl_reviewList: UITableView!
    @IBOutlet weak var view_Indicator: UIView!
    @IBOutlet weak var disAbtLbl: UILabel!
    @IBOutlet weak var disByLbl: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var reviewHeight: NSLayoutConstraint!

    @IBOutlet weak var DropView: UIView!
    @IBOutlet weak var EmptyImg: UIImageView!
    
    var isDropDown = Bool()
    var headerTitle = String()
    var aboutyou = String()
    var byYou = String()
    var reviewAbt = NSArray()
    var reviewBy = NSArray()
    var isReviewabtYou = true
    var selectId = Int()
    var selectDropCount = Int()
    var selectDropBYCount = Int()
    
    var reviewSelected = Bool()
    var disputeSelected = Bool()
    var Reviewsby = String()
    var statusChange = String()
    var ReviewsAbt = String()
    var dropDownArr = NSMutableArray()
    var ProcessingArr = NSMutableArray()
    var MainArray = NSMutableArray()
    var MainArrayBy = NSMutableArray()
    
    
    let stateDropDowns = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.stateDropDowns,
            
            ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lbl_header.font = UIFont(name: SemiBoldFont, size: 16)
        
         self.lbl_noReviews.font = UIFont(name: RegularFont, size: 15)
          self.disAbtLbl.font = UIFont(name: RegularFont, size: 15)
          self.disByLbl.font = UIFont(name: RegularFont, size: 15)
         self.btn_ReviewsAbt.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
         self.btn_Reviewsby.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
          self.dropDownButton.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 13)
        
        self.view_Indicator.backgroundColor = AppSecondColor
        
        tbl_reviewList.tableFooterView = UIView()
        DropView.layer.shadowColor = UIColor.lightGray.cgColor
        DropView.layer.shadowOffset = CGSize(width: 3, height: 3)
        DropView.layer.shadowOpacity = 0.7
        DropView.layer.shadowRadius = 4.0
        DropView.layer.cornerRadius = 5.0
        isDropDown = false
        self.selectDropCount = 0
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        
        dropDownArr = ["Processing","Completed","Reject","Pending"]
        
        disAbtLbl.text = String(format: "%d", Singleton.sharedInstance.userInfoModel.profileinfo[0].disputeAboutYouCount)
        disAbtLbl.isHidden = false
        disAbtLbl.layer.cornerRadius = 10
        disAbtLbl.layer.masksToBounds = true
        
        disByLbl.text = String(format: "%d", Singleton.sharedInstance.userInfoModel.profileinfo[0].disputeByYouCount)
        disByLbl.isHidden = false
        disByLbl.layer.cornerRadius = 10
        disByLbl.layer.masksToBounds = true
        
        self.lbl_header.text = "All Disputes"
        let id = Singleton.sharedInstance.selectedCategory!
        
        isReviewabtYou = true
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.DropView.isHidden = true
        self.tbl_reviewList.isHidden = true
        self.reviewHeight.constant = 15
        UserInformation()
            
            
//            self.showActivityIndicator(uiView: self.view)
//            let parameterStr = "language=\(login_session.value(forKey: "APP_LANGUAGE") as! String)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&userid=\(login_session.value(forKey: "UserId")!)"
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: USER_INFO_API, APIKEY: "USER_INFO_API")
//            print(parameterStr)
       
        
     }


func UserInformation(){
    if (Reachability()?.isReachable)!
    {
        
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        params = ["language":login_session.value(forKey: "APP_LANGUAGE") as! String,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"userid":login_session.value(forKey: "UserId")!]
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(USER_INFO_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.userInfoModel = mod
              
                
               
                 if Singleton.sharedInstance.userInfoModel.disputeByYou.count == 0
                {
                    self.tbl_reviewList.isHidden = true
                    self.lbl_noReviews.text = "No disputes by you"
                    self.EmptyImg.isHidden = true

                    self.lbl_noReviews.isHidden = false
                }
                else
                {
                    self.tbl_reviewList.isHidden = false
                     self.DropView.isHidden = false
                    self.reviewHeight.constant = 65
                    self.lbl_noReviews.isHidden = true
                    self.EmptyImg.isHidden = true

                    self.tbl_reviewList.reloadData()
                }
                if Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                {
                    self.tbl_reviewList.isHidden = true
                    self.lbl_noReviews.isHidden = false
                    self.DropView.isHidden = true

                    self.EmptyImg.isHidden = false
                    self.lbl_noReviews.text = "No disputes about you"
                    
                }else {
                    self.tbl_reviewList.isHidden = false
                    self.lbl_noReviews.isHidden = true
                    self.EmptyImg.isHidden = true

                    self.DropView.isHidden = false

                }
                
            }
                
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
    }else
    {
        self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
    }
}

    @IBAction func dropDoenButton(_ sender: Any)
    {
       
        var type = [String]()
        type = dropDownArr as! [String]
        stateDropDowns.anchorView = self.dropDownButton
        stateDropDowns.bottomOffset = CGPoint(x: 0, y: (self.dropDownButton?.bounds.height)!)
        stateDropDowns.dataSource = type
        stateDropDowns.backgroundColor = UIColor.white
        // Action triggered on selection
        stateDropDowns.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.isDropDown = true
            if index == 0
            {
                if self.isReviewabtYou == true
                {
                    self.MainArray.removeAllObjects()
                    let dictt = NSMutableDictionary()
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeAboutYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                            {
                                
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statuss")
                                dictt.setValue(createdDate, forKey: "createdDate")
                                dictt.setValue(hostname, forKey: "hostname")
                                dictt.setValue(userImage, forKey: "userImage")
                                dictt.setValue(messae, forKey: "messae")
                                dictt.setValue(rentalName, forKey: "rentalName")
                                dictt.setValue(bookingNo, forKey: "bookingNo")
                                
                                self.MainArray.add(dictt)
                                print(self.MainArray.count)
                                
                                
                                
                                
                            }
                            else
                            {
                                
                                
                            }
                            
                        }
                        if self.MainArray.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes about you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                        
                    }
                    
                    
                }
                else
                    
                {
                    self.MainArrayBy.removeAllObjects()
                    let dictt = NSMutableDictionary()
                    if  Singleton.sharedInstance.userInfoModel.disputeByYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes by you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else
                    {
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeByYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                            {
                                
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                
                                
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeByYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeByYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeByYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeByYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeByYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeByYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeByYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statussBy")
                                dictt.setValue(createdDate, forKey: "createdByDate")
                                dictt.setValue(hostname, forKey: "hostnameBy")
                                dictt.setValue(userImage, forKey: "userImageBy")
                                dictt.setValue(messae, forKey: "messaeBy")
                                dictt.setValue(rentalName, forKey: "rentalNameBy")
                                dictt.setValue(bookingNo, forKey: "bookingNoBy")
                                
                                self.MainArrayBy.add(dictt)
                                print(self.MainArrayBy.count)
                                
                                
                                
                                
                            }
                            else
                            {
                                
                            }
                            
                        }
                        if self.MainArrayBy.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes by you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                    }
                }
                
                self.dropDownButton.setTitle(self.dropDownArr.object(at: 0) as? String, for: .normal)
            }
           else if index == 1
            {
                if self.isReviewabtYou == true
                {
                    self.MainArray.removeAllObjects()
                    let dictt = NSMutableDictionary()
                    
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else
                    {
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeAboutYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                            {
                                
                                print(Singleton.sharedInstance.userInfoModel.disputeAboutYou.count)
                                
                                self.selectDropCount = self.selectDropCount  + 1
                                
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statuss")
                                dictt.setValue(createdDate, forKey: "createdDate")
                                dictt.setValue(hostname, forKey: "hostname")
                                dictt.setValue(userImage, forKey: "userImage")
                                dictt.setValue(messae, forKey: "messae")
                                dictt.setValue(rentalName, forKey: "rentalName")
                                dictt.setValue(bookingNo, forKey: "bookingNo")
                                
                                self.MainArray.add(dictt)
                                print(self.MainArray.count)
                                
                                
                            }
                        }
                        
                        if self.MainArray.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes about you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                        
                        
                    }
                    
                }
                else
                    
                {
                    let dictt = NSMutableDictionary()
                    self.MainArrayBy.removeAllObjects()
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeByYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                            {
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeByYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeByYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeByYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeByYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeByYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeByYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeByYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statussBy")
                                dictt.setValue(createdDate, forKey: "createdByDate")
                                dictt.setValue(hostname, forKey: "hostnameBy")
                                dictt.setValue(userImage, forKey: "userImageBy")
                                dictt.setValue(messae, forKey: "messaeBy")
                                dictt.setValue(rentalName, forKey: "rentalNameBy")
                                dictt.setValue(bookingNo, forKey: "bookingNoBy")
                                self.MainArrayBy.add(dictt)
                                print(self.MainArrayBy.count)
                                
                                
                                
                                
                            }
                            else
                            {
                                
                            }
                        }
                        if self.MainArrayBy.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes by you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                    }
                    
                }
                self.dropDownButton.setTitle(self.dropDownArr.object(at: 1) as? String, for: .normal)
            }
            else if index == 2
            {
                if self.isReviewabtYou == true
                {
                    self.MainArray.removeAllObjects()
                    let dictt = NSMutableDictionary()
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeAboutYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                            {
                                
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statuss")
                                dictt.setValue(createdDate, forKey: "createdDate")
                                dictt.setValue(hostname, forKey: "hostname")
                                dictt.setValue(userImage, forKey: "userImage")
                                dictt.setValue(messae, forKey: "messae")
                                dictt.setValue(rentalName, forKey: "rentalName")
                                dictt.setValue(bookingNo, forKey: "bookingNo")
                                self.MainArray.add(dictt)
                                print(self.MainArray.count)
                                
                                
                                
                                
                            }
                            else
                            {
                                
                            }
                        }
                        if self.MainArray.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes about you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                    }
                    
                }
                else
                    
                {
                    let dictt = NSMutableDictionary()
                    self.MainArrayBy.removeAllObjects()
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeByYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                            {
                                
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeByYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeByYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeByYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeByYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeByYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeByYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeByYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statussBy")
                                dictt.setValue(createdDate, forKey: "createdByDate")
                                dictt.setValue(hostname, forKey: "hostnameBy")
                                dictt.setValue(userImage, forKey: "userImageBy")
                                dictt.setValue(messae, forKey: "messaeBy")
                                dictt.setValue(rentalName, forKey: "rentalNameBy")
                                dictt.setValue(bookingNo, forKey: "bookingNoBy")
                                self.MainArrayBy.add(dictt)
                                print(self.MainArrayBy.count)
                                
                                
                                
                            }
                            else
                            {
                                
                            }
                            
                        }
                        if self.MainArrayBy.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes by you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                        
                    }
                }
                self.dropDownButton.setTitle(self.dropDownArr.object(at: 2) as? String, for: .normal)
            }
            else
            {
                if self.isReviewabtYou == true
                {
                    self.MainArray.removeAllObjects()
                    let dictt = NSMutableDictionary()
                    if  Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes about you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeAboutYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                            {
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeAboutYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statuss")
                                
                                dictt.setValue(createdDate, forKey: "createdDate")
                                dictt.setValue(hostname, forKey: "hostname")
                                dictt.setValue(userImage, forKey: "userImage")
                                dictt.setValue(messae, forKey: "messae")
                                dictt.setValue(rentalName, forKey: "rentalName")
                                dictt.setValue(bookingNo, forKey: "bookingNo")
                                self.MainArray.add(dictt)
                                print(self.MainArray.count)
                                
                                
                                
                            }
                            
                        }
                        if self.MainArray.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes About you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                        
                    }
                    
                    
                }
                else
                    
                {
                    let dictt = NSMutableDictionary()
                    self.MainArrayBy.removeAllObjects()
                    if  Singleton.sharedInstance.userInfoModel.disputeByYou.count == 0
                    {
                        
                        self.tbl_reviewList.isHidden = true
                        self.lbl_noReviews.text = "No disputes By you"
                        self.lbl_noReviews.isHidden = false
                        self.EmptyImg.isHidden = false

                        
                    }
                    else{
                        for i in 0..<Singleton.sharedInstance.userInfoModel.disputeByYou.count
                        {
                            if item == Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                                
                            {
                                
                                
                                self.selectDropCount =  self.selectDropCount + 1
                                let hostname = Singleton.sharedInstance.userInfoModel.disputeByYou[i].hostName
                                let userImage = Singleton.sharedInstance.userInfoModel.disputeByYou[i].userImage
                                let messae = Singleton.sharedInstance.userInfoModel.disputeByYou[i].message
                                let rentalName = Singleton.sharedInstance.userInfoModel.disputeByYou[i].rentalName
                                let bookingNo = Singleton.sharedInstance.userInfoModel.disputeByYou[i].bookingNo
                                let createdDate = Singleton.sharedInstance.userInfoModel.disputeByYou[i].createdDate
                                let status = Singleton.sharedInstance.userInfoModel.disputeByYou[i].status
                                let disputeIdd = Singleton.sharedInstance.userInfoModel.disputeByYou[i].disputeId
                                
                                dictt.setValue(disputeIdd, forKey: "disputeIdd")
                                dictt.setValue(status, forKey: "statussBy")
                                dictt.setValue(createdDate, forKey: "createdByDate")
                                dictt.setValue(hostname, forKey: "hostnameBy")
                                dictt.setValue(userImage, forKey: "userImageBy")
                                dictt.setValue(messae, forKey: "messaeBy")
                                dictt.setValue(rentalName, forKey: "rentalNameBy")
                                dictt.setValue(bookingNo, forKey: "bookingNoBy")
                                
                                self.MainArrayBy.add(dictt)
                                print(self.MainArrayBy.count)
                                
                                
                                
                            }
                            
                        }
                        if self.MainArrayBy.count == 0
                        {
                            self.tbl_reviewList.isHidden = true
                            self.lbl_noReviews.text = "No disputes by you"
                            self.lbl_noReviews.isHidden = false
                            self.EmptyImg.isHidden = false

                        }
                        else
                        {
                            self.tbl_reviewList.reloadData()
                            self.tbl_reviewList.isHidden = false
                            self.lbl_noReviews.isHidden = true
                            self.EmptyImg.isHidden = true

                        }
                    }
                }
                self.dropDownButton.setTitle(self.dropDownArr.object(at: 3) as? String, for: .normal)
            }
        }
        self.stateDropDowns.show()
    }
    
    @IBAction func act_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_ReviewsAbt(_ sender: UIButton)
    {
        
        isReviewabtYou = true
        
        
        if isDropDown == true
        {
            
            if MainArray.count == 0
            {
                self.tbl_reviewList.isHidden = true
                self.lbl_noReviews.text = "No disputes about you"
                self.lbl_noReviews.isHidden = false
                self.EmptyImg.isHidden = false

            } else {
                self.tbl_reviewList.isHidden = false
                self.lbl_noReviews.isHidden = true
                self.EmptyImg.isHidden = true

                
            }
        }
            
        else
            
        {
            
            if Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
            {
                self.tbl_reviewList.isHidden = true
                self.lbl_noReviews.text = "No disputes about you"
                self.lbl_noReviews.isHidden = false
                self.EmptyImg.isHidden = false

            } else {
                self.tbl_reviewList.isHidden = false
                self.lbl_noReviews.isHidden = true
                self.EmptyImg.isHidden = true

                self.tbl_reviewList.reloadData()
            }
            
        }
       
        UIView.animate(withDuration: 0.25, animations: {
            self.view_Indicator.frame = CGRect(x: 0, y: self.view_Indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
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
    
    @IBAction func act_Reviewsby(_ sender: UIButton)
    {
        
        isReviewabtYou = false
        if isDropDown == true
        {
            if MainArrayBy.count == 0
            {
                self.tbl_reviewList.isHidden = true
                self.lbl_noReviews.text = "No disputes by you"
                self.lbl_noReviews.isHidden = false
                self.EmptyImg.isHidden = false

            } else {
                self.tbl_reviewList.isHidden = false
                self.lbl_noReviews.isHidden = true
                self.EmptyImg.isHidden = true

                self.tbl_reviewList.reloadData()
            }
            
            
        }
            
            
        else
        {
            if Singleton.sharedInstance.userInfoModel.disputeByYou.count == 0
            {
                self.tbl_reviewList.isHidden = true
                self.lbl_noReviews.text = "No disputes by you"
                self.lbl_noReviews.isHidden = false
                self.EmptyImg.isHidden = false

            } else {
                self.tbl_reviewList.isHidden = false
                self.lbl_noReviews.isHidden = true
                self.EmptyImg.isHidden = true

                self.tbl_reviewList.reloadData()
            }
        }
        
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view_Indicator.frame = CGRect(x: self.view.frame.width / 2, y: self.view_Indicator.frame.origin.y, width: self.view.frame.width / 2, height: 3)
        })
        
        self.tbl_reviewList.reloadData()
        
        
    }
}

extension ReviewsViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isDropDown == false
        {
            if isReviewabtYou == true
            {
                if Singleton.sharedInstance.userInfoModel != nil
                {
                    return Singleton.sharedInstance.userInfoModel.disputeAboutYou.count
                } else {
                    return 0
                }
            }
            else
            {
                if Singleton.sharedInstance.userInfoModel != nil
                {
                    return Singleton.sharedInstance.userInfoModel.disputeByYou.count
                } else {
                    return 0
                }
                
                
            }
        }
            
        else
            
        {
            if isReviewabtYou == true
            {
                
                return MainArray.count
                
            }
            else
            {
                
                return MainArrayBy.count
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isDropDown == false
        {
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
            
        else
            
        {
            if isReviewabtYou == true
            {
                
                return 1
                
            }
            else
            {
                
                return 1
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if isDropDown == false
        {
            if isReviewabtYou == true
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell
                cell!.selectionStyle = .none
                let dict = Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section]
                
                 cell!.lbl_reviewComments.font = UIFont(name: SemiBoldFont, size: 15)
                cell!.rentalName.font = UIFont(name: RegularFont, size: 15)
                 cell!.lbl_userName.font = UIFont(name: RegularFont, size: 15)
                 cell!.bookingDateLabel.font = UIFont(name: RegularFont, size: 15)
                 cell!.bookingIdLabel.font = UIFont(name: RegularFont, size: 14)
                
                cell!.acceptBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                cell!.rejectBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
                
                cell!.lbl_reviewComments.text = dict.message!
                cell!.img_user.layer.masksToBounds = true
                cell!.img_user.layer.cornerRadius = 40
                let imgURL = URL(string: Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].userImage!)
                cell!.img_user.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
                cell!.rentalName.text = dict.rentalName!
                if dict.hostName != nil
                {
                    cell!.lbl_userName.text = String(format: "by %@", dict.hostName!)
                }
                
                cell!.bookingIdLabel.text = dict.bookingNo!
                let date = dict.createdDate!
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let dateFromString : NSDate = dateFormatter.date(from: date)! as NSDate
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let datenew = dateFormatter.string(from: dateFromString as Date)
                cell!.bookingDateLabel.text = datenew
                
                cell!.acceptBtn.tag = indexPath.section
                cell!.rejectBtn.tag = indexPath.section
                if Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].status == "Pending"
                {
                    cell!.acceptBtn.isHidden = false
                    cell!.rejectBtn.isHidden = false
                    cell!.acceptBtn.isEnabled = true
                    cell!.rejectBtn.isEnabled = true
                    cell!.acceptBtn.setTitle("Accept", for: .normal)
                    cell!.rejectBtn.setTitle("Reject", for: .normal)
                    
                }
                else if Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].status == "Pending Request Expired"
                {
                    cell!.acceptBtn.isHidden = false
                    cell!.acceptBtn.setTitle("Expired", for: .normal)
                    
                    cell!.acceptBtn.isEnabled = false
                    
                    cell!.rejectBtn.isHidden = true
                }
                else if Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].status == "Reject"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Rejected", for: .normal)
                    cell!.acceptBtn.isEnabled = false
                    
                    cell!.rejectBtn.isHidden = true
                }
                    
                else if Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].status == "Processing"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Processing", for: .normal)
                    cell!.acceptBtn.isEnabled = true
                    
                    cell!.rejectBtn.isHidden = true
                }
                    
                    
                else if Singleton.sharedInstance.userInfoModel.disputeAboutYou[indexPath.section].status == "Completed"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Completed", for: .normal)
                    cell!.acceptBtn.isEnabled = false
                    
                    cell!.rejectBtn.isHidden = true
                }
                
                cell!.acceptBtn.addTarget(self, action: #selector(acceptPressed(_:)), for: .touchUpInside)
                cell!.rejectBtn.addTarget(self, action: #selector(rejectPressed(_:)), for: .touchUpInside)
                
                
                cell?.selectionStyle = .none
                return cell!
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ByCell") as? ReviewsByTableViewCell
                cell!.selectionStyle = .none
                let dict = Singleton.sharedInstance.userInfoModel.disputeByYou[indexPath.section]
                
                
                cell!.lbl_reviews.font = UIFont(name: SemiBoldFont, size: 15)
                             cell!.rentalName.font = UIFont(name: RegularFont, size: 15)
                              cell!.hostName.font = UIFont(name: RegularFont, size: 15)
                              cell!.bookingDateLabel.font = UIFont(name: RegularFont, size: 15)
                              cell!.bookingIdLabel.font = UIFont(name: RegularFont, size: 12)
                              cell!.statusLabel.font = UIFont(name: RegularFont, size: 15)
                         
                
                
                
                cell!.lbl_reviews.text = dict.message!
                cell!.img_User.layer.masksToBounds = true
                cell!.img_User.layer.cornerRadius = 40
                let imgURL = URL(string: Singleton.sharedInstance.userInfoModel.disputeByYou[indexPath.section].userImage!)
                cell!.img_User.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
                cell!.rentalName.text = dict.rentalName!
                

                
                if Singleton.sharedInstance.userInfoModel.disputeByYou[indexPath.section].status == "Reject"
                {
                    cell!.statusLabel.text = "Rejected"
                }
                    
                else
                {
                    cell!.statusLabel.text = dict.status!
                }
                
                
                cell!.hostName.text =  String(format: "to %@", dict.hostName!)
                
                cell!.bookingIdLabel.text = dict.bookingNo!
                
                let datee = dict.createdDate
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let dateFromString   = dateFormatter.date(from: datee!)! as NSDate
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let datenew = dateFormatter.string(from: dateFromString as Date)
                
                cell!.bookingDateLabel.text = datenew
                cell?.selectionStyle = .none
                
                return cell!
            }
        }
            
        else
        {
            
            if isReviewabtYou == true
            {
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell
                cell!.selectionStyle = .none
                cell!.lbl_reviewComments.text =  (self.MainArray[indexPath.section] as AnyObject).value(forKey: "messae") as? String
                
                
                cell!.img_user.layer.masksToBounds = true
                cell!.img_user.layer.cornerRadius = 40
                
                let imaageUrl =  (self.MainArray[indexPath.section] as AnyObject).value(forKey: "userImage") as? String
                
                let imgURL = URL(string: imaageUrl!)
                cell!.img_user.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
                
                cell!.rentalName.text =  (self.MainArray[indexPath.section] as AnyObject).value(forKey: "rentalName") as? String
                
                
                cell!.lbl_userName.text = String(format: "by %@",  (self.MainArray[indexPath.section] as AnyObject).value(forKey: "hostname") as! CVarArg)
                
                cell!.bookingIdLabel.text = (self.MainArray[indexPath.section] as AnyObject).value(forKey: "bookingNo") as? String
                
                let date = (self.MainArray[indexPath.section] as AnyObject).value(forKey: "createdDate") as? String
                let dateFormatter = DateFormatter()
              
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let datenew = dateFormatter.string(from: dateFromString as Date)
                cell!.bookingDateLabel.text = datenew
                
                cell!.acceptBtn.tag = indexPath.section
                cell!.rejectBtn.tag = indexPath.section
                
                if (self.MainArray[indexPath.section] as AnyObject).value(forKey: "statuss") as? String == "Pending"
                {
                    cell!.acceptBtn.isHidden = false
                    cell!.rejectBtn.isHidden = false
                    cell!.acceptBtn.isEnabled = true
                    cell!.rejectBtn.isEnabled = true
                    
                    
                }
                else if (self.MainArray[indexPath.section] as AnyObject).value(forKey: "statuss") as? String == "Reject"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Rejected", for: .normal)
                    cell!.acceptBtn.isEnabled = false
                    
                    cell!.rejectBtn.isHidden = true
                }
                    
                else if (self.MainArray[indexPath.section] as AnyObject).value(forKey: "statuss") as? String == "Processing"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Processing", for: .normal)
                    cell!.acceptBtn.isEnabled = true
                    
                    cell!.rejectBtn.isHidden = true
                }
                    
                    
                else if (self.MainArray[indexPath.section] as AnyObject).value(forKey: "statuss") as? String == "Completed"
                {
                    cell!.acceptBtn.isHidden = false
                    
                    cell!.acceptBtn.setTitle("Completed", for: .normal)
                    cell!.acceptBtn.isEnabled = false
                    
                    cell!.rejectBtn.isHidden = true
                }
                
                cell!.acceptBtn.addTarget(self, action: #selector(acceptPressed(_:)), for: .touchUpInside)
                cell!.rejectBtn.addTarget(self, action: #selector(rejectPressed(_:)), for: .touchUpInside)
                
                
                cell?.selectionStyle = .none
                return cell!
            }
                
            else{
                
                
                
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ByCell") as? ReviewsByTableViewCell
                cell!.selectionStyle = .none
                //let dict = Singleton.sharedInstance.userInfoModel.disputeByYou[indexPath.row]
                cell!.lbl_reviews.text = (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "messaeBy") as? String
                cell!.img_User.layer.masksToBounds = true
                cell!.img_User.layer.cornerRadius = 40
                //                let imgURL = URL(string: (self.MainArrayBy[indexPath.row] as AnyObject).value(forKey: "userImageBy") as! String)
                //                cell!.img_User.kf.setImage(with: imgURL!)
                
                
                let imaageUrl =  (self.self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "userImageBy") as? String
                
                let imgURL = URL(string: imaageUrl!)
                cell!.img_User.kf.setImage(with: imgURL!, placeholder:UIImage(named:"user"))
                
                cell!.rentalName.text = (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "rentalNameBy") as? String
                
                
                if (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "statussBy") as? String == "Reject"
                {
                    cell!.statusLabel.text = "Rejected"
                }
                    
                else
                {
                    cell!.statusLabel.text = (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "statussBy") as? String
                }
                
                
                cell!.hostName.text =  String(format: "to %@", ((self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "hostnameBy") as? String)!)
                
                cell!.bookingIdLabel.text = (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "bookingNoBy") as? String
                
                let date = (self.MainArrayBy[indexPath.section] as AnyObject).value(forKey: "createdByDate") as? String
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                 dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let datenew = dateFormatter.string(from: dateFromString as Date)
                cell!.bookingDateLabel.text = datenew
                
                cell?.selectionStyle = .none
                
                return cell!
            }
        }
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        if isReviewabtYou == true
    //        {
    //            return 186
    //        }
    //        else
    //        {
    //            return 170
    //        }
    //    }
    @objc func acceptPressed(_ sender: UIButton) {
        let buttonRow = sender.tag
        print(buttonRow)        //  let cell = sender.superview?.superview as? ReviewsTableViewCell
        
        if isDropDown == false
        {
            let disputeIdStr = String(format: "%@", Singleton.sharedInstance.userInfoModel.disputeAboutYou[buttonRow].disputeId)
            let bookingIdStr = String(format: "%@", Singleton.sharedInstance.userInfoModel.disputeAboutYou[buttonRow].bookingNo)
            
            let statusChanged = String(format: "%@", Singleton.sharedInstance.userInfoModel.disputeAboutYou[buttonRow].status)
            if statusChanged == "Processing"
            {
                self.statusChange = "Completed"
            }
            else
                
            {
                self.statusChange = "Processing"
            }
            
            
            if (Reachability()?.isReachable)!
            {
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                params = ["disputeId":disputeIdStr,"booking_no":bookingIdStr,"change_status":self.statusChange]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(DISPUTE_STATUS_CHANGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as! String)
                       self.UserInformation()
                        self.tbl_reviewList.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
                
//                self.showActivityIndicator(uiView: self.view)
//                let parameterStr = "disputeId=\(disputeIdStr)&booking_no=\(bookingIdStr)&change_status=\(self.statusChange)"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_STATUS_CHANGE, APIKEY: "DISPUTE_STATUS_CHANGE")
//                print(parameterStr)
            }
            else
            {
                self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        }
        else
            
        {
            let disputeIdStr = (self.self.MainArray[buttonRow] as AnyObject).value(forKey: "disputeIdd") as? String
            
            let bookingIdStr = (self.self.MainArray[buttonRow] as AnyObject).value(forKey: "bookingNo") as? String
            
            
            let statusChanged = (self.self.MainArray[buttonRow] as AnyObject).value(forKey: "statuss") as? String
            
            if statusChanged == "Processing"
            {
                self.statusChange = "Completed"
            }
            else
                
            {
                self.statusChange = "Processing"
            }
            
            
            if (Reachability()?.isReachable)!
            {
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                 params = ["disputeId":disputeIdStr!,"booking_no":bookingIdStr!,"change_status":self.statusChange]
               
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(DISPUTE_STATUS_CHANGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as! String)
                        self.UserInformation()
                        self.tbl_reviewList.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
//                self.showActivityIndicator(uiView: self.view)
//                let parameterStr = "disputeId=\(disputeIdStr!)&booking_no=\(bookingIdStr!)&change_status=\(self.statusChange)"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_STATUS_CHANGE, APIKEY: "DISPUTE_STATUS_CHANGE")
//                print(parameterStr)
            }
            else
            {
                self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        }
    }
    @objc func rejectPressed(_ sender: UIButton) {
        let buttonRow = sender.tag
        print(buttonRow)
        //  let cell = sender.superview?.superview as? ReviewsTableViewCell
        
        if isDropDown == false
        {
            if (Reachability()?.isReachable)!
            {
                self.showActivityIndicator(uiView: self.view)
                Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
                
                let disputeIdStr = String(format: "%@", Singleton.sharedInstance.userInfoModel.disputeAboutYou[buttonRow].disputeId)
                
                let bookingIdStr = String(format: "%@", Singleton.sharedInstance.userInfoModel.disputeAboutYou[buttonRow].bookingNo)
                
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                 params = ["disputeId":disputeIdStr,"booking_no":bookingIdStr,"change_status":"Reject"]
               
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(DISPUTE_STATUS_CHANGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as! String)
                        self.UserInformation()
                        self.tbl_reviewList.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
//                let parameterStr = "disputeId=\(disputeIdStr)&booking_no=\(bookingIdStr)&change_status=\("Reject")"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_STATUS_CHANGE, APIKEY: "DISPUTE_STATUS_CHANGE")
//                print(parameterStr)
            }
            else
            {
                self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        }
        else{
            if (Reachability()?.isReachable)!
            {
                self.showActivityIndicator(uiView: self.view)
                Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
                
                let disputeIdStr = (self.self.MainArray[buttonRow] as AnyObject).value(forKey: "disputeIdd") as? String
                
                let bookingIdStr = (self.self.MainArray[buttonRow] as AnyObject).value(forKey: "bookingNo") as? String
                
                showActivityIndicator(uiView: self.view)
                var params = NSMutableDictionary()
                
                 params = ["disputeId":disputeIdStr!,"booking_no":bookingIdStr!,"change_status":"Reject"]
                
              
                
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(DISPUTE_STATUS_CHANGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.hideActivityIndicator(uiView: self.view)
                    if responseDict.value(forKey: "status") as! Int == 1 {
                        self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as! String)
                        self.UserInformation()
                        self.tbl_reviewList.reloadData()
                        
                    }
                        
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                    }
                }, failure: { (operation, error) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
                
                
                
//                let parameterStr = "disputeId=\(disputeIdStr!)&booking_no=\(bookingIdStr!)&change_status=\("Reject")"
//                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_STATUS_CHANGE, APIKEY: "DISPUTE_STATUS_CHANGE")
//                print(parameterStr)
            }
            else
            {
                self.showInformation(title: "Warning", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
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
    
}
extension ReviewsViewController : HTTP_POST_STRING_REQUEST_PROTOCOL
{
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String){
        self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "USER_INFO_API"
        {
            if errorDict.count == 0 {
                let mod = UserInfo(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.userInfoModel = mod
                self.tbl_reviewList.isHidden = false
                
                if Singleton.sharedInstance.userInfoModel.disputeAboutYou.count == 0
                {
                    self.tbl_reviewList.isHidden = true
                    self.lbl_noReviews.isHidden = false
                    self.lbl_noReviews.text = "No disputes about you"
                    
                }
                else
                {
                    self.tbl_reviewList.isHidden = false
                    self.lbl_noReviews.isHidden = true
                    self.tbl_reviewList.reloadData()
                }
                
                
                if Singleton.sharedInstance.userInfoModel.disputeByYou.count == 0
                {
                    self.tbl_reviewList.isHidden = true
                    self.lbl_noReviews.text = "No disputes by you"
                    self.lbl_noReviews.isHidden = false
                }
                else
                {
                    self.tbl_reviewList.isHidden = false
                    self.lbl_noReviews.isHidden = true
                    self.tbl_reviewList.reloadData()
                }
                
                
            }
            
            self.tbl_reviewList.reloadData()
        }
        if APIKEY == "DISPUTE_STATUS_CHANGE"
        {
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                print(responseDict)
                Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
                let id = Singleton.sharedInstance.selectedCategory!
                if responseDict.value(forKey: "status") as! Int == 1{
                    
                    self.showInformation(title: "Message", message: responseDict.value(forKey: "message") as! String)
                    let parameterStr = "lang_code=\(login_session.value(forKey: "APP_LANGUAGE") as! String)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)"
                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: USER_INFO_API, APIKEY: "USER_INFO_API")
                    self.tbl_reviewList.reloadData()
                    
                }
            }
        }
        else
        {
            print("No Data")
        }
    }
    
}


