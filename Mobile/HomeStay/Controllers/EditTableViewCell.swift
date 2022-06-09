//
//  EditTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 29/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {

    @IBOutlet weak var dishNameLbl: UILabel!
    
    @IBOutlet weak var editDishNameLbl: UILabel!
    
    @IBOutlet weak var editdishpriceLbl: UILabel!
    
    @IBOutlet weak var editBut: UIButton!
    
    @IBOutlet weak var deleteBut: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
