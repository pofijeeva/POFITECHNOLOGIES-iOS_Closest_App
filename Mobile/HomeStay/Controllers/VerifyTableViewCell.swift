//
//  VerifyTableViewCell.swift
//  HomeStay
//
//  Created by M.NAGENDRANATH REDDY on 15/08/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class VerifyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FileImg: UIImageView!
    @IBOutlet weak var SNoLbl: UILabel!
    @IBOutlet weak var ProofTypeLbl: UILabel!
    @IBOutlet weak var ProofStatusLbl: UILabel!
    
    @IBOutlet weak var PrfStsLbl: UILabel!
    @IBOutlet weak var PfrtypLbl: UILabel!
    @IBOutlet weak var FileTypeLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        FileImg.layer.borderWidth = 1
        FileImg.layer.masksToBounds = false
        FileImg.layer.borderColor = UIColor.black.cgColor
        FileImg.layer.cornerRadius = FileImg.frame.height/2
        FileImg.clipsToBounds = true
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
