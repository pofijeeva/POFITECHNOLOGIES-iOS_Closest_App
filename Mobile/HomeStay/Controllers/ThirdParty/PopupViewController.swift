 //
 //  PopupViewController.swift
 //  HomeStay
 //
 //  Created by Apple2 on 23/12/18.
 //  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
 //
 
 import UIKit
 import MIBlurPopup
 
 class PopupViewController: BaseViewController {
    
    @IBOutlet weak var view_Buttons: UIView!
    @IBOutlet weak var btn_Cancel: UIButton!
    @IBOutlet weak var btn_Review: UIButton!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var okaybut: UIButton!
    @IBOutlet weak var btn_Msg: UIButton!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var tagLineLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageview: UIView!
    @IBOutlet weak var reviewView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var myreviewView: UIView!
    @IBOutlet weak var myreview: UILabel!
    @IBOutlet weak var reviewImg: UIImageView!
    @IBOutlet weak var bookingnum: UILabel!
    @IBOutlet weak var reviewMail: UILabel!
    @IBOutlet weak var reviewMsg: UILabel!
    @IBOutlet weak var reviewRat: FloatRatingView!
    @IBOutlet weak var cancelButton: UIButton!
    
    var canclbutton : String!
    var cancelPercent = String()
    var disputer_ID = Int()
    var propertyId = Int()
    var bookingNum = String()
    var cancelPercentage = String()
    var hostid = Int()
    var messages = String()
    var rating = String()
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_Buttons.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        self.messageview.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        self.reviewView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        self.cancelView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        self.messageView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        self.ratingView.setBorder(withColor: UIColor.lightGray, width: 1.0, cornerRadius: 5.0)
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if UserDefaults.standard.value(forKey: "CancelKey") != nil {
            btn_Cancel.setTitle(UserDefaults.standard.value(forKey: "CancelKey") as? String, for: .normal)
            self.selectedIndex = 1
        }
        else if UserDefaults.standard.value(forKey: "DisputeKey") != nil {
            btn_Cancel.setTitle(UserDefaults.standard.value(forKey: "DisputeKey") as? String, for: .normal)
            self.selectedIndex = 2
        }
        else
        {
            if UserDefaults.standard.value(forKey: "CancelKey") != nil {
                btn_Cancel.setTitle(UserDefaults.standard.value(forKey: "CancelKey") as? String, for: .normal)
            }
            print("Ok")
        }
        if UserDefaults.standard.value(forKey: "ShowReview") != nil {
            btn_Review.setTitle(UserDefaults.standard.value(forKey: "ShowReview") as? String, for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.messageView.isHidden = true
        self.myreviewView.isHidden = true
        let result = resultVal.value(forKey: "CHECKKEY") as? String
        if result == "Cancel"
        {
            self.nameLbl.text = "Cancel"
            btn_Cancel.setTitle(result, for: .normal)
        }
        else{
            self.nameLbl.text = "Dispute"
            btn_Cancel.setTitle(result, for: .normal)
            print("ok")
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // dismiss(animated: true)
        
    }
    @IBAction func act_Cancel(_ sender: UIButton) {
        let result = resultVal.value(forKey: "CHECKKEY") as? String
        if result == "Canceled" {
            
            showInformation(title: "Closest", message: "Trip has been already cancelled")
            
        }else if  result == "Disputed" {
            showInformation(title: "Closest", message: "Trip has been already Disputed")
        }else {
            
            self.tagLineLbl.text = ""
            self.ratingView.isHidden = true
            self.messageView.isHidden = false
        }
        
    }
    @IBAction func CancelAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Review(_ sender: UIButton) {
        
        let check = UserDefaults.standard.value(forKey: "ShowReview") as? String
        if  check == "My Review" {
            self.messageView.isHidden = true
            self.view_Buttons.isHidden = true
            self.myreview.isHidden = false
            self.myreview.text = "Your Review"
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory!
            let parameterStr = "booking_no=\(self.bookingNum)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&user_id=\(login_session.value(forKey: "UserId")!)"
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: HOTEL_YOUR_REVIEW, APIKEY: "HOTEL_YOUR_REVIEW")
            print(parameterStr)
            
        }
        else {
            self.nameLbl.text = "Add Review"
            self.tagLineLbl.text = "My review* (Exclude personally identifiable information such as name, email address, etc )"
            UserDefaults.standard.set("REVIEW", forKey: "REVIEWKEY")
            self.ratingView.isHidden = false
            self.messageView.isHidden = false
            self.okaybut.setTitle("Submit my Review", for: .normal)
        }
    }
    
    @IBAction func act_Msg(_ sender: UIButton) {
        self.nameLbl.text = "Message"
        self.tagLineLbl.text = "Message to Host"
        UserDefaults.standard.set("MESSAGE", forKey: "MESSAGEKEY")
        self.ratingView.isHidden = true
        self.view_Buttons.isHidden = true
        self.messageView.isHidden = false
    }
    
    // mark : messgae
    func messageAct() {
        if Reachability()!.isReachable {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory!
            let parameterStr = "sender_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].propertyId!)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[0].bookingno!)&message=\(self.messageTxt.text!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&device_type=iphone&receiver_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].hostId!)"
            
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SEND_MESSAGE, APIKEY: "SEND_MESSAGE")
            print(parameterStr)
        }
        else {
            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
    }
    // mark : Review Act
    
    func Review_Act()
    {
        if Reachability()!.isReachable
        {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory!
            let parametrStr = "currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&review=\(self.messageTxt.text!)&property_id=\(self.propertyId)&star_rating=\(self.ratingView.rating)&base_id=\(id)&bookingno=\(self.bookingNum)&user_id=\(login_session.value(forKey: "UserId")!)"
            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: ADD_REVIEW_API, APIKEY: "ADD_REVIEW_API")
            print(parametrStr)
        }
        else {
            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
    }
    
    func CancelTrip()
    {
        if Reachability()!.isReachable
        {
            self.showActivityIndicator(uiView: self.view)
            let id = Singleton.sharedInstance.selectedCategory!
            let parametrStr = "base_id=\(id)&email=\(login_session.value(forKey: "Email") as? String ?? "")&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].propertyId!)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[0].bookingno!)&cancel_percentage=\(Singleton.sharedInstance.yourTripModel.mytrips[0].cancelPercentage!)&user_id=\(login_session.value(forKey: "UserId")!)&disputer_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].hostId!)&message=\(self.messageTxt.text!)"
            Network.shared.POSTRequest(withParameterString: parametrStr, serviceURL: CANCELLATION_API, APIKEY: "CANCELLATION_API")
            
            print(parametrStr)
        }
    }
    @IBAction func okayAct(_ sender: UIButton) {
        
        let result = resultVal.value(forKey: "CHECKKEY") as? String
        self.messages = UserDefaults.standard.value(forKey: "MESSAGEKEY") as?  String ?? ""
        self.rating = UserDefaults.standard.value(forKey: "REVIEWKEY") as? String ??  ""
        
        if messages == "MESSAGE" {
            messageAct()
        }else{
            print("No Action")
        }
        
        if rating == "REVIEW" {
            Review_Act()
        }else if self.selectedIndex == 1 {
            if result == "Cancel" {
                CancelTrip()
            }
        }else {
            if result == "Dispute" {
                if Reachability()!.isReachable {
                    self.showActivityIndicator(uiView: self.view)
                    let id = Singleton.sharedInstance.selectedCategory!
                    let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].propertyId!)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[0].bookingno!)&message=\(self.messageTxt.text!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
                    Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_API, APIKEY: "DISPUTE_API")
                    print(parameterStr)
                }
                else {
                    showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
                }
            }
        }
    }
 }
 extension PopupViewController: MIBlurPopupDelegate {
    
    var popupView: UIView {
        return view_Buttons ?? UIView()
    }
    var blurEffectStyle: UIBlurEffectStyle {
        return UIBlurEffectStyle.light
    }
    var initialScaleAmmount: CGFloat {
        return 1.0
    }
    var animationDuration: TimeInterval {
        return 0.1
    }
 }
 extension PopupViewController : HTTP_POST_STRING_REQUEST_PROTOCOL{
    
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        print(responseDict)
        if APIKEY == "DISPUTE_API"
        {
            if errorDict.count == 0 {
                let popupVc = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                self.navigationController?.pushViewController(popupVc!, animated: true)
                print(responseDict)
            }
        }
        else if APIKEY == "CANCELLATION_API"
        {
            if errorDict.count == 0 {
                let popupVc = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                self.navigationController?.pushViewController(popupVc!, animated: true)
                print(responseDict)
            }
        }
        else if APIKEY == "ADD_REVIEW_API"
        {
            if errorDict.count == 0 {
                let popupVc = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                self.navigationController?.pushViewController(popupVc!, animated: true)
                print(responseDict)
            }
        }
        else if APIKEY == "SEND_MESSAGE"
        {
            if errorDict.count == 0
            {
                print(responseDict)
                let popupVc = self.storyboard?.instantiateViewController(withIdentifier: "YourTripsViewController") as? YourTripsViewController
                self.navigationController?.pushViewController(popupVc!, animated: true)
            }
        }
        else if APIKEY == "HOTEL_YOUR_REVIEW"
        {
            if errorDict.count == 0 {
                print(responseDict)
                self.myreviewView.isHidden = false
                self.reviewMail.isHidden = true
                let reviewDetails = responseDict.value(forKey: "your_review") as? NSArray
                for detail in 0..<reviewDetails!.count
                {
                    let hotelDict = reviewDetails![detail] as! NSDictionary
                    
                    self.reviewMsg.text = hotelDict.value(forKey: "review") as? String
                    self.reviewRat.rating = Float(hotelDict.value(forKey: "star_rating") as? Int ?? 0)
                    let url = URL(string: hotelDict.value(forKey: "user_image") as? String ?? "")
                    self.bookingnum.text = hotelDict.value(forKey: "review_date") as? String
                    self.reviewImg.kf.setImage(with: url)
                }
            }
        }
        else {
            
            showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
        }
        
    }
    
 }
 
 
/*
  @IBAction func okayAct(_ sender: UIButton) {
  
  let result = resultVal.value(forKey: "CHECKKEY") as? String
  self.messages = UserDefaults.standard.value(forKey: "MESSAGEKEY") as?  String ?? ""
  self.rating = UserDefaults.standard.value(forKey: "REVIEWKEY") as? String ??  ""
  
  if messages == "MESSAGE" {
  messageAct()
  }else{
  print("No Action")
  }
  
  if rating == "REVIEW" {
  Review_Act()
  }else{
  print("No Action")
  }
  
  if result == "Cancel" {
  CancelTrip()
  }
  else if result == "Dispute"
  {
  
  if Reachability()!.isReachable
  {
  self.showActivityIndicator(uiView: self.view)
  let id = Singleton.sharedInstance.selectedCategory!
  let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.yourTripModel.mytrips[0].propertyId!)&bookingno=\(Singleton.sharedInstance.yourTripModel.mytrips[0].bookingno!)&message=\(self.messageTxt.text!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
  Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: DISPUTE_API, APIKEY: "DISPUTE_API")
  print(parameterStr)
  }
  else {
  showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
  }
  }
  }
  */
