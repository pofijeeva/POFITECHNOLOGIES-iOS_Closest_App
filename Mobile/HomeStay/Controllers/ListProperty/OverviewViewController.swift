//
//  OverviewViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 02/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown
      
class OverviewViewController: UIViewController {
    
    //MARK:- Outlets
    
    //Labels
    
    @IBOutlet weak var lblTheSpace: UILabel!
    @IBOutlet weak var lblRequestToBook: UILabel!

    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lbl150Words: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPlsFillDetails: UILabel!
    @IBOutlet weak var lblOtherThings: UILabel!
    @IBOutlet weak var lblHouseRules: UILabel!
    @IBOutlet weak var lblGuestAccess: UILabel!
    @IBOutlet weak var lblIntWithGuest: UILabel!
    @IBOutlet weak var lblNeighborhood: UILabel!
    
    //TextFields
    
    @IBOutlet weak var txtTitleEn: UITextField!
    
    //TextViews
    @IBOutlet weak var txtviewOtherthingsEn: UITextView!
    @IBOutlet weak var txtviewSummaryEn: UITextView!
    @IBOutlet weak var txtviewSpaceEn: UITextView!
    @IBOutlet weak var txtviewHouseRulesEn: UITextView!
    @IBOutlet weak var txtviewGuestAccessEn: UITextView!
    @IBOutlet weak var txtviewIntWithGuestEn: UITextView!
    @IBOutlet weak var txtviewNeighborhoodEn: UITextView!
    @IBOutlet weak var txtlanguage: UITextField!
    
    
    //View
    @IBOutlet weak var optionalView: UIView!
    @IBOutlet weak var writemoreView: UIView!
    @IBOutlet weak var requestView: UIView!
    
    //ImageView
    @IBOutlet weak var imgRequestBook: UIImageView!
    @IBOutlet weak var imgInstantBook: UIImageView!
    @IBOutlet weak var PayLater: UIImageView!

    //Button
    @IBOutlet weak var btnSave: UIButton!
    
    //Constrain
    
    @IBOutlet weak var conTopSpace: NSLayoutConstraint!
    
    var DropData = ["English","Arabic"]
    let dropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDown
        ]
    }()
    
    //MARK:- Variables
    
    var ListingActivityDelegate: listingActivityProtocol!
    var propertyID : Int = 0
    var isInstantPay:String = "No"
    var isRequestToBook = "Yes"
    var PayLaterStr = "No"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnSave.backgroundColor = AppColor
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.optionalView.isHidden = false
        //self.writemoreView.isHidden = false
        UserDefaults.standard.set("Yes", forKey: "isRequestToBook")
        UserDefaults.standard.set("No", forKey: "isInstantPay")
        
        self.propertyID = Singleton.sharedInstance.rentYourSpace.result[0].step1.propertyid
        
        setData()
        
        
       
        
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .any }
        self.txtlanguage.layer.shadowColor = BorderColor.cgColor
        self.txtlanguage.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.txtlanguage.layer.shadowOpacity = 0.7
        self.txtlanguage.layer.shadowRadius = 3.0
        self.txtlanguage.layer.cornerRadius = 5.0
        self.txtlanguage.layer.borderWidth = 1.0
        self.txtlanguage.layer.borderColor = BorderColor.cgColor
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.lblOverview.font = UIFont(name: SemiBoldFont, size: 18)
        self.txtlanguage.font = UIFont(name: SemiBoldFont, size: 17)
        self.lblPlsFillDetails.font = UIFont(name: RegularFont, size: 14)
        self.lblTitle.font = UIFont(name: SemiBoldFont, size: 14)
         self.txtTitleEn.font = UIFont(name: SemiBoldFont, size: 14)
          self.lblRequestToBook.font = UIFont(name: SemiBoldFont, size: 14)
           self.lbl150Words.font = UIFont(name: SemiBoldFont, size: 14)
           self.txtviewSummaryEn.font = UIFont(name: SemiBoldFont, size: 14)
         self.lblTheSpace.font = UIFont(name: SemiBoldFont, size: 12)
          self.txtviewSpaceEn.font = UIFont(name: SemiBoldFont, size: 14)
         self.lblOtherThings.font = UIFont(name: SemiBoldFont, size: 12)
            self.txtviewOtherthingsEn.font = UIFont(name: SemiBoldFont, size: 14)
         self.lblHouseRules.font = UIFont(name: SemiBoldFont, size: 12)
         self.txtviewHouseRulesEn.font = UIFont(name: SemiBoldFont, size: 14)
         self.lblGuestAccess.font = UIFont(name: SemiBoldFont, size: 12)
        self.txtviewGuestAccessEn.font = UIFont(name: SemiBoldFont, size: 14)
        self.lblIntWithGuest.font = UIFont(name: SemiBoldFont, size: 12)
         self.txtviewIntWithGuestEn.font = UIFont(name: SemiBoldFont, size: 14)
         self.lblNeighborhood.font = UIFont(name: SemiBoldFont, size: 12)
         self.txtviewNeighborhoodEn.font = UIFont(name: SemiBoldFont, size: 14)
        self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        self.btnSave.backgroundColor = AppColor
        
        
        self.txtlanguage.text = GlobalLanguageDictionary.object(forKey: "key_english") as? String ?? ""
        self.lblTitle.text = GlobalLanguageDictionary.object(forKey: "key_propertyTitle") as? String ?? ""
        self.txtTitleEn.placeholder = GlobalLanguageDictionary.object(forKey: "key_title") as? String ?? ""
        self.lbl150Words.text = GlobalLanguageDictionary.object(forKey: "key_about") as? String ?? ""
        self.lblRequestToBook.text = GlobalLanguageDictionary.object(forKey: "key_request2Book") as? String ?? ""
        self.lblTheSpace.text = GlobalLanguageDictionary.object(forKey: "key_aboutSpace") as? String ?? ""
        self.lblOtherThings.text = GlobalLanguageDictionary.object(forKey: "key_rules") as? String ?? ""
        self.lblHouseRules.text = GlobalLanguageDictionary.object(forKey: "key_othersNote") as? String ?? ""
        self.lblGuestAccess.text = GlobalLanguageDictionary.object(forKey: "key_guestAccess") as? String ?? ""
        self.lblNeighborhood.text = GlobalLanguageDictionary.object(forKey: "key_Neighborhood") as? String ?? ""
        self.btnSave.setTitle(GlobalLanguageDictionary.object(forKey: "key_next") as? String ?? "", for: .normal)
        
        self.txtTitleEn.layer.borderWidth = 1
        self.txtTitleEn.layer.borderColor = BorderColor.cgColor
      
        self.updateTextView(textView: self.txtviewSummaryEn)
        self.updateTextView(textView: self.txtviewSpaceEn)
        self.updateTextView(textView: self.txtviewOtherthingsEn)
        self.updateTextView(textView: self.txtviewHouseRulesEn)
        self.updateTextView(textView: self.txtviewGuestAccessEn)
        self.updateTextView(textView: self.txtviewNeighborhoodEn)
    
       
      
        
    }
    func updateTextView(textView: UITextView) {
       
        textView.textColor = UIColor.black
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = BorderColor.cgColor
        textView.layer.shadowColor = BorderColor.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowOpacity = 0.6
        textView.delegate = self
        textView.keyboardType = .default
        textView.returnKeyType = .done
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setPlaceHolder() {
        txtviewOtherthingsEn.set(placeHolder: "2")
        txtviewSummaryEn.set(placeHolder: "3")
        txtviewSpaceEn.set(placeHolder: "5")
        txtviewHouseRulesEn.set(placeHolder: "7")
        txtviewGuestAccessEn.set(placeHolder: "9")
        txtviewIntWithGuestEn.set(placeHolder: "11")
        txtviewNeighborhoodEn.set(placeHolder: "13")
        
    }
    
    func setData()
    {
        let stepFour = Singleton.sharedInstance.rentYourSpace.result[0].step4!
        
        
        
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step4 = result.step4 {
            
            self.txtTitleEn.text = step4.rentDetail.en.ren_title
            self.txtviewSummaryEn.text = step4.rentDetail.en.ren_summary
            self.txtviewHouseRulesEn.text = step4.rentDetail.en.ren_house_rule
            self.txtviewOtherthingsEn.text = step4.rentDetail.en.ren_other_things
            self.txtviewGuestAccessEn.text = step4.rentDetail.en.ren_guest_axes
            self.txtviewSpaceEn.text = step4.rentDetail.en.ren_space
        
            
        }

        
    }
    

    
    func DropDownTypes() {
        
        dropDown.anchorView = self.txtlanguage
        dropDown.bottomOffset = CGPoint(x: 0, y: (self.txtlanguage?.bounds.height)!)
        dropDown.dataSource = DropData
        dropDown.backgroundColor = UIColor.white
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.txtlanguage.text = item
            let stepFour = Singleton.sharedInstance.rentYourSpace.result[0].step4!
            if (index == 0){
                self.txtTitleEn.text = stepFour.rentDetail.en.ren_title
                self.txtviewSummaryEn.text = stepFour.rentDetail.en.ren_summary
                self.txtviewHouseRulesEn.text = stepFour.rentDetail.en.ren_house_rule
                self.txtviewOtherthingsEn.text = stepFour.rentDetail.en.ren_other_things
                self.txtviewGuestAccessEn.text = stepFour.rentDetail.en.ren_guest_axes
                self.txtviewSpaceEn.text = stepFour.rentDetail.en.ren_space
                self.requestView.isHidden = false
                
            }else{
                self.txtTitleEn.text = stepFour.rentDetail.ar.ren_title
                self.txtviewSummaryEn.text = stepFour.rentDetail.ar.ren_summary
                self.txtviewHouseRulesEn.text = stepFour.rentDetail.ar.ren_house_rule
                self.txtviewOtherthingsEn.text = stepFour.rentDetail.ar.ren_other_things
                self.txtviewGuestAccessEn.text = stepFour.rentDetail.ar.ren_guest_axes
                self.txtviewSpaceEn.text = stepFour.rentDetail.ar.ren_space
                self.requestView.isHidden = true
            }
            }
        
    }
    
    //MARK:- Button Actions
    @IBAction func act_ScrollBGtapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func act_ShowMoreFeilds(_ sender: UIButton) {
        if self.optionalView.isHidden == true {
            self.optionalView.isHidden = false
            self.writemoreView.isHidden = true
        }
    }
    
    @IBAction func act_RequestToBook(_ sender: UIButton) {
        if isRequestToBook == "No" {
            isRequestToBook = "Yes"
            self.imgRequestBook.image = UIImage(named: "tick-on")?.maskWithColor(color: AppColor)
            UserDefaults.standard.set("Yes", forKey: "isRequestToBook")
        } else {
            isRequestToBook = "No"
            self.imgRequestBook.image = UIImage(named: "tick-off")?.maskWithColor(color: AppColor)
            UserDefaults.standard.set("No", forKey: "isRequestToBook")
        }
        self.imgRequestBook.setImageColor(color: AppColor)
    }
    
    @IBAction func act_PayLater(_ sender: UIButton) {
        if PayLaterStr == "No" {
            PayLaterStr = "Yes"
//            self.PayLater.image = UIImage(named: "tick-on")
//            UserDefaults.standard.set("Yes", forKey: "PayLater")
        } else {
            PayLaterStr = "No"
//            self.PayLater.image = UIImage(named: "tick-off")
//            UserDefaults.standard.set("No", forKey: "PayLater")
        }
    }
    
    
    @IBAction func act_InstantPay(_ sender: UIButton) {
        if isInstantPay == "No" {
            isInstantPay = "Yes"
            self.imgInstantBook.image = UIImage(named: "tick-on")
            UserDefaults.standard.set("Yes", forKey: "isInstantPay")
        } else {
            isInstantPay = "No"
            self.imgInstantBook.image = UIImage(named: "tick-off")
            UserDefaults.standard.set("No", forKey: "isInstantPay")
        }
    }
    
    @IBAction func showdropDownOverview(_ sender: Any) {
        self.dropDown.show()
        self.DropDownTypes()
    }
    
    @IBAction func act_Save(_ sender: UIButton)
    {
        
        self.view.endEditing(true)
        if (self.txtTitleEn.text?.count)! <= 0 {
            self.showInformation(title: "Closest", message: "Title should not be empty")
        } else if (self.txtviewSummaryEn.text?.count)! <= 0 {
            self.showInformation(title: "Closest", message: "Description should not be empty")
        } else {
            if Reachability()!.isReachable {
                ListingActivityDelegate.showActivity()
                var params = NSMutableDictionary()
                params =  ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                           "ren_title":self.txtTitleEn.text!,
                           "ren_summary":self.txtviewSummaryEn.text!,
                           "ren_space":self.txtviewSpaceEn.text!,
                           "ren_house_rule":self.txtviewHouseRulesEn.text!,
                           "ren_other_things":self.txtviewOtherthingsEn.text!,
                           "ren_guest_axes":self.txtviewGuestAccessEn.text!,
                           "ren_request_book":isRequestToBook,
                           "property_id":self.propertyID]
                
                APIManager.apiPostWithHeaders(serviceName: SAVE_OVERVIEW_LISTING, parameters: params as? [String : Any]) { response, error in
                    DispatchQueue.main.async {
                        self.ListingActivityDelegate.hideActivity()
                    }
                    if error != nil {
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                    } else {
                        print(response)
                        let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                        Singleton.sharedInstance.rentYourSpace = mod
                        sharedInstanceListing.gotoStepfour()
                    }
                }
            } else {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as? String ?? "")
            }
        }
    }
    
}

extension OverviewViewController: UITextFieldDelegate {
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
           if textField == txtlanguage {
               self.dropDown.show()
               self.DropDownTypes()
               textField.resignFirstResponder()
           }
       }
   //    func textFieldDidEndEditing(_ textField: UITextField) {
   //        amountString = textField.text!
   //    }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if textField == self.txtlanguage {
               return false
           }
   
           return true
       }
}

extension OverviewViewController : UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}

extension OverviewViewController: HTTP_POST_STRING_REQUEST_PROTOCOL{
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        ListingActivityDelegate.hideActivity()
        if APIKEY == "SAVE_OVERVIEW_LISTING" {
            
            if errorDict.count == 0 {
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                setData()
                self.showInformation(title: "Closest", message: mod.message)
            } else {
                
            }
        }
    }
}
