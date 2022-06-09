//
//  ExperienceStepsTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceStepsTableViewCell: UITableViewCell {

    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var StepNameLbl: UILabel!
    @IBOutlet weak var StepDescLbl: UILabel!
     @IBOutlet weak var StepImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
