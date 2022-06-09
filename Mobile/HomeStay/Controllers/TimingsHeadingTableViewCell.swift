//
//  TimingsHeadingTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TimingsHeadingTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTimings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelTimings.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelTimings.textColor = UIColor.darkGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
