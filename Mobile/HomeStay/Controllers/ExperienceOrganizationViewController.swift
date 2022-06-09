//
//  ExperienceOrganizationViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceOrganizationViewController: UIViewController,CommonListingSaveDelegate {

    
    
      @IBOutlet weak var BasicLbl: UILabel!
         @IBOutlet weak var StepsLbl: UILabel!
         @IBOutlet weak var BasicTextLbl: UILabel!
      @IBOutlet weak var OrganizationLbl: UILabel!
      @IBOutlet weak var aboutOrganizationLbl: UILabel!
    
    @IBOutlet weak var OrganizationTxt: UITextField!
        @IBOutlet weak var aboutOrganizationTxt: UITextField!
    
      var ListingActivityDelegate: listingActivityProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BasicLbl.font = UIFont(name: SemiBoldFont, size: 18)
                         self.StepsLbl.font = UIFont(name: RegularFont, size: 14)
                          self.BasicTextLbl.font = UIFont(name: RegularFont, size: 14)
         self.OrganizationLbl.font = UIFont(name: SemiBoldFont, size: 17)
         self.aboutOrganizationLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.OrganizationTxt.font = UIFont(name: RegularFont, size: 14)
        self.aboutOrganizationTxt.font = UIFont(name: RegularFont, size: 14)
        SharedsaveInstance.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func ActasCommonSave()
        {
         
            print(self.OrganizationTxt.text)
             print(self.aboutOrganizationTxt.text)
             
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
