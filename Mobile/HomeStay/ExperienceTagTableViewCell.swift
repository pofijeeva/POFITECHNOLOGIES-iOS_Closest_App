//
//  ExperienceTagTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceTagTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var TagLbl: UILabel!
    @IBOutlet weak var TypeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
