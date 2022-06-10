//
//  LanguagesExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 18/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class LanguagesExperienceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var tableLanguage: UITableView!
   // @IBOutlet weak var heightTableLanguage: NSLayoutConstraint!
   // @IBOutlet weak var buttonNext: UIButton!
    
    var arrayOfList = [String]()
    var dictOfValues = NSMutableArray()
    var arrayofLangId = NSMutableArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("didload")
//        self.dictOfValues = [
//            ["state":"0","name":"Arabic"],["state":"0","name":"Albanian"],["state":"0","name":"Bahasa Indonesia"],["state":"0","name":"Chinease"],["state":"0","name":"Japanese"],["state":"0","name":"English"],["state":"0","name":"French"],["state":"0","name":"Spanish"],["state":"0","name":"Tamil"]
//        ] as [[String:AnyObject]]
        self.tableLanguage.delegate = self
        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
//        self.dictOfValues = dictOfExperience["known_languages"] as! [[String:AnyObject]]
        self.dictOfValues.addObjects(from: (dictOfExperience["known_languages"] as! NSArray) as! [Any])
        print(self.dictOfValues)
        
        if arrayOfResult.count > 0 {
            let dictt = (arrayOfResult[0] as? NSDictionary)?.object(forKey: "Languages") as! NSDictionary
            self.arrayofLangId.addObjects(from:  (dictt.object(forKey: "selected_languages") as? String ?? "").components(separatedBy: ","))
            print(arrayofLangId)
        }        
    }
    
    //    MARK: Table View Delegate & Data source.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictOfValues.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != self.dictOfValues.count {
            let cell = tableLanguage.dequeueReusableCell(withIdentifier: "cellList", for: indexPath)
            let labelName: UILabel = cell.viewWithTag(20) as! UILabel
            let tickImage: UIImageView = cell.viewWithTag(10) as! UIImageView
            labelName.font = UIFont(name: RegularFont, size: 15.0)
            labelName.textColor = .darkGray
            labelName.text = ((self.dictOfValues.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "language_name") as? String ?? "")
            
            let lang = (self.dictOfValues.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "language_code") as? String ?? ""
            if !self.arrayofLangId.contains(lang) {
                tickImage.image = UIImage(named: "unSelectBox")
            }
            else {
                tickImage.image = UIImage(named: "greenTick")
            }
            
            cell.selectionStyle = .none
            return cell
        }
        else {
            let cell = tableLanguage.dequeueReusableCell(withIdentifier: "cellNext", for: indexPath)
            let nextButton = cell.viewWithTag(10) as! UIButton
            nextButton.titleLabel?.font =  UIFont(name: RegularFont, size: 17.0)
            nextButton.layer.cornerRadius = 5
            nextButton.backgroundColor = AppSecondColor
            nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != self.dictOfValues.count {
            let lang = (self.dictOfValues.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "language_code") as? String ?? ""
            if self.arrayofLangId.contains(lang) {
                self.arrayofLangId.remove(lang)
            }
            else {
                self.arrayofLangId.add(lang)
            }
            self.tableLanguage.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != self.dictOfValues.count {
            return 44.0
        }
        else {
            return 80.0
        }
    }
    
    //    MARK: Functions and Objc functions
    
    @objc func nextButtonAction() {
        print("selected")
        
        if self.arrayofLangId.count == 0 {
            self.showInformation(title: "Closest", message: "Choose Language")
        }
        else {
            let selectedLang = self.arrayofLangId.componentsJoined(by: ",")
            if Helper.sharedInstance.isConnectedToInternet() {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","languages_known": selectedLang,"exp_id":currentExpId]
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                print("params",params)
                print("Api",AddExperienceLanguage)
                manager.post(AddExperienceLanguage, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    let responseDict:NSDictionary = resultData as! NSDictionary
                    print("Response:",responseDict)
                    if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                        currentExpId = "\(responseDict.object(forKey: "experience_id") as AnyObject)"
                        sharedInstanceExperience.gotoStepThree()
                    }
                    else {
                        self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                    }
                }, failure: { (operation, error) in
                    print(error)
                    self.showInformation(title: "Closest", message: error.localizedDescription)
                })
                
            }
            else {
                self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
            }
        }

    }
    
//    override func updateViewConstraints() {
//        self.heightTableLanguage.constant = tableLanguage.contentSize.height
//        super.updateViewConstraints()
//    }
        
}
