//
//  StartViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 12/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var imgSlider: UIImageView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBAction func submitBut(_ sender: UIButton) {
        
    }
    // MARK: - Variables
    
    //var sliderImageArray = ["splash_car","splash_flight","splash_hotel"]
    var sliderImageArray = ["slider_one","slider_two","slider_three","bgHome"]
    var timer = Timer()
    var sliderCount = 0
  
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogin.setTitle(GlobalLanguageDictionary.object(forKey: "Key_login") as! String, for: .normal)
        self.btnSignUp.setTitle(GlobalLanguageDictionary.object(forKey: "Key_Csignup") as! String, for: .normal)
//        self.btnLogin.setTitle(NSLocalizedString("login", comment: "login"), for: .normal)
//        self.btnSignUp.setTitle(NSLocalizedString("signup", comment: "signup"), for: .normal)
          self.btnLogin.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
          self.btnSignUp.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 18)
          self.btnLogin.backgroundColor = AppSecondColor
          self.btnSignUp.backgroundColor = AppSecondColor
        self.btnSignUp.setTitle("", for: .selected)
        self.btnLogin.setTitle("", for: .selected)
        self.image2.contentMode = .scaleAspectFill
        
       // self.navigationController?.isNavigationBarHidden = false
      //  timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.slideImage), userInfo: nil, repeats: true)
        login_session.setValue(LANG_EN, forKey: "APP_LANGUAGE")
        login_session.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
     // MARK: - Button Actions
    
    @IBAction func act_Signup(_ sender: UIButton) {
        
    }
    
    @IBAction func act_Login(_ sender: UIButton) {
    
    }
    
    // MARK: - ImageSlider Action
    
    @objc func slideImage(){
       
        UIView.transition(with: self.image2,
                          duration:1.1,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.image2.image = UIImage(named:self.sliderImageArray[self.sliderCount])
        },
                          completion: nil)
        if sliderCount == sliderImageArray.count - 1
        {
          sliderCount = 0
        } else
        {
          sliderCount = sliderCount+1
        }
    }
}
