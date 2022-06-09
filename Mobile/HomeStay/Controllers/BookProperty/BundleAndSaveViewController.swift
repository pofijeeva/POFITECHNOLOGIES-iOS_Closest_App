//
//  BundleAndSaveViewController.swift
//  HomeStay
//
//  Created by Apple7 on 26/04/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import FSCalendar

class BundleAndSaveViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance,UITextFieldDelegate {

    @IBOutlet weak var BundleDescLbl: UILabel!
    @IBOutlet weak var FromDateView: UIView!
    @IBOutlet weak var ToDateView: UIView!
    @IBOutlet weak var FromDateLbl: UILabel!
    @IBOutlet weak var ToDateLbl: UILabel!
    @IBOutlet weak var BundleTable: UITableView!
    @IBOutlet weak var BundleSubmitBtn: UIButton!
    
    @IBOutlet weak var NewBundleTable: UICollectionView!
    @IBOutlet weak var NewBundleTableHeight: NSLayoutConstraint!

    
    @IBOutlet weak var GrayView: UIView!
    @IBOutlet weak var CalenderView: FSCalendar!

    private var cell: BundleTwoTableViewCell!


    var noOfRows = Int()
    var SelectnoOfRows = Int()

    var isFromDate = "Arrive"
    var minimumDate = Date()
    var BundleSelectedDict = NSMutableArray()
    var OriginalBundleSelectedDict = NSMutableArray()


    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
   
    fileprivate weak var calendar: FSCalendar!
    fileprivate weak var eventLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.GrayView.isHidden = true
        self.CalenderView.isHidden = true
        self.BundleSubmitBtn.titleLabel?.font = UIFont(name: SemiBoldFont, size: 18)
        self.BundleSubmitBtn.backgroundColor = AppSecondColor

        self.FromDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.ToDateLbl.font = UIFont(name: SemiBoldFont, size: 13)
        self.BundleTable.reloadData()
        
        self.CalenderView.appearance.headerTitleFont = UIFont.init(name: RegularFont, size: 18)
        self.CalenderView.appearance.weekdayFont = UIFont.init(name: RegularFont, size: 16)
        self.CalenderView.appearance.titleFont  = UIFont.init(name: RegularFont, size: 16)
        self.CalenderView.appearance.weekdayTextColor = AppColor
        self.CalenderView.appearance.headerTitleColor = AppColor
        
        
        if bundle_checkindate == "" {
            self.FromDateLbl.text = "From Date"

        }else{
            self.FromDateLbl.text = bundle_checkindate
        }
        
        if bundle_checkoutdate == "" {
            self.ToDateLbl.text = "To Date"

        }else{
            self.ToDateLbl.text = bundle_checkoutdate

        }
        if BundleArray.count > 2 {
            self.NewBundleTableHeight.constant = 560
        }else{
            self.NewBundleTableHeight.constant = 280

        }
       
        // Do any additional setup after loading the view.
    }
    
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if self.gregorian.isDateInToday(date) {
            return UIColor.orange
        }
        return nil
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return self.minimumDate
    }
   
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if isFromDate == "Arrive"
        {
            self.minimumDate = date
            self.FromDateLbl.text = self.formatter.string(from: date)

            self.GrayView.isHidden = true
            self.CalenderView.isHidden = true
        }
        else
        {
            self.ToDateLbl.text = self.formatter.string(from: date)

            self.GrayView.isHidden = true
            self.CalenderView.isHidden = true

        }
          calendar.reloadData()
    }
    
    @IBAction func act_Cancelledtapped(_ sender: UITapGestureRecognizer) {
        self.GrayView.isHidden = true
        self.CalenderView.isHidden = true

    }
    
    @IBAction func act_Back(_ sender: UIButton)
    {
//        if BundleSelectedDictValues.count == 0 {
//            BUndleSelectedArray.removeAllObjects()
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_FromDate(_ sender: UIButton)
    {
        isFromDate = "Arrive"
        self.GrayView.isHidden = false
        self.CalenderView.isHidden = false

    }
    @IBAction func act_ToDate(_ sender: UIButton)
    {
        isFromDate = "Depart"
        if self.FromDateLbl.text == "From Date" {
            self.showInformation(title: "Closest", message: "Please select from date")
        }else{
            self.GrayView.isHidden = false
            self.CalenderView.isHidden = false

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        result = count <= 2
        return result
    }
    
   
    @IBAction func act_Submit(_ sender: UIButton)
    {
       
        if self.FromDateLbl.text == "From Date" {
            self.showInformation(title: "Closest", message: "Please select from date")
        }else if ToDateLbl.text == "To Date" {
            self.showInformation(title: "Closest", message: "Please select to date")
        }else if BundleSelectedDict.count == 0 {
            self.showInformation(title: "Closest", message: "Please select to any one bundle")
        }
        else{
            var bundleAmt = Int()
            for i in 0..<self.BundleSelectedDict.count {
                let BundlePrice = "\((self.BundleSelectedDict.object(at: i) as! NSDictionary).object(forKey: "total_amount") as AnyObject)"
                let decimal = Decimal(floatLiteral: Double(BundlePrice)!)
                let intValue = (decimal as NSDecimalNumber).intValue
                bundleAmt = bundleAmt + intValue
            }
            
            Bundle_amount = bundleAmt
            bundle_checkindate = self.FromDateLbl.text!
            bundle_checkoutdate = self.ToDateLbl.text!

            BundleSelectedDictValues = self.BundleSelectedDict
            self.navigationController?.popViewController(animated: true)
            print(BundleSelectedDict)
            print(Bundle_amount)

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if BundleArray.count == 1
        {
            noOfRows = 1
            return 1
            
        }else if BundleArray.count == 0{
            noOfRows = 0
            return 0
        }
        else if BundleArray.count % 2 == 0{
            noOfRows = BundleArray.count/2
            return BundleArray.count/2
        }
        else{
            let temp  = BundleArray.count/2 + BundleArray.count % 2
            noOfRows = temp
            return temp
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
             cell = tableView.dequeueReusableCell(withIdentifier: "BundleTwoTableViewCell") as? BundleTwoTableViewCell
            cell!.selectionStyle = .none
        
        if BundleArray.count > 0
        {
            cell?.FirstView.isHidden = false
            cell?.SecondView.isHidden = false
            let actualIndex = indexPath.row + indexPath.row
            cell?.loadFirstFoodItems(item: BundleArray.object(at: actualIndex)as! NSDictionary)
            cell?.SecondView.isHidden = true
            cell!.FirstGuestLbl.accessibilityLabel = "\(actualIndex)"
            cell!.SecondGuestLbl.tag = actualIndex + 1
            cell!.FirstGuestLbl.delegate = self
            cell!.SecondGuestLbl.delegate = self

            if actualIndex+1 < BundleArray.count{
                cell?.loadSecondFoodItems(item: BundleArray.object(at: actualIndex+1)as! NSDictionary)
                cell?.SecondView.isHidden = false
            }
            cell?.FirstView.tag = actualIndex
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap(_:)))
            cell?.FirstView.addGestureRecognizer(tap)
            cell?.FirstView.isUserInteractionEnabled = true
            cell?.FirstBtn.tag = actualIndex
          //  cell?.FirstBtn.addTarget(self, action: #selector(self.firstAct), for: .touchUpInside)
            cell?.SecondView.tag = actualIndex + 1
            let firsttap = UITapGestureRecognizer(target: self, action: #selector(self.firstgestureTap(_:)))
            cell?.SecondView.addGestureRecognizer(firsttap)
            cell?.SecondView.isUserInteractionEnabled = true
        }
        else
        {
            cell?.FirstView.isHidden = true
            cell?.SecondView.isHidden = true
        }
            return cell!
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
            print("textfield tag \(textField.tag)")
        }
    @objc func gestureTap(_ sender: UITapGestureRecognizer)
    {
        let resultdata = NSMutableDictionary()
        let index = sender.view?.tag
        
        print(cell.FirstGuestLbl.hasText)
        let Count = index!/2
        
        let indexPath = IndexPath(row: Count, section: 0)

       let text =  (BundleTable.cellForRow(at: indexPath) as! BundleTwoTableViewCell).FirstGuestLbl.text

        let count = Int(text!)
        if count == nil {
            self.showInformation(title: "Closest", message: "Please Enter Guest Count")

        }else{
            resultdata.addEntries(from: (BundleArray.object(at: index!)as! NSDictionary) as! [AnyHashable : Any])
            let BundleId = "\(resultdata.object(forKey: "bundle_id") as AnyObject)"
            let bundle_name = "\(resultdata.object(forKey: "bundle_Name") as AnyObject)"

            if BUndleSelectedArray.contains(BundleId) {
                self.showActivityIndicator(uiView: self.view)

                BUndleSelectedArray.remove(BundleId)
                
                for i in 0..<self.BundleSelectedDict.count{
                    let addonIds = "\((self.BundleSelectedDict.object(at: i) as! NSDictionary).object(forKey: "bundle_id") as AnyObject)"
                    if BundleId == addonIds{
                        self.BundleSelectedDict.removeObject(at: i)
                        BundleSelectedDictValues = self.BundleSelectedDict

                        self.hideActivityIndicator(uiView: self.view)
                        break
                    }
                }
            }else{
                BUndleSelectedArray.add(BundleId)
                
                let BundleDescPrice = "\(resultdata.object(forKey: "bundle_amount_after_discount") as AnyObject)"
                
                let BundlePrice = "\(resultdata.object(forKey: "bundle_price") as AnyObject)"
                
                var amount = Int()

                let Data = NSMutableDictionary()
                if BundleDescPrice == "0" {
                    
                    let decimal = Decimal(floatLiteral: Double(BundlePrice)!)
                    let intValue = (decimal as NSDecimalNumber).intValue
                    if count == nil {
                        amount = intValue
                    }else{
                        amount = count! * intValue
                    }
                }else {
                    let decimal = Decimal(floatLiteral: Double(BundleDescPrice)!)
                    let intValue = (decimal as NSDecimalNumber).intValue
                    if count == nil {
                        amount = intValue
                    }else{
                        amount = count! * intValue
                    }
                }
                print(amount)
                Data.setValue(amount, forKey: "total_amount")
                Data.setValue(bundle_name, forKey: "bundle_name")
                Data.setValue(BundleId, forKey: "bundle_id")
                Data.setValue(count, forKey: "No_of_Guests")
                self.BundleSelectedDict.add(Data)
                print(BundleSelectedDict)
                BundleSelectedDictValues = self.BundleSelectedDict

            }
            self.BundleTable.reloadData()
        }
        self.hideActivityIndicator(uiView: self.view)

    }
    
    @objc func firstgestureTap(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)

        let resultdata = NSMutableDictionary()
        let index = sender.view?.tag
        let Count = index!/2

        let indexPath = IndexPath(row: Count, section: 0)

       let text =  (BundleTable.cellForRow(at: indexPath) as! BundleTwoTableViewCell).SecondGuestLbl.text
        let count = Int(text!)

        if count == nil {
            self.showInformation(title: "Closest", message: "Please Enter Guest Count")
        }else{
            resultdata.addEntries(from: (BundleArray.object(at: index!)as! NSDictionary) as! [AnyHashable : Any])
            let BundleId = "\(resultdata.object(forKey: "bundle_id") as AnyObject)"
            let bundle_name = "\(resultdata.object(forKey: "bundle_Name") as AnyObject)"

            if BUndleSelectedArray.contains(BundleId) {
                self.showActivityIndicator(uiView: self.view)

                BUndleSelectedArray.remove(BundleId)
                for i in 0..<self.BundleSelectedDict.count{
                    let addonIds = "\((self.BundleSelectedDict.object(at: i) as! NSDictionary).object(forKey: "bundle_id") as AnyObject)"
                    if BundleId == addonIds{
                        self.BundleSelectedDict.removeObject(at: i)
                        BundleSelectedDictValues = self.BundleSelectedDict

                        self.hideActivityIndicator(uiView: self.view)
                        break
                    }
                }
            }else{
                BUndleSelectedArray.add(BundleId)
                let BundleDescPrice = "\(resultdata.object(forKey: "bundle_amount_after_discount") as AnyObject)"
                let BundlePrice = "\(resultdata.object(forKey: "bundle_price") as AnyObject)"
                var amount = Int()
                
                let Data = NSMutableDictionary()
                if BundleDescPrice == "0" {
                    
                    let decimal = Decimal(floatLiteral: Double(BundlePrice)!)
                    let intValue = (decimal as NSDecimalNumber).intValue
                    if count == nil {
                        amount = intValue
                    }else{
                        amount = count! * intValue
                    }
                }else {
                    let decimal = Decimal(floatLiteral: Double(BundleDescPrice)!)
                    let intValue = (decimal as NSDecimalNumber).intValue
                    if count == nil {
                        amount = intValue
                    }else{
                        amount = count! * intValue
                    }
                }
                print(amount)
                Data.setValue(amount, forKey: "total_amount")
                Data.setValue(bundle_name, forKey: "bundle_name")
                Data.setValue(BundleId, forKey: "bundle_id")
                Data.setValue(count, forKey: "No_of_Guests")
                self.BundleSelectedDict.add(Data)
                BundleSelectedDictValues = self.BundleSelectedDict

               
            }
            
            
            print(BundleSelectedDict)

            self.BundleTable.reloadData()
        }
        self.hideActivityIndicator(uiView: self.view)

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
extension BundleAndSaveViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
   func numberOfSections(in collectionView: UICollectionView) -> Int
   {
       return 1
   }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return BundleArray.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BundleCollectionViewCell", for: indexPath as IndexPath) as! BundleCollectionViewCell
    
    cell.FirstNameLbl.font = UIFont(name: SemiBoldFont, size: 13)
    cell.FirstDescLbl.font = UIFont(name: SemiBoldFont, size: 10)

    cell.FirstPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
    cell.FirstStPriceLbl.font = UIFont(name: SemiBoldFont, size: 11)
    
   
    
    cell.FirstGuestLbl.font = UIFont(name: SemiBoldFont, size: 12)

    
    let DataDict = BundleArray.object(at: indexPath.row)as! NSDictionary
      
    let imgURL = URL(string: DataDict.object(forKey: "bundle_image") as! String)
    cell.FirstImg.kf.setImage(with: imgURL)
    cell.FirstNameLbl.text = (DataDict.object(forKey: "bundle_Name") as! String)
    cell.FirstDescLbl.text = (DataDict.object(forKey: "bundle_description") as! String)
    
   // let BundleId = "\(DataDict.object(forKey: "bundle_id") as! String)"

            
        if "\(DataDict.object(forKey: "Selected") as AnyObject)" == "Yes" {
            cell.FirstGuestLbl.text = "\(DataDict.object(forKey: "No_of_Guests") as AnyObject)"
            
            cell.FirstView.layer.borderWidth = 1.2
            cell.FirstView.layer.borderColor = AppSecondColor.cgColor
            cell.FirstSelImg.isHidden = false
       
       
    }else{
        let COunt = "\(DataDict.object(forKey: "No_of_Guests") as AnyObject)"
        
        if COunt == "<null>"{
            cell.FirstGuestLbl.text = ""
        }else{
            cell.FirstGuestLbl.text = "\(DataDict.object(forKey: "No_of_Guests") as AnyObject)"

        }
        
        cell.FirstView.layer.borderWidth = 1.2
        cell.FirstView.layer.borderColor = UIColor.lightGray.cgColor
        cell.FirstSelImg.isHidden = true
    }
    
    
    let BundlePrice = "\(DataDict.object(forKey: "bundle_amount_after_discount") as AnyObject)"
    
    if BundlePrice == "0" {
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "USD \((DataDict.object(forKey: "bundle_price") as AnyObject))", attributes: [NSAttributedString.Key.foregroundColor: AppSecondColor]));
        attributedString.append(NSAttributedString(string: " / guest", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        cell.FirstPriceLbl.attributedText = attributedString
        cell.FirstStPriceLbl.isHidden = true

    }else {
        cell.FirstStPriceLbl.isHidden = false
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "USD \((DataDict.object(forKey: "bundle_amount_after_discount") as AnyObject))", attributes: [NSAttributedString.Key.foregroundColor: AppSecondColor]));
        attributedString.append(NSAttributedString(string: " / guest", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        cell.FirstPriceLbl.attributedText = attributedString

//        cell.FirstPriceLbl.text = "USD \((DataDict.object(forKey: "bundle_amount_after_discount") as AnyObject)) / guest"
        cell.FirstStPriceLbl.attributedText = "USD \((DataDict.object(forKey: "bundle_price") as AnyObject))".strikeThrough()
    }
    return cell
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
   {
    
    
    let Count = indexPath.row
    
    let indexPathSelect = IndexPath(item: indexPath.row, section: 0)

   let text =  (NewBundleTable.cellForItem(at: indexPathSelect) as! BundleCollectionViewCell).FirstGuestLbl.text

    let count = Int(text!)
    if count == nil {
        self.showInformation(title: "Closest", message: "Please Enter Guest Count")

    }else{
        let resultdata = NSMutableDictionary()

        resultdata.addEntries(from: (BundleArray.object(at: indexPath.row)as! NSDictionary) as! [AnyHashable : Any])
        let BundleId = "\(resultdata.object(forKey: "bundle_id") as AnyObject)"
        let bundle_name = "\(resultdata.object(forKey: "bundle_Name") as AnyObject)"

        if BUndleSelectedArray.contains(BundleId) {
            self.showActivityIndicator(uiView: self.view)

            BUndleSelectedArray.remove(BundleId)
            let tempDict = (BundleArray[indexPath.row] as! NSDictionary).mutableCopy()
            
            (tempDict as AnyObject).setValue(count, forKey: "No_of_Guests")
            (tempDict as AnyObject).setValue("No", forKey: "Selected")
            
            BundleArray[indexPath.row] = tempDict as! NSDictionary
            
            for i in 0..<self.BundleSelectedDict.count{
                let addonIds = "\((self.BundleSelectedDict.object(at: i) as! NSDictionary).object(forKey: "bundle_id") as AnyObject)"
                if BundleId == addonIds{
                    self.BundleSelectedDict.removeObject(at: i)
                    BundleSelectedDictValues = self.BundleSelectedDict

                    self.hideActivityIndicator(uiView: self.view)
                    break
                }
            }
           

            print(BundleSelectedDict)
        }else{
            BUndleSelectedArray.add(BundleId)
            
            let BundleDescPrice = "\(resultdata.object(forKey: "bundle_amount_after_discount") as AnyObject)"
            
            let BundlePrice = "\(resultdata.object(forKey: "bundle_price") as AnyObject)"
            
            var amount = Int()

            let Data = NSMutableDictionary()
            if BundleDescPrice == "0" {
                
                let decimal = Decimal(floatLiteral: Double(BundlePrice)!)
                let intValue = (decimal as NSDecimalNumber).intValue
                if count == nil {
                    amount = intValue
                }else{
                    amount = count! * intValue
                }
            }else {
                let decimal = Decimal(floatLiteral: Double(BundleDescPrice)!)
                let intValue = (decimal as NSDecimalNumber).intValue
                if count == nil {
                    amount = intValue
                }else{
                    amount = count! * intValue
                }
            }
            print(amount)
            Data.setValue(amount, forKey: "total_amount")
            Data.setValue(bundle_name, forKey: "bundle_name")
            Data.setValue(BundleId, forKey: "bundle_id")
            Data.setValue(count, forKey: "No_of_Guests")
            self.BundleSelectedDict.add(Data)
            
            let tempDict = (BundleArray[indexPath.row] as! NSDictionary).mutableCopy()
            
            (tempDict as AnyObject).setValue(count, forKey: "No_of_Guests")
            (tempDict as AnyObject).setValue("Yes", forKey: "Selected")
            
            BundleArray[indexPath.row] = tempDict as! NSDictionary

            print(BundleSelectedDict)

            
            BundleSelectedDictValues = self.BundleSelectedDict

        }
       
        SelectnoOfRows = indexPath.row
        NewBundleTable.reloadData()
           }
    
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
   {
       return 0
   }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//            let yourWidth = collectionView.bounds.width / 2 - 10
//            return CGSize(width: yourWidth, height: 250)
//
//
//    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            let widthPerItem = collectionView.bounds.width / 2
            return CGSize(width: widthPerItem, height: 250)
        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
            return UIEdgeInsets.zero
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
