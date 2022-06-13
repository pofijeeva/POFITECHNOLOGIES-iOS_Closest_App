//
//  ExperienceListingBundleViewController.swift
//  HomeStay
//
//  Created by Gopi Sunkara on 22/12/20.
//  Copyright © 2020 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
protocol CommonListingSaveDelegate
{
    func ActasCommonSave()
}
class ExperienceListingBundleViewController: UIViewController {

       var window: UIWindow?
      var backAct : String = ""
    var currentIndexPath = IndexPath()
     var ListingActivityDelegate: listingActivityProtocol?
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var StepsCollection: UITableView!
    @IBOutlet weak var StepsView: UIView!
    @IBOutlet weak var ParentView: UIView!
    
    
    //MARK:- Variables
       var container: UIView = UIView()
       var loadingView: UIView = UIView()
       var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
     var delegate : CommonListingSaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedsaveInstance = self
 self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
         AddCalender()
    }
    
    func AddCalender(){
           let childViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceBasicViewController") as? ExperienceBasicViewController
           //self.isCalenderSelected = true
           childViewController?.ListingActivityDelegate = self
          
         //  childViewController?.PropertyID = Singleton.sharedInstance.rentYourSpace.propertyid
          // self.PropertyId  = Singleton.sharedInstance.rentYourSpace.propertyid
           childViewController?.view.frame = self.ParentView.bounds
           add(childViewController!, parent: self)
           self.StepsCollection.reloadData()
           self.ListingActivityDelegate?.hideActivity()
           
       }
    //MARK:- Button Actions
       
       @IBAction func act_Back(_ sender: UIButton) {
           
           
           if self.backAct == "PropertyListing" {
               self.navigationController?.popViewController(animated: true)
           }else{
               self.window = UIWindow(frame: UIScreen.main.bounds)
               let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
               
               self.window?.rootViewController = mainViewController
               
               self.window?.makeKeyAndVisible()
           }
       }
    @IBAction func act_Save(_ sender: UIButton)
      {
         delegate?.ActasCommonSave()
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
extension ExperienceListingBundleViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return self.BasicsArray.count
//        case 1:
//            return self.descriptionArray.count
//        case 2:
//            return self.settingArray.count
//        default:
//            return 0
//        }
        return 17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell") as? ExperienceTableViewCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperienceTableViewCell") as? ExperienceTableViewCell
        cell.NameLbl.font = UIFont(name: RegularFont, size: 14)
        
        if  self.currentIndexPath == indexPath {
            cell.backgroundColor = UIColor.white
            cell.NameLbl.textColor = .red
        } else {
            cell.backgroundColor = UIColor.lightGray
            cell.NameLbl.textColor = .black
        }
       
        
        cell.NameLbl.text = "\(indexPath.row)."
      
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = UIView(frame: CGRect(x: 5, y: 0, width: tableView.bounds.width, height: 50))
//        let label = UILabel(frame: CGRect(x: 5, y: -5, width: tableView.bounds.width, height: 40))
//        headerView.backgroundColor = UIColor.white
//        label.textColor = UIColor.black
//        label.text = self.ListingSection[section] as? String
//        label.font = UIFont(name:"HelveticaNeue-Bold", size: 12.0)
//
//        if canHideTable == false {
//            label.isHidden = false
//        } else {
//            label.isHidden = true
//        }
//        headerView.addSubview(label)
//        return headerView
//    }
//
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var childViewController: UIViewController?
        self.currentIndexPath = indexPath
//        isCalenderSelected = false

        if indexPath.row == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceBasicViewController") as? ExperienceBasicViewController
                          childViewController = vc
                          vc!.ListingActivityDelegate = self
        }else if indexPath.row == 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceLanguageViewController") as? ExperienceLanguageViewController
                          childViewController = vc
                          vc!.ListingActivityDelegate = self
                         
        }else if indexPath.row == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceOrganizationViewController") as? ExperienceOrganizationViewController
                          childViewController = vc
                          vc!.ListingActivityDelegate = self
                         
        }
        else if indexPath.row == 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceTitleViewController") as? ExperienceTitleViewController
                          childViewController = vc
                          vc!.ListingActivityDelegate = self
                         
        } else if indexPath.row == 4{
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "ExperienceScheduleViewController") as? ExperienceScheduleViewController
                                 childViewController = vc
                                 vc!.ListingActivityDelegate = self
                                
               }
              
  self.StepsCollection.reloadData()
        add(childViewController!,parent: self)
        childViewController?.view.frame = self.ParentView.bounds
    }
}
extension ExperienceListingBundleViewController: listingActivityProtocol {
    
    func showActivity() {
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColorFromHex(rgbValue:0xffffff, alpha: 0.3)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
extension UIViewController {
    func add(_ child: UIViewController,parent: ExperienceListingBundleViewController) {
        addChild(child)
        parent.ParentView.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChild(parentCon: ExperienceListingBundleViewController) {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        parentCon.ParentView.removeFromSuperview()
    }
}
