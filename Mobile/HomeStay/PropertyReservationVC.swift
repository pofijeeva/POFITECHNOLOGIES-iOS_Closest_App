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


//"id": 10019,
//                "property_title": "Paddle Houseboats8",
//                "property_address": "Chorao, Goa, India",
//                "ratings": "0.00",
//                "tot_booking": 0,
//                "property_id": 10019,
//                "cancel_booking": 0,
//                "request_booking": 0,
//                "property_image": "http://localhost/Web_Rental_Product/pu

class PropertyReservationVC: BaseViewController {

    @IBOutlet weak var tblview: UITableView!
    var propertyListArray = [MyreservationDetailModel]()
    var isLoading:Bool = true
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblview.isHidden = true

        let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "page_no": 1
            ]
        self.getPropertyReservationApiResponse(params: parameters)
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
            self.showInformation(title: "Info", message: "Check your internet connection")
        }
        
//        showActivityIndicator(uiView: self.view)
//        if (Reachability()?.isReachable)! {
//            APIManager.apiPostWithHeaders(serviceName: PROPERTY_RESERVATION, parameters: params) { (json:NSDictionary?, error:NSError?) in
////                self.hideActivityIndicator(uiView: self.view)
//                if error != nil {
//                    print(error!.localizedDescription)
//                    self.showInformation(title: "Info", message: error!.localizedDescription)
//                    return
//                }
//                let responseDict:NSDictionary = json!
//                print(responseDict)
//                if responseDict.value(forKey: "code") as! NSNumber == 200 {
//
//
//
//
//                }
//                else if responseDict.value(forKey: "code") as! NSNumber == 400 {
//
//                    }
//
//                   // self.showInformation(title: "Info", message: responseDict.value(forKey: "message") as? String ?? "")
//
//                }
//            }
        }
        

    }




extension PropertyReservationVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyListArray.count
        print(propertyListArray.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyReservationCell", for: indexPath) as! PropertyReservationCell
        let propertyModel = self.propertyListArray[indexPath.row]
        if let rate = propertyModel.ratings {
        cell.proratingLabel.text = String(format: "%0.0f", Double(rate) ?? 0.0)
        }else{
            cell.proratingLabel.text = ""
        }
//        cell.proratingLabel.text = propertyModel.ratings ?? ""
        let imgURL =  propertyModel.property_image ?? ""
//        (wishListObj["property_images"] as? String ?? "")
        cell.proImg.contentMode = .scaleAspectFill
        cell.proImg.cornerRadius = 10
        cell.proImg.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder.png"))
        cell.proLocImg.setImageColor(color: AppColor)
//        cell.proImg.image = UIImage(named: propertyModel.property_image ?? "")
        cell.pronameLabel.text = propertyModel.property_title ?? ""
        cell.prolocnameLabel.text = propertyModel.property_address ?? ""
        cell.prototalBookingLabel.text =  String(propertyModel.request_booking ?? 0)
        cell.prototalBookingLabel.textColor = AppColor
        cell.procancelBookingLabel.textColor = AppColor

        cell.procancelBookingLabel.text =  String(propertyModel.cancel_booking ?? 0)
//        cell.prolocnameLabel.text = propertyModel.property_address ?? ""
//        if let id = propertyModel.id {
//
//        }
//        print(propertyModel)
      
        
        
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = propertyListArray[indexPath.row]
        let nav = self.storyboard?.instantiateViewController(withIdentifier: "PropertyDetailsVC") as? PropertyDetailsVC
        nav?.propertyModel = model 
       
        self.navigationController?.pushViewController(nav!, animated: true)
    }
    
}
