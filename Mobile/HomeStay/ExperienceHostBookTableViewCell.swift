//
//  ExperienceHostBookTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceHostBookTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
          @IBOutlet weak var HostText: UILabel!
       @IBOutlet weak var HostName: UILabel!
     @IBOutlet weak var HostImg: UIImageView!
     @IBOutlet weak var BookBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
