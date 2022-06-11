//
//  ProductDetailGalleryTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 28/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailGalleryTableViewCell: UITableViewCell,UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var BaseView: UIView!
          @IBOutlet weak var GalleryCollection: UICollectionView!
    
    
    var photoGallery : NSMutableArray = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func DataReload(array:NSArray){
        self.photoGallery.removeAllObjects()
        self.photoGallery.addObjects(from: array as! [Any])
        self.GalleryCollection.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
         
            return  self.photoGallery.count//Singleton.sharedInstance.PropertyDetail.productImage.count
           
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
           
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as?
                GalleryCollectionViewCell
          // let url = URL(string:Singleton.sharedInstance.PropertyDetail.productImage[indexPath.row].productImage!)
            
            
            let url = URL(string:(self.photoGallery.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "product_image") as? String ?? "")
                     //cell!.imgSlider.kf.setImage(with: url)
                     cell!.ProductImage.kf.setImage(with: url, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
            if self.photoGallery.count < 4 {
                cell!.ImgCnt.isHidden = true
            }else{
                 cell!.ImgCnt.isHidden = false
            }
                return cell!
          
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
