//
//  ReqBookCalenderTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 08/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar

class ReqBookCalenderTableViewCell: UITableViewCell {

    @IBOutlet weak var BaseView: UIView!
      @IBOutlet weak var DatesViewHeight: NSLayoutConstraint!
     @IBOutlet weak var DatesCalender: FSCalendar!
    @IBOutlet weak var PickUpDate: UILabel!
    @IBOutlet weak var dropDate: UILabel!
    @IBOutlet weak var PickUpLbl: UILabel!
      @IBOutlet weak var dropLbl: UILabel!
    @IBOutlet weak var PickUpTime: UILabel!
    @IBOutlet weak var dropTime: UILabel!
 @IBOutlet weak var DaysView: UIView!
    
    @IBOutlet weak var bookeddaysLbl: UILabel!
    @IBOutlet weak var UnAvailabledaysLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
