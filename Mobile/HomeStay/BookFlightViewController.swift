//
//  BookFlightViewController.swift
//  HomeStay
//
//  Created by apple4 on 04/01/19.
//  Copyright © 2019 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BookFlightViewController: BaseViewController,HTTP_GET_STRING_REQUEST_PROTOCOL,HTTP_POST_STRING_REQUEST_PROTOCOL {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var bookAFlightLbl: UILabel!
    @IBOutlet weak var flightListTableView: UITableView!
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var grayScrollView: UIScrollView!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var topRedView: UIView!
    @IBOutlet weak var popFlightNameLbl: UILabel!
    @IBOutlet weak var popFlightImageView: UIImageView!
    
    @IBOutlet weak var refundStatusView: UIView!
    
    @IBOutlet weak var refundStatusLineView: UIView!
    
    @IBOutlet weak var refundStatusLbl: UILabel!
    
    @IBOutlet weak var refundStatusValueLbl: UILabel!
    
    @IBOutlet weak var locationDetailsView: UIView!
    
    @IBOutlet weak var locationDetailsLineView: UIView!
    
    @IBOutlet weak var departLbl: UILabel!
    @IBOutlet weak var departAirportNameLbl: UILabel!
    @IBOutlet weak var departValueLbl: UILabel!
    
    @IBOutlet weak var arriveLbl: UILabel!
    @IBOutlet weak var arriveAirportNameLbl: UILabel!
    @IBOutlet weak var arriveValueLbl: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var dateTimeView: UIView!
    
    @IBOutlet weak var departDateTimeLbl: UILabel!
    
    @IBOutlet weak var departTimeLbl: UILabel!
    
    @IBOutlet weak var arriveTimeLbl: UILabel!
    
    @IBOutlet weak var departDateLbl: UILabel!
    
    @IBOutlet weak var arrivalDateLbl: UILabel!
    
    @IBOutlet weak var datetimeArrowImageView: UIImageView!
    
    @IBOutlet weak var bookNowBtn: UIButton!
    
    @IBOutlet weak var bottomStopsLbl: UILabel!
    
    @IBOutlet weak var locationDetailsBtn: UIButton!
    
    @IBOutlet weak var dateTimeDetailsBtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    var departDateStr = String()
    var arriveDateStr = String()
    var classString:String = ""
    
    var fromAirportNameStr:String = ""
    var toAirportNameStr:String = ""
    var typeOfBookingString = String()
    
    var adultPassengerString:String = "0"
    var childrenPassengerString:String = "0"
    var infantPassengerString:String = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grayScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+150)
        grayScrollView.isHidden = true
        Network.shared.HTTP_GET_STRING_REQUEST_DELEGATE = self
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        flightListTableView.delegate = self
        flightListTableView.dataSource = self
        // Do any additional setup after loading the view.
        //getFlightListApiCall()
    }
    
    //MARK:- GetRequest Methods
    func httpGetRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorStr: String) {
        self.hideActivityIndicator(uiView: self.view)
    }
    //MARK:- PostRequest Methods
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        if APIKEY == "FLIGHT_SEARCH" {
            if (responseDict.value(forKey: "status")  as? Int) == 1{
                print(responseDict)
                let mod = FlightSearch(fromDictionary: responseDict as! [String : Any])
                Singleton.sharedInstance.flightSearchforBookAlistModel = mod
            } else {
                self.showInformation(title: "ePickMeUp", message: responseDict.value(forKey: "message") as! String)
            }
        }
        self.hideActivityIndicator(uiView: self.view)
    }
    
    //MARK:- Button Actions
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterBtnTapped(_ sender: Any) {
    }
    @IBAction func bookNowBtnTapped(_ sender: Any) {
    }
    @IBAction func locationDetailsBtnTapped(_ sender: Any) {
    }
    @IBAction func dateTimeDetailsBtnTapped(_ sender: Any) {
    }
    @IBAction func cancelBtntapped(_ sender: Any) {
    }
    
}
extension BookFlightViewController : UITableViewDelegate,UITableViewDataSource {
    //MARK:- UITableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Singleton.sharedInstance.flightSearchforBookAlistModel != nil {
            return Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookFlightTableViewCell") as? BookFlightTableViewCell
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        cell?.priceLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].totalFareAmount
        cell?.flightNameLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].airlinename
        cell?.hoursLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].departureDetails.flightDuration
        cell?.fromAirportNameLAbel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].flightPopupDetails[0].departLocation
        cell?.toAirportNameLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].flightPopupDetails[0].arriveLocation
        cell?.departTimeLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].departureDetails.departTime
        cell?.arriveTimeLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].departureDetails.arrivalTime
        cell?.departPlaceNameLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].departureDetails.departLocation
        cell?.arrivePlaceNameLabel.text = Singleton.sharedInstance.flightSearchforBookAlistModel.flightDetails[indexPath.row].departureDetails.arrivalLocation
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.flightListTableView {
            return 185
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        grayScrollView.isHidden = false
    }
}
