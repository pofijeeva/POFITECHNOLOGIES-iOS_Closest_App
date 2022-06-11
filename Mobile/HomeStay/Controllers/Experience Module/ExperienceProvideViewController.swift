//
//  ExperienceProvideViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 29/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class ExperienceProvideViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
     @IBOutlet weak var DescLbl: UILabel!
     @IBOutlet weak var AddBtn: UIButton!
     @IBOutlet weak var YourItemList: UILabel!
     @IBOutlet weak var ProvideTable: UITableView!
    @IBOutlet weak var SaveBtn: UIButton!
    
    var arrayOfImens = [String]()
    
    var ProvideListArray : NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SaveBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getBaseDetails()
    }
    
    
    func getBaseDetails() {
        if Helper.sharedInstance.isConnectedToInternet() {
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                
                let responseDict:NSDictionary = resultData as! NSDictionary
                print(responseDict)
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    
                    let DataDict = responseDict.value(forKey: "result") as? NSArray
                    
                    ((DataDict?.object(at: 0) as? NSDictionary)?.object(forKey: "what_you_will_provide") as? NSDictionary)?.object(forKey: "kit_details") as! NSArray
                    self.ProvideListArray.removeAllObjects()
                    self.ProvideListArray.addObjects(from: ((((DataDict?.object(at: 0) as? NSDictionary)?.object(forKey: "what_you_will_provide") as? NSDictionary)?.object(forKey: "kit_details") as? NSArray) as? [Any] ?? []))
                    print(self.ProvideListArray)
                    self.ProvideTable.reloadData()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    
    @IBAction func Act_Save(_ sender: UIButton) {
        if self.ProvideListArray.count == 0 {
            self.showInformation(title: "Closest", message: "Please add item first")
        }else{
            sharedInstanceExperience.gotoStepTwelve()
        }
    }
    
 @IBAction func act_Additem(_ sender: UIButton) {
    let navg = self.storyboard?.instantiateViewController(withIdentifier: "ProvideAddItemSheetViewController") as? ProvideAddItemSheetViewController
     
     self.navigationController?.pushViewController(navg!, animated: true)
    
    }
    @objc func EditAct(sender: UIButton) {
     let navg = self.storyboard?.instantiateViewController(withIdentifier: "ProvideAddItemSheetViewController") as? ProvideAddItemSheetViewController
        navg?.ItemTitle = (self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_title") as? String ?? ""
        navg?.AboutItem = (self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_details") as? String ?? ""
        navg?.QuantityItem = "\((self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_count") as! AnyObject)"
        navg?.DescItem = (self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_description") as? String ?? ""
        navg?.ComingType = "Edit"
        navg?.KitID = "\((self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_id") as! AnyObject)"
         self.navigationController?.pushViewController(navg!, animated: true)
     }
     
    @objc func DeleteAct(sender: UIButton) {
        
        
        let KitID = "\((self.ProvideListArray.object(at: sender.tag) as? NSDictionary)?.object(forKey: "kit_id") as! AnyObject)"
        
        if Helper.sharedInstance.isConnectedToInternet() {
            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId,"kit_id":KitID]
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            manager.post(ExperienceDeleteKit, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print(responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    self.getBaseDetails()
                }
                else {
                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ProvideListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceProvideTableViewCell") as! ExperienceProvideTableViewCell
        cell.ItemName.text = (self.ProvideListArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "kit_title") as? String ?? ""
        cell.ItemQuantity.text = "\((self.ProvideListArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "kit_count") as AnyObject)"
        cell.DescLbl.text = (self.ProvideListArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "kit_description") as? String ?? ""
        cell.AboutLbl.text = (self.ProvideListArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "kit_details") as? String ?? ""
        cell.EditBtn.tag = indexPath.row
         cell.DeleteBtn.tag = indexPath.row
        cell.EditBtn.addTarget(self, action: #selector(EditAct), for: .touchUpInside)
        cell.DeleteBtn.addTarget(self, action: #selector(DeleteAct), for: .touchUpInside)
        
        
        return cell
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
