//
//  currencyVC.swift
//  HomeStay
//
//  Created by Sunil Kumar on 27/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
enum PopUpType {
    case language
    case currency
}
class currencyVC: BaseViewController {
    
    @IBOutlet weak var viewHeightConstrints: NSLayoutConstraint!
    @IBOutlet weak var tblview: UITableView!
    var type: PopUpType = .currency
    var languageArray = [LanguageList]()
    var currenceArray = [CurrencyNameList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self
        tblview.register(UINib(nibName: "PopUpListTableViewCell", bundle: nil), forCellReuseIdentifier: "PopUpListTableViewCell")
        if type == .currency {
            crruencyList()
            viewHeightConstrints.constant = 300
        } else {
            languageList()
            viewHeightConstrints.constant = 300
        }
        
        // Do any additional setup after loading the view.
    }
    
    func crruencyList() {
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: CURRENCYLIST, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(CurrencylistModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        if let currency = successModel.data?.currency_list, currency.count != 0 {
                            self.currenceArray = currency
                            self.tblview.reloadData()
                            
                        }
                        
                    } else {
                        self.tblview.reloadData()
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    self.tblview.reloadData()
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
    }
    func languageList() {
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: LANGUAGELIST, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(LanguageModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        if let array = successModel.data?.language_list {
                            self.languageArray = array
                            self.tblview.reloadData()
                        }
                        }
                        else {
                            self.tblview.reloadData()
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    self.tblview.reloadData()
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
    }
    
}

extension currencyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .language {
            return languageArray.count
        } else {
            return currenceArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpListTableViewCell", for: indexPath) as? PopUpListTableViewCell else { return UITableViewCell() }
        if type == .language {
            let model = self.languageArray[indexPath.row]
            cell.titleLbl.text = model.name ?? ""
            cell.titleLbl.textAlignment = .left
        } else {
            let model = self.currenceArray[indexPath.row]
            cell.titleLbl.text = model.currency_type ?? ""
            cell.titleLbl.textAlignment = .left
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .language {
            let model = self.languageArray[indexPath.row]
            let Lang = model.name
           //  login_session.setValue(Lang, forKey: "language")

        } else {
            let model = self.currenceArray[indexPath.row]
            let Currency = model.currency_symbols
            login_session.setValue(Currency, forKey: "APP_CURRENCYSYM")
         }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

