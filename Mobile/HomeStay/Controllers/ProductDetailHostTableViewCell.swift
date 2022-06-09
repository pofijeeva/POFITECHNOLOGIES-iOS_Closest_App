//
//  ProductDetailHostTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 28/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProductDetailHostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var HostedByLbl: UILabel!
     @IBOutlet weak var HostNameLbl: UILabel!
    @IBOutlet weak var JoinDateLbl: UILabel!

    @IBOutlet weak var HostImage: UIImageView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
