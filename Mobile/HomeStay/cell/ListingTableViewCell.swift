//
//  ListingTableViewCell.swift
//  HomeStay
//
//  Created by Nishanth on 31/07/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import SDWebImage

protocol delegateForHomeProperty {
    func passFeatureProperty(storeName: String, restId: String, currency: String)
    func wishlist(StoreId: String)
}

class ListingTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionVW: UICollectionView!
    
    var featuredProperty = [[String:Any]]()
   
    var sectionIndex:Int?
    var delegate : delegateForHomeProperty?

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionVW.delegate = self
        collectionVW.dataSource = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return featuredProperty.count
       
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
      
            guard let cell = self.collectionVW.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeaturedListingCollectionViewCell else {
                return UICollectionViewCell()
            }
        
        cell.StarandRateLbl.layer.cornerRadius = 5.0
        
        cell.Listingimg.layer.cornerRadius = 5.0
            let featuredProperty = self.featuredProperty[indexPath.item]
        let currencySymbol = (featuredProperty["currency_symbol"] as? String ?? "")
            
        let price = (featuredProperty["price_list"] as! NSNumber)
            cell.costLabel.text = "\(currencySymbol)\(price) / day"
        cell.costLabel.font = UIFont(name: SemiBoldFont, size: 17)
        cell.addLabel.font = UIFont(name: SemiBoldFont, size: 18)
        cell.locationLabel.font = UIFont(name: SemiBoldFont, size: 14)

        if let rate = featuredProperty["ratings"] as? String {
        cell.ratingLabel.text = String(format: "%0.0f", Double(rate) ?? 0.0)
                }
//        cell.ratingLabel.text = (featuredProperty["ratings"] as? String ?? "")
            cell.locationLabel.text = (featuredProperty["location"] as? String ?? "")
            cell.addLabel.text = (featuredProperty["ren_title"] as? String ?? "")
        let imgURL = (featuredProperty["ren_image"] as? String ?? "")
        cell.Listingimg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        let favid = "\(featuredProperty["is_wishlist"] as AnyObject)"
        if favid == "1"  {
            
            cell.FavButton.setImage(UIImage(named: "FavNew"), for: .normal)
        }else {
            cell.FavButton.setImage(UIImage(named: "like-1"), for: .normal)
         }
        
        cell.FavButton.tag = indexPath.row
        cell.FavButton.addTarget(self, action: #selector(Fav), for: .touchUpInside)
            return cell
        
        
//        guard let cell = self.CollectionVw.dequeueReusableCell(withReuseIdentifier: "RestaurantCollectionViewCell", for: indexPath) as? RestaurantCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        cell.contentVW.layer.borderWidth = 1.0
//        cell.contentVW.layer.borderColor = UIColor.lightGray.cgColor
//        cell.contentVW.layer.cornerRadius = 5.0
//        cell.name.text = resArray[indexPath.row].restaurant_name ?? ""
//        cell.resDes.text = resArray[indexPath.row].restaurant_desc
//        cell.resTimimg.text = resArray[indexPath.row].today_wking_time
//        cell.resImage.sd_setImage(with: URL(string: resArray[indexPath.row].restaurant_image ?? "placeholder.png"), placeholderImage: UIImage(named: "placeholder.png"))
//        return cell
    }
    
    @objc func Fav(sender:UIButton){
        let featuredProperty = self.featuredProperty[sender.tag]
        let FavId = "\((featuredProperty["property_id"] as AnyObject))"
        delegate?.wishlist(StoreId: FavId)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let featuredProperty = self.featuredProperty[indexPath.item]
        self.delegate?.passFeatureProperty(storeName: "\((featuredProperty["ren_slug"] as AnyObject))", restId: "\(featuredProperty["property_id"] as AnyObject)", currency: (featuredProperty["currency_symbol"] as? String ?? ""))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: 350)
    }

}
