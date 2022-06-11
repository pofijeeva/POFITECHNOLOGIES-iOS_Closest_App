//
//  ExperienceDetailViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 04/02/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit


class ExperienceDetailViewController: BaseViewController {
    
    
     @IBOutlet weak var ChooseTableHeight: NSLayoutConstraint!
     @IBOutlet weak var ExperienceDetailTable: UITableView!
    @IBOutlet weak var ChooseTimeTable: UITableView!
    @IBOutlet weak var ChooseTimeView: UIView!
    @IBOutlet weak var ChooseTimeLbl: UILabel!
    
    @IBOutlet weak var DescLbl: UILabel!
    @IBOutlet weak var PersonsLbl: UILabel!
    @IBOutlet weak var SlotsLbl: UILabel!
    
    @IBOutlet weak var SlotsTableView: UIView!

    @IBOutlet weak var SlotsEmptyView: UIView!
    @IBOutlet weak var EmptyDescLbl: UILabel!
    @IBOutlet weak var EmptysubDescLbl: UILabel!


    
    var expId : String = ""
    var DateId : String = ""
    var exp_host_id : String = ""
    
      let newPin = MKPointAnnotation()
     var ExpListingSteps : NSMutableArray = []
     var ExpListingStepsImges : NSMutableArray = []
     var ExpListingStepsSlide : NSMutableArray = []
    
    var ExperienceHistory : NSMutableArray = []
     var ExperienceHistoryDict = NSMutableDictionary()
    var KnownLanguages : NSMutableArray = []
    var ChooseTimeArray : NSMutableArray = []
    var CurrencyCornId : String = ""
   
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChooseTimeLbl.font = UIFont(name: SemiBoldFont, size: 17)
        self.ExpListingStepsSlide = ["Group Size","Group Requirements"]
        self.ExpListingSteps = ["Offered Languages in","What We Will Do","What I Will Provide","Note To Guest","Where We Will be"]
        self.ExpListingStepsImges = ["Image-22","Image-17","Image-21","Image-20","Image-18"]
        self.GetExperienceDetails()
        self.ChooseTimeView.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.ChooseTimeView.isHidden = true
    }
    
    func GetExperienceDetails(){
        self.showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        
        params = ["user_id": login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","lang_code":login_session.value(forKey: "APP_LANGUAGE") as? String ?? "en","exp_id":self.expId]
         
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
        
        manager.post("https://www.bensonboat.pofirentals.in//json/view_experience_details", parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
            DispatchQueue.main.async {
                
            }
            let responseDict:NSDictionary = responseObject as! NSDictionary
            print(responseDict)
            self.hideActivityIndicator(uiView: self.view)
            if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                self.ExperienceHistory.removeAllObjects()
                self.ExperienceHistoryDict.removeAllObjects()
                self.ChooseTimeArray.removeAllObjects()
                self.ExperienceHistoryDict.addEntries(from: responseDict as! [AnyHashable: Any])
              
                print("ExperienceHistoryDict",self.ExperienceHistoryDict)
                self.ExperienceHistory.addObjects(from: (responseDict.object(forKey: "experience_details") as? NSArray) as? [Any] ?? [])
                
                
                self.exp_host_id = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_host_id") as AnyObject)"
                self.KnownLanguages.removeAllObjects()
                let languagesArray = self.ExperienceHistoryDict.object(forKey: "Known_languages") as! NSArray
                
                for i in 0..<languagesArray.count {
                    let name = (languagesArray.object(at: i) as? NSDictionary)?.object(forKey: "known_language") as? String ?? ""
                    self.KnownLanguages.add(name)
                }
                
                self.ChooseTimeArray.addObjects(from: (responseDict.object(forKey: "experience_schedules") as? NSArray) as? [Any] ?? [])
                print(self.KnownLanguages)
                self.ExperienceDetailTable.reloadData()
                self.ChooseTimeTable.reloadData()
                
               
                
            }
                
            else {
                self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
            }
        }, failure: { (operation, error) -> Void in
            DispatchQueue.main.async {
                
            }
            print(error)
            self.showInformation(title: "Closest", message: error.localizedDescription)
        })
        
    }
    
    
    @IBAction func CloseChooseView(_ sender: Any) {
        self.ChooseTimeView.isHidden = true
    }
    
    @objc func BackAct(sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func favTapped(sender: UIButton)
    {
        
        let AvailableSlots = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "availableslots") as AnyObject
         
        if "\(AvailableSlots)" == "0" {
            self.EmptyDescLbl.font = UIFont(name: SemiBoldFont, size: 18)
            self.EmptysubDescLbl.font = UIFont(name: SemiBoldFont, size: 15)
            
            self.ChooseTimeView.isHidden = false
            self.SlotsTableView.isHidden = true
            self.SlotsEmptyView.isHidden = false
            
        }else{
            self.PersonsLbl.font = UIFont(name: SemiBoldFont, size: 14)
            self.SlotsLbl.font = UIFont(name: SemiBoldFont, size: 14)
            self.DescLbl.font = UIFont(name: SemiBoldFont, size: 14)
            
            self.PersonsLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "userCurSym") as? String ?? "") \((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_price") as AnyObject) per person"
            
            self.SlotsLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "availableslots") as AnyObject) slots available"
            
            
            let userId = login_session.value(forKey: "UserId") as? AnyObject
            let hostId = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_host_id") as AnyObject
            let HostIDVerified = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "hostid_verified") as? String ?? ""
            
            if String(describing: userId!) == String(describing: hostId) {
                self.showInformation(title: "Closest", message: " You are not able to book your own Experience")
            }else if HostIDVerified != "VERIFIED" {
                self.showInformation(title: "Closest", message: "Host is not verified yest ..!")
            }
            else {
                self.ChooseTimeView.isHidden = false
                self.SlotsTableView.isHidden = false
                self.SlotsEmptyView.isHidden = true
                if self.ChooseTimeArray.count == 0 {
                    self.showInformation(title: "Closest", message: "There is no available time slot for this experience to book")
                    self.ChooseTimeView.isHidden = true
                    self.SlotsTableView.isHidden = true

                }
                else if self.ChooseTimeArray.count == 1 {
                    self.ChooseTableHeight.constant = 250
                }else if self.ChooseTimeArray.count == 2{
                    self.ChooseTableHeight.constant = 300
                }else if self.ChooseTimeArray.count == 3 {
                    self.ChooseTableHeight.constant = 350
                }else{
                    self.ChooseTableHeight.constant = 400
                }
                
            }
        }
        
        

        
      
    }
    
    
   
    
    @objc func ChooseAct(sender: UIButton)
    {
        let id = sender.tag
        
        self.DateId = "\((self.ChooseTimeArray.object(at: id) as? NSDictionary)?.object(forKey: "date_id") as! AnyObject)"
        
        
        let BookingVC = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceBookingViewController") as! ExperienceBookingViewController
        BookingVC.DateId = self.DateId
        BookingVC.expId = self.expId
        BookingVC.exp_host_id = self.exp_host_id
        BookingVC.CurrencyCornId = self.CurrencyCornId
        
        self.navigationController?.pushViewController(BookingVC, animated: true)
        
       
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
extension ExperienceDetailViewController : UITableViewDataSource,UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        if tableView == ExperienceDetailTable {
            if self.ExperienceHistory.count == 0 {
                return 0
            }else{
                return 5
            }
        }else{
            return 1
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == ExperienceDetailTable {
        if section == 0 {
            return 2
        }else if section == 1{
            return 5
        }else if section == 2{
            return 2
        }else if section == 3{
            return 2
            
        }else{
            return 6
        }
        }else{
            return self.ChooseTimeArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == ExperienceDetailTable {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceDetailImageTableViewCell") as? ExperienceDetailImageTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceDetailImageTableViewCell") as? ExperienceDetailImageTableViewCell
                cell.selectionStyle = .none
                cell.ExperiencePrice.font = UIFont(name: SemiBoldFont, size: 17)
                cell.ExperienceTitle.font = UIFont(name: SemiBoldFont, size: 16)
                cell.ExperienceLocation.font = UIFont(name: SemiBoldFont, size: 15)
                cell.ExperienceViewed.font = UIFont(name: SemiBoldFont, size: 14)
                cell.ExperienceHr.font = UIFont(name: SemiBoldFont, size: 13)
                cell.ExperienceRating.font = UIFont(name: SemiBoldFont, size: 13)
                
                
                let CurrencySym = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "userCurSym") as? String ?? ""
                cell.ExperiencePrice.text = CurrencySym + "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_price") as AnyObject) per person"
                cell.ExperienceTitle.text = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_title") as? String ?? ""
                 cell.ExperienceLocation.text = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_city") as? String ?? ""
                 cell.ExperienceViewed.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "page_view_count") as! AnyObject) People have viewed it"
                
                cell.ExperienceRating.text = ""//"\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "") as? String ?? "")"
                
                cell.ExperienceHr.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_totalhours") as? String ?? "") hr"
                
                let wishlistImgUrl = URL(string: (((self.ExperienceHistoryDict.object(forKey: "experience_photos") as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "exp_imagesurl") as? String ?? ""))
                if wishlistImgUrl != nil {
                    
                    cell.ExperienceImg.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "test"), options: nil, progressBlock: nil, completionHandler: nil)
                }
                
                cell.BackBtn.addTarget(self, action:#selector(BackAct), for: .touchUpInside)
                
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTagTableViewCell") as? ExperienceTagTableViewCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTagTableViewCell") as? ExperienceTagTableViewCell
            cell.selectionStyle = .none
            cell.TagLbl.text = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "about_host") as? String ?? ""
            cell.TypeLbl.text = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_type") as? String ?? ""
            
           cell.TagLbl.font = UIFont(name: SemiBoldFont, size: 13)
            cell.TypeLbl.font = UIFont(name: SemiBoldFont, size: 14)
  
            return cell
            
        }else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepsTableViewCell") as? ExperienceStepsTableViewCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepsTableViewCell") as? ExperienceStepsTableViewCell
            
            cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
            cell.StepDescLbl.font = UIFont(name: SemiBoldFont, size: 13)
            
            cell.StepNameLbl.text = self.ExpListingSteps.object(at: indexPath.row) as? String
            let Image = self.ExpListingStepsImges.object(at: indexPath.row) as? String
            cell.StepImg.image = UIImage(named:Image!)
            cell.selectionStyle = .none
            
            let LangStr = self.KnownLanguages.componentsJoined(by: ",")
            
            if indexPath.row == 0{
                cell.StepDescLbl.text = LangStr
            }else if indexPath.row == 1{
                cell.StepDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_description") as! AnyObject)"
            }else if indexPath.row == 2{
                cell.StepDescLbl.text = "Detail"//"\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_description") as! AnyObject)"
            }else if indexPath.row == 3{
                cell.StepDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "notetoguest") as! AnyObject)"
            }else {
                cell.StepDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "location_description") as! AnyObject)"
            }
           
            return cell
        }else if indexPath.section == 2{
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell
            cell.selectionStyle = .none
            cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
            cell.StepNameDescLbl.font = UIFont(name: SemiBoldFont, size: 13)
              cell.StepNameLbl.text = self.ExpListingStepsSlide.object(at: indexPath.row) as? String
            if indexPath.row == 0{
                cell.StepNameDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "group_size") as! AnyObject) per experience schedule"
            }else{
                cell.StepNameDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "guest_requirement") as! AnyObject)"
            }
            
            return cell
        }else if indexPath.section == 3 {
            if indexPath.row == 0 {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell
                           cell.selectionStyle = .none
                             cell.StepNameLbl.text = "Review"
                cell.StepNameLbl.textColor = AppColor
                cell.StepNameLbl.textAlignment = .left
                cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                           return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell else { return UITableViewCell() }

//            let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell
            cell.selectionStyle = .none
              cell.StepNameLbl.text = "No reviews available"
            
            cell.StepNameLbl.textColor = AppSecondColor
            cell.StepNameLbl.textAlignment = .center
            cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 14)
            
            return cell
            
        }else{
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell
                           cell.selectionStyle = .none
                cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell.StepNameDescLbl.font = UIFont(name: SemiBoldFont, size: 13)
                             cell.StepNameLbl.text = "Cancellation Policy : "
                cell.StepNameDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "cancel_policy") as! AnyObject)"
                           return cell
            }else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepSlideTableViewCell") as? ExperienceStepSlideTableViewCell
                                          cell.selectionStyle = .none
                cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell.StepNameDescLbl.font = UIFont(name: SemiBoldFont, size: 13)
                                            cell.StepNameLbl.text = "Cancellation Percentage : "
                cell.StepNameDescLbl.text = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "cancel_percentage") as! AnyObject)%"
                  return cell
                
            }else if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell
                           cell.selectionStyle = .none
                cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                cell.StepNameLbl.textColor = AppColor
                cell.StepNameLbl.textAlignment = .left
                             cell.StepNameLbl.text = "Location :"
                           return cell
                
            }else if indexPath.row == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailMapTableViewCell") as? ProductDetailMapTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailMapTableViewCell") as? ProductDetailMapTableViewCell
                               cell.selectionStyle = .none
                let lat = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_lat") as AnyObject)"
                let long = "\((self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_lang") as AnyObject)"
                let center = CLLocationCoordinate2D(latitude: Double(lat)! , longitude: Double(long)!)
                                      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                               cell.mapLocation.setRegion(region, animated: true)
                                      newPin.coordinate =  center
                               cell.mapLocation.addAnnotation(newPin)
                               
                               return cell
            }else if indexPath.row == 4 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceStepTitleTableViewCell") as? ExperienceStepTitleTableViewCell
                           cell.selectionStyle = .none
                cell.StepNameLbl.font = UIFont(name: SemiBoldFont, size: 16)
                             cell.StepNameLbl.text = "Host"
                cell.StepNameLbl.textColor = AppColor
                cell.StepNameLbl.textAlignment = .left
                           return cell
                
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceHostBookTableViewCell") as? ExperienceHostBookTableViewCell else { return UITableViewCell() }

//                let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceHostBookTableViewCell") as? ExperienceHostBookTableViewCell
                                          cell.selectionStyle = .none
                cell.HostText.font = UIFont(name: SemiBoldFont, size: 14)
                cell.HostName.font = UIFont(name: SemiBoldFont, size: 14)
                cell.BookBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 17)
                
                cell.HostName.text = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "firstname") as? String ?? ""
                
                let wishlistImgUrl = URL(string: (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "host_imgurl") as? String ?? "")
                if wishlistImgUrl != nil {
                    
                    cell.HostImg.kf.setImage(with: wishlistImgUrl, placeholder: UIImage.init(named: "user"), options: nil, progressBlock: nil, completionHandler: nil)
                }
                let userId = login_session.value(forKey: "UserId") as? AnyObject
                let hostId = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "exp_host_id") as AnyObject
                let HostIDVerified = (self.ExperienceHistory.object(at: 0) as? NSDictionary)?.object(forKey: "hostid_verified") as? String ?? ""
                
                if String(describing: userId!) == String(describing: hostId) {
                    cell.BookBtn.isHidden = true
                }else if HostIDVerified != "VERIFIED" {
                    cell.BookBtn.isHidden = true
                }else{
                    cell.BookBtn.isHidden = false

                }
                
                cell.BookBtn.tag = indexPath.row
                       cell.BookBtn.addTarget(self, action:#selector(favTapped), for: .touchUpInside)
                                          return cell
            }
            
        }
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseTimeTableViewCell") as? ChooseTimeTableViewCell else { return UITableViewCell() }
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseTimeTableViewCell") as? ChooseTimeTableViewCell
            cell.NameLbl.font = UIFont(name: SemiBoldFont, size: 15)
            cell.DateLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.TimeLbl.font = UIFont(name: SemiBoldFont, size: 14)
            cell.ChooseBtn.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 15)
            
            
            cell.NameLbl.text = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_title") as? String ?? ""
            cell.DateLbl.text = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_schedule_date") as? String ?? ""
            
            let StartTime = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_start_time") as? String ?? ""
                let EndTime = (self.ChooseTimeArray.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "exp_end_time") as? String ?? ""
            cell.TimeLbl.text = StartTime + " - " + EndTime
            
            cell.ChooseBtn.tag = indexPath.row
                   cell.ChooseBtn.addTarget(self, action:#selector(ChooseAct), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
