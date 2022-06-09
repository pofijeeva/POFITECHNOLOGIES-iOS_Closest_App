//
//  ExperienceTitleViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ExperienceTitleViewController: UIViewController,CommonListingSaveDelegate {

    
    @IBOutlet weak var BasicLbl: UILabel!
        @IBOutlet weak var StepsLbl: UILabel!
        @IBOutlet weak var BasicTextLbl: UILabel!
     @IBOutlet weak var TitleLbl: UILabel!
     @IBOutlet weak var TitleTxt: UITextField!
      
      var ListingActivityDelegate: listingActivityProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedsaveInstance.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func ActasCommonSave()
        {
            
            print(self.TitleTxt.text)
             
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
