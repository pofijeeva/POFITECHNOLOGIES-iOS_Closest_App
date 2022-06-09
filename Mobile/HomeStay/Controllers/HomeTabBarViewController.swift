//
//  HomeTabBarViewController.swift
//  HomeStay
//
//  Created by Nishanth on 03/08/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.selectedIndex = SelectTabIndex
        if SelectTabIndex == 0 {
            SelectTabIndex = 2
        }
      //  let tabbar = UITabBarItem(title: "Home", image: UIImage(named: "home 3313")?.withRenderingMode(.alwaysOriginal), tag: 2)
        // Do any additional setup after loading the view.
        
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
