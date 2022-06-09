
//  ListingInfoViewController.swift
//  HomeStay
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import DropDown
import AFNetworking

class ListingInfoViewController: BaseViewController,UITextViewDelegate {

    //MARK:- Outlets
    @IBOutlet weak var btn_Save: UIButton!
    @IBOutlet weak var tblListingInfo: UITableView!
    @IBOutlet weak var lblPleaseMention: UILabel!
    @IBOutlet weak var lblListingInfoHeader: UILabel!
    @IBOutlet weak var conTabelHeight: NSLayoutConstraint!
    @IBOutlet weak var conTopSpace: NSLayoutConstraint!

    @IBOutlet weak var roomTypeHeight: NSLayoutConstraint!

    @IBOutlet weak var propertytext: UITextView!
    
    @IBOutlet weak var txt_Accommodities: UITextField!
    @IBOutlet weak var txt_Bathrooms: UITextField!
    @IBOutlet weak var txt_BedRooms: UITextField!
    @IBOutlet weak var txt_MiniStay: UITextField!
    

    @IBOutlet weak var roomText: UITextView!
    @IBOutlet weak var propertyView: UIView!

    @IBOutlet weak var lblaccomdates: UILabel!
    @IBOutlet weak var bathroomLbl: UILabel!
    @IBOutlet weak var BedroomLbl: UILabel!
    @IBOutlet weak var minimumStayLbl: UILabel!
    @IBOutlet weak var allowMultipleQtyLbl: UILabel!
    
    @IBOutlet weak var QtyTxt: UITextView!
    @IBOutlet weak var QtyTxtHeight: NSLayoutConstraint!
    
    @IBOutlet weak var QtyEnable: UIButton!
    @IBOutlet weak var QtyDisable: UIButton!



    @IBOutlet weak var roomHide: NSLayoutConstraint!
    var StaticDict = NSMutableDictionary()
    var Dict = [String:String]()
        
    

    var TextTagIndex = Int()
    var textId = String()
    var t1 = String()
    var t2 = String()
    var t3 = String()
    var t4 = String()
    var staticString = String()
    var multiple_qty = Int()
    
    var DropData = ["1","2","3"]
    let dropDown = DropDown()
    
    
//    let stateDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.dropDown
        ]
    }()
    var PropertyArr = [String]()
    var RoomArr = [String]()


    //MARK:- Variables
    var ListingInfoArr = [PropertyAttribute]()
    var PropertyID : AnyObject!
    var dropDownArr = NSArray()
    var currentIndexPath = IndexPath()
    var PropertyId = Int()
    var veh_ID = Int()
    var RoomType = String()
    var PropertyType = String()
    var propertyDict = NSMutableDictionary()
    var ListingActivityDelegate: listingActivityProtocol?
    let id = Singleton.sharedInstance.selectedCategory!
    var accommdates = String()


    var dropDownGuestArray = [String]()
    var priceChange = false
    
    let radioController: RadioButtonController = RadioButtonController()
    
    let radioMonController: RadioButtonMonController = RadioButtonMonController()
    
    let radioYearController: RadioButtonYearController = RadioButtonYearController()

    //MARK:- LifecycleMethods
    override func viewDidLoad()  {
        super.viewDidLoad()
        
        radioMonController.buttonsMonArray = [QtyEnable,QtyDisable]
        radioMonController.defaultButton = QtyEnable
        var dic = [String:String]()
        dic[t1] = self.txt_Accommodities.text
        dic[t2] = self.txt_Bathrooms.text
        dic[t3] = self.txt_BedRooms.text
        dic[t4] = self.txt_MiniStay.text
        
         QtyTxt.layer.borderWidth = 1.0
        QtyTxt.layer.borderColor = BorderColor.cgColor
        QtyTxt.layer.shadowColor = BorderColor.cgColor
        QtyTxt.layer.cornerRadius = 5
        QtyTxt.layer.shadowOffset = CGSize.zero
        QtyTxt.layer.shadowOpacity = 0.6
        QtyTxt.delegate = self
        QtyTxt.keyboardType = .default
        
        self.lblaccomdates.font = UIFont(name: SemiBoldFont, size: 15)
        self.BedroomLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.bathroomLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.minimumStayLbl.font = UIFont(name: SemiBoldFont, size: 15)
        self.allowMultipleQtyLbl.font = UIFont(name: SemiBoldFont, size: 15)
        
        
        self.txt_Accommodities.font = UIFont(name: SemiBoldFont, size: 15)
        self.txt_Bathrooms.font = UIFont(name: SemiBoldFont, size: 15)
        self.txt_BedRooms.font = UIFont(name: SemiBoldFont, size: 15)
        self.txt_MiniStay.font = UIFont(name: SemiBoldFont, size: 15)
        self.QtyTxt.font = UIFont(name: SemiBoldFont, size: 15)
        

        
        
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self

        if let listings = UserDefaults.standard.value(forKey: "ListingsArray") as? [[String: Any]] {
            for dic in listings {
                let value = PropertyAttribute(fromDictionary: dic)
                ListingInfoArr.append(value)
            }
        }
        
//        ListingInfoArr = Singleton.sharedInstance.rentYourSpace.propertyAttributes
        btn_Save.backgroundColor = AppColor
        setData()
    

    }
    
    @IBAction func act_MonEnable(_ sender: UIButton){
        radioMonController.buttonMonArrayUpdated(buttonSelected: sender)
        self.multiple_qty = 1
        QtyTxtHeight.constant = 40
 
    }
    @IBAction func act_MonDisable(_ sender: UIButton){
        radioMonController.buttonMonArrayUpdated(buttonSelected: sender)
         QtyTxtHeight.constant = 0
        self.multiple_qty = 0
       
    }
    func updateTextView(textView: UITextView) {
        textView.text = "  Enter your value"
        textView.textColor = UIColor.lightGray
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = BorderColor.cgColor
        textView.layer.shadowColor = BorderColor.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowOpacity = 0.6
        textView.delegate = self
        textView.keyboardType = .default
        textView.returnKeyType = .done
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//
//        if textView == roomText{
//            RoomArr.removeAll()
//            let ar = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//
//            for num in 0..<ar!.count {
//                let str =  ar![num].childName
//                RoomArr.append(str!)
//            }
////            GetRoom()
//            stateDropDown.show()
//        }else if textView == propertytext {
//            PropertyArr.removeAll()
//            let ar = Singleton.sharedInstance.rentYourSpace.property[0].options
//
//            for num in 0..<ar!.count {
//                let str =  ar![num].childName
//                PropertyArr.append(str!)
//            }
//
//            GetProperty()
//            stateDropDown.show()
//        }
//         textView.resignFirstResponder()
//        return false
//    }

    func textViewDidEndEditing(_ textView: UITextView) {

    }
    func setData()
    {
        print("ListingINFO : \(ListingInfoArr)")
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step7 = result.step7 {
            let QtyAllow = step7.allow_multiple_qty!
            if QtyAllow == 1 {
                radioMonController.defaultButton = QtyEnable
                self.QtyTxtHeight.constant = 40
                self.QtyTxt.text = "\(step7.max_qty!)"
                self.multiple_qty = 1

            }else{
                self.multiple_qty = 0
                radioMonController.defaultButton = QtyDisable
                self.QtyTxtHeight.constant = 0
            }
            if let list = step7.saved_listing.first {
                if let selectedIDForAccommodate = list["4"] as? String {
//                   let value = ListingInfoArr.filter({$0.list_name == "Accommodates"}).first?.attributeValue {
//                    let selectedList1 = value.filter({$0.list_val_id == selectedIDForAccommodate}).first
//                    self.txt_Accommodities.text = selectedList1?.list_val_name
                    self.txt_Accommodities.text =  selectedIDForAccommodate//String(selectedIDForAccommodate)
                }
                if let selectedIDForBathroom = list["2"] as? String {
//                   let value = ListingInfoArr.filter({$0.list_name == "BathRooms"}).first?.attributeValue {
//                    let selectedList1 = value.filter({$0.list_val_id == selectedIDForBathroom}).first
//                    self.txt_Bathrooms.text = selectedList1?.list_val_name
                    self.txt_Bathrooms.text = selectedIDForBathroom
                }
                if let selectedIDForBedroom = list["3"] as? String{
//                   let value = ListingInfoArr.filter({$0.list_name == "BedRooms"}).first?.attributeValue {
//                    let selectedList1 = value.filter({$0.list_val_id == selectedIDForBedroom}).first
//                    self.txt_BedRooms.text = selectedList1?.list_val_name
                    self.txt_BedRooms.text = selectedIDForBedroom
                }
                if let selectedIDForMinStay = list["1"] as? String{
//                   let value = ListingInfoArr.filter({$0.list_name == "MinStay"}).first?.attributeValue {
//                    let selectedList1 = value.filter({$0.list_val_id == selectedIDForMinStay}).first
//                    self.txt_MiniStay.text = selectedList1?.list_val_name
                    self.txt_MiniStay.text = selectedIDForMinStay
                }
            }
        }
            
//        let attrs =  Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary
//
//        for dict in attrs
//        {
//            var chilValue = String()
//            //            let str1 = String(ListingInfoArr[0].attributeId)
//            //            let str2 = dict.key
//            //            if str1 == str2 as! String
//            //            {
//            let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//            print(guestcc!)
//            for num in 0..<guestcc!.count
//            {
//                let props = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                for nums in 0..<props!.count
//                {
//                    if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!) == (dict.value as? String)
//                    {
//                        chilValue = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue)
//                        print(chilValue)
//                    }
//
//                }
//            }
//            //            }
//        }
//    }
    }
    override func viewWillAppear(_ animated: Bool) {
        
//        self.lblListingInfoHeader.font = UIFont(name: SemiBoldFont, size: 18)
//        self.lblPleaseMention.font = UIFont(name: RegularFont, size: 15)
//          self.propertyLbl.font = UIFont(name: RegularFont, size: 13)
//        self.propertytext.font = UIFont(name: RegularFont, size: 13)
//        self.roomLbl.font = UIFont(name: RegularFont, size: 13)
//         self.roomText.font = UIFont(name: RegularFont, size: 13)
//        self.btn_Save.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
//               self.btn_Save.backgroundColor = AppSecondColor
        
        //        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        //        if choose == "en"
        //        {
        //            self.lblListingInfoHeader.text = LocalizeHelper().localizedStringForKey("listinginfo")
        //            self.lblPleaseMention.text = LocalizeHelper().localizedStringForKey("listingcnt")
        //            self.btn_Save.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
        //        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) -> Bool{
        if textView == propertytext {
            return false
        }else if textView == roomText {
            return false
        }
    return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        conTopSpace.constant = 20
        self.view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
////        self.conTabelHeight.constant = CGFloat(80 * self.ListingInfoArr.count) + 20
//        //self.RoomType = Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType
//        //self.PropertyType = Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType
//        if Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType != nil {
//            if let roomTypeStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType {
//                self.RoomType = roomTypeStr
//            }
//        }
//
//        if let PropertyTypeStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType{
//            self.PropertyType = PropertyTypeStr
//        }
////        self.propertyLbl.text = Singleton.sharedInstance.rentYourSpace.property[0].optionName!
//
//        self.accommdates = Singleton.sharedInstance.rentYourSpace.result[0].step1.accommodates
//
//        print("commonMaintainListDataDict....",commonMaintainListDataDict)
//        let propertyArray = NSMutableArray()
//        propertyArray.addObjects(from: (commonMaintainListDataDict.object(forKey: "property")as! NSArray) as! [Any])
//        let optionsArray = NSMutableArray()
//        optionsArray.addObjects(from: ((propertyArray.object(at: 0)as! NSDictionary).object(forKey: "options")as! NSArray) as! [Any])
//        //let props = Singleton.sharedInstance.rentYourSpace.property[0].options
//        for nums in 0..<optionsArray.count
//        {
//            let propInt = ((optionsArray.object(at: nums)as! NSDictionary).object(forKey: "child_id")as! String)
////            propInt = Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childId
////            let PropStr = String(propInt)
//
//            if propInt == Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType!
//            {
//                let value = (Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childName!)
//                self.propertyBut.contentHorizontalAlignment = .left
//               // self.propertyBut.setTitle(value, for: .normal)
//                self.propertytext.text = value
//
//            }
//
//        }
//
//        if Singleton.sharedInstance.rentYourSpace.rooms.count == 0 {
//            //self.roomHide.constant = 0
//            self.roomType.isHidden = true
//            self.roomTypeHeight.constant = 0
//        }else {
//            self.roomType.isHidden = false
//            self.roomTypeHeight.constant = 70
//            //self.roomHide.constant = 78
//            self.roomLbl.text = Singleton.sharedInstance.rentYourSpace.rooms[0].optionName!
//            let roomsl = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//
//            let roomArray = NSMutableArray()
//            roomArray.addObjects(from: (commonMaintainListDataDict.object(forKey: "rooms")as! NSArray) as! [Any])
//            let roomOptionsArray = NSMutableArray()
//            roomOptionsArray.addObjects(from: ((roomArray.object(at: 0)as! NSDictionary).object(forKey: "options")as! NSArray) as! [Any])
//
//            for nums in 0..<roomOptionsArray.count
//            {
//                let roomInt = ((roomOptionsArray.object(at: nums)as! NSDictionary).object(forKey: "child_id")as! String)
//
//                if roomInt == Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType!
//                {
//                    let value = (Singleton.sharedInstance.rentYourSpace.rooms[0].options[nums].childName!)
//                    self.roomBut.contentHorizontalAlignment = .left
//                  //  self.roomBut.setTitle(value, for: .normal)
//                    self.roomText.text = value
//
//                }
//
//            }
//        }
//        self.tblListingInfo.reloadData()
//
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ListingInfoPopUp" {
            let popViewController:PopViewController = segue.destination as! PopViewController
            popViewController.popOverDelegate = self
            if  self.staticString == "Static" {
                let ar = Singleton.sharedInstance.rentYourSpace.property[0].options
                var strArr = [String]()
                for num in 0..<ar!.count {
                    let str =  ar![num].childName
                    strArr.append(str!)
                }
                popViewController.key = currentIndexPath
                popViewController.headerTxt = Singleton.sharedInstance.rentYourSpace.property[0].optionName.uppercased()
                popViewController.dropDownArray = strArr as NSArray
            }else if self.staticString == "Static1" {
                let ar = Singleton.sharedInstance.rentYourSpace.rooms[0].options
                var strArr = [String]()
                for num in 0..<ar!.count {
                    let str =  ar![num].childName
                    strArr.append(str!)
                }
                popViewController.key = currentIndexPath
                popViewController.headerTxt = Singleton.sharedInstance.rentYourSpace.rooms[0].optionName.uppercased()
                popViewController.dropDownArray = strArr as NSArray
            }
            else {

            let ar = ListingInfoArr[(sender as! IndexPath).row].attributeValue
            var strArr = [String]()
            for num in 0..<ar!.count {
                let str =  (ar![num] as Attributevalue).attributeChildValue
                strArr.append(str!)
            }
            popViewController.key = currentIndexPath
            popViewController.headerTxt = ListingInfoArr[(sender as! IndexPath).row].attributeLabel.uppercased()
            popViewController.dropDownArray = strArr as NSArray
            }
        }
    }


    @IBAction func propertyBut(_ sender: UIButton) {
//        PropertyArr.removeAll()
//        let ar = Singleton.sharedInstance.rentYourSpace.property[0].options
//
//        for num in 0..<ar!.count {
//            let str =  ar![num].childName
//            PropertyArr.append(str!)
//        }
//        GetProperty()
//        stateDropDown.show()
    }
    @IBAction func roomBut(_ sender: UIButton) {
//        RoomArr.removeAll()
//        let ar = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//
//        for num in 0..<ar!.count {
//            let str =  ar![num].childName
//            RoomArr.append(str!)
//        }
//        GetRoom()
//        stateDropDown.show()
    }

//    func GetProperty() {
//        stateDropDown.anchorView = propertyBut
//        stateDropDown.bottomOffset = CGPoint(x: 0, y: (propertyBut?.bounds.height)!)
//        stateDropDown.dataSource = PropertyArr
//        stateDropDown.backgroundColor = UIColor.white
//        // Action triggered on selection
//        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.propertyBut.contentHorizontalAlignment = .left
//           // self.propertyBut.setTitle(item, for: .normal)
//            self.propertytext.text = item
//            let propertyArray = NSMutableArray()
//            propertyArray.addObjects(from: (commonMaintainListDataDict.object(forKey: "property")as! NSArray) as! [Any])
//            let optionsArray = NSMutableArray()
//            optionsArray.addObjects(from: ((propertyArray.object(at: 0)as! NSDictionary).object(forKey: "options")as! NSArray) as! [Any])
//
//            self.PropertyType = (optionsArray.object(at: index) as! NSDictionary).object(forKey: "child_id") as! String
//
//        }
//    }
//    func GetRoom() {
//        stateDropDown.anchorView = roomBut
//        stateDropDown.bottomOffset = CGPoint(x: 0, y: (roomBut?.bounds.height)!)
//        stateDropDown.dataSource = RoomArr
//        stateDropDown.backgroundColor = UIColor.white
//        // Action triggered on selection
//        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.roomBut.contentHorizontalAlignment = .left
//            self.roomBut.setTitle(item, for: .normal)
//            self.roomText.text = item
//            let propertyArray = NSMutableArray()
//            propertyArray.addObjects(from: (commonMaintainListDataDict.object(forKey: "rooms")as! NSArray) as! [Any])
//            let optionsArray = NSMutableArray()
//            optionsArray.addObjects(from: ((propertyArray.object(at: 0)as! NSDictionary).object(forKey: "options")as! NSArray) as! [Any])
//
//            self.RoomType = (optionsArray.object(at: index) as! NSDictionary).object(forKey: "child_id") as! String
//
//        }
//    }

    func DropDownTypes(_ anchor: UITextField, dataSource: [Attributevalue]) {
        
        dropDown.anchorView = anchor
        dropDown.bottomOffset = CGPoint(x: 0, y: (self.txt_Accommodities?.bounds.height)!)
        dropDown.dataSource = DropData
        dropDown.dataSource = dataSource.map({String(format: "%@", $0.list_val_name)})
        dropDown.backgroundColor = UIColor.white
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
            
            switch anchor {
            case txt_Accommodities:
                t1 = "\(dataSource[index].list_id ?? 0)"
            case txt_Bathrooms:
                t2 = "\(dataSource[index].list_id ?? 0)"
            case txt_BedRooms:
                t3 = "\(dataSource[index].list_id ?? 0)"
            case txt_MiniStay:
                t4 = "\(dataSource[index].list_id ?? 0)"
            default:
                break
            }
            let selectedItem = dataSource.filter({String(format: "%d", $0.list_val_name) == item}).first
           Dict["\(dataSource[index].list_id )"] = dataSource[index].list_val_name
            print(selectedItem?.list_id)
            anchor.text = item
            
//            self.txt_Accommodities.text = itemPlease fill the mandatory fields
//            let stepFour = Singleton.sharedInstance.rentYourSpace.result[0].step4!
            
            }
        
    }
    
    

    @IBAction func act_Save(_ sender: UIButton) {

//        if propertyDict.count == 0 //|| propertyDict.count == 1
//        {
//            showInformation(title: "Closest", message: "Please fill the mandatory fields")
//        }
//        else{
        
        var dic = [String:String]()
        dic[t1] = self.txt_Accommodities.text
        dic[t2] = self.txt_Bathrooms.text
        dic[t3] = self.txt_BedRooms.text
        dic[t4] = self.txt_MiniStay.text
        var params = NSMutableDictionary()
        let encoder = JSONEncoder()
                if let jsonData = try? encoder.encode(dic) {
                    
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        
                        params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
                                     "property_id":self.PropertyId,
                                    "list_id": jsonString,
                                    "max_allow_qty":self.QtyTxt.text!,
                                    "multiple_qty":self.multiple_qty]
                        print(jsonString)
                    
                    }
                }
        
//        var params = NSMutableDictionary()  "max_allow_qty":"3","multiple_qty":"1"
//
        
//        params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en",
//                     "property_id":self.PropertyId,
//                    "list_id":  ]
        
//        Singleton.sharedInstance.rentYourSpace.result.first?.step7.saved_listing.first
        
        print(params)
       
//            "lang_code":"en",
//            "list_id":"{"4":"12","3":"8","1":"2","2":"4"}",
//            "property_id":"41884"
       
       APIManager.apiPostWithHeaders(serviceName: SAVE_LISTINGINFO_LISTING, parameters: params as? [String : Any]) { response, error in
           DispatchQueue.main.async {
               self.ListingActivityDelegate?.hideActivity()
           }
           print(response)
           if error != nil {
               self.showInformation(title: "Closest", message: error!.localizedDescription)
           } else {
               let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
               Singleton.sharedInstance.rentYourSpace = mod
               sharedInstanceListing.gotoStepSeven()
           }
       }
//        if Reachability()!.isReachable {
        
//            showActivityIndicator(uiView: self.view)
//            var str = String()
//            for dict in propertyDict {
//                let one =  dict.key
//                var value = dict.value as! String
//                let minimStay = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//                for num in 0..<minimStay!.count
//                {
//                    let attributes = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                    for nums in 0..<attributes!.count{
//                        if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue!) == (dict.value as? String)!
//                        {
//                            value = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!)
//                            print(value)
//                        }
//
//                    }
//                }
//
//                let strn = "\"\(one)\""+":"+"\"\(value)\","
//                str.append(strn)
//            }
//
//            str = str.substring(to: str.index(before: str.endIndex))
//            let attribute = "{" + str + "}"
//
//
//            var params = NSMutableDictionary()
//
//
////             params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":self.PropertyId,"room_type":self.RoomType,"attribute":attribute,"property_type":self.PropertyType,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":Singleton.sharedInstance.selectedCategory!]
//
//
//
////            let manager = AFHTTPSessionManager()
////            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
////            manager.post(SAVE_LISTINGINFO_LISTING, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
////                DispatchQueue.main.async {
////
////                }
////                let responseDict:NSDictionary = responseObject as! NSDictionary
////                print(responseDict)
////                self.hideActivityIndicator(uiView: self.view)
////                if responseDict.value(forKey: "status") as! Int == 1 {
////                    let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
////                    Singleton.sharedInstance.rentYourSpace = mod
////                   // self.showInformation(title: "Closest", message: mod.message)
//////                    self.tblListingInfo.reloadData()
////                    sharedInstanceListing.gotoStepSeven()
////
////                }
////
////                else {
////                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
////                }
////            }, failure: { (operation, error) -> Void in
////                DispatchQueue.main.async {
////
////                }
////                print(error)
////                self.showInformation(title: "Closest", message: error.localizedDescription)
////            })
//
//
//
//
////            let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.PropertyId)&room_type=\(self.RoomType)&attribute=\(attribute)&property_type=\(self.PropertyType)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(Singleton.sharedInstance.selectedCategory!)"
////            print(parameterStr)
////            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_LISTINGINFO_LISTING, APIKEY: "SAVE_LISTINGINFO_LISTING")
//        } else {
//            showInformation(title: "Network Error", message: "Please check your internet connection")
//        }
//        }

    }
    
    @IBAction func showdropDownOverview(_ sender: Any) {
        self.dropDown.show()
        if let value = ListingInfoArr.filter({$0.list_name == "Accommodates"}).first?.attributeValue {
            self.dropDown.show()
            self.DropDownTypes(self.txt_Accommodities, dataSource: value)
        }
        if let value = ListingInfoArr.filter({$0.list_name == "BathRooms"}).first?.attributeValue {
            self.dropDown.show()
            self.DropDownTypes(self.txt_Bathrooms, dataSource: value)
        }
        if let value = ListingInfoArr.filter({$0.list_name == "BedRooms"}).first?.attributeValue {
            self.dropDown.show()
            self.DropDownTypes(self.txt_BedRooms, dataSource: value)
        }
        if let value = ListingInfoArr.filter({$0.list_name == "MinStay"}).first?.attributeValue {
            self.dropDown.show()
            self.DropDownTypes(self.txt_MiniStay, dataSource: value)
        }
    }
    
}
extension ListingInfoViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ListingInfoArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListingInfoCell
        
        
//        cell!.BaseView.layer.borderWidth = 1.0
//        cell!.BaseView.layer.borderColor = UIColor.lightGray.cgColor
//
        cell!.lblPlaceHolder.text = ListingInfoArr[indexPath.row].attributeLabel
        
        cell!.txtName.layer.borderWidth = 1
        cell!.txtName.layer.borderColor = BorderColor.cgColor
        
        if ListingInfoArr[indexPath.row].attributeLabel == "User  Capacity" {
            cell!.txtName.text = self.accommdates
        }else{
            
        }
        
        if ListingInfoArr[indexPath.row].attributeType == "option" {
            cell!.viewCell.isHidden = false
            cell!.imgDropDown.isHidden = false
            cell!.txtName.font = UIFont(name: RegularFont, size: 14.0)
            let attrs = Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary

            for dict in attrs {
                var chilValue = String()
                let str1 = String(ListingInfoArr[indexPath.row].attributeId)
                let str2 = dict.key
                if str1 == str2 as! String
                {
                    let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
                    print(guestcc!)
                    for num in 0..<guestcc!.count
                    {
                        let props = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
                        for nums in 0..<props!.count
                        {
                            if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!) == (dict.value as? String)
                            {
                                chilValue = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue)
                                print(chilValue)
                            }

                        }
                    }
                    cell?.txtName.text = chilValue
                    break
                }
            }

        }
        else
        {
        let attrs =  Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary

            for dict in attrs {
                var chilValue = String()
                let str1 = String(ListingInfoArr[indexPath.row].attributeId)
                let str2 = dict.key
                if str1 == str2 as! String
                {
                    let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
                    print(guestcc!)
                    for num in 0..<guestcc!.count
                    {
                        
                        if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeId) == (dict.key as? String)
                        {
                            chilValue =  dict.value as! String
                            //String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[num].attributeChildValue)
                            print(chilValue)
                        }
                    }
                    cell?.txtName.text = chilValue
                    break
                }
            }//{
//            var chilValue = String()
//            let str1 = String(ListingInfoArr[indexPath.row].attributeId)
//            let str2 = dict.key
//            if str1 == str2 as! String
//            {
//                let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//                print(guestcc!)
//                for num in 0..<guestcc!.count
//                {
//                    let props = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                    for nums in 0..<props!.count
//                    {
//                        if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeId) == (dict.key as? String)
//                        {
//                            chilValue =  dict.value as! String
//                            print(chilValue)
//                        }
//
//                    }
//                }
//                cell?.txtName.text = chilValue
//                break
//            }
//            }
            cell!.viewCell.isHidden = false
            cell!.imgDropDown.isHidden = true

        }

       
        
        cell!.txtName.tag = indexPath.row
        return cell!

    }

    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return 80
    //}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndexPath = indexPath
        TextTagIndex = indexPath.row
        self.staticString = "Dynamic"

        if ListingInfoArr[indexPath.row].attributeType! == "option" {
            self.performSegue(withIdentifier: "ListingInfoPopUp", sender: indexPath)
//            conTopSpace.constant = 20
            
        } else {
//            (tblListingInfo.cellForRow(at: indexPath) as! ListingInfoCell).txtName.becomeFirstResponder()
//            conTopSpace.constant = -256
        }
    }
}

extension ListingInfoViewController: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == txt_Accommodities {
                if let value = ListingInfoArr.filter({$0.list_name == "Accommodates"}).first?.attributeValue {
                    self.dropDown.show()
                    self.DropDownTypes(self.txt_Accommodities, dataSource: value)
                }
                textField.resignFirstResponder()

            } else if textField == txt_Bathrooms {
                if let value = ListingInfoArr.filter({$0.list_name == "Bath Room"}).first?.attributeValue {
                    self.dropDown.show()
                    self.DropDownTypes(self.txt_Bathrooms, dataSource: value)
                }
                textField.resignFirstResponder()

            } else if textField == txt_BedRooms {
                if let value = ListingInfoArr.filter({$0.list_name == "Bed Rooms"}).first?.attributeValue {
                    self.dropDown.show()
                    self.DropDownTypes(self.txt_BedRooms, dataSource: value)
                }
                textField.resignFirstResponder()

            } else if textField == txt_MiniStay {
                if let value = ListingInfoArr.filter({$0.list_name == "Minimum stay"}).first?.attributeValue {
                    self.dropDown.show()
                    self.DropDownTypes(self.txt_MiniStay, dataSource: value)
                }
                textField.resignFirstResponder()

            }else if textField == QtyTxt {
                textField.becomeFirstResponder()
            }
        return false



            

    //        if ListingInfoArr[textField.tag].attributeType! == "option" {

    //            self.performSegue(withIdentifier: "ListingInfoPopUp", sender: textField)

    //            return false

    //        } else {

    //            return true

    //        }

        }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
////        conTopSpace.constant = 20
//        return true
//    }
    
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == txt_Accommodities {
//            if let value = ListingInfoArr.filter({$0.list_name == "Accommodates"}).first?.attributeValue {
//                self.dropDown.show()
//                self.DropDownTypes(self.txt_Accommodities, dataSource: value)
//            }
//        } else if textField == txt_Bathrooms {
//            if let value = ListingInfoArr.filter({$0.list_name == "Bath Room"}).first?.attributeValue {
//                self.dropDown.show()
//                self.DropDownTypes(self.txt_Bathrooms, dataSource: value)
//            }
//        } else if textField == txt_BedRooms {
//            if let value = ListingInfoArr.filter({$0.list_name == "Bed Rooms"}).first?.attributeValue {
//                self.dropDown.show()
//                self.DropDownTypes(self.txt_BedRooms, dataSource: value)
//            }
//        } else if textField == txt_MiniStay {
//            if let value = ListingInfoArr.filter({$0.list_name == "Minimum stay"}).first?.attributeValue {
//                self.dropDown.show()
//                self.DropDownTypes(self.txt_MiniStay, dataSource: value)
//            }
//        }
//        textField.resignFirstResponder()
//    }

//    func textFieldDidEndEditing(_ textField: UITextField) {
//
////        let id = String(ListingInfoArr[textField.tag].attributeId)
////        propertyDict.setValue(textField.text, forKey: "\(id)")
//
//        if ListingInfoArr[textField.tag].attributeType == "text" {
//            textId = textField.text!
//        }
//        else {
//            textId = String(ListingInfoArr[textField.tag].attributeValue[listingIndex].attributeChildId)
//        }
//        let id = String(ListingInfoArr[textField.tag].attributeId)
//        propertyDict.setValue(textId, forKey: "\(id)")
//    }


}

extension ListingInfoViewController: DropDownProtocol {
    func getValueFromDropDown(value: String, Key: Any) {

        if self.staticString == "Static" {
            let id = Singleton.sharedInstance.rentYourSpace.property[0].optionId!
            self.RoomType = String(Singleton.sharedInstance.rentYourSpace.property[0].options[listingIndex].childId)
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
            StaticDict.setValue(textId, forKey: "\(id)")
        }else if  self.staticString == "Static1" {
            let id = Singleton.sharedInstance.rentYourSpace.rooms[0].optionId!
            self.PropertyType = String(Singleton.sharedInstance.rentYourSpace.rooms[0].options[listingIndex].childId)
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
            StaticDict.setValue(textId, forKey: "\(id)")
        }else {
            if ListingInfoArr[TextTagIndex].attributeType == "text" {
                textId = String(ListingInfoArr[(Key as! IndexPath).row].attributeId)
            }
            else {
                textId = String(ListingInfoArr[TextTagIndex].attributeValue[listingIndex].attributeChildId)
            }

            let id = String(ListingInfoArr[(Key as! IndexPath).row].attributeId)
            propertyDict.setValue(textId, forKey: "\(id)")
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
        }
    }
}

extension ListingInfoViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        self.hideActivityIndicator(uiView: self.view)
        if APIKEY == "SAVE_LISTINGINFO_LISTING" {
            if errorDict.count == 0 {
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.rentYourSpace = mod
                self.showInformation(title: "Closest", message: mod.message)
//                self.tblListingInfo.reloadData()
            }
        }
    }
}






//  ListingInfoViewController.swift
//  HomeStay
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.

//
//import UIKit
//import DropDown
//import AFNetworking
//
//class ListingInfoViewController: BaseViewController {
//
//    //MARK:- Outlets
//    @IBOutlet weak var btn_Save: UIButton!
//    @IBOutlet weak var tblListingInfo: UITableView!
//
//
//    @IBOutlet weak var propertyView: UIView!
//
//    @IBOutlet weak var roomBut: UIButton!
//    @IBOutlet weak var roomLbl: UILabel!
//    @IBOutlet weak var propertyBut: UIButton!
//    @IBOutlet weak var propertyLbl: UILabel!
//    @IBOutlet weak var roomType: UIView!
//    @IBOutlet weak var lblPleaseMention: UILabel!
//    @IBOutlet weak var lblListingInfoHeader: UILabel!
//    @IBOutlet weak var conTabelHeight: NSLayoutConstraint!
//
//    @IBOutlet weak var roomHide: NSLayoutConstraint!
//
//
//    @IBOutlet weak var conTopSpace: NSLayoutConstraint!
//
//    //MARK:- Variables
//    var ListingInfoArr = [PropertyAttribute]()
//    var PropertyID : AnyObject!
//    var dropDownArr = NSArray()
//    var currentIndexPath = IndexPath()
//    var PropertyId = Int()
//    var veh_ID = Int()
//    var RoomType = String()
//    var PropertyType = String()
//    var propertyDict = NSMutableDictionary()
//    var StaticDict = NSMutableDictionary()
//    var ListingActivityDelegate: listingActivityProtocol?
//    let id = Singleton.sharedInstance.selectedCategory!
//    var dropDownGuestArray = [String]()
//    var priceChange = false
//    var TextTagIndex = Int()
//    var textId = String()
//    var staticString = String()
//    let stateDropDown = DropDown()
//    lazy var dropDowns: [DropDown] = {
//        return [
//            self.stateDropDown
//
//
//        ]
//    }()
//    var PropertyArr = [String]()
//    var RoomArr = [String]()
//    //MARK:- LifecycleMethods
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
//        ListingInfoArr = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//        setData()
//    }
//
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func setData()
//    {
//        let attrs =  Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary
//
//        for dict in attrs
//        {
//            var chilValue = String()
//            //            let str1 = String(ListingInfoArr[0].attributeId)
//            //            let str2 = dict.key
//            //            if str1 == str2 as! String
//            //            {
//            let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//            print(guestcc!)
//            for num in 0..<guestcc!.count
//            {
//                let props = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                for nums in 0..<props!.count
//                {
//                    if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!) == (dict.value as? String)
//                    {
//                        chilValue = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue)
//                        print(chilValue)
//                    }
//
//                }
//            }
//            //            }
//        }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool)
//    {
//        //        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
//        //        if choose == "en"
//        //        {
//        //            self.lblListingInfoHeader.text = LocalizeHelper().localizedStringForKey("listinginfo")
//        //            self.lblPleaseMention.text = LocalizeHelper().localizedStringForKey("listingcnt")
//        //            self.btn_Save.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
//        //        }
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        conTopSpace.constant = 20
//        self.view.endEditing(true)
//    }
//
//    override func viewDidAppear(_ animated: Bool)
//    {
//        self.conTabelHeight.constant = CGFloat(80 * self.ListingInfoArr.count)
//        if Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType != nil {
//            if let roomTypeStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType {
//                self.RoomType = roomTypeStr
//            }
//        }
//
//        if let PropertyTypeStr:String = Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType
//        {
//            self.PropertyType = PropertyTypeStr
//        }
//        self.propertyLbl.text = Singleton.sharedInstance.rentYourSpace.property[0].optionName!
//
//
//
//
//        let props = Singleton.sharedInstance.rentYourSpace.property[0].options
//        for nums in 0..<props!.cou1nt
//        {
//            if String(Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childId) == Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType!
//            {
//                let value = (Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childName!)
//                self.propertyBut.contentHorizontalAlignment = .left
//                self.propertyBut.setTitle(value, for: .normal)
//
//            }
//
//        }
//
//        if Singleton.sharedInstance.rentYourSpace.rooms.count == 0 {
//            self.roomHide.constant = 0
//            self.roomType.isHidden = true
//        }else {
//            self.roomType.isHidden = false
//            self.roomHide.constant = 78
//            self.roomLbl.text = Singleton.sharedInstance.rentYourSpace.rooms[0].optionName!
//            let roomsl = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//            for nums in 0..<roomsl!.count
//            {
//                if String(Singleton.sharedInstance.rentYourSpace.rooms[0].options[nums].childId) == Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType!
//                {
//                    let value = (Singleton.sharedInstance.rentYourSpace.rooms[0].options[nums].childName!)
//                    self.roomBut.contentHorizontalAlignment = .left
//                    self.roomBut.setTitle(value, for: .normal)
//
//                }
//
//            }
//        }
//
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ListingInfoPopUp"
//        {
//            let popViewController:PopViewController = segue.destination as! PopViewController
//            popViewController.popOverDelegate = self
//
//            if  self.staticString == "Static" {
//                let ar = Singleton.sharedInstance.rentYourSpace.property[0].options
//                var strArr = [String]()
//                for num in 0..<ar!.count {
//                    let str =  ar![num].childName
//                    strArr.append(str!)
//                }
//                popViewController.key = currentIndexPath
//                popViewController.headerTxt = Singleton.sharedInstance.rentYourSpace.property[0].optionName.uppercased()
//                popViewController.dropDownArray = strArr as NSArray
//            }else if self.staticString == "Static1" {
//                let ar = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//                var strArr = [String]()
//                for num in 0..<ar!.count {
//                    let str =  ar![num].childName
//                    strArr.append(str!)
//                }
//                popViewController.key = currentIndexPath
//                popViewController.headerTxt = Singleton.sharedInstance.rentYourSpace.rooms[0].optionName.uppercased()
//                popViewController.dropDownArray = strArr as NSArray
//            }
//            else {
//                let ar = ListingInfoArr[(sender as! IndexPath).row].attributeValue
//                var strArr = [String]()
//                for num in 0..<ar!.count {
//                    let str =  (ar![num] as Attributevalue).attributeChildValue
//                    strArr.append(str!)
//                }
//                popViewController.key = currentIndexPath
//                popViewController.headerTxt = ListingInfoArr[(sender as! IndexPath).row].attributeLabel.uppercased()
//                popViewController.dropDownArray = strArr as NSArray
//            }
//
//
//        }
//    }
//
//    @IBAction func propertyBut(_ sender: UIButton) {
//        PropertyArr.removeAll()
//        let ar = Singleton.sharedInstance.rentYourSpace.property[0].options
//
//        for num in 0..<ar!.count {
//            let str =  ar![num].childName
//            PropertyArr.append(str!)
//        }
//        GetProperty()
//        stateDropDown.show()
//    }
//    @IBAction func roomBut(_ sender: UIButton) {
//        RoomArr.removeAll()
//        let ar = Singleton.sharedInstance.rentYourSpace.rooms[0].options
//
//        for num in 0..<ar!.count {
//            let str =  ar![num].childName
//            RoomArr.append(str!)
//        }
//        GetRoom()
//        stateDropDown.show()
//    }
//
//    func GetProperty() {
//        stateDropDown.anchorView = propertyBut
//        stateDropDown.bottomOffset = CGPoint(x: 0, y: (propertyBut?.bounds.height)!)
//        stateDropDown.dataSource = PropertyArr
//        stateDropDown.backgroundColor = UIColor.white
//        // Action triggered on selection
//        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.propertyBut.contentHorizontalAlignment = .left
//            self.propertyBut.setTitle(item, for: .normal)
//            self.PropertyType = String(Singleton.sharedInstance.rentYourSpace.property[0].options[index].childId)
//
//        }
//    }
//    func GetRoom() {
//        stateDropDown.anchorView = roomBut
//        stateDropDown.bottomOffset = CGPoint(x: 0, y: (roomBut?.bounds.height)!)
//        stateDropDown.dataSource = RoomArr
//        stateDropDown.backgroundColor = UIColor.white
//        // Action triggered on selection
//        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            self.roomBut.contentHorizontalAlignment = .left
//            self.roomBut.setTitle(item, for: .normal)
//            self.RoomType = String(Singleton.sharedInstance.rentYourSpace.rooms[0].options[index].childId)
//
//        }
//    }
//
//    @IBAction func act_Save(_ sender: UIButton) {
//
//        if propertyDict.count == 0 || propertyDict.count == 1
//        {
//            showInformation(title: "Closest", message: "Please fill the mandatory fields")
//        }
//        else{
//            if Reachability()!.isReachable
//            {
//                showActivityIndicator(uiView: self.view)
//                print(propertyDict
//                )
//                var str = String()
//
//                //                for dicts in StaticDict {
//                //                    let one =  dicts.key
//                //                    var value = dicts.value as! String
//                //
//                //
//                //                      let strn = "\"\(one)\""+":"+"\"\(value)\","
//                //                    strns.append(strn)
//                //                }
//                for dict in propertyDict {
//                    let one =  dict.key
//                    var value = dict.value as! String
//                    let minimStay = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//                    //                for num in 0..<minimStay!.count
//                    //                {
//                    //                    let attributes = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                    //                    for nums in 0..<attributes!.count{
//                    //                        if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue!) == (dict.value as? String)!
//                    //                        {
//                    //                            value = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!)
//                    //                            print(value)
//                    //                        }
//                    //
//                    //                    }
//                    //                }
//
//                    let strn = "\"\(one)\""+":"+"\"\(value)\","
//                    str.append(strn)
//                }
//
//                print(str)
//
//
//                str = str.substring(to: str.index(before: str.endIndex))
//                let attribute = "{" + str + "}"
//                print(attribute)
//
//                var params = NSMutableDictionary()
//
//
//                             params = ["user_id":login_session.value(forKey: "UserId")!,"property_id":self.PropertyId,"room_type":self.RoomType,"attribute":attribute,"property_type":self.PropertyType,"lang_code":lanuguage_selection.value(forKey: "language") ?? "en","base_id":Singleton.sharedInstance.selectedCategory!]
//                            let manager = AFHTTPSessionManager()
//                            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
//
//                            manager.post(SAVE_LISTINGINFO_LISTING, parameters: params, progress: nil, success: { (operation, responseObject) -> Void in
//                                DispatchQueue.main.async {
//
//                                }
//                                let responseDict:NSDictionary = responseObject as! NSDictionary
//                                print(responseDict)
//                                self.hideActivityIndicator(uiView: self.view)
//                                if responseDict.value(forKey: "status") as! Int == 1 {
//                                    let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                                    Singleton.sharedInstance.rentYourSpace = mod
//                                    self.showInformation(title: "Closest", message: mod.message)
//                                    self.tblListingInfo.reloadData()
//
//                                }
//
//                                else {
//                                    self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
//                                }
//                            }, failure: { (operation, error) -> Void in
//                                DispatchQueue.main.async {
//
//                                }
//                                print(error)
//                                self.showInformation(title: "Closest", message: error.localizedDescription)
//                            })
//
//
////
////
////                let parameterStr = "user_id=\(login_session.value(forKey: "UserId")!)&property_id=\(self.PropertyId)&room_type=\(self.RoomType)&attribute=\(attribute)&property_type=\(self.PropertyType)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(Singleton.sharedInstance.selectedCategory!)"
////                print(parameterStr)
////                Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_LISTINGINFO_LISTING, APIKEY: "SAVE_LISTINGINFO_LISTING")
////            } else {
//                showInformation(title: "Network Error", message: "Please check your internet connection")
//            }
//        }
//    }
//}
//extension ListingInfoViewController: UITableViewDelegate,UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int
//    {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        if section == 0 {
//        //            return 2
//        //        }else {
//        return self.ListingInfoArr.count
//        // }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListingInfoCell
//
//        //        if indexPath.section == 0 {
//        //
//        //            if indexPath.row == 0 {
//        //                 var chilValue = String()
//        //                cell!.lblPlaceHolder.text = Singleton.sharedInstance.rentYourSpace.property[0].optionName!
//        //
//        //                let props = Singleton.sharedInstance.rentYourSpace.property[0].options
//        //                for nums in 0..<props!.count
//        //                {
//        //                    if String(Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childId!) == Singleton.sharedInstance.rentYourSpace.result[0].step7.homeType!
//        //                    {
//        //                        chilValue = (Singleton.sharedInstance.rentYourSpace.property[0].options[nums].childName!)
//        //                        print(chilValue)
//        //                    }
//        //
//        //                }
//        //
//        //                  cell?.txtName.text = chilValue
//        //
//        //            }else {
//        //                 var chilValue = String()
//        //                let props = Singleton.sharedInstance.rentYourSpace.rooms
//        //                for nums in 0..<props!.count
//        //                {
//        //                    if String(Singleton.sharedInstance.rentYourSpace.rooms[0].options[nums].childId!) == Singleton.sharedInstance.rentYourSpace.result[0].step7.roomType!
//        //                    {
//        //                        chilValue = (Singleton.sharedInstance.rentYourSpace.rooms[0].options[nums].childName!)
//        //                        print(chilValue)
//        //                    }
//        //
//        //                }
//        //
//        //                 cell!.lblPlaceHolder.text = Singleton.sharedInstance.rentYourSpace.rooms[0].optionName!
//        //                  cell?.txtName.text = chilValue
//        //            }
//        //
//        //
//        //        }else {
//
//
//        if ListingInfoArr[indexPath.row].attributeType == "option" {
//            cell!.viewCell.isHidden = false
//            cell!.imgDropDown.isHidden = false
//            let attrs = Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary
//
//            for dict in attrs {
//                var chilValue = String()
//                let str1 = String(ListingInfoArr[indexPath.row].attributeId)
//                let str2 = dict.key
//                if str1 == str2 as! String
//                {
//                    let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//                    print(guestcc!)
//                    for num in 0..<guestcc!.count
//                    {
//                        let props = Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue
//                        for nums in 0..<props!.count
//                        {
//                            if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildId!) == (dict.value as? String)
//                            {
//                                chilValue = String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[nums].attributeChildValue)
//                                print(chilValue)
//                            }
//
//                        }
//                    }
//                    cell?.txtName.text = chilValue
//                    break
//                }
//            }
//
//        } else {
//            let attrs = Singleton.sharedInstance.rentYourSpace.result[0].step7.attribute! as NSDictionary
//
//            for dict in attrs {
//                var chilValue = String()
//                let str1 = String(ListingInfoArr[indexPath.row].attributeId)
//                let str2 = dict.key
//                if str1 == str2 as! String
//                {
//                    let guestcc = Singleton.sharedInstance.rentYourSpace.propertyAttributes
//                    print(guestcc!)
//                    for num in 0..<guestcc!.count
//                    {
//
//                        if String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeId) == (dict.key as? String)
//                        {
//                            chilValue =  dict.value as! String
//                            //String(Singleton.sharedInstance.rentYourSpace.propertyAttributes[num].attributeValue[num].attributeChildValue)
//                            print(chilValue)
//                        }
//                    }
//                    cell?.txtName.text = chilValue
//                    break
//                }
//            }
//
//            cell!.viewCell.isHidden = false
//            cell!.imgDropDown.isHidden = true
//        }
//
//        cell!.lblPlaceHolder.text = ListingInfoArr[indexPath.row].attributeLabel
//
//        cell!.txtName.tag = indexPath.row
//        //}
//        return cell!
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.currentIndexPath = indexPath
//        TextTagIndex = indexPath.row
//
//        //        if indexPath.section == 0 {
//        //
//        //            if indexPath.row == 0 {
//        //                self.staticString = "Static"
//        //                self.performSegue(withIdentifier: "ListingInfoPopUp", sender: indexPath)
//        //                conTopSpace.constant = 20
//        //            }else {
//        //                self.staticString = "Static1"
//        //                self.performSegue(withIdentifier: "ListingInfoPopUp", sender: indexPath)
//        //                conTopSpace.constant = 20
//        //            }
//        //
//        //        }else {
//        self.staticString = "Dynamic"
//        if ListingInfoArr[indexPath.row].attributeType! == "option" {
//            self.performSegue(withIdentifier: "ListingInfoPopUp", sender: indexPath)
//            conTopSpace.constant = 20
//        } else {
//            (tblListingInfo.cellForRow(at: indexPath) as! ListingInfoCell).txtName.becomeFirstResponder()
//            conTopSpace.constant = -256
//        }
//        // }
//    }
//}
//
//extension ListingInfoViewController: UITextFieldDelegate {
//
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        TextTagIndex = textField.tag
//        if ListingInfoArr[textField.tag].attributeType! == "option" {
//            self.performSegue(withIdentifier: "ListingInfoPopUp", sender: textField)
//            return false
//        } else {
//            return true
//        }
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        conTopSpace.constant = 20
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        //        if self.staticString == "Static" {
//        //            let id = Singleton.sharedInstance.rentYourSpace.property[0].optionId!
//        //            propertyDict.setValue(textField.text!, forKey: "\(String(describing: id))")
//        //        }
//        //        else if self.staticString == "Static1" {
//        //            let id = Singleton.sharedInstance.rentYourSpace.property[0].optionId!
//        //            propertyDict.setValue(textField.text!, forKey: "\(String(describing: id))")
//        //        }
//        //        else {
//        if ListingInfoArr[textField.tag].attributeType == "text" {
//            textId = textField.text!
//            //String(ListingInfoArr[textField.tag].attributeId)
//            //textField.text!
//        }
//        else {
//            textId = String(ListingInfoArr[textField.tag].attributeValue[listingIndex].attributeChildId)
//        }
//        let id = String(ListingInfoArr[textField.tag].attributeId)
//        propertyDict.setValue(textId, forKey: "\(id)")
//    }
//    //  }
//
//
//}
//
//
//extension ListingInfoViewController: DropDownProtocol {
//    func getValueFromDropDown(value: String, Key: Any) {
//
//        if self.staticString == "Static" {
//            let id = Singleton.sharedInstance.rentYourSpace.property[0].optionId!
//            self.RoomType = String(Singleton.sharedInstance.rentYourSpace.property[0].options[listingIndex].childId)
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
//            StaticDict.setValue(textId, forKey: "\(id)")
//        }else if  self.staticString == "Static1" {
//            let id = Singleton.sharedInstance.rentYourSpace.rooms[0].optionId!
//            self.PropertyType = String(Singleton.sharedInstance.rentYourSpace.rooms[0].options[listingIndex].childId)
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
//            StaticDict.setValue(textId, forKey: "\(id)")
//        }else {
//            if ListingInfoArr[TextTagIndex].attributeType == "text" {
//                textId = String(ListingInfoArr[(Key as! IndexPath).row].attributeId)
//            }
//            else {
//                textId = String(ListingInfoArr[TextTagIndex].attributeValue[listingIndex].attributeChildId)
//            }
//
//            let id = String(ListingInfoArr[(Key as! IndexPath).row].attributeId)
//            propertyDict.setValue(textId, forKey: "\(id)")
//            (tblListingInfo.cellForRow(at: Key as! IndexPath) as! ListingInfoCell).txtName.text = value
//        }
//    }
//}
//
//extension ListingInfoViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
//    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
//        self.hideActivityIndicator(uiView: self.view)
//        if APIKEY == "SAVE_LISTINGINFO_LISTING" {
//            if errorDict.count == 0 {
//                print(responseDict)
//                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
//                Singleton.sharedInstance.rentYourSpace = mod
//                setData()
//                self.showInformation(title: "Closest", message: mod.message)
//                self.tblListingInfo.reloadData()
//            }
//        }
//    }
//}





