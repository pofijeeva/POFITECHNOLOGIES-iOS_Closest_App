//
//  AmenitiesViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class AmenitiesViewController: UIViewController,UITextFieldDelegate {
    
    
    //MARK:- Outlets
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tblAmenities: UITableView!
    @IBOutlet weak var lblPleaseselect: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var conAmenitiesHeight: NSLayoutConstraint!
    
    @IBOutlet weak var AddonsBtn: UIButton!
    @IBOutlet weak var AmenitiesBtn: UIButton!
    
    //MARK:- Variables
    var Addon = NSMutableArray()

    var AmenitiesArr = [Attribute]()
    var PropertyId = Int()
    var selectedOptions = [Option]()
    var VEH_ID = Int()
    var ListingActivityDelegate: listingActivityProtocol!
    let id = Singleton.sharedInstance.selectedCategory!
    var selectedRestIDArray = NSMutableArray()
    //var selectedIDArray = NSMutableArray()
    var amenityArray = NSArray()
    var amenityOptionsArray = NSArray()
    var OptionsArray = NSMutableArray()
    
    var amenityMutArray = NSMutableArray()
    var SelectedRow = -1
    var SelectedSection = -1

    var SelectedType = String()
   
    var SavedAddonsIDS = NSMutableArray()
    var SavedAddonsIDSPrice = NSMutableArray()


    //MARK:- LifecycleMethods
    override func viewDidLoad() {
        super.viewDidLoad()
     

        setData()
        self.SelectedType = "Amenities"
        self.lblPleaseselect.font = UIFont(name: SemiBoldFont, size: 13)
        self.AddonsBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        self.AmenitiesBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 15)
        
        self.lblPleaseselect.text = GlobalLanguageDictionary.object(forKey: "key_AminitiesDesc") as! String
        self.AmenitiesBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_amenities") as! String, for: .normal)
        self.AddonsBtn.setTitle(GlobalLanguageDictionary.object(forKey: "key_addons") as! String, for: .normal)
        self.btnSave.setTitle(GlobalLanguageDictionary.object(forKey: "key_next") as! String, for: .normal)
        AmenitiesBtn.backgroundColor = AppSecondColor1

        AmenitiesArr = Singleton.sharedInstance.rentYourSpace.attribute
        //let amenityArr:NSArray = AmenitiesArr as NSArray
        //print(amenityArr)
                
        if UserDefaults.standard.value(forKey: "AmenitiesArray") != nil, (UserDefaults.standard.value(forKey: "AmenitiesArray") as! NSArray).count != 0 {
            amenityArray = UserDefaults.standard.value(forKey: "AmenitiesArray") as! NSArray
            //amenityMutArray.addObjects(from: amenityArray as! [Any])
            amenityMutArray = NSMutableArray(array:amenityArray)
            //OptionsArray.addObjects(from: [amenityArray.value(forKey: "options")])
            //print(OptionsArray)
//            for i in 0..<amenityArray.count {
//                let optArray:NSArray = (amenityArray[i] as AnyObject).value(forKey: "options") as! NSArray
//                for j in 0..<optArray.count{
//                    let dict:NSDictionary = optArray[j] as! NSDictionary
//                    print(dict)
//                    OptionsArray.add(dict)
//                }
//            }
        }
                
        print(amenityMutArray)
        print(OptionsArray)
        let SelectedAddons = NSMutableDictionary()
        SelectedAddons.addEntries(from: ((commonMaintainListDataDict.object(forKey: "data") as! NSDictionary).object(forKey: "step6") as! NSDictionary) as! [AnyHashable: Any])
        let SavedAddons = SelectedAddons.object(forKey: "saved_addons") as! NSArray
        let Add = NSMutableArray()

        for i in 0..<SavedAddons.count {
            let IDS = SavedAddons.object(at: i) as! NSDictionary
             Add.addObjects(from: IDS.allValues)
            print(Add)
        }
        for i in 0..<Add.count {
            let IDS = (Add.object(at: i) as! NSArray).object(at: i) as! NSDictionary
            for j in 0..<(Add.object(at: i) as! NSArray).count{
             SavedAddonsIDS.add("\(((Add.object(at: i) as! NSArray).object(at: j) as! NSDictionary).object(forKey: "id") as AnyObject)")
            SavedAddonsIDSPrice.add("\(((Add.object(at: i) as! NSArray).object(at: j) as! NSDictionary).object(forKey: "price") as AnyObject)")
            }
          }
        
        print(SavedAddonsIDS)
        print(SavedAddonsIDSPrice)
        
        
//        let data = NSMutableDictionary()
//        let data1 = NSMutableDictionary()
//
//       data.setValue(textField.text!, forKey: "price")
//    data.setValue(((((ListingAddonsArray.object(at: self.SelectedSection) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: self.SelectedRow) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject), forKey: "id")
//
//    data1.setValue(data, forKey: "\((ListingAddonsArray[self.SelectedSection] as AnyObject).value(forKey: "amen_id") as AnyObject)")
//    Addon.add(data)
//       ListingAddonsDict.setValue(Addon, forKey: "\((ListingAddonsArray[self.SelectedSection] as AnyObject).value(forKey: "amen_id") as AnyObject)")
//    print(ListingAddonsDict)
        
        
        
        if Singleton.sharedInstance.rentYourSpace.result[0].step6.listName != nil {
            if let listName:String = Singleton.sharedInstance.rentYourSpace.result[0].step6.listName {
                checkedIDArray.removeAllObjects()
                AddonscheckedIDArray.removeAllObjects()

                let listArr = listName.components(separatedBy: ",")
                checkedIDArray.addObjects(from: listArr)
                AddonscheckedIDArray.addObjects(from: listArr)

                for i in 0..<checkedIDArray.count {
                    if checkedIDArray.contains("") {
                        checkedIDArray.removeObject(at: i)
                        AddonscheckedIDArray.removeObject(at: i)

                    }
                }
            }
        }
        
//        if Singleton.sharedInstance.rentYourSpace.result[0].step6.listName != nil {
//            if let listName:String = Singleton.sharedInstance.rentYourSpace.result[0].step6.listName {
//                let listArr = listName.components(separatedBy: ",")
//                AddonscheckedIDArray.addObjects(from: listArr)
//                for i in 0..<checkedIDArray.count {
//                    if AddonscheckedIDArray.contains("") {
//                        AddonscheckedIDArray.removeObject(at: i)
//                    }
//                }
//            }
//        }
        print(checkedIDArray)
        //let listName = Singleton.sharedInstance.rentYourSpace.result[0].step6.listName
        //let listArr = listName?.components(separatedBy: ",")
        //selectedIDArray.addObjects(from: listArr!)
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
    }
    
    func setData()
    {
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step6 = result.step6 {
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        ListingAddonsDict.removeAllObjects()
          self.lblHeader.font = UIFont(name: SemiBoldFont, size: 18)
          self.lblPleaseselect.font = UIFont(name: SemiBoldFont, size: 14)
          self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
            self.btnSave.backgroundColor = AppSecondColor1
        
        
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.lblHeader.text = LocalizeHelper().localizedStringForKey("amenities")
//            self.lblPleaseselect.text = LocalizeHelper().localizedStringForKey("amenitiestitle")
            self.btnSave.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
        }
        self.AmenitiesBtn.backgroundColor = AppSecondColor1
        self.AmenitiesBtn.titleLabel?.textColor = .white

        self.AddonsBtn.backgroundColor = .white
        self.AddonsBtn.titleLabel?.textColor = AppSecondColor

    }
    override func viewDidAppear(_ animated: Bool) {
        self.conAmenitiesHeight.constant =  self.tblAmenities.contentSize.height + 20
    }
    
    
    @IBAction func act_Amenities(_ sender: UIButton) {
        self.SelectedType = "Amenities"
        self.AmenitiesBtn.backgroundColor = AppColor
        self.AmenitiesBtn.titleLabel?.textColor = .white

        self.AddonsBtn.backgroundColor = .white
        self.AddonsBtn.titleLabel?.textColor = AppColor

        self.tblAmenities.reloadData()
        self.conAmenitiesHeight.constant =  self.tblAmenities.contentSize.height + 20


    }
    @IBAction func act_Addons(_ sender: UIButton) {
        
        self.SelectedType = "Addons"
        self.AmenitiesBtn.backgroundColor = .white
        self.AmenitiesBtn.titleLabel?.textColor = AppColor

        self.AddonsBtn.backgroundColor = AppColor
        self.AddonsBtn.titleLabel?.textColor = .white

        self.tblAmenities.reloadData()
        self.conAmenitiesHeight.constant =  self.tblAmenities.contentSize.height + 20

    }
    //MARK:- Button Actions
    @IBAction func act_Save(_ sender: UIButton) {
        ListingActivityDelegate.showActivity()
         var AddonString = String()

        do {
            //Convert to Data
            
            let AddonData = try JSONSerialization.data(withJSONObject: ListingAddonsDict, options: [])
            //Convert back to string. Usually only do this for debugging
                  
            if let AddonStr = String(data: AddonData, encoding: String.Encoding.utf8) {
                AddonString = AddonStr
            }
            
        } catch {
            print(error.localizedDescription)
        }
         print(AddonString)
 
        let params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                      "property_id":self.PropertyId,
                      "amen_id": Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.first,
                      "addon_id":AddonString
        ]
    
        print(params)
 
//        SAVE_CALENDER_LISTING
        APIManager.apiPostWithHeaders(serviceName: SAVE_AMINITIES_LISTING, parameters: params) { response, error in
            DispatchQueue.main.async {
                self.ListingActivityDelegate.hideActivity()
            }
            
            print(response)
            
            if error != nil {
                self.showInformation(title: "Closest", message: error!.localizedDescription)
            } else {
                let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                sharedInstanceListing.gotoStepSix()
            }
        }
/*
        var aminitiesStr = String()
        //        for num in 0..<selectedOptions.count {
        //          aminitiesStr = aminitiesStr + selectedOptions[num].childId + ","
        //        }
        ////            name.substring(to: name.index(before: name.endIndex))
        //        aminitiesStr = aminitiesStr.substring(to: aminitiesStr.index(before: aminitiesStr.endIndex))
        
        if self.SelectedType == "Amenities" {
            aminitiesStr = checkedIDArray.componentsJoined(by: ",")

        }else{
            aminitiesStr = AddonscheckedIDArray.componentsJoined(by: ",")

        }
        
        if aminitiesStr.count == 0 {
            if self.SelectedType == "Amenities" {
                showInformation(title: "Closest", message: "Please select Amenities for your rental")

            }else{
                showInformation(title: "Closest", message: "Please select Addons for your rental")

            }
        }else{
            if Reachability()!.isReachable
            {
                
                var params = NSMutableDictionary()
                params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":Singleton.sharedInstance.rentYourSpace.propertyid!,"string":aminitiesStr,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":Singleton.sharedInstance.selectedCategory!]
              
                
                let manager = AFHTTPSessionManager()
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
                
                manager.post(SAVE_AMINITIES_LISTING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                    DispatchQueue.main.async {
                        
                    }
                    let responseDict:NSDictionary = responseObject as! NSDictionary
                    print(responseDict)
                    self.ListingActivityDelegate.hideActivity()
                    if responseDict.value(forKey: "status") as! Int == 1 {
                      
                        let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                        Singleton.sharedInstance.rentYourSpace = mod
                      //  self.showInformation(title: "Closest", message: mod.message)
                        sharedInstanceListing.gotoStepSix()
                        
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
                
                
                
                
                
    //            ListingActivityDelegate.showActivity()
    //            let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(Singleton.sharedInstance.rentYourSpace.propertyid!)&string=\(aminitiesStr)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(Singleton.sharedInstance.selectedCategory!)"
    //            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_AMINITIES_LISTING, APIKEY: "SAVE_AMINITIES_LISTING")
    //            print(parameterStr)
            }
            else
            {
                showInformation(title: "Network Error", message: GlobalLanguageDictionary.object(forKey: "key_nointernet") as! String)
            }

        }
 */
    }
    
}
extension AmenitiesViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return AmenitiesArr.count
        if self.SelectedType == "Amenities" {
            return amenityArray.count
        }else{
            return ListingAddonsArray.count

        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return AmenitiesArr[section].options.count
        
        if self.SelectedType == "Amenities" {
            return ((amenityArray.object(at: section) as! NSDictionary).value(forKey: "child_values") as! NSArray).count
        }else{
            return ((ListingAddonsArray.object(at: section) as! NSDictionary).object(forKey: "child_values") as! NSArray).count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AmenitiesCell
        //cell?.lblAmenities.text = AmenitiesArr[indexPath.section].options[indexPath.row].childName
        //cell?.lblAmenities.text = (OptionsArray[indexPath.row] as AnyObject).value(forKey: "child_name") as? String
        cell?.lblAmenities.font = UIFont(name: SemiBoldFont, size: 13)

        if self.SelectedType == "Amenities" {
            cell?.PriceTxtHeight.constant = 0
//            cell?.lblAmenities.font = UIFont(name: RegularFont, size: 12)
            let amenSection = amenityArray.object(at: indexPath.section) as? [String: Any]
            let amenChild = amenSection?["child_values"] as? [[String: Any]]
            cell?.lblAmenities.text = (amenChild?[indexPath.row])?["amen_val_name"] as? String
            cell?.btnSelect.tag = indexPath.row

            if let sa = Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.first,
               let amen_ID = amenSection?["amen_id"] as? Int,
               let amenChildID = (amenChild?[indexPath.row])?["amen_val_id"] as? Int {
                let key = String(format: "%d", amen_ID)
                if let savedAmen = sa[key] as? NSArray, let saObj = savedAmen.firstObject as? NSArray {
                    if saObj.contains(String(format: "%d", amenChildID)) {
                        cell?.btnSelect.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)
                    } else {
                        cell?.btnSelect.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
                    }
                }
            } else {
                cell?.btnSelect.setImage(UIImage(named: "tick-off")?.maskWithColor(color: AppColor), for: .normal)
            }
            cell?.editBtn.isHidden = true
            
            //let tempChildID = AmenitiesArr[indexPath.section].options[indexPath.row].childId
//            let tempChildID:String = (((amenityMutArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "options") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "child_id") as! String
//            if (checkedIDArray .contains(tempChildID as Any))
//            {
//                cell?.btnSelect.setImage(UIImage(named: "checkbox-2"), for: .normal)
//            }
//            else {
//                cell?.btnSelect.setImage(UIImage(named: "tick-off"), for: .normal)
//            }
        }else{
            cell?.editBtn.isHidden = false
            cell?.lblAmenities.text = (((ListingAddonsArray.object(at: indexPath.section) as AnyObject).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_name") as! String + " - " + "\((((ListingAddonsArray.object(at: indexPath.section) as AnyObject).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amount") as AnyObject)"
            cell?.btnSelect.tag = indexPath.row
            //let tempChildID = AmenitiesArr[indexPath.section].options[indexPath.row].childId
            let tempChildID:String = "\((((ListingAddonsArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject)"
            if self.SavedAddonsIDS.contains(tempChildID) {
                cell?.btnSelect.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)

                let tag = self.SavedAddonsIDS.index(of: tempChildID)
                cell?.lblAmenities.text = (((ListingAddonsArray.object(at: indexPath.section) as AnyObject).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_name") as! String + " - " + "\(self.SavedAddonsIDSPrice.object(at: tag) as AnyObject)"
            }
            else if (AddonscheckedIDArray .contains(tempChildID as Any))
            {
                
                    cell?.lblAmenities.text = (((ListingAddonsArray.object(at: indexPath.section) as AnyObject).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_name") as! String + " - " + "\((((ListingAddonsArray.object(at: indexPath.section) as AnyObject).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amount") as AnyObject)"
                cell?.btnSelect.setImage(UIImage(named: "tick-on")?.maskWithColor(color: AppColor), for: .normal)
            }
            else {
                cell?.btnSelect.setImage(UIImage(named: "tick-off"), for: .normal)
            }
            if self.SelectedSection == indexPath.section {
                if self.SelectedRow == indexPath.row {
                    cell?.PriceTxtHeight.constant = 45

                }else{
                    cell?.PriceTxtHeight.constant = 0
                }
            }else{
                cell?.PriceTxtHeight.constant = 0

            }
            cell?.PriceTxt.placeholder = GlobalLanguageDictionary.object(forKey: "key_addonsPrice") as! String
            cell?.PriceTxt.delegate = self
            cell?.editBtn.tag = indexPath.section
            cell?.editBtn.accessibilityLabel = "\(indexPath.row)"
            cell?.editBtn.addTarget(self, action: #selector(wishListApi(sender:)), for: .touchUpInside)
        }
        
        
      
        //let listName = Singleton.sharedInstance.rentYourSpace.result[0].step6.listName
        //        let listArr = listName?.components(separatedBy: ",")
        //        let count = listArr!.count
        //        for n in 0..<count{
        //            if listArr![n] == AmenitiesArr[indexPath.section].options[indexPath.row].childId
        //            {
        //                selectedOptions.append(self.AmenitiesArr[indexPath.section].options[indexPath.row])
        //                cell?.btnSelect.setImage(UIImage(named: "tick-on"), for: .normal)
        //            }
        //        }
        return cell!
    }
        func textFieldDidEndEditing(_ textField: UITextField) {

        let tempChildId = "\((ListingAddonsArray.object(at: self.SelectedSection) as! NSDictionary).object(forKey: "amen_id") as AnyObject)"
//       if(AddonscheckedIDArray.contains(tempChildId as Any)){
//           AddonscheckedIDArray.remove(tempChildId as Any)
            let data = NSMutableDictionary()
            let data1 = NSMutableDictionary()
 
           data.setValue(textField.text!, forKey: "price")
        data.setValue(((((ListingAddonsArray.object(at: self.SelectedSection) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: self.SelectedRow) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject), forKey: "id")
           
        data1.setValue(data, forKey: "\((ListingAddonsArray[self.SelectedSection] as AnyObject).value(forKey: "amen_id") as AnyObject)")
            let AddonCopy = NSMutableArray()
            AddonCopy.add(data)
        Addon.add(data)
            let AddonsParentId = NSMutableArray()

            AddonsParentId.addObjects(from:ListingAddonsDict.allKeys)
 print(AddonsParentId)
            
                   if(AddonsParentId.contains(tempChildId as Any)){
                    ListingAddonsDict.setValue(Addon, forKey: "\((ListingAddonsArray[self.SelectedSection] as AnyObject).value(forKey: "amen_id") as AnyObject)")
                    }else{
                        ListingAddonsDict.setValue(AddonCopy, forKey: "\((ListingAddonsArray[self.SelectedSection] as AnyObject).value(forKey: "amen_id") as AnyObject)")
                   }
        print(ListingAddonsDict)


    }
    @objc func wishListApi(sender: UIButton) {
        self.SelectedRow = Int("\(sender.accessibilityLabel!)")!
        self.SelectedSection = sender.tag

        let tempChildId = "\((((ListingAddonsArray.object(at: sender.tag) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: self.SelectedRow) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject)"
       if(SavedAddonsIDS.contains(tempChildId as Any)){
        self.SelectedSection = sender.tag
        self.SelectedRow = Int("\(sender.accessibilityLabel!)")!
        self.tblAmenities.reloadData()
       }else{
        showInformation(title: "Closest", message: "Please select Addons checkbox first")
       }
       
  }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 10, width: tableView.bounds.width, height: 70))
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: tableView.bounds.width, height: 40))
        headerView.backgroundColor = UIColor.groupTableViewBackground
        label.textColor = UIColor.darkGray
        //label.text = self.AmenitiesArr[section].optionName
        
        if self.SelectedType == "Amenities" {
            label.text = ((amenityArray[section] as AnyObject).value(forKey: "amen_name") as? String)?.uppercased()
        }else{
            label.text = ((ListingAddonsArray[section] as AnyObject).value(forKey: "amen_name") as? String)?.uppercased()
        }
        label.font = UIFont(name:SemiBoldFont, size: 16)
        headerView.addSubview(label)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let tempChildId = self.AmenitiesArr[indexPath.section].options[indexPath.row].childId  AddonscheckedIDArray
        if self.SelectedType == "Amenities" {
            let amenSection = amenityArray.object(at: indexPath.section) as? [String: Any]
            let amenChild = amenSection?["child_values"] as? [[String: Any]]
            if var sa = Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.first,
               let amen_ID = amenSection?["amen_id"] as? Int,
               let amenChildID = (amenChild?[indexPath.row])?["amen_val_id"] as? Int {
                let key = String(format: "%d", amen_ID)
                if let savedAmen = sa[key] as? NSArray, let saObj = savedAmen.firstObject as? NSArray {
                    let amArray = NSMutableArray(array: saObj)
                    if (tableView.cellForRow(at: indexPath) as! AmenitiesCell).btnSelect.currentImage == UIImage(named: "tick-on") {
                        amArray.remove(String(format: "%d", amenChildID))
                    } else {
                        amArray.add(String(format: "%d", amenChildID))
                    }
                    
                    sa[key] = NSArray(object: amArray)
                } else {
                    sa[key] = NSArray(object: [String(format: "%d", amenChildID)])
                }
                                
                Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.removeAll()
                Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.append(sa)
            } else {
                
                if let amen_ID = amenSection?["amen_id"] as? Int,
                   let amenChildID = (amenChild?[indexPath.row])?["amen_val_id"] as? Int {
                    let key = String(format: "%d", amen_ID)
                    let value = String(format: "%d", amenChildID)
                    let child = NSArray(object: [value])
                    let saved = [key: child]
                    Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.removeAll()
                    Singleton.sharedInstance.rentYourSpace.result.first?.step6.saved_amenities.append(saved)
                }
            }
            
                
            
//            let tempChildId = (((amenityMutArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "options") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "child_id") as! String
//            if(checkedIDArray.contains(tempChildId as Any)){
//                checkedIDArray.remove(tempChildId as Any)
//            }else{
//                checkedIDArray.add(tempChildId as Any)
//            }
        }else{
            self.SelectedSection = indexPath.section
            self.SelectedRow = indexPath.row
             let tempChildId = "\((((ListingAddonsArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject)"
            if(AddonscheckedIDArray.contains(tempChildId as Any)){
                AddonscheckedIDArray.remove(tempChildId as Any)
            }else{
                AddonscheckedIDArray.add(tempChildId as Any)
//                let data = NSMutableDictionary()
//                let data1 = NSMutableDictionary()
//
//                data.setValue(((ListingAddonsArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "amen_id") as AnyObject), forKey: "addon_id")
//                let tempCard = self.tblAmenities.viewWithTag(indexPath.row) as? UITextField
//                let Te = (tableView.cellForRow(at: indexPath) as! AmenitiesCell).PriceTxt.text!
//
//                data.setValue(Te, forKey: "price")
//                data.setValue(((((ListingAddonsArray.object(at: indexPath.section) as! NSDictionary).object(forKey: "child_values") as AnyObject).object(at: indexPath.row) as! NSDictionary).object(forKey: "amen_val_id") as AnyObject), forKey: "id")
//
//                data1.setValue(data, forKey: "\((ListingAddonsArray[indexPath.section] as AnyObject).value(forKey: "amen_id") as AnyObject)")
//
//                ListingAddonsDict.add(data1)
            }
            

        }
        
       
        self.tblAmenities.reloadData()
        //    selectedOptions.append(self.AmenitiesArr[indexPath.section].options[indexPath.row])
        //        (tableView.cellForRow(at: indexPath) as! AmenitiesCell).btnSelect.setImage(UIImage(named: "tick-on"), for: .normal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if selectedOptions.count != 0 {
            for index in 0..<selectedOptions.count {
                if selectedOptions[index].childId == self.AmenitiesArr[indexPath.section].options[indexPath.row].childId
                {
                    selectedOptions.remove(at: index)
                    break
                } else {
                    
                }
            }
            (tableView.cellForRow(at: indexPath) as! AmenitiesCell).btnSelect.setImage(UIImage(named: "tick-off"), for: .normal)
        }
    }
}

extension AmenitiesViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        ListingActivityDelegate.hideActivity()
        if APIKEY == "SAVE_AMINITIES_LISTING"
        {
            if errorDict.count == 0 {
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                self.showInformation(title: "Closest", message: mod.message)
            }
            else
            {
                
            }
        }
    }
}

