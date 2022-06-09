//
//  ReqBookImageTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 30/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReqBookImageTableViewCell: UITableViewCell {

     @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
      @IBOutlet weak var ProductLocation: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var LocImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
