//
//  ReqBookTimeTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 11/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReqBookTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var BaseView: UIView!
        
      @IBOutlet weak var PickUpTime: UILabel!
      @IBOutlet weak var dropTime: UILabel!
      @IBOutlet weak var StartLbl: UILabel!
    @IBOutlet weak var endLbl: UILabel!
    @IBOutlet weak var StartBtn: UIButton!
      @IBOutlet weak var endBtn: UIButton!

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
