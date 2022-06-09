//
//  FeaturedCitiesTableViewCell.swift
//  Nagendra
//
//  Created by Nishanth on 31/07/21.
//

import UIKit
protocol delegateForHomeFeatured {
    func passFeatureData(storeName:String,restId:String)
}
class FeaturedCitiesTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionVW: UICollectionView!
    var feature_city_list = [[String:Any]]()
    var delegate : delegateForHomeFeatured?

    
    var deli : delegateForHomeFeatured?
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
            return feature_city_list.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeaturedCitiesCollectionViewCell else {
            return UICollectionViewCell()
        }
        //
        cell.cityImg.layer.cornerRadius = 5.0
        let featuredPcities = self.feature_city_list[indexPath.item]
        cell.nameLabel.text = (featuredPcities["fcty_name"] as! String)
        cell.nameLabel.font = UIFont(name: SemiBoldFont, size: 17)
        cell.BtnExplore.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)

        let imgURL = (featuredPcities["fcty_image"] as! String)
        cell.cityImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let featuredPcities = self.feature_city_list[indexPath.item]
        self.delegate?.passFeatureData(storeName: (featuredPcities["fcty_name"] as! String), restId: "")
    }
    
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: 180)
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        deli?.updateToList(indexPath: indexPath)
//    }
    
}


//guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FeaturedCitiesCollectionViewCell else {
//    return UICollectionViewCell()
//}
//let featuredPcities = self.feature_city_list[indexPath.item]
//cell.nameLabel.text = (featuredPcities["fcty_name"] as! String)
