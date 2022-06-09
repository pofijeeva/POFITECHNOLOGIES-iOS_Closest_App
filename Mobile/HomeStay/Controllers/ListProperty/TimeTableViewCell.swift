//
//  TimeTableViewCell.swift
//  HomeStay
//
//  Created by Apple2 on 02/01/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var timetextField: UITextField!
    
    
    @IBOutlet weak var editActionBut: UIButton!
    
    @IBOutlet weak var deleteActionBut: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
