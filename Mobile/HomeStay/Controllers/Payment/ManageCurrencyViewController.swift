//
//  ManageCurrencyViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 18/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class ManageCurrencyViewController: UIViewController {

    
    
    @IBOutlet weak var lblHeader: UILabel!
      @IBOutlet weak var lblNotAvailable: UILabel!
      @IBOutlet weak var Currency: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.lblHeader.font = UIFont(name: SemiBoldFont, size: 16)
        self.Currency.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    @IBAction func act_Close(_ sender: UIButton) {
           // self.navigationController?.popViewController(animated: true)
          // self.dismiss(animated: true, completion: nil)
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
extension ManageCurrencyViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.sharedInstance.homeModel.currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ManageCurrencyTableViewCell") as? ManageCurrencyTableViewCell else { return UITableViewCell() }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageCurrencyTableViewCell") as? ManageCurrencyTableViewCell
        cell.textLabel?.textAlignment =  .center
        
        
        
        if login_session.value(forKey: "APP_CURRENCY") as? String == Singleton.sharedInstance.homeModel.currencyList[indexPath.row].currencyCode{
               
                 cell.CurrencyBtn.setImage(UIImage(named: "radiobtnselected"), for: .normal)
        }else{
              
                 cell.CurrencyBtn.setImage(UIImage(named: "radiobtndeselected"), for: .normal)
        }
            
      
        
        cell.CurrencySymbol.text =  Singleton.sharedInstance.homeModel.currencyList[indexPath.row].currencySymbol
        cell.CurrencyCode.text =  Singleton.sharedInstance.homeModel.currencyList[indexPath.row].currencyCode
        
        cell.CurrencySymbol.font = UIFont(name: RegularFont, size: 14.0)
         cell.CurrencyCode.font = UIFont(name: RegularFont, size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SelectedCurrency = Singleton.sharedInstance.homeModel.currencyList[indexPath.row].currencyCode
        let SelectedCurrencySymbol = Singleton.sharedInstance.homeModel.currencyList[indexPath.row].currencySymbol
       
            login_session.set(SelectedCurrency, forKey: "APP_CURRENCY")
        login_session.set(SelectedCurrencySymbol, forKey: "APP_CURRENCY_SYMBOL")

      
        listingIndex = indexPath.row

        
      self.navigationController?.popViewController(animated: true)
    }
    
    
}
