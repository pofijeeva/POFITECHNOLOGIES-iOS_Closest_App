//
//  MyProfileViewController.swift
//  HomeStay
//
//  Created by M.NAGENDRANATH REDDY on 10/08/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    
    
    @IBOutlet var MoveView: UIView!
    @IBOutlet var MoveCollection: UICollectionView!
    
    @IBOutlet var PImageview: UIImageView!
    @IBOutlet var PFirstName: UITextField!
    @IBOutlet var PLastName: UITextField!
    @IBOutlet var PEmailAddress: UITextField!
    @IBOutlet var PPhoneNumber: UITextField!
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var viewTrustandVerification: UIView!
    @IBOutlet weak var viewPassportverify: UIView!
    
    @IBOutlet var UploadnewImg: UILabel!
    @IBOutlet var MaximumLbl: UILabel!

    @IBOutlet var AccSubmitBtn: UIButton!
    @IBOutlet var PFirstNameLbl: UILabel!
    @IBOutlet var PLastNameLbl: UILabel!
    @IBOutlet var PEmailAddressLbl: UILabel!
    @IBOutlet var PPhoneNumberLbl: UILabel!
    
    var Array : NSMutableArray = []
    var SelectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PFirstName.font = UIFont(name: SemiBoldFont, size: 14)
        PLastName.font = UIFont(name: SemiBoldFont, size: 14)
        PEmailAddress.font = UIFont(name: SemiBoldFont, size: 14)
        PPhoneNumber.font = UIFont(name: SemiBoldFont, size: 14)
        UploadnewImg.font = UIFont(name: SemiBoldFont, size: 17)
        MaximumLbl.font = UIFont(name: SemiBoldFont, size: 17)
        
        
        PFirstNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
        PLastNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
        PEmailAddressLbl.font = UIFont(name: SemiBoldFont, size: 16)
        PPhoneNumberLbl.font = UIFont(name: SemiBoldFont, size: 16)
        
        self.AccSubmitBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.Array = ["  Account  ","  Trust & Verification  ","  Change password  "]
    }
    
    
    
    @IBAction func PAct_Submit(_ sender: Any) {
        
        
        let parameters:[String : Any] =
                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                     "u_first_name":PFirstName.text ?? "" , "u_last_name":PLastName.text ?? "" ,
                     "u_phone":PPhoneNumber.text ?? "","email": login_session.value(forKey: "Email") as? String ?? ""
                ]
                print(parameters)
                APIManager.apiPostWithHeaders(serviceName: UPDATE_USER_PROF_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                        
                        let resData = responseDict["data"] as! [String:Any]
                        
                        
                        let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.homeModel = mod
                        
                        
                    }
                    else
                    {
                        
                     //   self.hideActivityIndicator(uiView: self.view)
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                    
                }
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
    
    @IBAction func Act_Emailverify(_ sender: Any) {
        
//        {
//        "lang_code":"en",
//        "verification_type":"idproof",//email,phone,idproof
//        "verify_email":"sathyapriya@pofitec.com",
//        "phone_no":"+919656719052",
//        "proof_type":"passport",//passport,voterid,licence
//        "proof_file":
//        }
        
        let parameters:[String : Any] =
                    ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                      
                     "u_phone":PPhoneNumber.text ?? "","email": login_session.value(forKey: "Email") as? String ?? ""
                ]
                print(parameters)
                APIManager.apiPostWithHeaders(serviceName: UPDATE_USER_PROF_API, parameters: parameters) { (json:NSDictionary?, error:NSError?) in
                    DispatchQueue.main.async {  }
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                        return
                    }
                    let responseDict:NSDictionary = json!
                    print(responseDict)
                    if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                        
                        let resData = responseDict["data"] as! [String:Any]
                        
                        
                        let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.homeModel = mod
                        
                        
                    }
                    else
                    {
                        
                     //   self.hideActivityIndicator(uiView: self.view)
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                        //self.showInformation(title: AppName, message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                    
                }
            }
    
    
    

}


extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
       
            return 3
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCollectionViewCell", for: indexPath) as? MoveCollectionViewCell else { return UICollectionViewCell() }

//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoveCollectionViewCell", for: indexPath) as? MoveCollectionViewCell
       
        cell.MoveLbl.font = UIFont(name: SemiBoldFont, size: 14)
       
        cell.MoveLbl.text = Array.object(at: indexPath.row)  as? String
        
        if SelectedRow == indexPath.row {
            cell.MoveLbl.backgroundColor = AppSecondColor
            cell.MoveLbl.textColor = .white
        }else{
             cell.MoveLbl.textColor = .black
            cell.MoveLbl.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        }
       // cell.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        self.SelectedRow = indexPath.row
        self.MoveCollection.reloadData()
        if indexPath.row == 0 {
           // self.viewSecurity.isHidden = true
                 self.viewPassportverify.isHidden = true
                 self.viewTrustandVerification.isHidden = true
            self.viewPassportverify.isHidden = true
               
                     self.viewProfile.isHidden = false
                   
        }else if indexPath.row == 1{
            //self.viewSecurity.isHidden = true
                
                self.viewProfile.isHidden = true
                    self.viewPassportverify.isHidden = false
                    self.viewTrustandVerification.isHidden = false
                   
//        }else if indexPath.row == 2 {
//            self.viewPayoutPreferences.isHidden = true
//                  self.view_ResidenceView.isHidden = true
//                  self.viewTransactionHistory.isHidden = true
//
//                      self.viewSecurity.isHidden = false
//
        }
            else{
                
                self.viewProfile.isHidden = false
                    self.viewPassportverify.isHidden = false
                    self.viewTrustandVerification.isHidden = false
//            self.tbl_Countrylist.isHidden = true
//                  self.grayView.isHidden = true
//                  self.viewSecurity.isHidden = true
//                  self.viewTransactionHistory.isHidden = true
//                  self.viewPayoutPreferences.isHidden = true
//
//                      self.view_ResidenceView.isHidden = false
                    
        }
        perform(#selector(updateStepsRemaining), with: nil, afterDelay: 0.3)
    }
    func reloadCollectionView() {
        self.MoveCollection.reloadData()
    }
    @objc func updateStepsRemaining() {
        
        self.MoveCollection.scrollToItem(at: IndexPath(row: self.SelectedRow, section: 0), at: .centeredHorizontally, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5
    }
}

