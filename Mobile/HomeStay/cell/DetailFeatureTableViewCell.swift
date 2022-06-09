//
//  DetailFeatureTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class DetailFeatureTableViewCell: UITableViewCell {

     @IBOutlet weak var FeatureTitle: UILabel!
    @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var FeatureDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
