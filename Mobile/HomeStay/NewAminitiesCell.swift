//
//  NewAminitiesCell.swift
//  HomeStay
//
//  Created by Apple7 on 26/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class NewAminitiesCell: UITableViewCell {
    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var AminitiesView: UIView!
    @IBOutlet weak var AddonsView: UIView!
    @IBOutlet weak var BundleView: UIView!

    
    @IBOutlet weak var AminitiesTitleLbl: UILabel!
    @IBOutlet weak var AminitiesLbl: UILabel!
    @IBOutlet weak var AminitiesImg: UIImageView!
    @IBOutlet weak var AminitiesBtn: UIButton!
    @IBOutlet weak var AminitiesViewLbl: UILabel!


    @IBOutlet weak var AddonsTitleLbl: UILabel!
    @IBOutlet weak var AddonsLbl: UILabel!
    @IBOutlet weak var AddonsBtn: UIButton!
    @IBOutlet weak var AddonsImg: UIImageView!
    @IBOutlet weak var AddonsViewLbl: UILabel!


    @IBOutlet weak var BundleTitleLbl: UILabel!
    @IBOutlet weak var BundleLbl: UILabel!
    @IBOutlet weak var BundleBtn: UIButton!
    @IBOutlet weak var BundleImg: UIImageView!
    @IBOutlet weak var BundleViewLbl: UILabel!




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
