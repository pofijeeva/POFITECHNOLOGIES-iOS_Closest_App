//
//  ListingInfoCell.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ListingInfoCell: UITableViewCell {

    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgDropDown: UIImageView!
      @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
