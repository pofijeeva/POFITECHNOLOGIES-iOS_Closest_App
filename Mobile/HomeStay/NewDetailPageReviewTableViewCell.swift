//
//  NewDetailPageReviewTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 11/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewDetailPageReviewTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    
    
    @IBOutlet weak var Baseview: UIView!
    @IBOutlet weak var ReviewCollectionView: UICollectionView!
   @IBOutlet weak var ReviewCollectionViewHeight: NSLayoutConstraint!

    @IBOutlet weak var ReviewTitle: UILabel!
    @IBOutlet weak var OverAllRatLbl: UILabel!
    @IBOutlet weak var RatingView: FloatRatingView!
    @IBOutlet weak var OverAllReviewBtn: UIButton!
    @IBOutlet weak var CollectionBase: UIView!
    
    @IBOutlet weak var Reviewview: UIView!
    @IBOutlet weak var ReviewImg: UIImageView!
    @IBOutlet weak var ReviewMsg: UILabel!
    @IBOutlet weak var ReviewerName: UILabel!

    @IBOutlet weak var ReviewDate: UILabel!
    @IBOutlet weak var ReviewRatingView: FloatRatingView!



    

    override func awakeFromNib() {
        super.awakeFromNib()
       // self.ReviewCollectionViewHeight.constant = 180
        // Initialization code
    }
   
    
   @objc func DataArray(){
    self.ReviewCollectionView.reloadData()
    

      //  self.ReviewCollectionViewHeight.constant = self.ReviewCollectionView.contentSize.height
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0//Singleton.sharedInstance.PropertyDetail.propertyReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailPageReviewsCollectionViewCell", for: indexPath) as! DetailPageReviewsCollectionViewCell
        
        cell.ReviewMsg.font = UIFont(name: SemiBoldFont, size: 13)
        cell.ReviewerName.font = UIFont(name: SemiBoldFont, size: 16)
        cell.ReviewDate.font = UIFont(name: SemiBoldFont, size: 13)
        
        cell.ReviewerName.textColor = AppColor
        
        
        
        cell.ReviewMsg.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].review!
        cell.ReviewerName.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userName!.uppercased()
        cell.ReviewDate.text = Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].reviewDate!
        
        let ImageUrl = URL(string: Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].userImage!)
        
        cell.ReviewImg.setImageWith(ImageUrl!, placeholderImage: UIImage(named: "user"))
        
        cell.RatingView.rating = Float(Singleton.sharedInstance.PropertyDetail.propertyReviews[indexPath.row].starRating! as! NSNumber)
        
//        if Singleton.sharedInstance.PropertyDetail.propertyReviews.count == indexPath.row + 1 {
//            perform(#selector(DataArray), with: nil, afterDelay: 1.0)
//        }
        
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.contentSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
