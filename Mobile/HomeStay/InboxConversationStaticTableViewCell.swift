//
//  InboxConversationStaticTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 23/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InboxConversationStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
       @IBOutlet weak var lblMemberSince: UILabel!
      
       @IBOutlet weak var lblDate: UILabel!
       @IBOutlet weak var lblImgUser: UIImageView!
     
       
       @IBOutlet weak var lblGuestnumber: UILabel!
       @IBOutlet weak var lblChatTitle: UILabel!
       @IBOutlet weak var lblEnquiryID: UILabel!
       @IBOutlet weak var btnPreApproval: UIButton!
       @IBOutlet weak var btnDecline: UIButton!
       
     
       
         @IBOutlet weak var lblWelcome: UILabel!
       
       
         @IBOutlet weak var EnquiryID: UILabel!
         @IBOutlet weak var Date: UILabel!
       @IBOutlet weak var Guest: UILabel!
          @IBOutlet weak var PreApproveHeight: NSLayoutConstraint!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
