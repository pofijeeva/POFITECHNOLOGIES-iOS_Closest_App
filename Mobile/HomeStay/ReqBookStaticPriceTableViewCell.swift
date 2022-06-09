//
//  ReqBookStaticPriceTableViewCell.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 08/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ReqBookStaticPriceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var DailyPrice: UILabel!
    @IBOutlet weak var WeeklyPrice: UILabel!
    @IBOutlet weak var MonthlyPrice: UILabel!
    @IBOutlet weak var MinHourPrice: UILabel!
    @IBOutlet weak var HourlyPrice: UILabel!
    @IBOutlet weak var DailyPriceValue: UILabel!
       @IBOutlet weak var WeeklyPriceValue: UILabel!
       @IBOutlet weak var MonthlyPriceValue: UILabel!
       @IBOutlet weak var MinHourPriceValue: UILabel!
       @IBOutlet weak var HourlyPriceValue: UILabel!
      @IBOutlet weak var PriceDetails: UILabel!
      @IBOutlet weak var ChoosePrice: UILabel!
    @IBOutlet weak var DayLbl: UILabel!
      @IBOutlet weak var hourLbl: UILabel!
     @IBOutlet weak var hourImg: UIImageView!
     @IBOutlet weak var DayImg: UIImageView!
      @IBOutlet weak var DayBtn: UIButton!
      @IBOutlet weak var HourBtn: UIButton!
    
    @IBOutlet weak var DayView: UIView!
        @IBOutlet weak var HourView: UIView!
    @IBOutlet weak var ColorLbl: UILabel!

    
    @IBOutlet weak var DailyPriceView: UIView!
    @IBOutlet weak var HourlyPriceView: UIView!
    @IBOutlet weak var MonthlyPriceView: UIView!
    @IBOutlet weak var WeeklyPriceView: UIView!
    @IBOutlet weak var MinimumHourPrice: UIView!
    
    @IBOutlet weak var DailyPriceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var HourlyPriceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var MonthlyPriceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var WeeklyPriceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var MinimumHourPriceHeight: NSLayoutConstraint!

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
