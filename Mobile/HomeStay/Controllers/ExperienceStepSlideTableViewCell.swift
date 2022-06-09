//
//  ExperienceStepSlideTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceStepSlideTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
       @IBOutlet weak var StepNameLbl: UILabel!
    @IBOutlet weak var StepNameDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
