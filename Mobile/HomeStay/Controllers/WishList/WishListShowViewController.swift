//
//  WishListShowViewController.swift
//  HomeStay
//
//  Created by Apple2 on 22/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class WishListShowViewController: UIViewController {
    
    @IBOutlet weak var wishTable: UITableView!
    
    @IBOutlet weak var NavTitle: UILabel!

    var image : String = ""
    var name : String = ""
    var price : AnyObject!
    var currency : String = ""
    var selectedRow : Int = 0
    var wishListArr : NSMutableArray = []

    
    let id = Singleton.sharedInstance.selectedCategory
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavTitle.font = UIFont(name: SemiBoldFont, size: 18)
        // Do any additional setup after loading the view.
        self.wishTable.reloadData()

        
    }
    @IBAction func backAct(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension WishListShowViewController: UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wishListArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell") as! PlaceListCell
        cell.selectionStyle = .none
        let imageArray : NSMutableArray = []
        imageArray.addObjects(from: ((wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_images")as? NSArray) as? [Any] ?? [])
        let wishlistImgUrl = URL(string:(imageArray.object(at: 0)as? NSDictionary)?.object(forKey: "property_image")as? String ?? "")
        cell.lblPlace.font = UIFont(name: SemiBoldFont, size: 15)
        cell.lblPrice.font = UIFont(name: SemiBoldFont, size: 16)
      //  cell.lblPrice.textColor = AppSecondColor
       // cell.wishImage.kf.setImage(with: wishlistImgUrl!)
        cell.imgPlace.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)

        cell.lblPrice.text = ((wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_currency_symbol")as? String ?? "") + " " + ((wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_price")as? NSNumber ?? 0).stringValue
     
        cell.lblPlace.text = ((wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_title")as? String ?? "")
      
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "NewProductDetailViewController") as? NewProductDetailViewController
       // nav?.PropertyID = String(Singleton.sharedInstance.wishListModel.wishlist[indexPath.section].hotelDetails[indexPath.row].propertyId)
        nav?.currencySymbol = (wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_currency_symbol")as? String ?? ""
        nav?.PropertyID = ((wishListArr.object(at: indexPath.row)as? NSDictionary)?.object(forKey: "property_id")as? NSNumber ?? 0).stringValue
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


