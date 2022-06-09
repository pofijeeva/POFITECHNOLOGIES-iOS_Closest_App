
//  WishListController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 20/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import Kingfisher
import AFNetworking

class WishListController: BaseViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var collWishList: UICollectionView!
    @IBOutlet weak var lblNoItemsInWishList: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var WishListTable: UITableView!
    
      @IBOutlet weak var lblNoItems: UIImageView!
    
    let wishListCounttempArray = NSMutableArray()

    var wishListDict = NSMutableDictionary()
    
    let id = Singleton.sharedInstance.selectedCategory!
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblNoItemsInWishList.isHidden = true
        self.lblNoItems.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
         self.lblNoItemsInWishList.font = UIFont(name: RegularFont, size: 17)
        
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if (Reachability()?.isReachable)!
        {
            WishListApiCall()
            
            
//            let id = Singleton.sharedInstance.selectedCategory!
//
//            let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&base_id=\(id)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
//            print(parameterStr)
//            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: GET_WISHLIST_API, APIKEY: "GET_WISHLIST_API")
        } else {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }

    }
    
    func WishListApiCall() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(GET_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                print("GET_WISHLIST_API Response:::",responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                self.wishListDict.addEntries(from: responseDict as! [AnyHashable : Any])
                self.wishListCounttempArray.removeAllObjects()
                self.wishListCounttempArray.addObjects(from: (self.wishListDict.object(forKey: "wishlist")as! NSArray) as! [Any])
                
                if mod.wishlist.count == 0
                {
                    self.collWishList.isHidden = true
                    self.lblNoItemsInWishList.isHidden = false
                    self.lblNoItems.isHidden = false
                }
                else
                {
                    self.collWishList.isHidden = false
                    self.lblNoItemsInWishList.isHidden = true
                    self.lblNoItems.isHidden = true
                }
                self.collWishList.reloadData()

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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Button actions
    
    @IBAction func act_Backbtn(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

//extension WishListController: UITableViewDelegate ,UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        if Singleton.sharedInstance.wishListModel != nil
//              {
//                  if Singleton.sharedInstance.wishListModel.wishlist.count != 0
//                  {
//                      return wishListCounttempArray.count
//                  }
//                  return 0
//              }
//              else
//              {
//                  return 0
//              }
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell  = tableView.dequeueReusableCell(withIdentifier: "PlaceListCell") as! PlaceListCell
//        cell.selectionStyle = .none
//        
//        let wishlistImgUrl = URL(string: ((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "wishlist_image") as? String)!)
//               cell.lblPlace.font = UIFont(name: SemiBoldFont, size: 14)
//                cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 18)
//               if wishlistImgUrl != nil {
//                  // cell?.imgWishList.kf.setImage(with:wishlistImgUrl!)
//                cell.imgPlace.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
//               }
//        cell.lblPlace.text = ((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "wishlist_title") as? String)
//               
//              // cell?.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
//               
//              cell.lblPrice.text  = (((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "property_details")as! NSArray).count as NSNumber).stringValue
//        
//        
//     
//        return cell
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 250
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        
//        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailViewController") as? PropertyDetailViewController
//       // nav?.PropertyID = String(Singleton.sharedInstance.wishListModel.wishlist[indexPath.section].hotelDetails[indexPath.row].propertyId)
////        nav?.currencySymbol = (wishListArr.object(at: indexPath.row)as! NSDictionary).object(forKey: "property_currency_symbol")as! String
////        nav?.PropertyID = ((wishListArr.object(at: indexPath.row)as! NSDictionary).object(forKey: "property_id")as! NSNumber).stringValue
////        self.navigationController?.pushViewController(nav!, animated: true)
//    }
//    
//    
//}
extension WishListController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if Singleton.sharedInstance.wishListModel != nil
        {
            if Singleton.sharedInstance.wishListModel.wishlist.count != 0
            {
                return wishListCounttempArray.count
            }
            return 0
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WishListCell
        let wishlistImgUrl = URL(string: ((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "wishlist_image") as? String)!)
        cell?.lblWishlistName.font = UIFont(name: SemiBoldFont, size: 14)
         cell?.lblWishlistCount.font = UIFont(name: SemiBoldFont, size: 12)
        if wishlistImgUrl != nil {
           // cell?.imgWishList.kf.setImage(with:wishlistImgUrl!)
            cell?.imgWishList.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        cell?.lblWishlistName.text = ((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "wishlist_title") as? String)
        
       // cell?.lblWishlistCount.text = String(Singleton.sharedInstance.wishListModel.wishlist.count)
        
        cell?.lblWishlistCount.text  = (((wishListCounttempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "property_details")as! NSArray).count as NSNumber).stringValue
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let nav = storyboard?.instantiateViewController(withIdentifier: "WishListShowViewController") as? WishListShowViewController
        nav?.selectedRow = indexPath.row
        let tempArray = NSMutableArray()
        tempArray.addObjects(from: (wishListDict.object(forKey: "wishlist")as! NSArray) as! [Any])
        nav?.wishListArr.addObjects(from: ((tempArray.object(at: indexPath.row)as! NSDictionary).object(forKey: "property_details")as! NSArray) as! [Any])
        self.navigationController?.pushViewController(nav!, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
}

extension WishListController : HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
         self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "GET_WISHLIST_API" {
            
            
            if errorDict.count == 0
            {
                if responseDict.value(forKey: "status") as! Int == 0 {
                    self.showInformation(title: "MotoForAll", message: responseDict.value(forKey: "message") as! String)
                }else{
               
                print("GET_WISHLIST_API Response:::",responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                wishListDict.addEntries(from: responseDict as! [AnyHashable : Any])
                wishListCounttempArray.removeAllObjects()
                wishListCounttempArray.addObjects(from: (wishListDict.object(forKey: "wishlist")as! NSArray) as! [Any])

                if mod.wishlist.count == 0
                {
                    self.collWishList.isHidden = true
                    self.lblNoItemsInWishList.isHidden = false
                    self.lblNoItems.isHidden = false
                }
                else
                {
                    self.collWishList.isHidden = false
                    self.lblNoItemsInWishList.isHidden = true
                    self.lblNoItems.isHidden = true
                }
                collWishList.reloadData()
            }
            }
            
        }
        else
        {
            print("No Data")
        }
    }
}
