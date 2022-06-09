//
//  TimingsValueTableViewCell.swift
//  HomeStay
//
//  Created by dineshkumarr on 02/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class TimingsValueTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelSubHeading: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelSubHeading.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelSubHeading.textColor = UIColor.darkGray
        self.labelDate.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelDate.textColor = UIColor.darkGray
        self.labelTime.font = UIFont(name: SemiBoldFont, size: 17.0)
        self.labelTime.textColor = UIColor.darkGray
        
//        self.viewContent.layer.borderWidth = 1.0
//        self.viewContent.layer.borderColor = UIColor(hex: 0xBFBFC2).cgColor
        self.viewContent.layer.masksToBounds = false
        self.viewContent.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewContent.layer.shadowOffset = CGSize.zero
        self.viewContent.layer.shadowOpacity = 1.0
        self.viewContent.layer.shadowRadius = 2.0
        //(hex: 0xBFBFC2).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
