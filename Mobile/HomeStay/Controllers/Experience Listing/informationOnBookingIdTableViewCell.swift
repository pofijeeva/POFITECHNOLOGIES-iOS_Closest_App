//
//  informationOnBookingIdTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class informationOnBookingIdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelInformationonBooking: UILabel!
    @IBOutlet weak var labelBoatName: UILabel!
    @IBOutlet weak var labelNoOfGuests: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewProfile: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.frame.width / 2
        self.labelInformationonBooking.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelBoatName.font = UIFont(name: SemiBoldFont, size: 18.0)
        self.labelBoatName.textColor = UIColor.darkGray
        self.labelNoOfGuests.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelNoOfGuests.textColor = AppSecondColor
        self.labelDate.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelDate.textColor = AppSecondColor
//        let attributedString = NSMutableAttributedString()
//        let str = "Hello "
//        let attributed = NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : UIColor.darkGray])
//        let attributedTwo = NSAttributedString(string: str, attributes: [NSAttributedStringKey.foregroundColor : AppSecondColor])
//        attributedString.append(attributed)
//        attributedString.append(attributedTwo)
//        self.labelInformationonBooking.attributedText = attributedString
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
