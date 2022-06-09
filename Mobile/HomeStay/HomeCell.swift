//
//  HomeCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 18/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    
    //MARK:- Outlets
    
    @IBOutlet weak var imgHome: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
     @IBOutlet weak var LblListings: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
