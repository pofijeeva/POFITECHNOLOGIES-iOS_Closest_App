//
//  PaymentDetailsVC.swift
//  HomeStay
//
//  Created by pofiapple10 on 23/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking
import DropDown

class PaymentDetailsVC: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var dateSearchView: UIView!
    @IBOutlet weak var dateSearchHeightConstrints: NSLayoutConstraint!
    @IBOutlet weak var detailHeaderHeightConstrints: NSLayoutConstraint!
    @IBOutlet weak var detailHeaderView: UIView!
    @IBOutlet weak var selectDateTextField: UITextField!
    @IBOutlet weak var selectDateview: UIView!
    @IBOutlet weak var listTableview: UITableView!
    @IBOutlet weak var searchbtn: UIButton!
    
    @IBOutlet weak var ColView: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view1payout: UILabel!
    @IBOutlet weak var view1price: UILabel!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view2balance: UILabel!
    @IBOutlet weak var view2price: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view3payout: UILabel!
    @IBOutlet weak var view3price: UILabel!
    
    @IBOutlet weak var payoutDate: UILabel!
    @IBOutlet weak var payoutDetailsTitle: UILabel!
    
    
    @IBOutlet weak var txtBankName: UITextField!
    @IBOutlet weak var txtBranchName: UITextField!
    @IBOutlet weak var txtAccountNumber: UITextField!
    @IBOutlet weak var txtIfscCode: UITextField!
    @IBOutlet weak var Submitbtn: UIButton!
    @IBOutlet weak var BankView: UIView!
    @IBOutlet weak var AccountView: UIView!
    @IBOutlet weak var PaypalView: UIView!
    @IBOutlet weak var BankTypeTxt: UITextField!

    @IBOutlet weak var paypalTxt: UITextField!

    var bookingPaymentDetailArray = [BookingPaymentModel]()
    var listingPaymentArray = [MylistingPaymentChildModel]()
    var hostPaymentArray = [HospaymentChildModel]()
    var payoutDetails: PayoutRefrenceModel?
    var accountInfo: AccountInfoDetailModel?
    var payoutCell: PayoutMethodCell?
    
    var paymentIndex = 0
    var isLoading:Bool = true
    var currentPage = 1
    let datepicker = UIDatePicker()

    var decryptDataDict = NSMutableDictionary()
    let dropDown = DropDown()
    var BankTypesInt = Int()

    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDown
        ]
    }()
    
    var BankTypes = ["Checking","Saving"]

    let titlesheading = [ GlobalLanguageDictionary.object(forKey: "key_myBookingPayment") as? String ?? "" , GlobalLanguageDictionary.object(forKey: "key_myListingPayment") as? String ?? "" , GlobalLanguageDictionary.object(forKey: "key_hostPayout") as? String ?? "" , GlobalLanguageDictionary.object(forKey: "key_payoutMethod") as? String ?? ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BankView.isHidden = true
        self.AccountView.isHidden = true
        self.PaypalView.isHidden = true
        self.BankTypeTxt.delegate = self
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = true
        view1.layer.borderWidth = 0.2
        view1.layer.borderColor = UIColor.black.cgColor
        view1.layer.cornerRadius = 4
        view2.layer.borderWidth = 0.2
        view2.layer.borderColor = UIColor.black.cgColor
        view2.layer.cornerRadius = 4
        view3.layer.borderWidth = 0.2
        view3.layer.borderColor = UIColor.black.cgColor
        view3.layer.cornerRadius = 4
        selectDateview.layer.cornerRadius = 5
        searchbtn.layer.cornerRadius = 5
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .compact
                    }
        createDatePicker()
        selectDateview.layer.cornerRadius = 20
        listTableview.register(UINib(nibName: "PaymentDetailsCell", bundle: nil), forCellReuseIdentifier: "PaymentDetailsCell")
        listTableview.register(UINib(nibName: "hostPayOutCell", bundle: nil), forCellReuseIdentifier: "hostPayOutCell")
        listTableview.register(UINib(nibName: "PayoutMethodCell", bundle: nil), forCellReuseIdentifier: "PayoutMethodCell")
        listTableview.delegate = self
        listTableview.dataSource = self
        showActivityIndicator(uiView: self.view)
        listTableview.estimatedRowHeight = 250
        self.getBookingPaymentApiResponse()
        self.view1price.textColor = AppColor
        self.view2price.textColor = AppColor
        self.view3price.textColor = AppColor
        self.searchbtn.backgroundColor = AppColor
        
        self.view1payout.font = UIFont(name: SemiBoldFont, size: 14)
        self.view1price.font = UIFont(name: SemiBoldFont, size: 15)
        self.view2balance.font = UIFont(name: SemiBoldFont, size: 14)
        self.view2price.font = UIFont(name: SemiBoldFont, size: 15)
        self.view3payout.font = UIFont(name: SemiBoldFont, size: 14)
        self.view3price.font = UIFont(name: SemiBoldFont, size: 15)
        self.payoutDate.font = UIFont(name: SemiBoldFont, size: 15)
        self.selectDateTextField.font = UIFont(name: SemiBoldFont, size: 14)
        self.searchbtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 14)
        self.payoutDetailsTitle.font = UIFont(name: SemiBoldFont, size: 17)
        
        self.payoutDetailsTitle.text = GlobalLanguageDictionary.object(forKey: "key_paymentDetails") as? String ?? ""
        self.view1payout.text = GlobalLanguageDictionary.object(forKey: "key_yourPayout") as? String ?? ""
        self.view2balance.text = GlobalLanguageDictionary.object(forKey: "key_yourBalance") as? String ?? ""
        self.view3payout.text = GlobalLanguageDictionary.object(forKey: "key_TotalPayout") as? String ?? ""
        self.payoutDate.text = GlobalLanguageDictionary.object(forKey: "key_payoutDate") as? String ?? ""
        self.selectDateTextField.placeholder = GlobalLanguageDictionary.object(forKey: "key_selectDate") as? String ?? ""
        self.searchbtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_search") as? String ?? "", for: .normal)


    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == BankTypeTxt {
            self.dropDown.show()
            self.DropDownTypes()
            textField.resignFirstResponder()
        }
    }
    func DropDownTypes() {
        
        dropDown.anchorView = self.BankTypeTxt
        dropDown.bottomOffset = CGPoint(x: 0, y: (self.BankTypeTxt?.bounds.height)!)
        dropDown.dataSource = BankTypes
        dropDown.backgroundColor = UIColor.white
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.BankTypeTxt.text = item
            self.BankTypesInt = index+1
           
            }
        
    }
    @IBAction func PaypalButAct(_ sender: UIButton) {
        if self.paypalTxt.text?.count == 0 {
            self.showInformation(title: "Error", message: GlobalLanguageDictionary.object(forKey: "Key_enterEmailId") as? String ?? "")

        }else{
            self.BankView.isHidden = true
            self.AccountView.isHidden = true
           self.PaypalView.isHidden = true
            let parameters:[String : Any] =
               ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                "accname": "",
                "accno": "",
                "bankname": "",
                "branchname": "",
                "ifsccode": "",
                "primay_payment_method":"1",
                "payment_type":"paypal",
                "paypal_email": self.paypalTxt.text!
               ]
           print(parameters)
           showActivityIndicator(uiView: self.view)

          
           
           
            let data = try! JSONSerialization.data(withJSONObject: parameters as Any, options: [])
           let key = "625202f9149e061d"
           let iv = "5efd3f6060e20330"
           var plainText = NSString()
           let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
              if let json = json {
               plainText = json
              }

           let cryptLib = CryptLib()
           //let newStr =
           var newStr = String()
           newStr = plainText as String
           let encryStr = cryptLib.encryptPlainText(newStr, key: key, iv: iv)
           let jsonData = try! JSONSerialization.data(withJSONObject: [encryStr!] as Any, options: [])

           let parameter:[String : Any] =
              ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
               "decryption_data": encryStr
              ]
           
           print(parameters)
           showActivityIndicator(uiView: self.view)
           APIManager.apiPostWithHeadersCodable(serviceName: USER_ACC_UPDATE_API, parameters: parameter as [String : Any]) { (data, error) in
               self.hideActivityIndicator(uiView: self.view)
               guard let data = data else {
                   
                   self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                   return
               }
               do {
                  
                        let json = String(data: data, encoding: String.Encoding.utf8)
                       let decryptedStr = cryptLib.decryptCipherText(json, key: key, iv: iv)
                       if let data = decryptedStr!.data(using: String.Encoding.utf8) {
                           do {
                               let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                               
                               
                               print(result)

                           } catch {
                               print("Something went wrong")
                           }
                       }

                   let successModel = try JSONDecoder().decode(HostpaymentModel.self, from: data)
                   print(successModel)
                   if let responseCode = successModel.code, responseCode == 200 {
                    self.dateSearchView.isHidden = true
                  
                   self.detailHeaderView.isHidden = true
                   self.dateSearchHeightConstrints.constant = 0
                   self.detailHeaderHeightConstrints.constant = 0
                   self.UserAccountApi()
                   self.listTableview.reloadData()
                       self.showInformation(title:"Closest", message: successModel.message ?? "")
                   
                    
                    
                   } else {
                       self.showInformation(title: "Error", message: successModel.message ?? "")
                   }
                   
                   
                   
               } catch {
                   print("error reading JSON: \(error)")
                   let successModel = try? JSONDecoder().decode(CommonSuccessModel.self, from: data)
                  
                   if let responseCode = successModel?.code, responseCode == 200 {
                       self.showInformation(title:"", message: successModel?.message ?? "")
  
                   } else {
                       self.showInformation(title: "Error", message: successModel?.message ?? "")
                   }
               }
           }
        }
    }
    
    @IBAction func submitButAct(_ sender: UIButton) {
        self.BankView.isHidden = true
        self.AccountView.isHidden = true
       self.PaypalView.isHidden = true
        let parameters:[String : Any] =
           ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
            "accname": self.txtBankName.text!,
            "accno": self.txtIfscCode.text ?? "",
            "bankname":self.txtBranchName.text ?? "",
            "branchname":self.payoutCell?.txtBranchName.text ?? "",
            "ifsccode": self.payoutCell?.txtIfscCode.text ?? "",
            "primay_payment_method":self.BankTypesInt,
            "payment_type":"bank"
           ]
       print(parameters)
       showActivityIndicator(uiView: self.view)

      
       
       
        let data = try! JSONSerialization.data(withJSONObject: parameters as Any, options: [])
       let key = "625202f9149e061d"
       let iv = "5efd3f6060e20330"
       var plainText = NSString()
       let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
          if let json = json {
           plainText = json
          }

       let cryptLib = CryptLib()
       //let newStr =
       var newStr = String()
       newStr = plainText as String
       let encryStr = cryptLib.encryptPlainText(newStr, key: key, iv: iv)
       let jsonData = try! JSONSerialization.data(withJSONObject: [encryStr!] as Any, options: [])

       let parameter:[String : Any] =
          ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
           "decryption_data": encryStr
          ]
       
       print(parameters)
       showActivityIndicator(uiView: self.view)
       APIManager.apiPostWithHeadersCodable(serviceName: USER_ACC_UPDATE_API, parameters: parameter as [String : Any]) { (data, error) in
           self.hideActivityIndicator(uiView: self.view)
           guard let data = data else {
               
               self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
               return
           }
           do {
               
               // Convert JSON from NSData to AnyObject
               //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
               //                    print(jsonObject)
               
               
                    let json = String(data: data, encoding: String.Encoding.utf8)
                   let decryptedStr = cryptLib.decryptCipherText(json, key: key, iv: iv)
                   if let data = decryptedStr!.data(using: String.Encoding.utf8) {
                       do {
                           let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                           
                           
                           print(result)

                       } catch {
                           print("Something went wrong")
                       }
                   }

               let successModel = try JSONDecoder().decode(HostpaymentModel.self, from: data)
               print(successModel)
               if let responseCode = successModel.code, responseCode == 200 {
                self.dateSearchView.isHidden = true
                self.BankView.isHidden = true
                 self.AccountView.isHidden = true
                self.PaypalView.isHidden = true
               self.detailHeaderView.isHidden = true
               self.dateSearchHeightConstrints.constant = 0
               self.detailHeaderHeightConstrints.constant = 0
               self.UserAccountApi()
               self.listTableview.reloadData()
                   self.showInformation(title:"Closest", message: successModel.message ?? "")
               
               }
               else {
                   self.showInformation(title: "Error", message: successModel.message ?? "")
               }
               
               
               
           } catch {
               print("error reading JSON: \(error)")
               let successModel = try? JSONDecoder().decode(CommonSuccessModel.self, from: data)
              
               if let responseCode = successModel?.code, responseCode == 200 {
                   self.showInformation(title:"", message: successModel?.message ?? "")
//                        self.listTableview.reloadData()
//                        UserAccountApi()
               } else {
                   self.showInformation(title: "Error", message: successModel?.message ?? "")
               }
           }
       }

    }

    @IBAction func searchButton(_ sender: UIButton) {
       
        if selectDateTextField.text?.count != 0 {
            if paymentIndex == 0{
                showActivityIndicator(uiView: self.view)
                self.bookingPaymentDetailArray.removeAll()
                self.isLoading = true
                getBookingPaymentApiResponse(dateSerach: self.selectDateTextField.text ?? "")
                
            }
            else if paymentIndex == 1 {
                showActivityIndicator(uiView: self.view)
                self.listingPaymentArray.removeAll()
                self.isLoading = true
                getBookingListingPaymentApiResponse(dateSerach: self.selectDateTextField.text ?? "")
                
            }
            else if paymentIndex == 2 {
                showActivityIndicator(uiView: self.view)
                self.hostPaymentArray.removeAll()
                self.isLoading = true
                getHostingPaymentApiResponse(dateSerach: self.selectDateTextField.text ?? "")
                
            }
            
        }
    }
    
    @IBAction func selectDateButtonTapped(_ sender: UIButton) {
       
    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelbtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelButton))
        
        toolbar.setItems([cancelbtn, spaceButton,donebtn], animated: true)
        
        selectDateTextField.inputAccessoryView = toolbar
        
        selectDateTextField.inputView = datepicker
        
        datepicker.datePickerMode = .date
    }
    @objc func donepressed() {
        let dateformator = DateFormatter()
        
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .none
        
        
       
        selectDateTextField.text = dateformator.string(from: datepicker.date)
        self.view.endEditing(true)
    }
    @objc func cancelButton() {
        //cancel button dismiss datepicker dialog
         self.view.endEditing(true)
    }
    func getBookingPaymentApiResponse(pageno: Int = 1, dateSerach: String = "") {
       
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view, isFulLoader: true)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "page_no":pageno,
                 "currency_code":"USD",
                 "date_search":dateSerach,
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: BOOKINGPAYMENT, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(PaymentDetailsModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        
                        if let paymentArray = successModel.data?.booking_payment, paymentArray.count != 0 {
                            self.isLoading = false
                            self.bookingPaymentDetailArray.append(contentsOf: paymentArray)
                            let currenceySymbol = successModel.data?.currency_symbol ?? "$"
                            DispatchQueue.main.async {
                                if let model = successModel.data {
                                    if let payout = model.paid_amnt {
                                        self.view1.isHidden = false
                                        self.view1price.text = "\(currenceySymbol)\(payout)"
                                    }else {
                                        self.view1.isHidden = true
                                    }
                                    if let balanece = model.payable_amnt {
                                        self.view2.isHidden = false
                                        self.view2price.text = "\(currenceySymbol)\(balanece)"
                                        
                                    }else {
                                        self.view2.isHidden = true
                                    }
                                    if let  totalAmount = model.total_amnt {
                                        self.view3.isHidden = false
                                        self.view3price.text = "\(currenceySymbol)\(totalAmount)"
                                        
                                    }else {
                                        self.view3.isHidden = true
                                    }
                                }
                            }
                           
                            
                        } else {
                            self.isLoading = true
                        }
                        self.listTableview.reloadData()
                        
                    } else {
                        self.listTableview.reloadData()
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    self.listTableview.reloadData()
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
    }
    func getBookingListingPaymentApiResponse(pageno: Int = 1, dateSerach: String = "") {
       
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "page_no":pageno,
                 "currency_code":"USD",
                 "date_search":dateSerach,
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: LISTING_PAYMENT, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(MyListingPaymentModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        if let paymentArray = successModel.data?.listing_payment, paymentArray.count != 0 {
                            let currenceySymbol = successModel.data?.currency_symbol ?? "$"
                            DispatchQueue.main.async {
                                if let model = successModel.data {
                                    if let payout = model.paid_amount {
                                        self.view1.isHidden = false
                                        self.view1price.text = "\(currenceySymbol)\(payout)"
                                    } else {
                                        self.view1.isHidden = true
                                    }
                                    if let balanece = model.payable_amnt {
                                        self.view2.isHidden = false
                                        self.view2price.text = "\(currenceySymbol)\(balanece)"
                                        
                                    } else {
                                        self.view2.isHidden = true
                                    }
                                    if let  totalAmount = model.total_amount {
                                        self.view3.isHidden = false
                                        self.view3price.text = "\(currenceySymbol)\(totalAmount)"
                                        
                                    } else {
                                        self.view3.isHidden = true
                                    }
                                }
                            }
                            
                            self.isLoading = false
                            self.listingPaymentArray.append(contentsOf: paymentArray)
                        } else {
                            self.isLoading = true
                        }
                        self.listTableview.reloadData()
              
                    } else {
                        self.listTableview.reloadData()
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    self.listTableview.reloadData()
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
    }
    func getHostingPaymentApiResponse(pageno: Int = 1, dateSerach: String = "") {
      
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "page_no":pageno,
                 "currency_code":"USD",
                 "date_search":dateSerach,
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: HOST_PAYOUT, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(HostpaymentModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        if let paymentArray = successModel.data?.payout_list, paymentArray.count != 0 {
                            
                            self.isLoading = false
                            DispatchQueue.main.async {
                                let currenceySymbol = successModel.data?.currency_symbol ?? "$"
                                if let model = successModel.data {
                                    if let payout = model.paid_amnt {
                                        self.view1.isHidden = false
                                        self.view1price.text = "\(currenceySymbol)\(payout)"
                                    }else {
                                        self.view1.isHidden = true
                                    }
                                    if let balanece = model.payable_amnt {
                                        self.view2.isHidden = false
                                        self.view2price.text = "\(currenceySymbol)\(balanece)"
                                        
                                    }else {
                                        self.view2.isHidden = true
                                    }
                                    if let  totalAmount = model.total_amount {
                                        self.view3.isHidden = false
                                        self.view3price.text = "\(currenceySymbol)\(totalAmount)"
                                        
                                    }else {
                                        self.view3.isHidden = true
                                    }
                                }
                            }
                            self.hostPaymentArray.append(contentsOf: paymentArray)
                        } else {
                            self.isLoading = true
                        }
                       
                        
                        self.listTableview.reloadData()
                        
                    } else {
                        self.listTableview.reloadData()
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    self.listTableview.reloadData()
                    print("error reading JSON: \(error)")
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
    }
    
    @objc func AddBankAccountAct()  {
        self.BankView.isHidden = false
        self.AccountView.isHidden = false
        self.PaypalView.isHidden = true
    }
    
    @objc func AddPaypalAct()  {
        self.BankView.isHidden = false
        self.AccountView.isHidden = true
        self.PaypalView.isHidden = false
    }
    @objc func getDocumentListData()  {
         let parameters:[String : Any] =
            ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
             "accname": self.accountInfo?.accname ?? "",
             "accno": self.payoutCell?.txtAccountNumber.text ?? "",
             "bankname":self.payoutCell?.txtBankName.text ?? "",
             "branchname":self.payoutCell?.txtBranchName.text ?? "",
             "ifsccode": self.payoutCell?.txtIfscCode.text ?? "",
             "primay_payment_method":"1",
             "payment_type":"bank"
            ]
        print(parameters)
        showActivityIndicator(uiView: self.view)

       
        
        
         let data = try! JSONSerialization.data(withJSONObject: parameters as Any, options: [])
        let key = "625202f9149e061d"
        let iv = "5efd3f6060e20330"
        var plainText = NSString()
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
           if let json = json {
            plainText = json
           }

        let cryptLib = CryptLib()
        //let newStr =
        var newStr = String()
        newStr = plainText as String
        let encryStr = cryptLib.encryptPlainText(newStr, key: key, iv: iv)
        let jsonData = try! JSONSerialization.data(withJSONObject: [encryStr!] as Any, options: [])

        let parameter:[String : Any] =
           ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
            "decryption_data": encryStr
           ]
        
        print(parameters)
        showActivityIndicator(uiView: self.view)
        APIManager.apiPostWithHeadersCodable(serviceName: USER_ACC_UPDATE_API, parameters: parameter as [String : Any]) { (data, error) in
            self.hideActivityIndicator(uiView: self.view)
            guard let data = data else {
                
                self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                return
            }
            do {
                
                // Convert JSON from NSData to AnyObject
                //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                //                    print(jsonObject)
                
                
                     let json = String(data: data, encoding: String.Encoding.utf8)
                    let decryptedStr = cryptLib.decryptCipherText(json, key: key, iv: iv)
                    if let data = decryptedStr!.data(using: String.Encoding.utf8) {
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                            
                            
                            print(result)

                        } catch {
                            print("Something went wrong")
                        }
                    }
 
                let successModel = try JSONDecoder().decode(HostpaymentModel.self, from: data)
                print(successModel)
                if let responseCode = successModel.code, responseCode == 200 {
                    self.showInformation(title:"", message: successModel.message ?? "")
                    self.listTableview.reloadData()
                } else {
                    self.showInformation(title: "Error", message: successModel.message ?? "")
                }
                
                
                
            } catch {
                print("error reading JSON: \(error)")
                let successModel = try? JSONDecoder().decode(CommonSuccessModel.self, from: data)
               
                if let responseCode = successModel?.code, responseCode == 200 {
                    self.showInformation(title:"", message: successModel?.message ?? "")
//                        self.listTableview.reloadData()
//                        UserAccountApi()
                } else {
                    self.showInformation(title: "Error", message: successModel?.message ?? "")
                }
            }
        }


    }
    
   @objc func  getPayoutMethodApiResponse() {
        //showActivityIndicator(uiView: self.view)
        
        if (Reachability()?.isReachable)! {
            showActivityIndicator(uiView: self.view)
          
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
                 "accname": self.accountInfo?.accname ?? "",
                 "accno": self.payoutCell?.txtAccountNumber.text ?? "",
                 "bankname":self.payoutCell?.txtBankName.text ?? "",
                 "branchname":self.payoutCell?.txtBranchName.text ?? "",
                 "ifsccode": self.payoutCell?.txtIfscCode.text ?? "",
                 "paypal_email":""
                ]
            APIManager.apiPostWithHeadersCodable(serviceName: USER_ACC_UPDATE_API, parameters: parameters as [String : Any]) { (data, error) in
                self.hideActivityIndicator(uiView: self.view)
                guard let data = data else {
                    
                    self.showInformation(title: "Error", message: error?.localizedDescription ?? "")
                    return
                }
                do {
                    
                    // Convert JSON from NSData to AnyObject
                    //                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    //                    print(jsonObject)
                    
                    let successModel = try JSONDecoder().decode(HostpaymentModel.self, from: data)
                    print(successModel)
                    if let responseCode = successModel.code, responseCode == 200 {
                        self.showInformation(title:"", message: successModel.message ?? "")
                        self.listTableview.reloadData()
                    } else {
                        self.showInformation(title: "Error", message: successModel.message ?? "")
                    }
                    
                    
                    
                } catch {
                    print("error reading JSON: \(error)")
                    let successModel = try? JSONDecoder().decode(CommonSuccessModel.self, from: data)
                   
                    if let responseCode = successModel?.code, responseCode == 200 {
                        self.showInformation(title:"", message: successModel?.message ?? "")
//                        self.listTableview.reloadData()
//                        UserAccountApi()
                    } else {
                        self.showInformation(title: "Error", message: successModel?.message ?? "")
                    }
                }
            }
            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
        
        
    }
    func UserAccountApi() {
     
        
        if (Reachability()?.isReachable)! {
//            showActivityIndicator(uiView: self.view)
            let parameters:[String : Any] =
                ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en",
               
                 "currency_code":"USD",
               
                ]
            
            Alamofire.request(GET_USER_ACCOUNT_DETAILS, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HeaderManager.headers()).responseJSON { (response:DataResponse<Any>) in
                switch(response.result) {
                case .success(_):
                    if let data = response.value{
                        let json576 = data as? NSDictionary
                        let convertStr = json576?.object(forKey: "data") as? String ?? ""
                        let dataStr = convertStr.data(using: .utf8, allowLossyConversion: true)

                        let key = "625202f9149e061d"
                        let iv = "5efd3f6060e20330"
                        let cryptLib = CryptLib()
                        let json = String(data: dataStr!, encoding: String.Encoding.utf8)
                        let decryptedStr = cryptLib.decryptCipherText(json, key: key, iv: iv)
                        if let data = decryptedStr?.data(using: String.Encoding.utf8) {
                            do {
                                let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                                self.decryptDataDict.removeAllObjects()
                                self.decryptDataDict.addEntries(from: result as! [AnyHashable : Any])
                                print(self.decryptDataDict)
                                if let bankName = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "bankname") as? String {
                                    self.txtBankName.text = bankName
                                }
                                self.txtBranchName.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "branch_name") as? String ?? ""
                                self.txtAccountNumber.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "accno") as? String ?? ""
                                
                                self.txtIfscCode.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "ifc_code") as? String ?? ""
                                self.paypalTxt.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "paypal_email") as? String ?? ""
                                self.listTableview.reloadData()
                                
                            } catch {
                                print("Something went wrong")
                            }
                        }
                    }
                    break
                case .failure(_):
                     break
                }
            }
            

            
        }
        else {
            self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
       
    }
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}




extension PaymentDetailsVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titlesheading.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Payment_DetailsCVCell", for: indexPath) as! Payment_DetailsCVCell
        cell.Lbltitle.text = titlesheading[indexPath.item]
        
        cell.Lbltitle.font = UIFont(name: SemiBoldFont, size: 16)
        
        cell.LblUnderline.backgroundColor = paymentIndex == indexPath.item ? AppColor : .none
        
//        cell.Lbltitle.textColor = paymentIndex == indexPath.item ? #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) : .black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.paymentIndex = indexPath.item
        self.ColView.reloadData()
        self.selectDateTextField.text = ""
        dateSearchView.isHidden = false
        detailHeaderView.isHidden = false
        dateSearchHeightConstrints.constant = 40
        detailHeaderHeightConstrints.constant = 180
        
        if indexPath.item == 0{
            showActivityIndicator(uiView: self.view)
            self.bookingPaymentDetailArray.removeAll()
            self.isLoading = true
          
            getBookingPaymentApiResponse()
            
        }
        else if indexPath.item == 1 {
            showActivityIndicator(uiView: self.view)
            self.listingPaymentArray.removeAll()
            self.isLoading = true
            getBookingListingPaymentApiResponse()
            
        }
        else if indexPath.item == 2 {
            showActivityIndicator(uiView: self.view)
            self.hostPaymentArray.removeAll()
            self.isLoading = true
            getHostingPaymentApiResponse()
            
        }
        else if indexPath.item == 3 {
           
            dateSearchView.isHidden = true
            detailHeaderView.isHidden = true
            dateSearchHeightConstrints.constant = 0
            detailHeaderHeightConstrints.constant = 0
            UserAccountApi()
            //showActivityIndicator(uiView: self.view)
            //getPayoutMethodApiResponse()
            self.listTableview.reloadData()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 44)
    }
    
}

extension PaymentDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch paymentIndex {
        case 0:
            return self.bookingPaymentDetailArray.count
        case 1:
            return self.listingPaymentArray.count
        case 2:
            return self.hostPaymentArray.count
        default:
            if self.decryptDataDict.count == 0 {
                return 0
            }else{
                return 1
            }
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch paymentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsCell", for: indexPath) as? PaymentDetailsCell else { return UITableViewCell() }
            let model = self.bookingPaymentDetailArray[indexPath.row]
            let finalString = "\(model.dateadded ?? "")(\(GlobalLanguageDictionary.object(forKey: "key_noBooking") as? String ?? ""):\(model.bookingno ?? ""))"
            
            
            
            if login_session.object(forKey: "Language")as? String ?? "" == "en"{
                cell.transId.textAlignment = .left
                cell.transType.textAlignment = .left
                cell.Amttype.textAlignment = .left
                cell.currencytype.textAlignment = .left
                cell.Statustype.textAlignment = .left
            }else{
                cell.transId.textAlignment = .right
                cell.transType.textAlignment = .right
                cell.Amttype.textAlignment = .right
                cell.currencytype.textAlignment = .right
                cell.Statustype.textAlignment = .right
            }
            
            cell.dateLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.nameDesLbl.font = UIFont(name: SemiBoldFont, size: 15)
            cell.transactionIdLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.transactiontypeLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.amountLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.currencyLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.pendingLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.pendingLbl.font = UIFont(name: SemiBoldFont, size: 13)
            
            cell.transId.font = UIFont(name: SemiBoldFont, size: 13)
            cell.transType.font = UIFont(name: SemiBoldFont, size: 13)
            cell.Amttype.font = UIFont(name: SemiBoldFont, size: 13)
            cell.currencytype.font = UIFont(name: SemiBoldFont, size: 13)
            cell.Statustype.font = UIFont(name: SemiBoldFont, size: 13)

            cell.dateLbl.text = finalString
           
            cell.nameDesLbl.text = model.ren_title ?? ""
            cell.transactionIdLbl.text = model.transaction_id ?? ""
            cell.transactiontypeLbl.text = model.transaction_method ?? ""
            cell.amountLbl.text = model.amount ?? ""
            cell.currencyLbl.text = model.currency_symbol ?? ""
            if let cancledStatus = model.cancelled_status, cancledStatus == 0 {
                if let paidStatus = model.paid_status,  paidStatus != 0 {
                    cell.pendingLbl.backgroundColor = UIColor.systemGreen
                    cell.pendingLbl.text = GlobalLanguageDictionary.object(forKey: "key_success") as? String ?? ""
                    cell.pendingLbl.textColor = UIColor.white
                    
                } else {
                    cell.pendingLbl.backgroundColor = UIColor.systemGreen
                    cell.pendingLbl.text = GlobalLanguageDictionary.object(forKey: "key_pending") as? String ?? ""
                    cell.pendingLbl.textColor = UIColor.white
                }
                
            } else {
                cell.pendingLbl.backgroundColor = UIColor.red
                cell.pendingLbl.text = GlobalLanguageDictionary.object(forKey: "key_cancelled") as? String ?? ""
                cell.pendingLbl.textColor = UIColor.white
            }
            
            print(model.amount)
            return cell
        case 1:
            guard let second = tableView.dequeueReusableCell(withIdentifier: "PaymentDetailsCell", for: indexPath) as? PaymentDetailsCell else { return UITableViewCell() }
            
            let model = self.listingPaymentArray[indexPath.row]
            second.dateLbl.text = model.dateadded ?? ""
            second.nameDesLbl.text = model.property_title ?? ""
            second.transactionIdLbl.text = model.transaction_id ?? ""
            second.transactiontypeLbl.text = model.transaction_method ?? ""
            second.currencyLbl.text = model.currency_symbol ?? ""
            second.amountLbl.text = model.property_price ?? ""
            
          
                if let paidStatus = model.payment_status,  paidStatus != 0 {
                    second.pendingLbl.backgroundColor = UIColor.systemGreen
                    second.pendingLbl.text = GlobalLanguageDictionary.object(forKey: "key_success") as? String ?? ""
                    second.pendingLbl.textColor = UIColor.white
                    
                } else {
                    second.pendingLbl.backgroundColor = UIColor.systemYellow
                    second.pendingLbl.text = GlobalLanguageDictionary.object(forKey: "key_pending") as? String ?? ""
                    second.pendingLbl.textColor = UIColor.white
                }
            return second
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "hostPayOutCell", for: indexPath) as? hostPayOutCell else { return UITableViewCell() }
            let model = self.hostPaymentArray[indexPath.row]
            cell.dateLabel.text = model.paid_on ?? ""
            cell.transactionIdlabel.text = model.transaction_id ?? ""
            cell.AmountLabel.text = model.total_amnt ?? ""
            cell.CurrencyLabel.text = model.comm_user_currency
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PayoutMethodCell", for: indexPath) as? PayoutMethodCell else { return UITableViewCell() }
            self.payoutCell = cell
            cell.Submitbtn.addTarget(self, action: #selector(getDocumentListData), for: .touchUpInside)
            cell.BankAddBtn.addTarget(self, action: #selector(AddBankAccountAct), for: .touchUpInside)
            cell.PayPalAddBtn.addTarget(self, action: #selector(AddPaypalAct), for: .touchUpInside)

            if (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "accno") as? String ?? "" != "" {
                cell.BankAddBtn.setTitle("***********    Edit", for: .normal)
                cell.BankAddImgBtn.setImage(UIImage(named: "radio-on-button"), for: .normal)
            }else{
                cell.BankAddBtn.setTitle("Add", for: .normal)
                cell.BankAddImgBtn.setImage(UIImage(named: "radio-button"), for: .normal)

            }
            
            if (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "paypal_email") as? String ?? "" != "" {
                cell.PayPalAddImgBtn.setImage(UIImage(named: "radio-on-button"), for: .normal)
                cell.PayPalAddBtn.setTitle("***********    Edit", for: .normal)
            }else{
                cell.PayPalAddBtn.setTitle("Add", for: .normal)
                cell.PayPalAddImgBtn.setImage(UIImage(named: "radio-button"), for: .normal)
            }

//            if let model = self.payoutDetails {
                cell.txtBankName.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "bankname") as? String ?? ""//model.bankname ?? ""
                cell.txtBranchName.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "branch_name") as? String ?? ""
            cell.txtAccountNumber.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "accno") as? String ?? ""
            
                cell.txtIfscCode.text = (self.decryptDataDict.object(forKey: "payout_perference") as? NSDictionary)?.object(forKey: "ifc_code") as? String ?? ""
            
//                cell.Submitbtn.addTarget(self, action: #selector(""), for: .touchUpInside)
//            }
            return cell
            
            
        default:
            return UITableViewCell()
            
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch paymentIndex {
        case 0:
            return UITableViewAutomaticDimension
        case 1:
            return UITableViewAutomaticDimension
        case 2:
            return 150
        case 3:
            return 400
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch paymentIndex {
        case 0:
            if indexPath.item == self.bookingPaymentDetailArray.count - 1 && !self.isLoading{
                self.isLoading = true
                currentPage += 1
                getBookingPaymentApiResponse(pageno: currentPage)
                
            }
        case 1:
            if indexPath.item == self.listingPaymentArray.count - 1 && !self.isLoading{
                self.isLoading = true
                currentPage += 1
                getBookingListingPaymentApiResponse(pageno: currentPage)
                
            }
        case 2:
            if indexPath.item == self.hostPaymentArray.count - 1 && !self.isLoading{
                self.isLoading = true
                currentPage += 1
                getHostingPaymentApiResponse(pageno: currentPage)
                
            }
        case 3:
            break
        default:
            break
        }
        
    }
    
}
