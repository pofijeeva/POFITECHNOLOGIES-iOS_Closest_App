//
//  PaymentTypesTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 12/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PaymentTypesTableViewCell: UITableViewCell {

    
    
     @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var TypeImg: UIImageView!
     @IBOutlet weak var TypeName: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
