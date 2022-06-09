//
//  ScheduleTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fromLbl: UILabel!
        @IBOutlet weak var toLbl: UILabel!
    @IBOutlet weak var fromDateLbl: UILabel!
        @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var DeleteBtn: UIButton!
         @IBOutlet weak var activeBtn: UIButton!
      @IBOutlet weak var BaseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
