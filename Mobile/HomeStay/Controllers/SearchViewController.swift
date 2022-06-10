////
////  SearchViewController.swift
////  HomeStay
////
////  Created by POFI TECHNOLOGIES on 26/07/18.
////  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
////
//
//import UIKit
//import GooglePlaces
//
//
//protocol LoctaionSearchProtocol {
//    func getLocation(SearchResult:String)
//    func getLocationFromCoordinates(lat:String,long:String)
//    func showPlaceList(searchResult:String)
//}
//
//class SearchViewController: UIViewController{
//
//
//    //MARK:- Variables
//
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var searchController: UISearchController?
//    var resultView: UITextView?
//    var locationName: String!
//    var searchLoctaionDelegate: LoctaionSearchProtocol!
//    var BookingTypes = String()
//
//    //Outlets
//    @IBOutlet weak var lblHeader: UILabel!
//    @IBOutlet weak var btn_Back: UIButton!
//
//    //MARK:- Lifecycle Methods
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController?.searchResultsUpdater = resultsViewController
//        let subView = UIView(frame: CGRect(x: 0, y: 64.0, width: self.view.frame.size.width, height: 45.0))
//        subView.addSubview((searchController?.searchBar)!)
//        view.addSubview(subView)
//        searchController?.searchBar.delegate = self
//        searchController?.searchBar.barTintColor = .white
//        searchController?.searchBar.sizeToFit()
//        searchController?.searchBar.placeholder = "Search your location"
//        searchController?.searchBar.showsCancelButton = false
//        searchController?.hidesNavigationBarDuringPresentation = false
//        definesPresentationContext = true
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    //MARK:- Button Actions
//
//    @IBAction func act_Cancel(_ sender: UIButton) {
//         self.navigationController?.popViewController(animated: true)
//    }
//
//    @IBAction func act_Back(_ sender: UIButton)
//    {
//        if isFromHomePage_Search == true
//        {
//         self.navigationController?.popViewController(animated: true)
//        }
//        else
//        {
//          self.dismiss(animated: true, completion: nil)
//        }
//    }
//}
//
//extension SearchViewController: UISearchBarDelegate {
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        let transition: CATransition = CATransition()
////        transition.duration = 0.5
////        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
////        transition.type = kCATransitionReveal
////        transition.subtype = kCATransitionFromBottom
////        self.view.window!.layer.add(transition, forKey: nil)
//        //self.dismiss(animated: false, completion: nil)
//        self.navigationController?.popViewController(animated: true)
//    }
//    func didPresentSearchController(searchController: UISearchController) {
//        searchController.searchBar.showsCancelButton = false
//    }
//}
//
//extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate {
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
//                           didAutocompleteWith place: GMSPlace) {
//        self.dismiss(animated: true, completion: nil)
//        searchController?.isActive = false
//        locationName = place.name
//        searchController?.searchBar.text = locationName
//        searchLoctaionDelegate?.getLocationFromCoordinates(lat: String(place.coordinate.latitude), long:String(place.coordinate.longitude))
//        searchLoctaionDelegate?.getLocation(SearchResult: place.name)
//        searchLoctaionDelegate?.showPlaceList(searchResult: place.name)
//
//    }
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
//                           didFailAutocompleteWithError error: Error){
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//
//    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
//        return true
//    }
//}
//
//  SearchViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 26/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import GooglePlaces

protocol LoctaionSearchProtocol {
    func getLocation(SearchResult:String)
    func getLocationFromCoordinates(lat:String,long:String)
    func showPlaceList(searchResult:String)
}

class SearchViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    //MARK:- Variables
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var locationName: String!
    var searchLoctaionDelegate: LoctaionSearchProtocol!
    var BookingTypes = String()
    var placeSearchArray = NSMutableArray()
    var isFrom = ""
    
    //Outlets
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var SearchTable: UITableView!
    @IBOutlet weak var SearchTextField: UITextField!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SearchTable.tableFooterView = UIView()
        self.lblHeader.font = UIFont(name: SemiBoldFont, size: 16)
        self.SearchTextField.font = UIFont(name: SemiBoldFont, size: 14)
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController?.searchResultsUpdater = resultsViewController
//        let subView = UIView(frame: CGRect(x: 0, y: 60.0, width: self.view.frame.size.width, height: 45.0))
//        subView.addSubview((searchController?.searchBar)!)
//        view.addSubview(subView)
//        searchController?.searchBar.delegate = self
//        searchController?.searchBar.sizeToFit()
//        searchController?.searchBar.showsCancelButton = false
//        searchController?.hidesNavigationBarDuringPresentation = false
//        definesPresentationContext = true
        self.SearchTextField.delegate = self
        self.SearchTextField.layer.cornerRadius = 5
        self.SearchTextField.layer.masksToBounds = true
        SearchTextField.addTarget(self, action: #selector(typingName), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @objc func typingName(textField:UITextField)
    {
        if let typedText = textField.text {
            googlePlacesResult(input: typedText) { (result) -> Void in
                print(result)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func googlePlacesResult(input: String, completion: @escaping (_ result: NSArray) -> Void)  {
        
        let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=AIzaSyDI3KfTjweOu_rjMSgzZpV3kq_GCxwPLvI&sessiontoken=1234567890",input)
        print(urlString)
        let url = NSURL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        
        //let url = URL(string: urlString as String)
        //print(url!)
        let defaultConfigObject = URLSessionConfiguration.default
        let delegateFreeSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        let request = NSURLRequest(url: url! as URL)
        let task =  delegateFreeSession.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, response, error) -> Void in
            if let data = data
            {
                do {
                    let jSONresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let results:NSArray = jSONresult["predictions"] as! NSArray
                    let status = jSONresult["status"] as? String ?? ""
                    if status == "NOT_FOUND" || status == "REQUEST_DENIED"
                    {
                        //                            let userInfo:NSDictionary = ["error": jSONresult["status"]!]
                        //                            let newError = NSError(domain: "API Error", code: 666, userInfo: userInfo as [NSObject : AnyObject])
                        //                            let arr:NSArray = [newError]
                        //                            completion(arr)
                        return
                    }
                    else
                    {
                        self.placeSearchArray.removeAllObjects()
                        self.placeSearchArray.addObjects(from: results as! [NSDictionary])
                        if self.placeSearchArray.count == 0 {
                          
                        }else{
                         
                            self.SearchTable.reloadData()
                        }
                        completion(results)
                    }
                }
                catch
                {
                    print("json error: \(error)")
                }
            }
            else if let error = error
            {
                print(error)
            }
        })
        task.resume()
    }
    
    
    
    //MARK:- Button Actions
    
    @IBAction func act_Cancel(_ sender: UIButton)
    {
//        let transition: CATransition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.release
//        transition.subtype = CATransitionSubtype.fromBottom
//        self.view.window!.layer.add(transition, forKey: nil)
        searchController?.searchBar.endEditing(true)
        //      self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func act_Back(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeSearchArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }

//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
        cell.selectionStyle = .none
        let tempDict = NSMutableDictionary()
        tempDict.addEntries(from: (placeSearchArray.object(at: indexPath.row)as? NSDictionary) as? [AnyHashable : Any] ?? [:])
        cell.LocationName.font = UIFont(name: SemiBoldFont, size: 15)
        cell.LocationName.text = (tempDict.object(forKey: "description") as? String ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
//        if isFrom == "exp" {
//            self.navigationController?.popViewController(animated: true)
//        }
//        else {
            var placeId = String()
            let tempDict = NSMutableDictionary()
        tempDict.addEntries(from: (placeSearchArray.object(at: indexPath.row)as? NSDictionary) as? [AnyHashable : Any] ?? [:])
            SearchTextField.text = (tempDict.object(forKey: "description") as? String ?? "")
            placeId = tempDict.object(forKey: "place_id")as? String ?? ""
        if isFrom != "exp" {
            self.searchLoctaionDelegate.getLocation(SearchResult: (tempDict.object(forKey: "description") as? String ?? ""))
            self.searchLoctaionDelegate.showPlaceList(searchResult: (tempDict.object(forKey: "description") as? String ?? ""))
        }
            //  self.navigationController?.popViewController(animated: true)
            self.getLatitudeLogitude(place_id: placeId){ (result) -> Void in
                print(result)
                
                let MomentaryLatitude = result.object(forKey: "lat")as? Double ?? 0
                let MomentaryLongitude = result.object(forKey: "lng")as? Double ?? 0
                var coordinate = CLLocationCoordinate2D()
                coordinate.latitude = MomentaryLatitude
                coordinate.longitude = MomentaryLongitude
                
                self.searchLoctaionDelegate?.getLocationFromCoordinates(lat: String(coordinate.latitude), long:String(coordinate.longitude))
                
                _ = CLLocationCoordinate2DMake(coordinate.latitude,coordinate.longitude)
                
                let lat = String(coordinate.latitude)
                let lon = String(coordinate.longitude)
                self.getAddressFromLatLon(pdblLatitude: lat, pdblLongitude: lon)
                
            }
            self.navigationController?.popViewController(animated: true)
//        }
    }
    
    func getLatitudeLogitude(place_id: String,completion: @escaping (_ result: NSDictionary) -> Void) {
        
        let urlString = NSString(format: "https://maps.googleapis.com/maps/api/place/details/json?input=&placeid=%@&key=AIzaSyDI3KfTjweOu_rjMSgzZpV3kq_GCxwPLvI",place_id)
        print(urlString)
        //let url = NSURL(string: urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        let url = URL(string: urlString as String)
        print(url!)
        let defaultConfigObject = URLSessionConfiguration.default
        let delegateFreeSession = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        let request = NSURLRequest(url: url! as URL)
        let task =  delegateFreeSession.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, response, error) -> Void in
            if let data = data
            {
                do {
                    let jSONresult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let resultsDict:NSDictionary = jSONresult["result"] as! NSDictionary
                    let geometryDict:NSDictionary = resultsDict["geometry"]as! NSDictionary
                    let locationDict:NSDictionary = geometryDict["location"]as! NSDictionary
                    let status = jSONresult["status"] as? String ?? ""
                    if status == "NOT_FOUND" || status == "REQUEST_DENIED"
                    {
                        //                            let userInfo:NSDictionary = ["error": jSONresult["status"]!]
                        //                            let newError = NSError(domain: "API Error", code: 666, userInfo: userInfo as [NSObject : AnyObject])
                        //                            let arr:NSArray = [newError]
                        //                            completion(arr)
                        return
                    }
                    else
                    {
                        completion(locationDict)
                    }
                }
                catch
                {
                    print("json error: \(error)")
                }
            }
            else if let error = error
            {
                print(error)
            }
        })
        task.resume()
    }
    
    func getAddressFromLatLon(pdblLatitude: String, pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if self.isFrom == "exp" {
                        var dict = [String:AnyObject]()
                        dict["locality"] = pm.locality as AnyObject
                        dict["pin"] = pm.postalCode as AnyObject
                        dict["country"] = pm.country as AnyObject
                        dict["name"] = pm.name as AnyObject
                        dict["subLocality"] = pm.subLocality as AnyObject
                        dict["localityOne"] = pm.subThoroughfare as AnyObject
                        dict["localityTwo"] = pm.thoroughfare as AnyObject
                        dict["lat"] = pm.location?.coordinate.latitude as AnyObject
                        dict["long"] = pm.location?.coordinate.longitude as AnyObject
                        UserDefaults.standard.removeObject(forKey: addressKey)
                        Helper.sharedInstance.setObjectForKey(addressKey, object: dict)
                    }
                    var addressString : String = ""
                    if pm.subThoroughfare != nil {
                        addressString = addressString + pm.subThoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                   
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                   print("addressString",addressString)
                   
                    if pm.postalCode != nil{
                      
                    }
                  
                }
        })
    }
    
}

extension SearchViewController: UISearchBarDelegate
{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        self.dismiss(animated: true, completion: nil)
        //       let transition: CATransition = CATransition()
        //        transition.duration = 0.5
        //        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //        transition.type = CATransitionType.reveal
        //        transition.subtype = CATransitionSubtype.fromBottom
        //        self.view.window!.layer.add(transition, forKey: nil)
        //        searchBar.endEditing(true)
        //        //self.dismiss(animated: false, completion: nil)
        //        //self.navigationController?.popViewController(animated: true)
    }
    func didPresentSearchController(searchController: UISearchController)
    {
        searchController.searchBar.showsCancelButton = false
    }
}

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate
{
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace)
    {
        
        searchController?.isActive = false
        locationName = place.name
       
        if searchLoctaionDelegate != nil{
            searchLoctaionDelegate?.getLocationFromCoordinates(lat: String(place.coordinate.latitude), long:String(place.coordinate.longitude))
            searchLoctaionDelegate.getLocation(SearchResult: place.name!)
            searchLoctaionDelegate.showPlaceList(searchResult: place.name!)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error)
    {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController)
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool
    {
        return true
    }
}
