//
//  ProductDetailFeaturesTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailFeaturesTableViewCell: UITableViewCell,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var BaseView: UIView!
       @IBOutlet weak var FeatureCollection: UICollectionView!
        @IBOutlet weak var FeatureHeight: NSLayoutConstraint!
     @IBOutlet weak var BaseHeight: NSLayoutConstraint!
   
    
    var DataArray = NSMutableArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func FeatureData(array: NSMutableArray){
        self.DataArray.removeAllObjects()
        self.DataArray.add(array)
        self.FeatureHeight.constant = 150
        self.BaseHeight.constant = 150
        print(CGFloat(5 * 50))
        self.FeatureCollection.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
       
              return  5
         
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
      {
         
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as?
              FeatureCollectionViewCell
        cell!.FeatureLbl.font = UIFont(name: RegularFont, size: 14)
              return cell!
        
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let height = 60
     let width = collectionView.frame.width/2
        return CGSize(width: 130, height: 60)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
 
