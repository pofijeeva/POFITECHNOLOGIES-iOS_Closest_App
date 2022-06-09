//
//  BundleTwoTableViewCell.swift
//  HomeStay
//
//  Created by Apple7 on 26/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BundleTwoTableViewCell: UITableViewCell {
    
    // FirstView
    
    @IBOutlet weak var BaseView: UIView!
    @IBOutlet weak var FirstView: UIView!
    @IBOutlet weak var FirstImg: UIImageView!
    @IBOutlet weak var FirstNameLbl: UILabel!
    @IBOutlet weak var FirstDescLbl: UILabel!
    @IBOutlet weak var FirstPriceLbl: UILabel!
    @IBOutlet weak var FirstStPriceLbl: UILabel!
    @IBOutlet weak var FirstGuestLbl: UITextField!
    @IBOutlet weak var FirstSelImg: UIImageView!
    @IBOutlet weak var FirstBtn: UIButton!

    
    @IBOutlet weak var SecondView: UIView!
    @IBOutlet weak var SecondImg: UIImageView!
    @IBOutlet weak var SecondNameLbl: UILabel!
    @IBOutlet weak var SecondDescLbl: UILabel!
    @IBOutlet weak var SecondPriceLbl: UILabel!
    @IBOutlet weak var SecondStPriceLbl: UILabel!
    @IBOutlet weak var SecondGuestLbl: UITextField!
    @IBOutlet weak var SecondSelImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FirstNameLbl.font = UIFont(name: SemiBoldFont, size: 13)
        FirstDescLbl.font = UIFont(name: SemiBoldFont, size: 10)

        FirstPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
        FirstStPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
        
        SecondNameLbl.font = UIFont(name: SemiBoldFont, size: 13)
        SecondDescLbl.font = UIFont(name: SemiBoldFont, size: 10)

        SecondPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
        SecondStPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
        
        FirstGuestLbl.font = UIFont(name: SemiBoldFont, size: 12)
        SecondGuestLbl.font = UIFont(name: SemiBoldFont, size: 12)

        
        // Initialization code
    }
    func loadFirstFoodItems(item:NSDictionary){
        
        
       
        let imgURL = URL(string: item.object(forKey: "bundle_image") as! String)
        FirstImg.kf.setImage(with: imgURL)
        FirstNameLbl.text = (item.object(forKey: "bundle_Name") as! String)
        FirstDescLbl.text = (item.object(forKey: "bundle_description") as! String)
        
        let BundleId = "\(item.object(forKey: "bundle_id") as! String)"

        for i in 0..<BundleSelectedDictValues.count {
            let BundleIds = "\((BundleSelectedDictValues.object(at: i) as! NSDictionary).object(forKey: "bundle_id") as AnyObject)"
            
            if BundleId == BundleIds && BUndleSelectedArray.contains(BundleId) {
                FirstGuestLbl.text = "\((BundleSelectedDictValues.object(at: i) as! NSDictionary).object(forKey: "No_of_Guests") as AnyObject)"
                self.FirstView.layer.borderWidth = 1.2
                self.FirstView.layer.borderColor = AppSecondColor.cgColor
                self.FirstSelImg.isHidden = false
            }else{
                self.FirstView.layer.borderWidth = 1.2
                self.FirstView.layer.borderColor = UIColor.lightGray.cgColor
                self.FirstSelImg.isHidden = true
            }
        }
        
        let BundlePrice = "\(item.object(forKey: "bundle_amount_after_discount") as! AnyObject)"
        
        if BundlePrice == "0" {
            FirstPriceLbl.text = "USD \((item.object(forKey: "bundle_price") as AnyObject)) / guest"
            FirstStPriceLbl.isHidden = true

        }else {
            FirstStPriceLbl.isHidden = false

            FirstPriceLbl.text = "USD \((item.object(forKey: "bundle_amount_after_discount") as AnyObject)) / guest"
            FirstStPriceLbl.attributedText = "USD \((item.object(forKey: "bundle_price") as AnyObject))".strikeThrough()
        }

        

        
//        if BUndleSelectedArray.contains(BundleId) {
//            self.FirstView.layer.borderWidth = 1.2
//            self.FirstView.layer.borderColor = AppSecondColor.cgColor
//            self.FirstSelImg.isHidden = false
//
//        }else{
//            self.FirstView.layer.borderWidth = 1.2
//            self.FirstView.layer.borderColor = UIColor.lightGray.cgColor
//            self.FirstSelImg.isHidden = true
//
//        }

  
    }
    
    func loadSecondFoodItems(item:NSDictionary){
        let imgURL = URL(string: item.object(forKey: "bundle_image") as! String)
        SecondImg.kf.setImage(with: imgURL)
        SecondNameLbl.text = (item.object(forKey: "bundle_Name") as! String)
        SecondDescLbl.text = (item.object(forKey: "bundle_description") as! String)

        SecondPriceLbl.text = (item.object(forKey: "bundle_price") as! String)
        SecondStPriceLbl.text = "\(item.object(forKey: "bundle_discount") as AnyObject)"
        
        
        let BundlePrice = "\(item.object(forKey: "bundle_amount_after_discount") as! AnyObject)"
        let BundleId = "\(item.object(forKey: "bundle_id") as! String)"

        for i in 0..<BundleSelectedDictValues.count {
            let BundleIds = "\((BundleSelectedDictValues.object(at: i) as! NSDictionary).object(forKey: "bundle_id") as AnyObject)"
            
            if BundleId == BundleIds && BUndleSelectedArray.contains(BundleId){
                SecondGuestLbl.text = "\((BundleSelectedDictValues.object(at: i) as! NSDictionary).object(forKey: "No_of_Guests") as AnyObject)"
                self.SecondView.layer.borderWidth = 1.2
                self.SecondView.layer.borderColor = AppSecondColor.cgColor
                self.SecondSelImg.isHidden = false
            }else{
                self.SecondView.layer.borderWidth = 1.2
                self.SecondView.layer.borderColor = UIColor.lightGray.cgColor
                self.SecondSelImg.isHidden = true
            }
        }
        
        if BundlePrice == "0" {
            SecondPriceLbl.text = "USD \((item.object(forKey: "bundle_price") as AnyObject)) / guest"
            SecondStPriceLbl.isHidden = true


        }else {
            SecondStPriceLbl.isHidden = false

            SecondPriceLbl.text = "USD \((item.object(forKey: "bundle_amount_after_discount") as AnyObject)) / guest"
            
            
            SecondStPriceLbl.attributedText = "USD \((item.object(forKey: "bundle_price") as AnyObject))".strikeThrough()

        }
        

        
//        if BUndleSelectedArray.contains(BundleId) {
//            self.SecondView.layer.borderWidth = 1.2
//            self.SecondView.layer.borderColor = AppSecondColor.cgColor
//            self.SecondSelImg.isHidden = false
//
//        }else{
//            self.SecondView.layer.borderWidth = 1.2
//            self.SecondView.layer.borderColor = UIColor.lightGray.cgColor
//            self.SecondSelImg.isHidden = true
//
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
