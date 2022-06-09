//
//  FilterInboxViewController.swift
//  HomeStay
//
//  Created by Apple3 on 27/05/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol filterDelegate {
    
    func updateFilter(bookingName: String)
}

    class FilterInboxViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    var filterDelegate : filterDelegate!
    var selectedRows:[IndexPath] = []
    var infoArray =  NSMutableArray()
    var selectedId = Int()
    @IBOutlet weak var tableView: UITableView!
         @IBOutlet weak var TitleLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
   self.TitleLBL.font = UIFont(name: SemiBoldFont, size: 17.0)
        if Reachability()!.isReachable
        {
            
            let id = Singleton.sharedInstance.selectedCategory!
            self.showActivityIndicator(uiView: self.view)
            
            if selectedId == 1
            {
                //   let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")"
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&device_type=\("ios")"
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: INBOX_API, APIKEY: "INBOX_API")
                print(parameterStr)
            }
            else if selectedId == 2
            {
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_STARRED_MESSGAE, APIKEY: "MOBILE_INBOX_STARRED_MESSGAE")
                print(parameterStr)
            }
            else if selectedId == 3
            {
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_UNREAD_MESSGAE, APIKEY: "MOBILE_INBOX_UNREAD_MESSGAE")
                print(parameterStr)
            }
            else if selectedId == 4
            {
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_RESERVATION_MESSGAE, APIKEY: "MOBILE_INBOX_RESERVATION_MESSGAE")
                print(parameterStr)
            }
            else  if selectedId == 5
            {
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_PENDINGREQ_MESSGAE, APIKEY: "MOBILE_INBOX_PENDINGREQ_MESSGAE")
                print(parameterStr)
            }
            else  if selectedId == 6
            {
                // let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)&base_id=\(id)&currency_code=\(login_session.value(forKey: "APP_CURRENCY") as! String)&device_type=\("ios")"
                
                let parameterStr = "userid=\(login_session.value(forKey: "UserId")!)"
                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: MOBILE_INBOX_ARCHIVED_MESSGAE, APIKEY: "MOBILE_INBOX_ARCHIVED_MESSGAE")
                print(parameterStr)
            }
        }
            
            
        else
        {
            showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as! String)
            
        }
        
        // Do any additional setup after loading the view.
    }
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Singleton.sharedInstance.inboxList.messageValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CustomCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountrylistTableViewCell
        
          cell.lbl_CountryName.font = UIFont(name: RegularFont, size: 14.0)
        cell.lbl_CountryName.text = Singleton.sharedInstance.inboxList.messageValues[indexPath.row].bookingno
        cell.selectionStyle = UITableViewCellSelectionStyle.gray
        if selectedRows.contains(indexPath)
        {
            cell.buttonSelect.setImage(UIImage(named:"checkbox-2"), for: .normal)
        }
        else
        {
            cell.buttonSelect.setImage(UIImage(named:"tick-off"), for: .normal)
        }
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //(tableView.cellForRow(at: indexPath) as! CountrylistTableViewCell).butonSelect.setImage(UIImage(named: "tick-on"), for: .normal)
        
        let selectedIndexPath = IndexPath(row: indexPath.row, section: 0)
        if self.selectedRows.contains(selectedIndexPath)
        {
            self.selectedRows.remove(at: self.selectedRows.index(of: selectedIndexPath)!)
            
            infoArray.remove(Singleton.sharedInstance.inboxList.messageValues[indexPath.row].bookingno)
            print("infoArraydidSelectRowAt",String(format: "%@", infoArray))
            
            
            
        }
        else
        {
            self.selectedRows.append(selectedIndexPath)
            infoArray.add(Singleton.sharedInstance.inboxList.messageValues[indexPath.row].bookingno)
            print("infoArraydidSelectRowAt",String(format: "%@", infoArray))
            
            
            
        }
        self.tableView.reloadData()
        
        
        
        
    }
    
    
    @IBAction func correctBtn(_ sender: Any)
    {
        print("hjkdsghhdgh")
        if infoArray.count == 0
        {
            self.showInformation(title: "Closest", message: "Please select BookingId")
            
        }
        else
        {
            
            let strCountry = infoArray.componentsJoined(by: ",")
            print(strCountry)
            filterDelegate.updateFilter(bookingName: strCountry)
            self.navigationController!.popViewController(animated: true)
        }
        
        
    }

        @IBAction func back_Act(_ sender: Any)
        {
            self.navigationController?.popViewController(animated: true)

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
extension FilterInboxViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {

    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)

        if APIKEY == "INBOX_API"{
            self.hideActivityIndicator(uiView: self.view)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
               
                self.tableView.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_STARRED_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
               
                self.tableView.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_UNREAD_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
               
               self.tableView.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_RESERVATION_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
               
                self.tableView.reloadData()
            }
        }
            
            
            
            
            
            
        else if APIKEY == "MOBILE_INBOX_PENDINGREQ_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
               
                self.tableView.reloadData()
            }
        }
            
        else if APIKEY == "MOBILE_INBOX_ARCHIVED_MESSGAE"{
            self.hideActivityIndicator(uiView: self.view)
            print(responseDict)
            if errorDict.count == 0 {
                let mod = InboxListModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.inboxList = mod
//                if mod.messageValues.count == 0 {
//                    self.tblInbox.isHidden = true
//                    self.lblNoMessageFound.isHidden = false
//                } else {
//                    self.tblInbox.isHidden = false
//                    self.lblNoMessageFound.isHidden = true
//                }
                self.tableView.reloadData()
            }
        }
            
            
       
        else
        {
            
        }
        
        
    }
}
