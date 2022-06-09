//
//  CalenderDateTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 03/01/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CalenderDateTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tableName: UILabel!
    
    @IBOutlet weak var tabletime: UILabel!
   
    @IBOutlet weak var tablePrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        tableName.layer.cornerRadius = 5
        tabletime.layer.cornerRadius = 5
        tablePrice.layer.cornerRadius = 5
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//extension CalenderDateTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return  Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails.count
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableDetailsCollectionViewCell", for: indexPath) as?
//        TableDetailsCollectionViewCell
//        
//        cell?.tableNameLbl.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].tableName
//        cell?.tablePriceLbl.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].price ?? ""
//        cell?.tableTimingLbl.text = Singleton.sharedInstance.rootClass.dateDetails[0].tableDetails[indexPath.item].startTime
//        
//        return cell!
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        print("Row Number is:",indexPath.item)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableDetailsCollectionViewCell", for: indexPath) as? TableDetailsCollectionViewCell
//        
//        // self.present(cells!, animated: true, completion: nil)
//    }
//}
