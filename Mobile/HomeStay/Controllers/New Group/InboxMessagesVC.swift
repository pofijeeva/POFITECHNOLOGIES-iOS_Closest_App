//
//  InboxMessagesVC.swift
//  HomeStay
//
//  Created by apple on 20/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class InboxMessagesVC: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var headerLbl: UILabel!

    var messages = [ [String: Any]]()
    var filteredArray = [ [String: Any]]()
    var isLoading:Bool = true
    var currentPage = 1
    
    var isSearchData: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSearch.font = UIFont(name: SemiBoldFont, size: 15)
        self.txtSearch.placeholder = GlobalLanguageDictionary.object(forKey: "key_nameorBookingnum") as? String ?? ""
        self.headerLbl.text = GlobalLanguageDictionary.object(forKey: "key_inbox") as? String ?? ""
        
        tblView.delegate = self
        tblView.dataSource = self
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "booking_numbers": "",
             "page_no":1
            ]
        self.getInboxApiResponse(params: parameters)
        if login_session.object(forKey: "Language")as? String ?? "" == "en"{
            txtSearch.textAlignment = .left
        }else{
            txtSearch.textAlignment = .right
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionSearch(_ sender: UIButton) {
        if txtSearch.text == ""  {
            self.messages = self.filteredArray
            self.isSearchData = false
        } else {
           
            
            self.messages = messages.filter { ($0["message"] as? String)?.contains(txtSearch.text ?? "") == true  || ($0["bookingno"] as? String)?.contains(txtSearch.text ?? "") == true}
            self.isSearchData = true
            print(self.messages)
//            let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", txtSearch.text)
//                filteredArray = self.messages.filter { searchPredicate.evaluate(with: $0) };
//            self.filteredArray = messages.filter { $0["message"] as? String ?? "" == searchText }
               
    
        }
        
//        let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
//        arrrDict = self.arrrDict.filter { searchPredicate.evaluate(with: $0) };
        
        
        tblView.reloadData()

    }
    
  
    func getInboxApiResponse(params: [String:Any]) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            APIManager.apiPostWithHeaders(serviceName: INBOX, parameters: params) { (json:NSDictionary?, error:NSError?) in
                self.hideActivityIndicator(uiView: self.view)
                if error != nil {
                    print(error!.localizedDescription)
                    self.showInformation(title: "Info", message: error!.localizedDescription)
                    return
                }
                let responseDict:NSDictionary = json!
                print(responseDict)
                if responseDict.value(forKey: "code") as! NSNumber == 200 {
                    self.isLoading = false
                    let data = responseDict.object(forKey: "data") as! [String:Any]
                    self.messages.append(contentsOf: data["message_values"] as! [[String:Any]])
                    self.filteredArray.append(contentsOf: data["message_values"] as! [[String:Any]])
                    
                    
                    self.tblView.reloadData()
                }
                else if responseDict.value(forKey: "code") as! NSNumber == 400 {
                    if self.isLoading == false {
                    self.messages.removeAll()
                    self.tblView.reloadData()
                    }
                   
                   // self.showInformation(title: "Info", message: responseDict.value(forKey: "message") as? String ?? "")
                    
                }
            }
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
    }

}
extension InboxMessagesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTVCell") as! InboxTVCell
     
        let msgObj = self.messages[indexPath.item]
        let imgURL = (msgObj["user_image"] as? String ?? "")
        if #available(iOS 13.0, *) {
            cell.viewContent.backgroundColor = (msgObj["msg_read"] as? String ?? "") == "No" ? UIColor.systemGray6 : .white
        } else {
            // Fallback on earlier versions
        }
        
        cell.lblBookType.font = UIFont(name: SemiBoldFont, size: 16)
        cell.lblName_ID.font = UIFont(name: SemiBoldFont, size: 17)
        cell.lblLocation.font = UIFont(name: SemiBoldFont, size: 14)
        
        
        cell.imgprofile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        cell.lblBookType.text = msgObj["message"] as? String ?? ""
        cell.lblName_ID.text = "\(msgObj["ren_title"] as? String ?? ""):\(msgObj["bookingno"] as? String ?? "")"
        cell.lblLocation.text = (msgObj["dateAdded"] as? String ?? "")
//            .stringToDateFormatter(toFormate: "dd-MM-yyyy HH:mm:ss", fromFormate: "dd MMM,yyyy")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "InboxMessageDetailVC") as? InboxMessageDetailVC
        let msgObj = self.messages[indexPath.item]
        nav?.msgDIct = msgObj
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == self.messages.count - 1 && !self.isLoading{
            self.isLoading = true
            currentPage += 1
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "booking_numbers": "",
                 "page_no":currentPage
                ]
            if !isSearchData {
                self.getInboxApiResponse(params: parameters)
            }
           
            
        }
    }
    
    
}

extension InboxMessagesVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        self.filteredArray =  messages.filter {$0.name.range(of: searchText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
        
        if searchText == ""  {
           self.filteredArray = messages
        } else {
            self.filteredArray.removeAll()
            let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
                filteredArray = self.messages.filter { searchPredicate.evaluate(with: $0) };
//            self.filteredArray = messages.filter { $0["message"] as? String ?? "" == searchText }
                print(filteredArray)
    
        }
        
//        let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
//        arrrDict = self.arrrDict.filter { searchPredicate.evaluate(with: $0) };
        
        
        tblView.reloadData()

        
        
    }
}

