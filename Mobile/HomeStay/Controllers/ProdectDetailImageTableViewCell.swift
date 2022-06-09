//
//  ProdectDetailImageTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 27/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ProdectDetailImageTableViewCell: UITableViewCell {

    
     @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var FavBtn: UIButton!
    @IBOutlet weak var FavImg: UIImageView!
    @IBOutlet weak var StartsLbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var ProductName: UILabel!
 @IBOutlet weak var ProductLocation: UILabel!
    @IBOutlet weak var ProductRating: UILabel!
    @IBOutlet weak var LocImage: UIImageView!
     @IBOutlet weak var RatingImage: UIImageView!
    @IBOutlet weak var GuestCountLbl: UILabel!

    @IBOutlet weak var verifiedHeight: NSLayoutConstraint!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
