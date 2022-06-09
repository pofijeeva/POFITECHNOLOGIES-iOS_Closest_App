//
//  ExperienceListingBaseTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 07/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceListingBaseTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewMain: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var labelDateAndTime: UILabel!
    @IBOutlet weak var buttonManage: UIButton!
    @IBOutlet weak var buttonPayNow: UIButton!
    @IBOutlet weak var Statuslbl: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
