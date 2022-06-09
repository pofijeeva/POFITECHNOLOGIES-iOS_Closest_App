//
//  ExperincyHistoryTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 05/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperincyHistoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var ExpNameLbl: UILabel!
    @IBOutlet weak var ExpBookedOnLbl: UILabel!
    @IBOutlet weak var ExpBookedOnValueLbl: UILabel!
    @IBOutlet weak var ExpDateLbl: UILabel!
    @IBOutlet weak var PayBtn: UIButton!
    @IBOutlet weak var AvailableTimesBtn: UIButton!
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var ExpPriceLbl: UILabel!
    @IBOutlet weak var ExpBookingIdLbl: UILabel!
    @IBOutlet weak var ExpBookingIdValueLbl: UILabel!
    @IBOutlet weak var ExpPayStatusLbl: UILabel!
    @IBOutlet weak var ExpPayStatusValueLbl: UILabel!
    @IBOutlet weak var ExpHostApprovalStatusLbl: UILabel!
    @IBOutlet weak var ExpHostApprovalStatusValueLbl: UILabel!
    @IBOutlet weak var ExpLocation: UILabel!
    @IBOutlet weak var ExpHostedByLbl: UILabel!
    @IBOutlet weak var ExpHostNameLbl: UILabel!
    @IBOutlet weak var ExpImage: UIImageView!
    @IBOutlet weak var HostBtn: UIButton!
    
    @IBOutlet weak var ThreeDotsBtn: UIButton!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
