 //
 //  SplitCell.swift
 //  HomeStay
 //
 //  Created by POFI TECHNOLOGIES on 31/07/18.
 //  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
 //
 
 import UIKit
 protocol delegateForCategorySearch {
    func showItemsBasedOnCategory(nameStr:String)
    // func showItemBasedOnName(nameStr:String)
 }
 class SplitCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var lblName: UILabel!
    
    
    
    
    
    /////////////////////COUPONCELL///////////////
     @IBOutlet weak var couponNameLbl: UILabel!
      @IBOutlet weak var couponCode: UILabel!
     @IBOutlet weak var couponPerRental: UILabel!
      @IBOutlet weak var couponPrice: UILabel!
    @IBOutlet weak var couponLimit: UILabel!
    @IBOutlet weak var couponDate: UILabel!
     @IBOutlet weak var FromTo: UILabel!
    
    @IBOutlet weak var couponName: UILabel!
    @IBOutlet weak var couponCodeLbl: UILabel!
    @IBOutlet weak var couponRentlLbl: UILabel!
    @IBOutlet weak var couponPriceLbl: UILabel!
    @IBOutlet weak var couponDatesLbl: UILabel!
    @IBOutlet weak var couponLimitLbl: UILabel!
    @IBOutlet weak var couponCellView: UIView!
    
    
    var selectedIndex = Int()
    var propertyId = String()
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate : delegateForCategorySearch?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.couponCellView.layer.cornerRadius = 10
        self.couponCellView.layer.borderColor = UIColor.lightGray.cgColor
        self.couponCellView.layer.borderWidth = 2
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func reloadCollectionView(index:Int) -> Void {
        selectedIndex = index
        self.collectionView.reloadData()
    }
    
 }
 
 extension SplitCell : UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if Singleton.sharedInstance.couponDetailsJson != nil
        {
            return Singleton.sharedInstance.couponDetailsJson.couponDetails[selectedIndex].couponAssignedProducts.count
            
            
            //return Singleton.sharedInstance.couponDetailsJson.couponDetails.count
        } else {
            return 0
        }
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CouponCollectionViewCell
        
         cell.couponLbl.font = UIFont(name: RegularFont, size: 14)
        cell.couponLbl.text = Singleton.sharedInstance.couponDetailsJson.couponDetails[selectedIndex].couponAssignedProducts[indexPath.row].productTitle
        // self.propertyId = Singleton.sharedInstance.couponDetailsJson.couponDetails[selectedIndex].couponAssignedProducts[indexPath.row].id
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.delegate?.showItemsBasedOnCategory(nameStr: Singleton.sharedInstance.couponDetailsJson.couponDetails[selectedIndex].couponAssignedProducts[indexPath.row].id)
        
        
        
    }
    
 }

