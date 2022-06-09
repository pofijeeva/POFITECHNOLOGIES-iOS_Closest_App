//
//  PropertyReservationVC.swift
//  HomeStay
//
//  Created by pofiapple10 on 18/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

struct PropertyReservationModel: Codable {
    let code: Int?
    let data: MyreservationModel?
    let message: String?
}
struct MyreservationModel: Codable {
    let  my_reservation: [MyreservationDetailModel]?
}
struct MyreservationDetailModel: Codable {
    let cancel_booking: Int?
    let property_title: String?
    let id: Int?
    let property_address: String?
    let ratings: String?
    let tot_booking: Int?
    let property_id: Int?
    //    let cancel_booking: Int?
    let request_booking: Int?
    let property_image: String?
}

class PropertyReservationVC: BaseViewController {
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var headerLbl: UILabel!
    
    
    
    var propertyListArray = [MyreservationDetailModel]()
    var isLoading:Bool = true
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerLbl.text = GlobalLanguageDictionary.object(forKey: "key_propertyReservation") as! String
        self.headerLbl.font = UIFont(name: SemiBoldFont, size: 20)
        
        
        self.tblview.isHidden = true
        
        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "page_no": 1
            ]
        self.getPropertyReservationApiResponse(params: parameters)
        if login_session.object(forKey: "Language")as! String == "en"{
            headerLbl.textAlignment = .left
        }else{
            headerLbl.textAlignment = .right
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)    }
    
    func getPropertyReservationApiResponse(params: [String:Any]){
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            
            APIManager.apiPostWithHeadersCodable(serviceName: PROPERTY_RESERVATION, parameters:params) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                
                
                do {
                    
                    let propertyModel = try JSONDecoder().decode(PropertyReservationModel.self, from: data)
                    
                    if let responseCode = propertyModel.code, responseCode == 200 {
                        self.tblview.isHidden = false
                        
                        if let array = propertyModel.data?.my_reservation {
                            
                            print(array)
                            self.isLoading = false
                            self.propertyListArray.append(contentsOf: array)
                            self.tblview.reloadData()
                        }
                        
                    } else {
                        self.isLoading = false
                        self.showInformation(title: "Error", message: propertyModel.message ?? "")
                    }
                } catch {
                    print("error reading JSON: \(error)")
                }
            }
            
        } else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as! String)
        }
    }
}




extension PropertyReservationVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyListArray.count
        print(propertyListArray.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyReservationCell", for: indexPath) as! PropertyReservationCell
        cell.totalBookingLbl.text = GlobalLanguageDictionary.object(forKey: "key_totalBookings") as! String
        cell.cancelledBookingLbl.text = GlobalLanguageDictionary.object(forKey: "key_cancelledBookings") as! String
        
        cell.totalBookingLbl.font = UIFont(name: SemiBoldFont, size: 14)
        cell.cancelledBookingLbl.font = UIFont(name: SemiBoldFont, size: 14)
        cell.pronameLabel.font = UIFont(name: SemiBoldFont, size: 16)
        cell.prolocnameLabel.font = UIFont(name: SemiBoldFont, size: 12)
        cell.prototalBookingLabel.font = UIFont(name: SemiBoldFont, size: 15)
        cell.procancelBookingLabel.font = UIFont(name: SemiBoldFont, size: 15)
        
        
        let propertyModel = self.propertyListArray[indexPath.row]
        if let rate = propertyModel.ratings {
            cell.proratingLabel.text = String(format: "%0.0f", Double(rate) ?? 0.0)
        }else{
            cell.proratingLabel.text = ""
        }
        let imgURL =  propertyModel.property_image ?? ""
        cell.proImg.contentMode = .scaleAspectFill
        cell.proImg.cornerRadius = 10
        cell.proImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        cell.proLocImg.setImageColor(color: AppColor)
        cell.pronameLabel.text = propertyModel.property_title ?? ""
        cell.prolocnameLabel.text = propertyModel.property_address ?? ""
        cell.prototalBookingLabel.text =  String(propertyModel.request_booking ?? 0)
        cell.prototalBookingLabel.textColor = AppColor
        cell.procancelBookingLabel.textColor = AppColor
        
        cell.procancelBookingLabel.text =  String(propertyModel.cancel_booking ?? 0)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == self.propertyListArray.count - 1 && !self.isLoading{
            self.isLoading = true
            currentPage += 1
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "page_no": currentPage
                ]
            self.getPropertyReservationApiResponse(params: parameters)
            
            
        }
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = propertyListArray[indexPath.row]
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailsVC") as? PropertyDetailsVC
        nav?.propertyModel = model 
        
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
}
