//
//  FavouriteDestinationTableViewCell.swift
//  Nagendra
//
//  Created by Nishanth on 31/07/21.
//

import UIKit

class FavouriteDestinationTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionVW: UICollectionView!
    var favDesArray = [[String:Any]]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionVW.delegate = self
        collectionVW.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return favDesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FavouriteDestinationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
       // cell.contentView.layer.borderWidth = 1.0
      //  cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.cornerRadius = 5.0
        let featuredPcities = self.favDesArray[indexPath.item]
        cell.cityNameLabel.font = UIFont(name: SemiBoldFont, size: 15)
        cell.proCountLabel.font = UIFont(name: SemiBoldFont, size: 13)

        cell.cityNameLabel.text = (featuredPcities["fav_city_name"] as! String)
        let imgURL = (featuredPcities["fav_city_image"] as! String)
        cell.cityImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        cell.proCountLabel.text = "\(featuredPcities["fav_city_pro_count"] as! Int) Homes"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}
