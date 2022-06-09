//
//  ReqBookGuestTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 30/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReqBookGuestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
        
       
            @IBOutlet weak var GuestLbl: UILabel!
      
       @IBOutlet weak var GuestValueLbl: UILabel!
          
    
     @IBOutlet weak var PlusBtn: UIButton!
     @IBOutlet weak var minusBtn: UIButton!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
