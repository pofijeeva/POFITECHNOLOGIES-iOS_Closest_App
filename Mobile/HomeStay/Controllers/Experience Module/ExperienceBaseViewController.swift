//
//  ExperienceBaseViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 11/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking


//protocol CommonCallNavigateDelegate
//{
//    func commonCall()
//}
class ExperienceBaseViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var viewNavigationTitle: UIView!
    @IBOutlet weak var labelStepsRemaining: UILabel!
    @IBOutlet weak var collectionViewTop: UICollectionView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var labelnavigationTitle: UILabel!
    
    var arrayOfMenus = [[String:AnyObject]]()
//    var delegatee : CommonCallNavigateDelegate?
    var ListingActivityDelegate: listingActivityProtocol?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedInstanceExperience = self
        self.getBaseDetails()
        self.arrayOfMenus = [
            ["selected":"0","name":" BASIC "],
            ["selected":"0","name":" LANGUAGE "],
            ["selected":"0","name":" ORGANISATION "],
            ["selected":"0","name":" TITLE "],
            ["selected":"0","name":" TIMING "],
            ["selected":"0","name":" TAG LINE "],
            ["selected":"0","name":" PHOTOS "],
            ["selected":"0","name":"  WHAT WE WILL DO  "],
            ["selected":"0","name":" WHERE TO GO? "],
            ["selected":"0","name":"  WHERE WE WILL BE  "],
            ["selected":"0","name":" WHAT WE WILL PROVIDE "],
            ["selected":"0","name":" NOTE "],
            ["selected":"0","name":" ABOUT YOU "],
            ["selected":"0","name":" REQUIREMENT "],
            ["selected":"0","name":" GROUP SIZE "],
            ["selected":"0","name":" PRICE "],
            ["selected":"0","name":" POLICY "]
                              ] as [[String:AnyObject]]
        arrayOfHeadings = ["Basics","Languages","Organization","Experience_Title","Timing","Tagline","Photos","What_you_will_do","where_you_will_be","where_we_will_meet","what_you_will_provide","notes","about_you","guest_reqirement","group_size","price","cancellation_policy"]
       
     //   arrayOfHeadings = ["Basics","Languages","Organization","Experience_Title","Timing","Tagline","Photos","What_you_will_do","where_you_will_be","where_we_will_meet","what_you_will_provide","notes","about_you","guest_reqirement","group_size","price","cancellation_policy"]
       
        self.labelnavigationTitle.font = UIFont(name: RegularFont, size: 20.0)
        self.labelStepsRemaining.font = UIFont(name: RegularFont, size: 12.0)
        
        self.buttonBack.addTarget(self, action: #selector(updateBackNavigation), for: .touchUpInside)
        let VC = storyBoardExperience.instantiateViewController(withIdentifier: "BasicExperienceViewController") as! BasicExperienceViewController
        self.addChildViewController(VC)
        VC.view.frame = self.parentView.bounds
        self.parentView.addSubview(VC.view)
        self.didMove(toParentViewController: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrayOfMenus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellList", for: indexPath)
        let titleLbl = cell.viewWithTag(10) as! UILabel
        titleLbl.font = UIFont(name: RegularFont, size: 15)
        let dict = self.arrayOfMenus[indexPath.row]
        titleLbl.text = (dict["name"] as? String ?? "")
        titleLbl.layer.masksToBounds = true
        titleLbl.layer.cornerRadius = 17.5
        let imageBottom = cell.viewWithTag(11) as! UIImageView
        imageBottom.backgroundColor = AppSecondColor
        imageBottom.addDiamondMask()
        
        
//        if arrayOfdictBasics.count > 0 {
//            let array = arrayOfdictBasics[0] as! NSDictionary
//            print(array.allKeys)
//            print(array.allValues)
//
//            let checkDict = NSMutableDictionary()
            
//            for i in 0..<array.count{
//
//                let KeyName = array.k
//                let KeyName = array.allKeys(for: i)
//
//            }
//
            
            
//            let arrayTwo = array.object(forKey: <#T##Any#>).object(at: indexPath.row) as! NSDictionary
//            if arrayTwo.object(forKey: "step_completed") as? String ?? "" == "true" {
//                if BaseSelectedIndex == indexPath.row {
//                    titleLbl.backgroundColor = AppSecondColor
//                    titleLbl.textColor = .white
//                    imageBottom.isHidden = false
//                }
//                else {
//                    titleLbl.backgroundColor = AppSecondColor
//                    titleLbl.textColor = .white
//                    imageBottom.isHidden = true
//                }
//            }
//            else {
//                imageBottom.isHidden = true
//                titleLbl.textColor = .black
//                titleLbl.backgroundColor = UIColor(hex: 0xF1F1F1)
//            }
//        }
//        else {
//            if indexPath.row == 0 {
//                titleLbl.backgroundColor = AppSecondColor
//                titleLbl.textColor = .white
//                imageBottom.isHidden = false
//            }
//            else {
//                imageBottom.isHidden = true
//                titleLbl.textColor = .black
//                titleLbl.backgroundColor = UIColor(hex: 0xF1F1F1)
//            }
//        }
        if arrayOfBoolValues.count > 0 {
            if arrayOfBoolValues[indexPath.row] as? String ?? "" == "true" {
                titleLbl.backgroundColor = AppSecondColor
                titleLbl.textColor = .white
                imageBottom.isHidden = true
            }
            else {
                if BaseSelectedIndex == indexPath.row {
                    titleLbl.backgroundColor = AppSecondColor
                    titleLbl.textColor = .white
                    imageBottom.isHidden = false
                }
                else {
                    imageBottom.isHidden = true
                    titleLbl.textColor = .black
                    titleLbl.backgroundColor = UIColor(hex: 0xF1F1F1)
                }
            }
        }
        else {
            if indexPath.row == 0 {
                titleLbl.backgroundColor = AppSecondColor
                titleLbl.textColor = .white
                imageBottom.isHidden = false
            }
            else {
                imageBottom.isHidden = true
                titleLbl.textColor = .black
                titleLbl.backgroundColor = UIColor(hex: 0xF1F1F1)
            }
        }
        
        
//        if BaseSelectedIndex == indexPath.row {
//            titleLbl.backgroundColor = AppSecondColor
//            titleLbl.textColor = .white
//            imageBottom.isHidden = false
//        }
//        else {
//            if dict["selected"] as? String ?? "" == "1" {
//                titleLbl.backgroundColor = AppSecondColor
//                titleLbl.textColor = .white
//                imageBottom.isHidden = true
//            }
//            else {
//                imageBottom.isHidden = true
//                titleLbl.textColor = .black
//                titleLbl.backgroundColor = UIColor(hex: 0xF1F1F1)
//            }
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel(frame: CGRect.zero)
        let dict = self.arrayOfMenus[indexPath.row]
        lbl.text = (dict["name"] as? String ?? "")
        lbl.sizeToFit()
        //let width = lbl.text?.width(withConstrainedHeight: 40.0, font: UIFont(name: RegularFont, size: 12.0)!)
        return CGSize(width: 130, height: 48.0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if arrayOfdictBasics.count > 0 {
        //            let array = arrayOfdictBasics[0] as! NSMutableArray
        //            let arrayTwo = array.object(at: indexPath.row) as! NSDictionary
        //            if arrayTwo.object(forKey: "step_completed") as? String ?? "" == "true" {
        if arrayOfBoolValues.count > 0 {
            if arrayOfBoolValues[indexPath.row] as? String ?? "" == "true" || BaseSelectedIndex == indexPath.row {
                //                if BaseSelectedIndex != indexPath.row {
                BaseSelectedIndex = indexPath.row
                switch indexPath.row {
                case 0:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "BasicExperienceViewController") as! BasicExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 1:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "LanguagesExperienceViewController") as! LanguagesExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 2:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "OrganizationExperienceViewController") as! OrganizationExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 3:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "TitleExperienceViewController") as! TitleExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 4:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "AddScheduleExperienceViewController") as! AddScheduleExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 5:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "TagLineExperienceViewController") as! TagLineExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 6:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "AddPhotosExperienceViewController") as! AddPhotosExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                    
                case 7:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "WhatAndWhereViewController") as! WhatAndWhereViewController
                    VC.isWhatOrWhere = "what"
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 8:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "WhatAndWhereViewController") as! WhatAndWhereViewController
                    VC.isWhatOrWhere = "where"
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 9:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "AddAddressExperienceViewController") as! AddAddressExperienceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 10:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceProvideViewController") as! ExperienceProvideViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 11:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddNotesViewController") as! ExperienceAddNotesViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 12:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddBioViewController") as! ExperienceAddBioViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 13:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceRequirementsViewController") as! ExperienceRequirementsViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 14:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceGroupSizeViewController") as! ExperienceGroupSizeViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 15:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddPriceViewController") as! ExperienceAddPriceViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                case 16:
                    let VC = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceCancellationViewController") as! ExperienceCancellationViewController
                    self.addChildViewController(VC)
                    VC.view.frame = self.parentView.bounds
                    self.parentView.addSubview(VC.view)
                    self.didMove(toParentViewController: self)
                    break;
                default:
                    print("default case in didselect")
                }
                self.getBaseDetailsWithoutLoader()
                self.reloadCollectionView()
                self.updateStepsRemaining(index: indexPath.row)
                //                }
            }
        }
    }
    
    func reloadCollectionView() {
        self.collectionViewTop.reloadData()
    }
    
    
//    MARK: Fucntions and OBJ-C
    
    @objc func updateBackNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getBaseDetails() {
        if Helper.sharedInstance.isConnectedToInternet() {
          //  Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id": currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",ExperienceBaseDetails)
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    dictOfExperience = responseDict
                    arrayOfCurrency.removeAllObjects()
                    arrayOfCurrency.addObjects(from: (dictOfExperience["Currency"] as? NSArray) as? [Any] ?? [])
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    arrayOfResult = dictOfExperience["result"] as! NSArray
                    arrayOfBoolValues.removeAllObjects()
                    for i in 0..<arrayOfHeadings.count {
                        let str = ((arrayOfResult[0] as? NSDictionary)?.value(forKey:  arrayOfHeadings[i] as? String ?? "") as? NSDictionary)?.object(forKey: "step_completed") as AnyObject
                        arrayOfBoolValues.add("\(str)")
                    }
                 TimingsArray = (((dictOfExperience["result"] as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Timing") as? NSDictionary)?.object(forKey: "schedules") as! NSArray
                    let emptyArray = NSArray()
                    arrayOfResult = emptyArray
                    self.collectionViewTop.reloadData()
                }
                else {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                //    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) in
                print(error)
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })

        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    func getBaseDetailsWithoutLoader() {
        if Helper.sharedInstance.isConnectedToInternet() {
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as? String ?? "","device_type":"ios","exp_id":currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",ExperienceBaseDetails)
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as? Int ?? 0 == 1 {
                    dictOfExperience = responseDict
                    arrayOfResult = dictOfExperience["result"] as! NSArray
                    arrayOfCurrency.removeAllObjects()
                    arrayOfCurrency.addObjects(from: (dictOfExperience["Currency"] as? NSArray) as? [Any] ?? [])
                    arrayOfBoolValues.removeAllObjects()
                    for i in 0..<arrayOfHeadings.count {
                        let str = ((arrayOfResult[0] as? NSDictionary)?.value(forKey:  arrayOfHeadings[i] as? String ?? "") as? NSDictionary)?.object(forKey: "step_completed") as AnyObject
                        arrayOfBoolValues.add("\(str)")
                    }
                    TimingsArray = (((dictOfExperience["result"] as! NSArray).object(at: 0) as? NSDictionary)?.object(forKey: "Timing") as? NSDictionary)?.object(forKey: "schedules") as! NSArray
                    arrayOfResult = dictOfExperience["result"] as! NSArray
                    self.collectionViewTop.reloadData()
                    
                }
            }, failure: { (operation, error) in
                print(error)
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
        }
        else {
            self.showInformation(title: "Closest", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    public func gotoStepOne() {
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "OrganizationExperienceViewController") as? OrganizationExperienceViewController
        childViewController?.view.frame = self.parentView.bounds
        addChildViewController(childViewController!)
    }
    
    public func gotoStepTwo() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "LanguagesExperienceViewController") as! LanguagesExperienceViewController
        self.addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
//        var dict = self.arrayOfMenus[0]
//        dict["selected"] = "1" as AnyObject
//        self.arrayOfMenus[0] = dict
        BaseSelectedIndex = 1
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 1)
    }
    public func gotoStepThree() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "OrganizationExperienceViewController") as! OrganizationExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
//        var dict = self.arrayOfMenus[1]
//        dict["selected"] = "1" as AnyObject
//        self.arrayOfMenus[1] = dict
        BaseSelectedIndex = 2
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 2, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 2)
    }
    public func gotoStepfour() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "TitleExperienceViewController") as! TitleExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
//        var dict = self.arrayOfMenus[2]
//        dict["selected"] = "1" as AnyObject
//        self.arrayOfMenus[2] = dict
        BaseSelectedIndex = 3
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 3, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 3)
    }
    public func gotoStepfive() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "AddScheduleExperienceViewController") as! AddScheduleExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
//        var dict = self.arrayOfMenus[3]
//        dict["selected"] = "1" as AnyObject
//        self.arrayOfMenus[3] = dict
        BaseSelectedIndex = 4
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 4, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 4)
    }
    public func gotoStepSix() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "TagLineExperienceViewController") as! TagLineExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 5
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 5, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 5)

    }
    public func gotoStepSeven() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "AddPhotosExperienceViewController") as! AddPhotosExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 6
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 6, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 6)
    }
    public func gotoStepEight() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "WhatAndWhereViewController") as! WhatAndWhereViewController
        childViewController.isWhatOrWhere = "what"
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 7
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 7, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 7)
    }
    public func gotoStepNine() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "WhatAndWhereViewController") as! WhatAndWhereViewController
        childViewController.isWhatOrWhere = "where"
        childViewController.view.frame = self.parentView.bounds
        addChildViewController(childViewController)
        BaseSelectedIndex = 8
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 8, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 8)
    }
    public func gotoStepTen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "AddAddressExperienceViewController") as! AddAddressExperienceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 9
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 9, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 9)
    }
    public func gotoStepEleven() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceProvideViewController") as! ExperienceProvideViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 10
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 10, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 10)
    }
    public func gotoStepTwelve() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddNotesViewController") as! ExperienceAddNotesViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 11
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 11, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 11)
    }
    public func gotoStepThirteen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddBioViewController") as! ExperienceAddBioViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 12
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 12, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 12)
    }
    public func gotoStepFourteen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceRequirementsViewController") as! ExperienceRequirementsViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 13
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 13, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 13)
    }
    public func gotoStepFifteen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceGroupSizeViewController") as! ExperienceGroupSizeViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 14
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 14, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 14)
    }
    public func gotoStepSixteen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceAddPriceViewController") as! ExperienceAddPriceViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 15
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 15, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 15)
    }
    public func gotoStepSeventeen() {
        self.getBaseDetailsWithoutLoader()
        let childViewController = storyBoardExperience.instantiateViewController(withIdentifier: "ExperienceCancellationViewController") as! ExperienceCancellationViewController
        addChildViewController(childViewController)
        childViewController.view.frame = self.parentView.bounds
        self.parentView.addSubview(childViewController.view)
        self.didMove(toParentViewController: self)
        BaseSelectedIndex = 16
        self.collectionViewTop.scrollToItem(at: IndexPath(row: 16, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionViewTop.reloadData()
        self.updateStepsRemaining(index: 16)
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 200, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options,attributes: [.font: font],context: nil)
    }
    
    func updateStepsRemaining(index: Int) {
        self.labelStepsRemaining.text = "STEPS REMAINING \(index + 1)/17"
        self.collectionViewTop.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}



//extension UIViewController {
//    func add(_ child: UIViewController,parent: BasicExperienceViewController) {
//        addChildViewController(child)
//        parent.ParentView.addSubview(child.view)
//        child.didMove(toParentViewController: self)
//    }
//
//    func removeChild(parentCon: BasicExperienceViewController) {
//        guard parent != nil else {
//            return
//        }
//        willMove(toParentViewController: nil)
//        removeFromParentViewController()
//        parentCon.ParentView.removeFromSuperview()
//    }
//}
