//
//  HomedetailTableViewCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 15/10/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HomedetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImgHome: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
