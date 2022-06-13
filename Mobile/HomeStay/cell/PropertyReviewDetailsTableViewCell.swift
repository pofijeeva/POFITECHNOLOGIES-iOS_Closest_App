//
//  PropertyReviewDetailsTableViewCell.swift
//  HomeStay
//
//  Created by Dinesh on 13/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PropertyReviewDetailsTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var btnAllReviews: UIButton!
    @IBOutlet weak var reviewCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.PropertyDetail != nil
        {
           
          
                return Singleton.sharedInstance.PropertyDetail.propertyReviews.count
           
        } else {
            return  0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PropertyDetailReviewCell
            cell!.bgView.layer.cornerRadius = 5.0
            cell!.bgView.layer.borderColor = UIColor.darkGray.cgColor
            cell!.bgView.layer.borderWidth = 1.0
            cell!.imgReviewUser.imageFromURL(urlString: Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userImage)
         cell!.lblReviewComment.font = UIFont(name: RegularFont, size: 16)
        cell!.lblReviewComment.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userName
        cell!.ratingView.rating = Float(Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].starRating as? NSNumber ?? 0)
            return cell!
        
    }

}
