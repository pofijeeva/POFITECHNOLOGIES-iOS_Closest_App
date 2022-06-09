//
//  InboxMessageSubmitTVCell.swift
//  HomeStay
//
//  Created by apple on 20/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InboxMessageSubmitTVCell: UITableViewCell {

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var viewReply: UIView!
    @IBOutlet weak var txtView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewReply.cornerRadius = self.viewReply.frame.size.height / 2
        btnSubmit.cornerRadius = self.btnSubmit.frame.size.height / 2
        
        self.btnReply.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.btnSubmit.titleLabel?.font = UIFont(name: SemiBoldFont, size: 17)
        self.txtView.font = UIFont(name: SemiBoldFont, size: 14)
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
