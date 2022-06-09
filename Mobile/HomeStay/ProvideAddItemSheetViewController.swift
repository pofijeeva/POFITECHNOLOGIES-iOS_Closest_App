//
//  ProvideAddItemSheetViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 29/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


class ProvideAddItemSheetViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var EnterYourItem: UILabel!
    @IBOutlet weak var ItemQuantity: UILabel!
    @IBOutlet weak var aboutItem: UILabel!
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var TitleTxt: UITextField!
    @IBOutlet weak var AboutTxt: UITextView!
    @IBOutlet weak var QuantityTxt: UITextField!
    @IBOutlet weak var DescTextView: UITextView!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var labelNavigationTitle: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    
   
    
    
    
    var ItemTitle = String()
    var AboutItem = String()
    var QuantityItem = String()
    var DescItem = String()
    var ComingType = String()
    var KitID = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TitleTxt.text = self.ItemTitle
         self.QuantityTxt.text = self.QuantityItem
         self.DescTextView.text = self.DescItem
         self.AboutTxt.text = self.AboutItem
        self.buttonBack.addTarget(self, action: #selector(updateToBack), for: .touchUpInside)
        
        
        EnterYourItem.font = UIFont(name: RegularFont, size: 15.0)
        EnterYourItem.textColor = .darkGray
        
        ItemQuantity.font = UIFont(name: RegularFont, size: 15.0)
        ItemQuantity.textColor = .darkGray
        
        aboutItem.font = UIFont(name: RegularFont, size: 15.0)
        aboutItem.textColor = .darkGray
        
        DescLbl.font = UIFont(name: RegularFont, size: 15.0)
        DescLbl.textColor = .darkGray
        
        labelNavigationTitle.font = UIFont(name: RegularFont, size: 20.0)
        labelNavigationTitle.textColor = .white
        
        //
        self.SubmitBtn.layer.cornerRadius = 5
        self.SubmitBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        self.CancelBtn.layer.cornerRadius = 5
        self.CancelBtn.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        
        Helper.sharedInstance.UpdateTextfield(self.TitleTxt)
        Helper.sharedInstance.UpdateTextfield(self.QuantityTxt)
        //
        
       
        self.DescTextView.textColor = UIColor.black
        self.DescTextView.layer.borderWidth = 1.0
        self.DescTextView.layer.borderColor = BorderColor.cgColor
        self.DescTextView.layer.shadowColor = BorderColor.cgColor
        self.DescTextView.layer.cornerRadius = 5
        self.DescTextView.layer.shadowOffset = CGSize.zero
        self.DescTextView.layer.shadowOpacity = 0.6
        self.DescTextView.delegate = self
        self.DescTextView.keyboardType = .default
        self.DescTextView.returnKeyType = .done
        
        
        self.AboutTxt.textColor = UIColor.black
        self.AboutTxt.layer.borderWidth = 1.0
        self.AboutTxt.layer.borderColor = BorderColor.cgColor
        self.AboutTxt.layer.shadowColor = BorderColor.cgColor
        self.AboutTxt.layer.cornerRadius = 5
        self.AboutTxt.layer.shadowOffset = CGSize.zero
        self.AboutTxt.layer.shadowOpacity = 0.6
        self.AboutTxt.delegate = self
        self.AboutTxt.keyboardType = .default
        self.AboutTxt.returnKeyType = .done
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func act_Submit(_ sender: UIButton) {
        if self.TitleTxt.text! == "" {
            self.showInformation(title: "Closest", message: "Please enter Title")
        }else if self.AboutTxt.text! ==  "" {
            self.showInformation(title: "Closest", message: "Please enter about you")
        }else if self.QuantityTxt.text! == "" {
            self.showInformation(title: "Closest", message: "Please enter Quantity")
        }else if self.DescTextView.text! == "" {
            self.showInformation(title: "Closest", message: "Please enter Description")
        }else{
            var params = NSMutableDictionary()
            var APINAME = ""
            if self.ComingType == "Edit" {
                APINAME = ExperienceUpdateKit
                params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","detailed_title" : self.TitleTxt.text!,"kit_detailed":self.AboutTxt.text!,"kit_count":self.QuantityTxt.text!,"kit_description":self.DescTextView.text!,"kit_id":self.KitID,"main_title" : self.TitleTxt.text! ]
                
//                Manikandan P (manikandan@pofitec.com)
//                kit_id=47&user_id=12&exp_id=346&detailed_title=hsyz&kit_count=3&device_type=android&main_title=hzyz&kit_description=thegsbzh&currency_code=EUR
                
                
            }else{
                APINAME = ExperienceAddKit
                params = ["user_id":login_session.value(forKey: "UserId")!,"exp_id":currentExpId,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","kit_title" : self.TitleTxt.text!,"kit_detailed":self.AboutTxt.text!,"kit_count":self.QuantityTxt.text!,"kit_description":self.DescTextView.text!]
            }
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(APINAME, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                DispatchQueue.main.async {
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    self.navigationController?.popViewController(animated: true)
                    // self.showInformation(title: "Closest", message: mod.message)
                }
                
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
        }
        
    }
    

    @objc func updateToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Cancel(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
        
       }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == DescTextView {
            if DescTextView.textColor == UIColor.lightGray {
                //DescTextView.text = ""
                DescTextView.textColor = UIColor.black
            }
        }else {
            if AboutTxt.textColor == UIColor.lightGray {
              //  AboutTxt.text = ""
                AboutTxt.textColor = UIColor.black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == DescTextView {
            if DescTextView.text == "" {
                self.DescTextView.text = "  Enter your value"
                self.DescTextView.textColor = UIColor.lightGray
            }
        }
        else {
            if AboutTxt.text == "" {
                self.AboutTxt.text = "  Enter your value"
                self.AboutTxt.textColor = UIColor.lightGray
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
