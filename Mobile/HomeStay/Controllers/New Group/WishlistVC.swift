//
//  WishlistVC.swift
//  HomeStay
//
//  Created by apple on 19/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import SideMenu

class WishlistVC: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var wishlist = [ [String: Any]]()
    var isLoading:Bool = true
    var currentPage = 1
    var bookings = [ [String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "page_no": 1,
                 "currency_code": "USD"
                ]
            self.getWishlistApiResponse(params: parameters)
            }
        else{
            showSimpleAlert()
         }
    }
    @IBAction func actionBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true
        {
            let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenu") as! SideMenuNavigationController
            menu.menuWidth = self.view.bounds.width - 100
             present(menu, animated: true, completion: nil)
            
        }else{

            showSimpleAlert()
        }
        
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_areyousureLogin") as? String ?? "",         preferredStyle: UIAlertControllerStyle.alert)
        
//        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_cancel") as? String ?? "", style: UIAlertActionStyle.default, handler: { _ in
//            //Cancel Action
//            self.dismiss(animated: true, completion: nil)
//        }))
        alert.addAction(UIAlertAction(title: GlobalLanguageDictionary.object(forKey: "Key_login") as? String ?? "",
                                      style: UIAlertActionStyle.default,
                                      handler: {(_: UIAlertAction!) in
                                        let navgt = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as? StartViewController
                                        self.navigationController?.pushViewController(navgt!, animated: true)
                                        
                                        
                                        //Sign out action
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func wishlistAPi(sender: UIButton) {
        
    }
    
    @objc func wishListApi(sender: UIButton) {
     
        let model = self.wishlist[sender.tag]
        print(model)
        
        if (Reachability()?.isReachable ?? false) {
            showActivityIndicator(uiView: self.view)
                
            let parameters:[String : Any] =  ["lang_code" : lanuguage_selection.value(forKey: "language") ?? "en",
                       "property_id": model["property_id"] as? Int ?? 0
                        ]
        print(parameters)
         
            APIManager.apiPostWithHeadersCodable(serviceName: ADD_WISHLIST, parameters:parameters) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }

               
                do {
                    
                    let successModel = try JSONDecoder().decode(SuccessModel.self, from: data)
        
                    if let responseCode = successModel.code, responseCode == 200 {
                     
                        self.wishlist[sender.tag]["is_favourite"] = (model["is_favourite"] as? Bool ?? false ? false  : true)
                        self.tblView.reloadData()
                        
                        
                        
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                   
                    
                   
                } catch {
                    print("error reading JSON: \(error)")
                }
               
                
            }
            
        } else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
        
    }

    func priceAttributeasatring(name: String) -> NSAttributedString {
        let finalAttributeString = NSMutableAttributedString()
        let attributedString = NSAttributedString(string:name,
                                          attributes:[NSAttributedString.Key.foregroundColor: AppColor,
                                                      NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16) as Any])
        finalAttributeString.append(attributedString)
        let secondString = NSAttributedString(string:" / day",
                                              attributes:[NSAttributedString.Key.foregroundColor: UIColor.black,
                         
                                                          NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14) as Any])
        finalAttributeString.append(secondString)
        return finalAttributeString
    }
    
    func getWishlistApiResponse(params: [String:Any]){
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable ?? false) {
            APIManager.apiPostWithHeaders(serviceName: WISHLISTVIEW, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.showInformation(title: "Info", message: error?.localizedDescription ?? "")
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    self.isLoading = false
                    let data = responseDict.object(forKey: "data") as! [String:Any]
                    self.wishlist.append(contentsOf: data["wishlist"] as! [[String:Any]]) //=  data["booking_details"] as! [[String:Any]]


                    self.tblView.reloadData()
                }
                else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                    if self.isLoading == false {
                    self.wishlist.removeAll()
                    self.tblView.reloadData()
                    }
                }
            }
        }
        else {
            self.showInformation(title: GlobalLanguageDictionary.object(forKey: "key_info") as? String ?? "", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }

    }
    
    
}

extension WishlistVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTVCell", for: indexPath) as! WishlistTVCell
        cell.btnWishList.tag = indexPath.row
        let bookingsObj = self.wishlist[indexPath.item]
        cell.btnWishList.addTarget(self, action: #selector(wishlistAPi(sender:)), for: .touchUpInside)
        
        cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 16)
        cell.lblPropertyName.font = UIFont(name: SemiBoldFont, size: 18)
        cell.lblLocation.font = UIFont(name: SemiBoldFont, size: 14)

        let wishListObj = self.wishlist[indexPath.item]
        let imgURL = (wishListObj["property_images"] as? String ?? "")
        cell.imgProperty.contentMode = .scaleToFill
        cell.imgProperty.cornerRadius = 10
        cell.imgProperty.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        let finalValue = "\((wishListObj["property_currency_symbol"] as? String ?? "$"))\((wishListObj["property_price"] as AnyObject))"
        cell.lblPrice.attributedText = priceAttributeasatring(name: finalValue)
        cell.lblPropertyName.text =  (wishListObj["property_title"] as? String ?? "")
        cell.lblLocation.text =  (wishListObj["property_address"] as? String ?? "")
        
        if let rate = wishListObj["ratings"] as? String {
        cell.lblRating.text = String(format: "%0.0f", Double(rate) ?? 0.0)
                }
        cell.lblLocation.textColor = .gray
        cell.btnWishList.tag = indexPath.row
        cell.btnWishList.addTarget(self, action: #selector(wishListApi(sender:)), for: .touchUpInside)
        
        cell.imgHeart.image = (bookingsObj["is_favourite"] as? Bool ?? false ? UIImage(named: "heart-fill")  : UIImage(named: "heart") )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 345
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == self.wishlist.count - 1 && !self.isLoading{
            self.isLoading = true
            currentPage += 1
//            let parameters:[String : Any] =
//                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "page_no": currentPage, "currency_code": "USD"
//                ]
//            self.getWishlistApiResponse(params: parameters)
            //callAPI(page: currentPage)
        }
    }
    
}
