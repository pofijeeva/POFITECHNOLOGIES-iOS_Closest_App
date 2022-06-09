//
//  MyInvoiceVC.swift
//  HomeStay
//
//  Created by pofiapple10 on 14/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
import Cosmos

class MyInvoiceVC: BaseViewController {
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var addReview: UITextView!
    @IBOutlet weak var ratingView: CosmosView!
    var delegate: MyBookingVCPrototcol?
    var PropertId = String()
    var review_details = [String:Any]()
    var ratingValue : Double?
    override func viewDidLoad() {
        submitBtn.layer.cornerRadius = 13
        addReview.delegate = self
        ratingView.didFinishTouchingCosmos = { rating in
            print(rating)
            self.ratingValue = rating
            
        }
        
    }
    
    
    @IBAction func addClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func addSubmit(_ sender: Any) {
        
        
        guard let text = addReview.text, text != "Add your review", text.count != 0 else {
            
            return
        }
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
                
            let parameters:[String : Any] =  ["lang_code" : lanuguage_selection.value(forKey: "language") ?? "en",
                       "property_id":review_details["property_id"] as? Int ?? 0,
                       "bookingno":review_details["booking_id"] as? Int ?? 0,
                       "review":text,
                       "star_rating": self.ratingValue ?? 0,
                       "host_id": review_details["host_id"] as? Int ?? 0
                        ]
        print(parameters)
         
            APIManager.apiPostWithHeadersCodable(serviceName: ADD_REVIEW_API, parameters:parameters) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }

               
                do {
                    
                    let successModel = try JSONDecoder().decode(SuccessModel.self, from: data)
        
                    if let responseCode = successModel.code, responseCode == 200 {
                        
                        
                        self.dismiss(animated: true) {
                            self.delegate?.reloadMybookinglist()
                        }
                      
                        
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
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

extension MyInvoiceVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        addReview.text = ""
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            addReview.text = "Add your review"
        }
        
    }
    
}
