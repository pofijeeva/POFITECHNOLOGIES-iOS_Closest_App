//
//  ExperienceNowViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 03/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar
import AFNetworking

class ExperienceNowViewController: BaseViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var HeaderTitle: UILabel!
    @IBOutlet weak var SelectTypeBtn: UIButton!
    @IBOutlet weak var CategoryBtn: UIButton!
    @IBOutlet weak var DatesBtn: UIButton!
    @IBOutlet weak var ArriveDepartView: UIView!
    @IBOutlet weak var ArriveDepartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var ArriveDepartLbl: UILabel!
    @IBOutlet weak var FromDateLbl: UILabel!
    @IBOutlet weak var toDateLbl: UILabel!
    @IBOutlet weak var DatesResetBtn: UIButton!
    @IBOutlet weak var ExperienceTable: UITableView!
    // SelectType
    
    @IBOutlet weak var GaryView: UIView!
    @IBOutlet weak var SelectType: UIView!
    @IBOutlet weak var AvailableTypeLbl: UILabel!
    @IBOutlet weak var SelectTypeTable: UITableView!
    @IBOutlet weak var TypeCancelBtn: UIButton!
    @IBOutlet weak var TypeResetBtn: UIButton!
    @IBOutlet weak var TypeOkBtn: UIButton!
    
    // Dates
    
    
    @IBOutlet weak var ChooseDateCalender: FSCalendar!
    
    // Categories
    
    @IBOutlet weak var CategoriesView: UIView!
    @IBOutlet weak var CategoriesLbl: UILabel!
    @IBOutlet weak var CategoriesTable: UITableView!
    @IBOutlet weak var CategoriesCancelBtn: UIButton!
    @IBOutlet weak var CategoriesResetBtn: UIButton!
    @IBOutlet weak var CategoriesOkBtn: UIButton!
    
    // WishList
    
    @IBOutlet weak var viewBottom: UIView!
       @IBOutlet weak var btn_addWishlist: UIButton!
       @IBOutlet weak var collectnviewWishlist: UICollectionView!
       @IBOutlet weak var viewWishlisttitlePopup: UIView!
       @IBOutlet weak var txf_Wishlistitle: UITextField!
       @IBOutlet weak var btn_Okay: UIButton!
    @IBOutlet weak var wishlistLbl: UILabel!
       @IBOutlet weak var choosewishlistLbl: UILabel!
    @IBOutlet weak var WishListCancelBtn: UIButton!

     @IBOutlet weak var WihsListView: UIView!
    
      @IBOutlet weak var EmptyView: UIView!
      @IBOutlet weak var EmptyResetBtn: UIButton!
      @IBOutlet weak var EmptyLbl: UILabel!
    
    @IBOutlet weak var EmptyExpView: UIView!
    
    @IBOutlet weak var EmptyExpLbl: UILabel!
    
    
    var wishListId = Int()
     var wishPropertyid = String()
    var isFromDate = "Arrive"
    
    var minimumDate = Date()
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    fileprivate let formatterNew: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    fileprivate let formatterNew1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?
    var fromDateStr = String()
    var toDateStr = String()
    
    var DatesShow:String = "Show"
    
    var ExperienceArray = NSMutableArray()
    var ExperienceTypesArray = NSMutableArray()
    var ExperienceCategoriesArray = NSMutableArray()
    var SelectedType = NSMutableArray()
    var SelectedCategoriesType = NSMutableArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.GetExperienceDetails()
        self.WishListApiCall()
        
        // Do any additional setup after loading the view.
        
        self.HeaderTitle.font = UIFont(name: SemiBoldFont, size: 17)
        self.ArriveDepartLbl.font = UIFont(name: SemiBoldFont, size: 16)
        self.FromDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.toDateLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.AvailableTypeLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.CategoriesLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.EmptyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        self.SelectTypeBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.CategoryBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.DatesBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.TypeCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.TypeResetBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.TypeOkBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.DatesResetBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.EmptyResetBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
        self.WishListCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)

        self.CategoriesCancelBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.CategoriesResetBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        self.CategoriesOkBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 14)
        
        self.EmptyExpLbl.font = UIFont(name: SemiBoldFont, size: 14)
        self.GaryView.isHidden = true
        self.ChooseDateCalender.isHidden = true
        self.SelectType.isHidden = true
        self.ArriveDepartViewHeight.constant = 140
        self.CategoriesView.isHidden = true
        self.WihsListView.isHidden = true
        self.EmptyView.isHidden = true
        
        self.ChooseDateCalender.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 15)
        self.ChooseDateCalender.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 14)
        self.ChooseDateCalender.appearance.titleFont = UIFont.init(name: RegularFont, size: 14)
        
        
        self.SelectTypeBtn.setTitleColor(AppSecondColor, for: .highlighted)
        self.CategoryBtn.setTitleColor(AppSecondColor, for: .highlighted)
        self.DatesBtn.setTitleColor(AppSecondColor, for: .highlighted)
        
    }
    func WishListApiCall() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
       
        params = ["userid":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en"]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(GET_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
           
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                print("GET_WISHLIST_API Response:::",responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                self.collectnviewWishlist.reloadData()
           }
           else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
    }
    func AddWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id":UserID,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"base_id":1,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"experience_id":self.wishPropertyid,"device_type":"ios"]
        
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(EXPERIENCEADDWISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
           
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                print(responseDict)
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                
                if mod.wishlist.count != 0
                {
                    self.GetExperienceDetails()
                  self.collectnviewWishlist.reloadData()
                }
                else
                {
                }
                self.WihsListView.isHidden = true
                
            }
                
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
    }
    func RemoveWishList() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","wishlist_id":self.wishListId,"user_id":UserID,"experience_id":self.wishPropertyid,"device_type":"ios","currency_code":login_session.value(forKey: "APP_CURRENCY") as! String]
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(EXPERIENCEREMOVEWISHLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
           
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                
                let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.wishListModel = mod
                if mod.wishlist.count != 0
                {
                    self.GetExperienceDetails()
                    self.collectnviewWishlist.reloadData()
                }
                else
                {

                    
                }
                
            }
                
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
    }
    

    
        @objc func favTapped(sender: UIButton)
        {
            let btnRow = sender.tag
            print("btnRow is :", btnRow)
            if sender.isSelected == true {
                print("btnRow is :", btnRow)
            }
            else {
                print("btnRow is :", btnRow)
            }
            
            
            self.wishPropertyid = "\((self.ExperienceArray.object(at: btnRow) as! NSDictionary).object(forKey: "exp_id") as AnyObject)"
            let favid = "\((self.ExperienceArray.object(at: btnRow) as! NSDictionary).object(forKey: "exp_favourite") as AnyObject)"
            if favid == "1"  {
                RemoveWishList()
                
            }else {
                self.GaryView.isHidden = false
                self.viewBottom.isHidden = false
                self.WihsListView.isHidden = false
                UIView.transition(with: self.viewBottom,
                                  duration:1.0,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.viewWishlisttitlePopup.isHidden = true
                                    self.viewBottom.isHidden = false
                                    self.GaryView.isHidden = false
                },
                                  completion: nil)
                
                if (Reachability()?.isReachable)!
                {
                     WishListApiCall()
     }
                else
                {
                    self.showInformation(title: "Closest", message: "Check your internet connection")
                }
            }
        }
    
    
    
    func GetExperienceDetails(){
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en"]
        print(params)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post(EXPERIENCENOW, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                self.EmptyExpView.isHidden = true
                self.EmptyView.isHidden = true
                self.ExperienceArray.removeAllObjects()
                self.ExperienceTypesArray.removeAllObjects()
                self.ExperienceCategoriesArray.removeAllObjects()
                self.ExperienceArray.addObjects(from: (responseDict.object(forKey: "experience_details")as! NSArray) as! [Any])
                self.ExperienceTypesArray.addObjects(from: (responseDict.object(forKey: "experience_types")as! NSArray) as! [Any])
                self.ExperienceCategoriesArray.addObjects(from: (responseDict.object(forKey: "experience_categories")as! NSArray) as! [Any])
                print(self.ExperienceArray)
                print(self.ExperienceTypesArray)
                print(self.ExperienceCategoriesArray)
                self.ExperienceTable.reloadData()
                self.SelectTypeTable.reloadData()
                self.CategoriesTable.reloadData()
            }
                
            else {
                self.EmptyExpLbl.text = responseDict.value(forKey: "message") as! String
                self.EmptyExpView.isHidden = false
               // self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
        
    }
    // MARK: wishlist Methods
    @IBAction func act_greyTapped(_ sender: UITapGestureRecognizer) {
        self.GaryView.isHidden = true
        self.viewBottom.isHidden = true
        self.viewWishlisttitlePopup.isHidden = true
        self.txf_Wishlistitle.text = ""
        self.SelectType.isHidden = true
        self.CategoriesView.isHidden = true
        self.ChooseDateCalender.isHidden = true
    }
    
    @IBAction func act_wishList(_ sender: UITapGestureRecognizer) {
        self.GaryView.isHidden = true
        self.viewBottom.isHidden = true
        self.viewWishlisttitlePopup.isHidden = true
        self.txf_Wishlistitle.text = ""
         self.WihsListView.isHidden = true
       
                            self.viewWishlisttitlePopup.isHidden = true
                            self.viewBottom.isHidden = true
                            self.GaryView.isHidden = true
        
        
        
    }
    @IBAction func act_wishListCancel(_ sender: UIButton)
    {
        self.viewWishlisttitlePopup.isHidden = true
        //self.greyView.isHidden = true
       // self.viewBottom.isHidden = true
    }
    @IBAction func act_addWishlist(_ sender: UIButton)
       {
        self.viewWishlisttitlePopup.isHidden = false
        self.GaryView.isHidden = false
        self.WihsListView.isHidden = false
        self.viewBottom.isHidden = true
       }
    
      @IBAction func act_OkayBtn(_ sender: UIButton) {
            if txf_Wishlistitle.text == "" {
                showInformation(title: "Closest", message: "Wishlist title cannot be empty")
            }
            else {
               
             
                if (Reachability()?.isReachable)!
                {
                    showActivityIndicator(uiView: self.view)
                    var params = NSMutableDictionary()
                    
                     params = ["base_id":1,"userid":login_session.value(forKey: "UserId")!,"wishlist_title":self.txf_Wishlistitle.text!,"property_id":self.wishPropertyid,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String]
                 
                    let manager = AFHTTPSessionManager()
                    manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                    
                    manager.post(CREATE_WISHLIST_API, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        let responseDict:NSDictionary = responseObject as! NSDictionary
                        self.hideActivityIndicator(uiView: self.view)
                        if responseDict.value(forKey: "status") as! Int == 1 {
                            self.viewWishlisttitlePopup.isHidden = true
                            self.GaryView.isHidden = true
                            self.viewBottom.isHidden = true
                           
                            let mod = WishlistModel(fromDictionary: responseDict as! [String : Any])
                            Singleton.sharedInstance.wishListModel = mod
                            self.collectnviewWishlist.reloadData()
                            self.WihsListView.isHidden = true
//                            self.GetExperienceDetails()
                            self.showInformation(title: "Closest", message: "WishList Created successfully")
                            
                        }
                       else {
                            self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                        }
                    }, failure: { (operation, error) -> Void in
                        DispatchQueue.main.async {
                            
                        }
                        print(error)
                        self.showInformation(title: "Closest", message: error.localizedDescription)
                    })
      }
                else {
                    self.showInformation(title: "Closest", message: "Check your internet connection")
                }
            }
        }
    
    
    // MARK: Calender Methods
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor(red: 234/255.0, green: 61/255.0, blue: 62/255.0, alpha: 1.0)
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        return 0
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor?
    {
        
        return nil
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minimumDate
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        self.minimumDate = date
        if isFromDate == "Arrive"
        {
            print("did select date \(self.formatter.string(from: date))")
            self.fromDateStr = self.formatterNew.string(from: date)
            self.FromDateLbl.text = self.formatterNew.string(from: date)
            self.toDateLbl.text = self.formatterNew.string(from: date)
            self.GaryView.isHidden = true
            self.ChooseDateCalender.isHidden = true
            
        }
        else
        {
            print("did select date \(self.formatter.string(from: date))")
            self.toDateStr =  self.formatterNew.string(from: date)
            self.toDateLbl.text = self.formatterNew.string(from: date)
            self.GaryView.isHidden = true
            self.ChooseDateCalender.isHidden = true
            
            self.DatesSubmit()
        }
        ChooseDateCalender.reloadData()
        
    }
    
    @IBAction func BackAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func EmptyResetAct(_ sender: Any) {
        self.EmptyView.isHidden = true
        self.FromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
        self.ChooseDateCalender.reloadData()
        self.GetExperienceDetails()
       }
    
    
    @IBAction func FromDateAct(_ sender: Any) {
        isFromDate = "Arrive"
        self.GaryView.isHidden = false
        self.ChooseDateCalender.isHidden = false
        self.SelectType.isHidden = true
    }
    @IBAction func ToDateAct(_ sender: Any) {
        
        isFromDate = "Depart"
        
        if self.fromDateStr == "" {
            self.showInformation(title: "Closest", message: "Please select From Date ")
        }else{
            self.GaryView.isHidden = false
            self.ChooseDateCalender.isHidden = false
            self.SelectType.isHidden = true
        }
    }
    
    @IBAction func categoryCancelAct(_ sender: Any) {
        self.GaryView.isHidden = true
        self.ChooseDateCalender.isHidden = true
        self.SelectType.isHidden = true
        self.CategoriesView.isHidden = true
    }
    @IBAction func CategoryResetAct(_ sender: Any) {
        self.GaryView.isHidden = true
        self.ChooseDateCalender.isHidden = true
        self.SelectType.isHidden = true
        self.CategoriesView.isHidden = true
        self.SelectedCategoriesType.removeAllObjects()
        self.CategoriesTable.reloadData()
        self.GetExperienceDetails()
    }
    @IBAction func CategoryApplyAct(_ sender: Any) {
        self.GaryView.isHidden = false
        self.ChooseDateCalender.isHidden = true
        self.SelectType.isHidden = false
        
        
        self.GaryView.isHidden = true
        self.SelectType.isHidden = true
        self.CategoriesView.isHidden = true
        
        var selectedCatStr = String()
        
        
        selectedCatStr = self.SelectedCategoriesType.componentsJoined(by: ",")
        print(selectedCatStr)
        
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","category":selectedCatStr]
        print(params)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post("https://www.bensonboat.pofirentals.in/json/explore_experience", parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                
                self.ExperienceArray.removeAllObjects()
                self.ExperienceTypesArray.removeAllObjects()
                self.ExperienceCategoriesArray.removeAllObjects()
                self.ExperienceArray.addObjects(from: (responseDict.object(forKey: "experience_details")as! NSArray) as! [Any])
                self.ExperienceTypesArray.addObjects(from: (responseDict.object(forKey: "experience_types")as! NSArray) as! [Any])
                self.ExperienceCategoriesArray.addObjects(from: (responseDict.object(forKey: "experience_categories")as! NSArray) as! [Any])
                print(self.ExperienceArray)
                print(self.ExperienceTypesArray)
                print(self.ExperienceCategoriesArray)
                self.ExperienceTable.reloadData()
                self.SelectTypeTable.reloadData()
                self.CategoriesTable.reloadData()
            }
                
            else {
                self.EmptyView.isHidden = false
             //   self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
   }
    
    
    @IBAction func SelectTypeAct(_ sender: Any) {
        
        if  self.ExperienceTypesArray.count == 0{
            self.EmptyExpView.isHidden = false

        }else{
            self.EmptyExpView.isHidden = true

            self.GaryView.isHidden = false
            self.ChooseDateCalender.isHidden = true
            self.SelectType.isHidden = false
            self.CategoriesView.isHidden = true
        }
        
    }
    @IBAction func CategoriesAct(_ sender: Any) {
        if  self.ExperienceCategoriesArray.count == 0{
            self.EmptyExpView.isHidden = false
            
        }else{
            self.EmptyExpView.isHidden = true

            self.GaryView.isHidden = false
            self.ChooseDateCalender.isHidden = true
            self.SelectType.isHidden = true
            self.CategoriesView.isHidden = false
        }
        
        
    }
    @IBAction func DateAct(_ sender: Any) {
        if self.DatesShow == "Show"
        {
            self.DatesShow = "Hide"
            self.DatesBtn.setTitle("SHOW DATES", for: .normal)
            self.ArriveDepartViewHeight.constant = 0
            self.ArriveDepartView.isHidden = true
        }else{
            self.DatesShow = "Show"
            self.DatesBtn.setTitle("HIDE DATES", for: .normal)
            self.ArriveDepartViewHeight.constant = 140
            self.ArriveDepartView.isHidden = false
        }
    }
    
    
    
    func DatesSubmit(){
        self.minimumDate = Date()
        
        if self.fromDateStr == "" {
            self.showInformation(title: "Closest", message: "Please select From Date ")
        }else{
            self.showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
            
            params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","checkin":self.FromDateLbl.text! ,"checkout":self.toDateLbl.text!]
             print(params)
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post("https://www.bensonboat.pofirentals.in/json/explore_experience", parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    
                    self.ExperienceArray.removeAllObjects()
                                   self.ExperienceTypesArray.removeAllObjects()
                                   self.ExperienceCategoriesArray.removeAllObjects()
                    self.ExperienceArray.addObjects(from: (responseDict.object(forKey: "experience_details")as! NSArray) as! [Any])
                    self.ExperienceTypesArray.addObjects(from: (responseDict.object(forKey: "experience_types")as! NSArray) as! [Any])
                    self.ExperienceCategoriesArray.addObjects(from: (responseDict.object(forKey: "experience_categories")as! NSArray) as! [Any])
                    print(self.ExperienceArray)
                    print(self.ExperienceTypesArray)
                    print(self.ExperienceCategoriesArray)
                    self.ExperienceTable.reloadData()
                    self.SelectTypeTable.reloadData()
                    self.CategoriesTable.reloadData()
                }
                    
                else {
                    self.EmptyView.isHidden = false
                   // self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
        }
    }
    
    @IBAction func DateSubmitAct(_ sender: Any) {
        
        self.fromDateStr = ""
        self.toDateStr = ""
        self.FromDateLbl.text = "From Date"
        self.toDateLbl.text = "To Date"
         self.EmptyView.isHidden = true
        self.GetExperienceDetails()
    }
    
    
    @IBAction func SelectTypeResetAct(_ sender: Any) {
        self.GaryView.isHidden = true
        self.SelectType.isHidden = true
        self.SelectedType.removeAllObjects()
        self.GetExperienceDetails()
        
    }
    
    @IBAction func SelectTypeCancelAct(_ sender: Any) {
        self.GaryView.isHidden = true
        self.SelectType.isHidden = true
   }
    
    @IBAction func SelectTypeOkAct(_ sender: Any) {
        self.GaryView.isHidden = true
        self.SelectType.isHidden = true
        var selectedTypeStr = String()
        
        
        selectedTypeStr = self.SelectedType.componentsJoined(by: ",")
        print(selectedTypeStr)
        
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","type_id":selectedTypeStr]
         print(params)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post("https://www.bensonboat.pofirentals.in/json/explore_experience", parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as! Int == 1 {
                
                self.ExperienceArray.removeAllObjects()
                self.ExperienceTypesArray.removeAllObjects()
                self.ExperienceCategoriesArray.removeAllObjects()
                self.ExperienceArray.addObjects(from: (responseDict.object(forKey: "experience_details")as! NSArray) as! [Any])
                self.ExperienceTypesArray.addObjects(from: (responseDict.object(forKey: "experience_types")as! NSArray) as! [Any])
                self.ExperienceCategoriesArray.addObjects(from: (responseDict.object(forKey: "experience_categories")as! NSArray) as! [Any])
                print(self.ExperienceArray)
                print(self.ExperienceTypesArray)
                print(self.ExperienceCategoriesArray)
                self.ExperienceTable.reloadData()
                self.SelectTypeTable.reloadData()
                self.CategoriesTable.reloadData()
            }
                
            else {
                self.EmptyView.isHidden = false
               // self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
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
extension ExperienceNowViewController : UITableViewDataSource,UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.ExperienceTable {
            return self.ExperienceArray.count + 1
        }else if tableView == self.SelectTypeTable{
            return self.ExperienceTypesArray.count
        }else{
            return self.ExperienceCategoriesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.ExperienceTable {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceNowTitleTableViewCell") as? ExperienceNowTitleTableViewCell
                cell!.selectionStyle = .none
                cell!.ExperienceName.font = UIFont(name: SemiBoldFont, size: 17)
                return cell!
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceNowTableViewCell") as? ExperienceNowTableViewCell
            cell!.selectionStyle = .none
            
            cell!.ExperienceTitle.font = UIFont(name: SemiBoldFont, size: 15)
            cell!.ExperiencePrice.font = UIFont(name: SemiBoldFont, size: 15)
            cell!.ExperienceRating.font = UIFont(name: SemiBoldFont, size: 10)
            
            
            let url = URL(string: (self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_image") as! String)
            cell!.ExperienceImg.kf.setImage(with: url)
            
            
            cell!.ExperienceTitle.text = (self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_name") as! String
            cell!.ExperienceRating.text = "\((self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_public_rating") as! AnyObject)"
            let CurrencySymbol = (self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "userCurSym") as! String
            cell!.ExperiencePrice.text = CurrencySymbol + " \((self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_price") as! AnyObject)"
            
            let Fav = "\((self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_favourite") as AnyObject)"
            
            if Fav == "1" {
                cell!.FavImg.image = UIImage(named: "like")
                
            }else{
                cell!.FavImg.image = UIImage(named: "unlike")
            }
            
            cell?.FavBtn.tag = indexPath.row-1
                   cell!.FavBtn.addTarget(self, action:#selector(favTapped), for: .touchUpInside)
            
            
            return cell!
            
        }else if tableView == self.SelectTypeTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceSelectTypeTableViewCell") as? ExperienceSelectTypeTableViewCell
            cell!.selectionStyle = .none
            cell!.SelectTypeLbl.font = UIFont(name: SemiBoldFont, size: 15)
            cell!.SelectTypeDescLbl.font = UIFont(name: SemiBoldFont, size: 13)
            
            let SelectedType = "\((self.ExperienceTypesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_id") as! AnyObject)"
            
            if self.SelectedType.contains(SelectedType) {
                cell!.SelectTypeImg.image = UIImage(named: "checkbox-2")
            }else{
                cell!.SelectTypeImg.image = UIImage(named: "unSelectBox")
                
            }
           cell!.SelectTypeLbl.text = (self.ExperienceTypesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_type_name") as! String
            cell!.SelectTypeDescLbl.text = (self.ExperienceTypesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_type_subname") as! String
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as? CategoriesTableViewCell
            cell!.selectionStyle = .none
            cell!.CategoriesLbl.text = (self.ExperienceCategoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_category_name") as! String
            cell!.CategoriesLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell!.CategoriesLbl.textColor = .darkGray
            let categoryType = "\((self.ExperienceCategoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_category_id") as! AnyObject)"
            
            if self.SelectedCategoriesType.contains(categoryType) {
                cell!.CategoriesImg.image = UIImage(named: "checkbox-2")
            }else{
                cell!.CategoriesImg.image = UIImage(named: "unSelectBox")
                
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.ExperienceTable {
            
            let searchVC = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceDetailViewController") as? ExperienceDetailViewController
            searchVC!.expId =  "\((self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "exp_id") as! AnyObject)"
            searchVC!.CurrencyCornId = "\((self.ExperienceArray.object(at: indexPath.row-1) as! NSDictionary).object(forKey: "currency_code") as! AnyObject)"
                           
                          self.navigationController?.pushViewController(searchVC!, animated: true)
            
        }else if tableView == self.SelectTypeTable {
            let SelectedType = "\((self.ExperienceTypesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_id") as! AnyObject)"
            if self.SelectedType.contains(SelectedType) {
                self.SelectedType.remove(SelectedType)
            }else {
                self.SelectedType.add(SelectedType)
            }
            
            self.SelectTypeTable.reloadData()
            
        }else{
            let SelectedType = "\((self.ExperienceCategoriesArray.object(at: indexPath.row) as! NSDictionary).object(forKey: "exp_category_id") as! AnyObject)"
            if self.SelectedCategoriesType.contains(SelectedType) {
                self.SelectedCategoriesType.remove(SelectedType)
            }else {
                self.SelectedCategoriesType.add(SelectedType)
            }
            self.CategoriesTable.reloadData()
        }
        
    }
}
extension ExperienceNowViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
   func numberOfSections(in collectionView: UICollectionView) -> Int
   {
       return 1
   }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if Singleton.sharedInstance.wishListModel != nil
       {
           return Singleton.sharedInstance.wishListModel.wishlist.count
       }
       else
       {
           return 0
       }
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
       cell.lbl_WishlistName.text = Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistTitle!
         cell.lbl_WishlistName.font = UIFont(name: SemiBoldFont, size: 13)
       cell.lbl_wishlistcount.font = UIFont(name: SemiBoldFont, size: 13)
       let wishlistImgUrl = URL(string: Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistImage!)
       if wishlistImgUrl != nil {
           
           cell.img_Wishlist.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "testImage.jpg"), options: nil, progressBlock: nil, completionHandler: nil)
       }
       return cell
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
   {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wcell", for: indexPath as IndexPath) as! WishlistCollectionViewCell
      // selectedItem = indexPath.row
       self.wishListId = Int(Singleton.sharedInstance.wishListModel.wishlist[indexPath.row].wishlistId)
       AddWishList()
       self.viewBottom.isHidden = true
       self.GaryView.isHidden = true
       self.collectnviewWishlist.reloadData()
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
   {
       return 20
   }
}
