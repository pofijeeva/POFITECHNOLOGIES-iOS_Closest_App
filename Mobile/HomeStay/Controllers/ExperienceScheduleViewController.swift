//
//  ExperienceScheduleViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceScheduleViewController: UIViewController,CommonListingSaveDelegate {

    
    @IBOutlet weak var BasicLbl: UILabel!
         @IBOutlet weak var StepsLbl: UILabel!
         @IBOutlet weak var BasicTextLbl: UILabel!
     @IBOutlet weak var AddScheduleLbl: UILabel!
      @IBOutlet weak var YourScheduleLbl: UILabel!
      @IBOutlet weak var StarteDateLbl: UILabel!
      @IBOutlet weak var EndDateLbl: UILabel!
      @IBOutlet weak var FromBtn: UIButton!
      @IBOutlet weak var ToBtn: UIButton!
      @IBOutlet weak var ApplyBtn: UIButton!
       @IBOutlet weak var ScheduleTable: UITableView!
    
    
      var ListingActivityDelegate: listingActivityProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         SharedsaveInstance.delegate = self
        self.BasicLbl.font = UIFont(name: SemiBoldFont, size: 18)
         self.AddScheduleLbl.font = UIFont(name: SemiBoldFont, size: 17)
         self.YourScheduleLbl.font = UIFont(name: SemiBoldFont, size: 17)
                  self.StepsLbl.font = UIFont(name: RegularFont, size: 14)
                   self.BasicTextLbl.font = UIFont(name: RegularFont, size: 14)
                     self.FromBtn.titleLabel?.font =  UIFont(name: RegularFont, size: 16)
                     self.ToBtn.titleLabel?.font =  UIFont(name: RegularFont, size: 16)
        self.ApplyBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
                   self.StarteDateLbl.font = UIFont(name: RegularFont, size: 16)
               self.EndDateLbl.font = UIFont(name: RegularFont, size: 16)
               self.ScheduleTable.reloadData()

        // Do any additional setup after loading the view.
    }
    func ActasCommonSave()
    {
     
        
         
    }

    //MARK:- Button Actions
          
          @IBAction func act_FromDate(_ sender: UIButton) {
              
              
          
          }
    @IBAction func act_ToDate(_ sender: UIButton) {
                 
                 
             
             }
    @IBAction func act_ApplyDate(_ sender: UIButton) {
                    
                    
                
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
extension ExperienceScheduleViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return self.BasicsArray.count
//        case 1:
//            return self.descriptionArray.count
//        case 2:
//            return self.settingArray.count
//        default:
//            return 0
//        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell") as? ScheduleTableViewCell
        cell!.fromLbl.font = UIFont(name: RegularFont, size: 16)
         cell!.toLbl.font = UIFont(name: RegularFont, size: 16)
         cell!.fromDateLbl.font = UIFont(name: RegularFont, size: 16)
        cell!.toDateLbl.font = UIFont(name: RegularFont, size: 16)
       
         cell!.activeBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
      
     
        
       
        return cell!
    }
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
    }
}
