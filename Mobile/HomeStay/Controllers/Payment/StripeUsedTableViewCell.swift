//
//  StripeUsedTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 12/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StripeUsedTableViewCell: UITableViewCell {

    @IBOutlet weak var BaseView: UIView!
     @IBOutlet weak var SelectTypeLbl: UILabel!
     @IBOutlet weak var SelectedCardType: UILabel!
    
     @IBOutlet weak var selectCardTtypeBtn: UIButton!
     @IBOutlet weak var CardNumberLbl: UILabel!
    @IBOutlet weak var ExpDateLbl: UILabel!
     @IBOutlet weak var CardNumberTxt: UITextField!
       @IBOutlet weak var CvvLbl: UILabel!
      
    @IBOutlet weak var yearTxt: UITextField!
         @IBOutlet weak var DateTxt: UITextField!
      @IBOutlet weak var CVVTxt: UITextField!
    @IBOutlet weak var SelectPaymentTypeLbl: UILabel!
    @IBOutlet weak var yearBtn: UIButton!
    @IBOutlet weak var monthBtn: UIButton!

    @IBOutlet weak var radioImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
