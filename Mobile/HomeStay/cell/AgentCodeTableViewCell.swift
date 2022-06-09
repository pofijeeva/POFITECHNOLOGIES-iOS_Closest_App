//
//  AgentCodeTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 16/03/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AgentCodeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var DataView: UIView!
    @IBOutlet weak var expandBtn: UIButton!

    @IBOutlet weak var AgentCodeTxt: UITextField!
    @IBOutlet weak var ApplyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var DataViewHeight: NSLayoutConstraint!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
