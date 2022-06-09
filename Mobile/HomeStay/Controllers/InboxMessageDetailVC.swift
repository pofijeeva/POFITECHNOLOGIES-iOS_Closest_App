//
//  InboxMessageDetailVC.swift
//  HomeStay
//
//  Created by apple on 20/11/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

struct SuccessModel: Codable {
    let code: Int?
    let message: String?
    let data: [String]?
}
struct SubmitSuccessModel: Codable {
    let code: Int?
    let message: String?
    let data: [String]?
}
class InboxMessageDetailVC: BaseViewController {

    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!

    var messages = [ [String: Any]]()
    var isLoading:Bool = true
    var currentPage = 1
    var msgDIct = [String:Any]()
    var PropertyID = Int()
    var detailCell: InboxMessageSubmitTVCell?
    var filteredArray = [ [String: Any]]()
//    var
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendBtn.backgroundColor = AppColor
        self.txtSearch.font = UIFont(name: SemiBoldFont, size: 15)

        tblView.delegate = self
        tblView.dataSource = self
       // textview.delegate = self
        
        print(msgDIct)
        self.fetchInboxRepsonse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    func fetchInboxRepsonse() {
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "bookingid": msgDIct["bookingno"] as? String ?? ""
            ]
        self.messages.removeAll()
        self.getInboxApiResponse(params: parameters)
    }
    @objc func deleteButtonTapped(sender: UIButton) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {
            let dict = self.messages[sender.tag]
                

            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "bookingNo": dict["bookingno"] as? Int ?? 0, "del_type":dict["del_type"]as? String ?? "","msg_id": dict["id"] as? Int ?? 0
                ]
            print(parameters)
            APIManager.apiPostWithHeadersCodable(serviceName: DELETE_MESSAGE, parameters:parameters) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }

               
                do {
                    
                    let successModel = try JSONDecoder().decode(SuccessModel.self, from: data)
        
                    if let responseCode = successModel.code, responseCode == 200 {
                        self.fetchInboxRepsonse()
                        
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                   
                    
                   
                } catch {
                    print("error reading JSON: \(error)")
                }
               
                
            }
            
        } else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionSubmit(_ sender: UIButton) {
//        printf(detailCell)
        if ( textview.text.count == 0){
            let refreshAlert = UIAlertController(title: "Closest", message: "Enter the message", preferredStyle: UIAlertControllerStyle.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                
            }))

            self.present(refreshAlert, animated: true, completion: nil)
        }
        
        if messages.count != 0 {
            
            let msgObj = self.messages.first
        let params = ["productId" : msgDIct["property_id"] as? Int ?? 0,
                      "bookingNo":  msgDIct["bookingno"] as? String ?? "",
                      "receiverId":  msgObj?["receiverId"] as? Int ?? 0,
                      "subject": msgDIct["subject"] as? String ?? "",
                      "message": textview.text, "lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en" ] as [String : Any]

        
        print(params)


        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            APIManager.apiPostWithHeadersCodable(serviceName: SEND_MESSAGE, parameters: params as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                   
                    // Convert JSON from NSData to AnyObject
//                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(SubmitSuccessModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        self.textview.text = ""
                        self.fetchInboxRepsonse()
                        
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                   
                    
                   
                } catch {
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }

    }
    }
    
    @IBAction func actionSearch(_ sender: UIButton) {
        if txtSearch.text == ""  {
           self.filteredArray = messages
        } else {
            self.filteredArray.removeAll()
            
//            let str = String(format: txtSearch.text ?? "")
//            let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", str)
//                filteredArray = self.messages.filter { searchPredicate.evaluate(with: $0) };
            self.filteredArray = messages.filter { ($0["message"] as? String)?.contains(txtSearch.text ?? "") == true}
            
                print(filteredArray)
    
        }
        
//        let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
//        arrrDict = self.arrrDict.filter { searchPredicate.evaluate(with: $0) };
        
        
        tblView.reloadData()
    }

    func  getInboxApiResponse(params: [String:Any]) {
        showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable)! {

            APIManager.apiPostWithHeaders(serviceName: INBOXCONVERSATION, parameters: params) { (json:NSDictionary?, error:NSError?) in
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
                    
                    self.tblView.scrollToBottom()
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
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
        
    }
    
    
    
    
    
    
    

}


extension InboxMessageDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //if indexPath.section == 1 {
          //  return 400
       // }
       // else {
        return 260
        //}
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if section == 1 {
          //  return 1
      //  }
       // else {
            return self.messages.count
       // }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InboxTVCell") as! InboxTVCell
         
            cell.btnDelete?.tag = indexPath.row
            cell.btnDelete?.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        cell.trashImg.setImageColor(color: AppColor)
            let msgObj = self.messages[indexPath.item]
            let imgURL = (msgObj["user_image"] as? String ?? "")
            cell.lblBookType.font = UIFont(name: SemiBoldFont, size: 16)
            cell.lblName_ID.font = UIFont(name: SemiBoldFont, size: 17)
            cell.lblLocation.font = UIFont(name: SemiBoldFont, size: 14)
            cell.imgprofile.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
            cell.lblName_ID.text = (msgObj["user_name"] as? String ?? "")
            cell.lblLocation.text = (msgObj["dateadded"] as! String).stringToDateFormatter(toFormate: "dd-MM-yyyy HH:mm:ss", fromFormate: "dd MMM,yyyy")
            cell.lblBookType.text = (msgObj["message"] as? String ?? "")
            return cell
      //  }
        //else {
         //   let cell = tableView.dequeueReusableCell(withIdentifier: "InboxMessageSubmitTVCell") as! InboxMessageSubmitTVCell
            //self.detailCell = cell
            
            //return cell
        }
    }
    
    



extension UITableView {

    func scrollToBottom(isAnimated:Bool = true){

        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }

    func scrollToTop(isAnimated:Bool = true) {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
           }
        }
    }

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

extension InboxMessageDetailVC : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        self.filteredArray =  messages.filter {$0.name.range(of: searchText, options: [.anchored, .caseInsensitive, .diacriticInsensitive]) != nil }
        
        if searchText == ""  {
           self.filteredArray = messages
        } else {
            self.filteredArray.removeAll()
            let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
                filteredArray = self.messages.filter { searchPredicate.evaluate(with: $0) };
//            self.filteredArray = messages.filter { $0["message"] as! String == searchText }
                print(filteredArray)
    
        }
        
//        let searchPredicate = NSPredicate(format: "Name CONTAINS[C] %@", searchText)
//        arrrDict = self.arrrDict.filter { searchPredicate.evaluate(with: $0) };
        
        
        tblView.reloadData()

        
        
    }
}
extension InboxMessageDetailVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Add a personal message"
        }
        
    }
    
}
