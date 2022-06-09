 //
 //  SearchCell.swift
 //  HomeStay
 //
 //  Created by POFI TECHNOLOGIES on 26/07/18.
 //  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
 //
 
 import UIKit
 
 class SearchCell: UITableViewCell {
    
    //MARK:- Outlets
    
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var lblLocationDisc: UILabel!
    
    
    
    
    //////////COUPONCELL///////////////////
    
    @IBOutlet weak var walletAmount: UILabel!
    @IBOutlet weak var usedWalletLabel: UILabel!
    @IBOutlet weak var balenceWallet: UILabel!
    
    
    @IBOutlet weak var YourEarings: UILabel!
       @IBOutlet weak var TotalWalletAmount: UILabel!
    @IBOutlet weak var UsedWallet: UILabel!
       @IBOutlet weak var WalletBalance: UILabel!
    //MARK:- Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
 }

