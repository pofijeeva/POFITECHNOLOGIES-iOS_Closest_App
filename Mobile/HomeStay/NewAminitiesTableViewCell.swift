//
//  NewAminitiesTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 05/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewAminitiesTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var AminitiesCollection: UICollectionView!
    @IBOutlet weak var AminitiesCollectionHeight: NSLayoutConstraint!

    var favDesArray = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
       
   
    func Aminities(Name:NSArray){
        self.favDesArray.removeAllObjects()
        self.favDesArray.addObjects(from: Name as! [Any])
        self.AminitiesCollectionHeight.constant = CGFloat(self.favDesArray.count * 30)
        self.AminitiesCollection.reloadData()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return favDesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newAminitiesCollectionViewCell", for: indexPath) as? newAminitiesCollectionViewCell else {
            return UICollectionViewCell()
        }
         
         cell.AminityName.font = UIFont(name: SemiBoldFont, size: 15)
        cell.AminityName.text = (self.favDesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "list_name") as! String
        
        if "\((self.favDesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "list_available") as AnyObject)" == "1"{
            cell.aminitiesImg.image = UIImage(named: "radiobtnselected")
        }else{
            cell.aminitiesImg.image = UIImage(named: "radiobtndeselected")

        }
        cell.aminitiesImg.setImageColor(color: AppColor)
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            let yourWidth = collectionView.bounds.width/2.0
            let yourHeight = CGFloat(60)
            return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // UICollectionViewDataSource method

//        func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//    sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//
// 
//        let width = collectionView.frame.size.width / 2
//
//        let height = 60
//
//            return CGSize(width: width, height: CGFloat(height));
//    }

    // UICollectionViewDelegateFlowLayout method

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//    insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        let cellWidthPadding = collectionView.frame.size.width / 2
//        let cellHeightPadding = 60
//        return UIEdgeInsets(top: CGFloat(cellHeightPadding),left: cellWidthPadding, bottom: CGFloat(cellHeightPadding),right: cellWidthPadding)
//    }
}
