 //
 //  HostCancellationViewController.swift
 //  HomeStay
 //
 //  Created by saravanan2 on 20/12/19.
 //  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
 //
 
 import UIKit
 import AFNetworking
 
 
 class HostCancellationViewController: BaseViewController {
    
    
    
    
    @IBOutlet weak var NodataLbl: UILabel!
    @IBOutlet weak var Host_Cancellation: UITableView!
     @IBOutlet weak var NavTitle: UILabel!
     @IBOutlet weak var HostCancelBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.NavTitle.font = UIFont(name: SemiBoldFont, size: 18)
        self.NodataLbl.font = UIFont(name: RegularFont, size: 17)
          self.HostCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
        
        
        Host_Cancellation.tableFooterView = UIView()
        if Singleton.sharedInstance.userInfoModel != nil {
            if Singleton.sharedInstance.userInfoModel.hostCancellation.count != 0 {
                self.Host_Cancellation.isHidden = false
                self.NodataLbl.isHidden = true
                self.Host_Cancellation.reloadData()
            }
            else{
                self.Host_Cancellation.isHidden = true
                self.NodataLbl.isHidden = false
            }
        }else{
            self.Host_Cancellation.isHidden = true
            self.NodataLbl.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back_Btn_Tapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
 extension HostCancellationViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if Singleton.sharedInstance.userInfoModel != nil {
            return Singleton.sharedInstance.userInfoModel.hostCancellation.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Singleton.sharedInstance.userInfoModel != nil {
            return 1
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ReviewsTableViewCell
        
        let ImageStr = Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].userImage
        let UpdateStr = ImageStr!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let Image = URL(string: UpdateStr!)
        cell?.img_user.setImageWith(Image!)
        
        
         cell?.rentNameLbl.font = UIFont(name: SemiBoldFont, size: 17.0)
        cell?.bookingDateLbl.font = UIFont(name: RegularFont, size: 12)
        cell?.bookingDateTimeLbl.font = UIFont(name: RegularFont, size: 15)
        cell?.cancelAmountLbl.font = UIFont(name: RegularFont, size: 15)
        cell?.paidLbl.font = UIFont(name: RegularFont, size: 15)
        cell?.balenceLbl.font = UIFont(name: RegularFont, size: 15)

        cell?.statusLbl.font = UIFont(name: RegularFont, size: 15)

        cell?.bookingNumLbl.font = UIFont(name: RegularFont, size: 12)

        
        
        
        cell?.rentNameLbl.text = Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].productTitle
        cell?.bookingDateTimeLbl.text = "\(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].checkin!) - \(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].checkout!)"
        cell?.bookingNumLbl.text = Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].bookingNo
        cell?.bookingDateLbl.text = Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].bookedDate
        cell?.cancelAmountLbl.text = "Cancel Amount : \(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].cancellationAmount!)"
        cell?.paidLbl.text = "Paid : \(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].paidAmount!)"
        cell?.balenceLbl.text = "Balance : \(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].balanceAmount!)"
        cell?.statusLbl.text = "Status : \(Singleton.sharedInstance.userInfoModel.hostCancellation[indexPath.section].paidStatus!)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = hexStringToUIColor(hex: "#F1F1F1")
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 245
    //    }
 }

