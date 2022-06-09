//
//  CalendarListTableViewCell.swift
//  HomeStay
//
//  Created by Kala on 13/10/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class CalendarListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSNo: UILabel!
    @IBOutlet weak var lblSNoValue: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTypeValue: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckInValue: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblCheckOutValue: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPriceValue: UILabel!
    
    func updateDetails(_ details: CalendarList?) {
        switch details?.prop_status {
        case 0: self.lblTypeValue.text = "Special"
        case 1: self.lblTypeValue.text = "Booked"
        default: self.lblTypeValue.text = "Unavailable"
        }
        self.lblCheckInValue.text = details?.check_in
        self.lblCheckOutValue.text = details?.check_out
        self.lblPriceValue.text = String(format: "%d", details?.price ?? 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
