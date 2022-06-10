//
//  AddonsViewController.swift
//  HomeStay
//
//  Created by Apple7 on 26/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class AddonsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var AddonsTable: UITableView!
    @IBOutlet weak var AddonsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var AddonsTotalAmountView: UIView!
    @IBOutlet weak var AddonsTotalAmountLbl: UILabel!
    @IBOutlet weak var AddonsTotalAmountValueLbl: UILabel!
    @IBOutlet weak var TitleHeader: UILabel!
    @IBOutlet weak var AddonsTotalViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AddonsSubmitBtn: UIButton!

    var AddonsArray = NSMutableArray()
//    var AddonsSelectedDictValues = NSMutableArray()
    var AddonsSelectedDict = NSMutableArray()

    var AmountStr = Int()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AddonsTotalViewHeight.constant = 0
        self.AddonsTotalAmountView.isHidden = true
        self.AddonsTotalAmountValueLbl.textColor = AppColor
        self.AddonsTotalAmountLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.AddonsTotalAmountValueLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.AddonsSubmitBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.AddonsSubmitBtn.backgroundColor = AppSecondColor
        
        if self.AddonsArray.count < 10 {
            self.AddonsTableHeight.constant = CGFloat(self.AddonsArray.count * 45)
        }else {
            self.AddonsTableHeight.constant = 400
        }
        self.AddonsTable.reloadData()

        if AddonsSelectedDictValues.count != 0 {
            self.AddonsTotalViewHeight.constant = 50
            self.AddonsTotalAmountView.isHidden = false
            self.AddonsTotalAmountValueLbl.text = "\(add_on_amount)"
        }else{
            self.AddonsTotalViewHeight.constant = 0
            self.AddonsTotalAmountView.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func act_Back(_ sender: UIButton)
    {
        if AddonsSelectedDictValues.count == 0 {
            AddonsSelectedDictValues.removeAllObjects()
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func act_Submit(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.AddonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddonsTableViewCell") as? AddonsTableViewCell else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AddonsTableViewCell") as? AddonsTableViewCell
            cell.selectionStyle = .none
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: (self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_name") as? String ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]));
        attributedString.append(NSAttributedString(string: "  -  \(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "amount") as AnyObject)", attributes: [NSAttributedString.Key.foregroundColor: AppColor]))
        
      //  let NameCurrency = (self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "add_on_name") as? String ?? "" + " ( USD - \((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "add_on_price") as AnyObject))"
        cell.AddonsLbl.attributedText = attributedString
        cell.AddonsLbl.font = UIFont(name: SemiBoldFont, size: 14)
        
        let AddOnId = "\((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_id") as AnyObject)"


//        for i in 0..<AddonsSelectedDictValues.count {
//            let BundleIds = "\((AddonsSelectedDictValues.object(at: i) as? NSDictionary)?.object(forKey: "id") as AnyObject)"
//            print(BundleIds)
//            if AddonsSelectedDictValues.contains(BundleIds) || AddonsSelectedDictValues.contains(AddOnId) {
//                cell.AddonsImg.image = UIImage(named: "Group-2")
//            }else{
//                cell.AddonsImg.image = UIImage(named: "Rectangle")
//            }
//        }
        
        if AddonsSelectedDictValues.contains(AddOnId) {
            cell.AddonsImg.image = UIImage(named: "Group-2")
        }else{
            cell.AddonsImg.image = UIImage(named: "Rectangle")
        }
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        let AddOnId = "\((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_id") as AnyObject)"
        let AddOnName = "\((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "list_name") as AnyObject)"
        
        let Amount = "\((self.AddonsArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "amount") as AnyObject)"
        
        let decimal = Decimal(floatLiteral: Double(Amount)!)
        let intValue = (decimal as NSDecimalNumber).intValue
        
        if AddonsSelectedDictValues.contains(AddOnId) {
            AddonsSelectedDictValues.remove(AddOnId)
            self.AmountStr = add_on_amount - intValue
            
            for i in 0..<AddonsSelectedValuesDict.count{
                let addonIds = "\((AddonsSelectedValuesDict.object(at: i) as? NSDictionary)?.object(forKey: "id") as AnyObject)"
                if AddOnId == addonIds{
                    AddonsSelectedValuesDict.removeObject(at: i)
                    break
                }
            }
        }else{
            AddonsSelectedDictValues.add(AddOnId)
            self.AmountStr = add_on_amount + intValue
            
            let data = NSMutableDictionary()
            data.setValue(AddOnId, forKey: "addon_id")
            data.setValue(AddOnName, forKey: "name")
            data.setValue(intValue, forKey: "id")
            
             AddonsSelectedValuesDict.add(data)
            print(AddonsSelectedDict)

        }
        add_on_amount = AmountStr

        if AddonsSelectedDictValues.count != 0 {
            self.AddonsTotalViewHeight.constant = 50
            self.AddonsTotalAmountView.isHidden = false
            self.AddonsTotalAmountValueLbl.text = "\(login_session.value(forKey: "APP_CURRENCYSYM") as? String ?? "$") \(AmountStr)"
            
        }else{
            self.AddonsTotalViewHeight.constant = 0
            self.AddonsTotalAmountView.isHidden = true
        }
        self.AddonsTable.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
