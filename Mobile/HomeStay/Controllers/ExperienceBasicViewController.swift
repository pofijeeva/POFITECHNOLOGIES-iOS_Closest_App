//
//  ExperienceBasicViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceBasicViewController: UIViewController,CommonListingSaveDelegate {
    
    
    @IBOutlet weak var BasicLbl: UILabel!
    @IBOutlet weak var StepsLbl: UILabel!
    @IBOutlet weak var BasicTextLbl: UILabel!
    @IBOutlet weak var ExperienceLbl: UILabel!
    @IBOutlet weak var NumberOfDays: UILabel!
    @IBOutlet weak var ExperenceCategory: UILabel!
    
    @IBOutlet weak var ExperienceTxt: UITextField!
    @IBOutlet weak var NumberOfDaysTxt: UITextField!
    @IBOutlet weak var ExperenceCategoryTxt: UITextField!
    
    
    @IBOutlet weak var StepsView: UIView!
    @IBOutlet weak var ParentView: UIView!
    
    var ListingActivityDelegate: listingActivityProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         SharedsaveInstance.delegate = self
        self.BasicLbl.font = UIFont(name: SemiBoldFont, size: 18)
            self.StepsLbl.font = UIFont(name: RegularFont, size: 14)
             self.BasicTextLbl.font = UIFont(name: RegularFont, size: 14)
               self.ExperienceLbl.font = UIFont(name: SemiBoldFont, size: 17.0)
              self.NumberOfDays.font = UIFont(name: SemiBoldFont, size: 17)
             self.ExperenceCategory.font = UIFont(name: SemiBoldFont, size: 17)
             self.ExperienceTxt.font = UIFont(name: RegularFont, size: 14)
         self.NumberOfDaysTxt.font = UIFont(name: RegularFont, size: 14)
         self.ExperenceCategoryTxt.font = UIFont(name: RegularFont, size: 14)
        // Do any additional setup after loading the view.
    }
    func ActasCommonSave()
    {
        if  ExperienceTxt.text?.count == 0{
            self.showInformation(title: "Closest", message: "Successfully Added")
        }else if NumberOfDaysTxt.text?.count == 0{
            self.showInformation(title: "Closest", message: "Successfully Added")
        }else if ExperenceCategoryTxt.text?.count == 0{
            self.showInformation(title: "Closest", message: "Successfully Added")
        }else{
            self.showInformation(title: "Closest", message: "Please add photo first")
        }
        print(ExperienceTxt.text)
        print(NumberOfDaysTxt.text)
        print(ExperenceCategoryTxt.text)
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
