//
//  LanguageViewController.swift
//  HomeStay
//
//  Created by Apple2 on 07/12/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var selLanguage: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if  lanuguage_selection.value(forKey: "language") as? String ?? "" == "en" {
              self.englishOutlet.setImage(UIImage(named: "checkbox-2"), for: .normal)
        }else {
             self.spanishOutlet.setImage(UIImage(named: "checkbox-2"), for: .normal)
        }
        
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var spanishOutlet: UIButton!
    @IBOutlet weak var englishOutlet: UIButton!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var garyView: UIView!
    
    @IBAction func englishAction(_ sender: Any) {
        
        garyView.isHidden = false
        lanuguage_selection.set("en", forKey: "language")
        LocalizeHelper().LocalizationSetLanguage("en")
       // Localize.setCurrentLanguage("en")
        let currentLanguageStr:String = "en"
        UserDefaults.standard.set(currentLanguageStr, forKey: "TranslationDocumentName")
        self.englishOutlet.setImage(UIImage(named: "checkbox-2"), for: .normal)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is HomeTabBarViewController
            {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    @IBAction func spanishAction(_ sender: UIButton) {
        
        garyView.isHidden = false
        //Localize.setCurrentLanguage("es-MX")
        lanuguage_selection.set("ph", forKey: "language")
        LocalizeHelper().LocalizationSetLanguage("es-MX")
        let currentLanguageStr:String = "es-MX"
        UserDefaults.standard.set(currentLanguageStr, forKey: "TranslationDocumentName")
        self.spanishOutlet.setImage(UIImage(named: "checkbox-2"), for: .normal)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is HomeTabBarViewController
            {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is HomeTabBarViewController
            {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
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
