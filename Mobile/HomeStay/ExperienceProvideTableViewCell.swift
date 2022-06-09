//
//  ExperienceProvideTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 29/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceProvideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemQuantity: UILabel!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var AboutLbl: UILabel!
    @IBOutlet weak var EditBtn: UIButton!
    @IBOutlet weak var DeleteBtn: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
