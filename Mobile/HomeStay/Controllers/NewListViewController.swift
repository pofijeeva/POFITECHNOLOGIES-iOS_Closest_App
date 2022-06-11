//
//  NewListViewController.swift
//  HomeStay
//
//  Created by Apple on 29/09/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import DropDown


class NewListViewController:BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
 
    
    @IBOutlet weak var textfieldSearch: UITextField!
    @IBOutlet weak var ProductListTable: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchImg: UIImageView!

    @IBOutlet weak var collectionViewList: UICollectionView!
    var arrayList : NSMutableArray = []
    var Location : String = ""
    var locationId : String = ""
    var isDropDown : Bool = false
    var Dropmenu = NSArray()
    let listDropDown = DropDown()
    var tempArray : NSMutableArray = []
    var window: UIWindow?
    var PropertyId : String = ""
    var PropertyType : String = ""

    
    
    var CheckInDate : String = ""
    var CheckOutDate : String = ""
    

     override func viewDidLoad() {
        super.viewDidLoad()
        self.textfieldSearch.placeholder = GlobalLanguageDictionary.object(forKey: "key_serachLoc") as? String
        self.textfieldSearch.font = UIFont(name: SemiBoldFont, size: 14)
         self.searchImg.setImageColor(color: AppColor)

        ProductListTable.tableFooterView = UIView()
        if self.Location == "" {
            
        }else{
             self.updateList()
        }
        self.backBtn.addTarget(self, action: #selector(pressed), for: .touchUpInside)

        self.textfieldSearch.addTarget(self, action: #selector(typingName), for: .editingChanged)
     }
    @objc func pressed() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    @IBAction func act_Back(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    
    @objc func typingName(textField:UITextField){
        self.tempArray.removeAllObjects()
        if let typedText = textField.text {
            searchRestaurantByName(input: typedText)
        }
    }
    
    func addingSearchData(dict: NSDictionary){
        listDropDown.dataSource = self.tempArray as! [String]
        listDropDown.textFont = UIFont(name: SemiBoldFont, size: 15)!
        listDropDown.anchorView = self.textfieldSearch
        listDropDown.direction = .bottom
        listDropDown.bottomOffset = CGPoint(x: 0, y: self.textfieldSearch.bounds.height)
         // Action triggered on selection
        listDropDown.selectionAction = { [weak self] (index, item) in
            print("@@@@@@@@",index,item)
          //  let dict = ((dict.value(forKey: "data")as? NSDictionary)?.value(forKey: "location_list") as! NSArray).object(at: index) as! NSDictionary
            
            var NameList = NSArray()
            NameList = item.components(separatedBy: ",") as NSArray
            self?.textfieldSearch.text = item
            LocationName = NameList[0] as? String ?? ""
            self?.Location = NameList[0] as? String ?? ""//dict.value(forKey: "location_name") as? String ?? ""
          //  self?.updateList()
            self?.window = UIWindow(frame: UIScreen.main.bounds)
            
            let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
            self?.window?.rootViewController = mainViewController
            self?.window?.makeKeyAndVisible()
           
//            let sb = UIStoryboard(name: "Main", bundle: nil)
//            let vc = sb.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
//            vc.Location = dict.value(forKey: "location_name") as? String ?? ""
//            vc.locationId = "\(dict.value(forKey: "location_id") as AnyObject)"
//            self?.present(vc, animated: true, completion: nil)
         }
    }
    
    func searchRestaurantByName(input: String) {
        
        let parameters:[String : Any] =

        ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "location":input
        ]
        print(parameters)
        APIManager.apiPostWithHeaders(serviceName: LOCATIONLIST, parameters: parameters) { responseDict, error in
            guard let result = responseDict, error == nil else {
                return
            }
            print (result)
//            self.stopLoadingIndicator(senderVC: self)
        
             if result.object(forKey: "code") as? Int ?? 0 == 200{
//                self.searchResultsArray.removeAllObjects()
//                self.searchResultsArray.addObjects(from: ((result.object(forKey: "data")as? NSDictionary)?.object(forKey: "search_list")as? NSArray) as? [Any] ?? [])
//                self.categorySearchTbl.reloadData()
               var arr =  (result.value(forKey: "data")as? NSDictionary)?.value(forKey: "location_list") as! NSArray
                for item in arr {
                    let dict = item as! NSDictionary
                    self.tempArray.add(dict.value(forKey: "location_name") as? String ?? "")
                }
                self.addingSearchData(dict: result)
            }else if result.object(forKey: "code") as? Int ?? 0 == 400{
                if result.object(forKey: "message")as? String ?? "" == "Token is Expired"{
//                    self.showToastAlert(senderVC: self, messageStr: result.object(forKey: "message") as? String ?? "")
//                    self.tokenExpired()
                }else if result.object(forKey: "message")as? String ?? "" == "user_blocked" {
//                    self.showTokenExpiredPopUp(msgStr: result.object(forKey: "message")as? String ?? "")
                }
                else{
//                    self.searchResultsArray.removeAllObjects()
//                    self.categorySearchTbl.reloadData()
                }
                //print(response.object(forKey: "message") as Any)
            }
            else if result.object(forKey: "message")as? String ?? "" == "user_blocked" {
//                self.showTokenExpiredPopUp(msgStr: result.object(forKey: "message")as? String ?? "")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.perform(#selector(updateTextfield), with: nil, afterDelay: 0.5)
         return true
    }
    
    @objc func updateTextfield() {
        if textfieldSearch.text?.count == 0 {
            self.tempArray.removeAllObjects()
            self.listDropDown.hide()
        }
        else {
            self.listDropDown.show()
        }
    }
    
    /*
     {
     "lang_code":"en",
     "currency_code":"USD",
     "check_in":
     "check_out":
     "types":"['1','2']",
     "amenities":"['10','8']",
     "ratings":"['1']",
     "prices":"['14-33','34-54']",
     "sort_by":"1",
     "price_sort_by":"1",
     "city":"",
     "types":"['1']",
     page_no:1 (mandatory)
     }
     HEADER
     fcm-id:
     device-id:
     type://     android/ios
     os-type:
     device-model:
     app-build-version
     */
    func updateList() {
        
        var params = NSMutableDictionary()
        
        params = ["lang_code": lanuguage_selection.value(forKey: "language") ?? "en","currency_code":login_session.value(forKey: "APP_CURRENCY") as Any,"check_in":self.CheckInDate,"check_out":self.CheckOutDate,"types":"","amenities":"","ratings":"","sort_by":"","prices":"","price_sort_by":"","city":self.Location,"types":"","page_no":"1"]
//        "device_id":"23232323","type":"ios","token":"BearereyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3RcL1dlYl9SZW50YWxfUHJvZHVjdFwvYXBpXC92XzFfMFwvYXBwbGVfbG9naW4iLCJpYXQiOjE2MjY2OTMxNDIsImV4cCI6MTYyNjc3OTU0MiwibmJmIjoxNjI2NjkzMTQyLCJqdGkiOiJnenVTY3cyM1JmYkE2b254Iiwic3ViIjo1OSwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.3CVW2CYve1trvxmGSjo8HECs1g0w7Xb0Gsdb8rrP2vg"
    
        print(params)
        APIManager.apiPostWithHeaders(serviceName: REQ_PROPERTY_DETAIL_PAGE, parameters: params as! [String : Any]) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
            
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                self.hideActivityIndicator(uiView: self.view)

                self.arrayList.removeAllObjects()
                self.arrayList.addObjects(from:(((responseDict.object(forKey: "data") as? NSDictionary)?.object(forKey: "rentalList") as? NSArray) as? [Any] ?? []))
                print(self.arrayList)
                self.ProductListTable.reloadData()
                
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
              
            }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
        
        
        
        
//        showActivityIndicator(uiView: self.view)
//        var params = NSMutableDictionary()
//
//        params = ["lang_code": lanuguage_selection.value(forKey: "language") ?? "en","currency_code":login_session.value(forKey: "APP_CURRENCY") as Any,"check_in":"","check_out":"","types":"","amenities":"","ratings":"","sort_by":"","prices":"","price_sort_by":"","city":self.Location,"types":"","page_no":"1"]
//       //  params = ["mcity_name":self.Location,"f_p_min":self.f_p_min,"f_p_max":self.f_p_max,"f_room_type":self.f_room_type,"f_home_type":self.f_home_type,"f_list_type":self.f_list_type,"f_date_arrive":self.arriveDate,"f_date_depart":self.departDate,"base_id":1,"f_guest":self.f_guest,"currency_code":login_session.value(forKey: "APP_CURRENCY")!,"user_id":UserID,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
//       // params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
//        print(params)
//
//
//
//
//        let manager = AFHTTPSessionManager()
//        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//        manager.post(REQ_PROPERTY_DETAIL_PAGE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
//            DispatchQueue.main.async {
//
//            }
//            let responseDict:NSDictionary = responseObject as! NSDictionary
//            self.hideActivityIndicator(uiView: self.view)
//            if responseDict.value(forKey: "code") as? Int ?? 0 == 200 {
//                print(responseDict)
////                   let mod = PlaceListModel(fromDictionary: responseDict as! [String : Any])
////                Singleton.sharedInstance.PlaceList = mod
////
////
////                let priceDetails = responseDict.value(forKey: "rentalList") as? NSArray
////                let sortedArray = priceDetails!.sortedArray(using: [NSSortDescriptor(key: "rental_price", ascending: true)]) as NSArray
////                 if mod.rentalList.count != 0
////                {
////                   }
////                else
////                {
////                   }
////
//            }
//
//            else {
//                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
//            }
//        }, failure: { (operation, error) -> Void in
//            DispatchQueue.main.async {
//
//            }
//            print(error)
//            self.showInformation(title: "Closest", message: error.localizedDescription)
//        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewList.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! FeaturedListingCollectionViewCell
        cell.StarandRateLbl.layer.cornerRadius = 5.0
        
        cell.Listingimg.layer.cornerRadius = 5.0
            let featuredProperty = self.arrayList[indexPath.item] as! NSDictionary
        cell.backgroundColor = .white
        let currencySymbol = featuredProperty.object(forKey: "property_currency_symbol") as? String ?? ""//(featuredProperty["property_currency_symbol"] as? String ?? "")
            
        let price = featuredProperty.object(forKey: "rental_price") as! AnyObject//(featuredProperty["rental_price"] as? Int ?? 0)
            cell.costLabel.text = "\(currencySymbol)\(price)"
            cell.ratingLabel.text = "\(featuredProperty.object(forKey: "ratings") as AnyObject)"//(featuredProperty["ratings"] as? String ?? "")
            cell.locationLabel.text = "\(featuredProperty.object(forKey: "location") as AnyObject)"//(featuredProperty["location"] as? String ?? "")
            cell.addLabel.text = "\(featuredProperty.object(forKey: "rental_title") as AnyObject)"//(featuredProperty["rental_title"] as? String ?? "")
        let imgURL = "\(featuredProperty.object(forKey: "rental_image") as AnyObject)"//(featuredProperty["rental_image"] as? String ?? "")
        cell.Listingimg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 280)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        add_on_amount = 0
        Bundle_amount = 0
        bundle_checkindate = ""
        bundle_checkoutdate = ""
        BundleSelectedDictValues.removeAllObjects()
        AddonsSelectedDictValues.removeAllObjects()
        BUndleSelectedArray.removeAllObjects()
        BundleArray.removeAllObjects()
        let featuredProperty = self.arrayList[indexPath.item] as! NSDictionary
     let currencySymbol = featuredProperty.object(forKey: "property_currency_symbol") as? String ?? ""
        let ProductId = "\(featuredProperty.object(forKey: "rental_id") as AnyObject)"
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
       nav!.PropertyID = ProductId
 
        nav!.currencySymbol = currencySymbol
        self.present(nav!, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewlistTabTableViewCell") as! NewlistTabTableViewCell
        
        cell.ProductRat.layer.cornerRadius = 5.0
        cell.SearchImg.setImageColor(color: AppColor)
        cell.StarImg.setImageColor(color: AppColor)
        cell.ProductCost.textColor = AppColor
        cell.FavImage.setImageColor(color: AppColor)

        cell.ProductCost.font = UIFont(name: SemiBoldFont, size: 16)
        cell.ProductLoc.font = UIFont(name: SemiBoldFont, size: 14)
        cell.ProductName.font = UIFont(name: SemiBoldFont, size: 17)
        cell.ProductImg.layer.cornerRadius = 5.0
            let featuredProperty = self.arrayList[indexPath.item] as! NSDictionary
        cell.backgroundColor = .white
        let currencySymbol = featuredProperty.object(forKey: "property_currency_symbol") as? String ?? ""//(featuredProperty["property_currency_symbol"] as? String ?? "")
            
        let price = featuredProperty.object(forKey: "rental_price") as! AnyObject//(featuredProperty["rental_price"] as? Int ?? 0)
            cell.ProductCost.text = " \(currencySymbol) \(price) / day"
            cell.ProductRat.text = "\(featuredProperty.object(forKey: "ratings") as AnyObject)"//(featuredProperty["ratings"] as? String ?? "")
            cell.ProductLoc.text = "\(featuredProperty.object(forKey: "location") as AnyObject)"//(featuredProperty["location"] as? String ?? "")
            cell.ProductName.text = "\(featuredProperty.object(forKey: "rental_title") as AnyObject)"//(featuredProperty["rental_title"] as? String ?? "")
        let imgURL = "\(featuredProperty.object(forKey: "rental_image") as AnyObject)"//(featuredProperty["rental_image"] as? String ?? "")
        cell.ProductImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        let favid = "\(featuredProperty.object(forKey: "is_favourite") as AnyObject)"
        if favid == "1"  {
            cell.FavImage.image = UIImage(named: "FavNew")
        }else {
            cell.FavImage.image = UIImage(named: "like-1")
        }
        cell.FavImage.setImageColor(color: AppColor)

        cell.ProductFav.tag = indexPath.row
        cell.ProductFav.addTarget(self, action: #selector(favTapped), for: .touchUpInside)
         return cell

       
    }
    
    
    
    @objc func favTapped(sender: UIButton)
    {
        if login_session.value(forKey: "IS_USER_LOGGEDIN") as? Bool == true {
        
        let btnRow = sender.tag
        print("btnRow is :", btnRow)
        if sender.isSelected == true {
            print("btnRow is :", btnRow)
        }
        else {
            print("btnRow is :", btnRow)
        }
        let featuredProperty = self.arrayList[btnRow] as! NSDictionary
         self.PropertyId = "\(featuredProperty.object(forKey: "rental_id") as AnyObject)"
         let favid = "\(featuredProperty.object(forKey: "is_favourite") as AnyObject)"
        if favid == "1"  {
            RemoveWishList()
            
        }else {

            
            if (Reachability()?.isReachable ?? false)
            {
                 WishListApiCall()
 
            }
            else
            {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }
        }else{
            self.showInformation(title: "Closest", message: "Please login first")
        }
    }
    
    func RemoveWishList() {
        
        var params = NSMutableDictionary()
        params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","user_id":login_session.value(forKey: "UserId")!,"property_id":self.PropertyId]
         
        showActivityIndicator(uiView: self.view)
 
       
        
        print(params)
        APIManager.apiPostWithHeaders(serviceName: ADD_WISHLIST, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
            
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                
                self.updateList()
                
                
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
              
            }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
    }
    
    func WishListApiCall() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":lanuguage_selection.value(forKey: "language") ?? "en","property_id":self.PropertyId]
        
        print(params)
        APIManager.apiPostWithHeaders(serviceName: ADD_WISHLIST, parameters: params as? [String : Any]) { (json:NSDictionary?, error:NSError?) in
            DispatchQueue.main.async {  }
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.showInformation(title: "Closest", message: error?.localizedDescription ?? "")
                return
            }
            let responseDict:NSDictionary = json!
            print(responseDict)
            
            if let code = responseDict.value(forKey: "code") as? NSNumber {
            
            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                
                self.updateList()
                
                
            }
            else
            {
                
                self.hideActivityIndicator(uiView: self.view)
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
              
            }
            }else{
                self.showInformation(title: "Closest", message: "something went wrong")
            }
        }
        
 
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        add_on_amount = 0
        Bundle_amount = 0
        bundle_checkindate = ""
        bundle_checkoutdate = ""
        BundleSelectedDictValues.removeAllObjects()
        AddonsSelectedDictValues.removeAllObjects()
        BUndleSelectedArray.removeAllObjects()
        BundleArray.removeAllObjects()
        let featuredProperty = self.arrayList[indexPath.row] as! NSDictionary
     let currencySymbol = featuredProperty.object(forKey: "property_currency_symbol") as? String ?? ""
        let ProductId = "\(featuredProperty.object(forKey: "rental_id") as AnyObject)"
        let prop_slug = "\(featuredProperty.object(forKey: "ren_slug") as AnyObject)"
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
       nav!.PropertyID = ProductId
        nav!.prop_slug = prop_slug
        nav!.currencySymbol = currencySymbol
        //self.present(nav!, animated: true, completion: nil)
        self.navigationController?.pushViewController(nav!, animated: true)

    }



}
