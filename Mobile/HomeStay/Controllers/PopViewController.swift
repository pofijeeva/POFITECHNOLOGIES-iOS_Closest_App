//
//  PopViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 24/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblNotAvailable: UILabel!
    @IBOutlet weak var tblDropDown: UITableView!
    @IBOutlet weak var btnClose: UIButton!
    var showingView = NSString()
    
    var dropDownArray = NSArray()
    var dropDownsymbol = NSArray()

    var popOverDelegate: DropDownProtocol?
    var key: Any?
    var headerTxt : String = ""
    var currCheckStr : String = ""
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHeader.text = headerTxt
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            //self.btnClose.setTitle(LocalizeHelper().localizedStringForKey("cancel"), for: .normal)
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if dropDownArray.count == 0{
            self.lblNotAvailable.isHidden = false
            self.tblDropDown.isHidden = true
        } else {
            self.lblNotAvailable.isHidden = true
            self.tblDropDown.isHidden = false
        }
    }
    
    //MARK:- Button Actions
    
    @IBAction func act_Close(_ sender: UIButton) {
        // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    func updateDropDown(str: String) {
        self.popOverDelegate?.getValueFromDropDown(value: str, Key: self.key)
    }
}

extension PopViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverCell") as? PopOverCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "PopOverCell") as? PopOverCell
        cell.textLabel?.textAlignment =  .center
        
          if currCheckStr == "YES" {
        
        if login_session.value(forKey: "APP_CURRENCY") as? String == dropDownArray[indexPath.row] as? String {
             cell.textLabel?.textColor = UIColor.red
        }else{
              cell.textLabel?.textColor = UIColor.black
        }
            
        }
        
        cell.textLabel?.text =  dropDownArray[indexPath.row] as? String
        cell.textLabel?.font = UIFont(name: RegularFont, size: 14.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SelectedCurrency = self.dropDownArray[indexPath.row] as? String
        if currCheckStr == "YES" {
            login_session.set(SelectedCurrency, forKey: "APP_CURRENCY")
        }
        else{
            
        }
        listingIndex = indexPath.row

        print(self.dropDownArray[indexPath.row])
        self.updateDropDown(str: dropDownArray[indexPath.row] as? String ?? "")
        self.dismiss(animated: true, completion: nil)
        // self.navigationController?.popViewController(animated: true)
    }
    
    
}
