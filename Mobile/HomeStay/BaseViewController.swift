//
//  BaseViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 17/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     @param uiView - add activity indicator to this view
     */
    
    func showActivityIndicator(uiView: UIView, isFulLoader: Bool = false) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue:0xffffff, alpha: (isFulLoader ? 1.0 : 0.3))
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func showActivityIndicatorFullScreen(uiView: UIView) {

            container.frame = uiView.frame

            container.center = uiView.center

            container.backgroundColor =  UIColor.white //UIColorFromHex(rgbValue:0xffffff, alpha: 1.0)

            loadingView.frame = CGRect(x: 0, y: 0, width: uiView.bounds.width, height: uiView.bounds.height)

            loadingView.center = uiView.center

            loadingView.backgroundColor = UIColor.white//UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)

            loadingView.clipsToBounds = true

            loadingView.layer.cornerRadius = 10

            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)

            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray

            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);

            loadingView.addSubview(activityIndicator)

            container.addSubview(loadingView)

            uiView.addSubview(container)

            activityIndicator.startAnimating()

        }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //convert 12 hours format
    func convertTwelveHoursFormat(actualDate:String)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "H:mm"
        if let inDate = dateFormatter.date(from: actualDate) {
            dateFormatter.dateFormat = "h:mm a"
            let outTime = dateFormatter.string(from:inDate)
            return outTime
        }
        return actualDate
    }
    
    func showToast(forMessage: String) {
        let alert = UIAlertController(title: "", message: forMessage, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2.5
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    func getCategory() -> String {
        switch Int(Singleton.sharedInstance.selectedCategory!) {
        case 1:
            return "FLIGHT"
        case 2:
            return "HOTEL"
        case 3:
            return "CAR"
        case 4:
            return "VAN"
        case 5:
            return "RESORT"
        case 6:
            return "RESTAURANT"
        case 7:
            return "OFFICE"
        case 8:
            return "EXPERIENCE"
        default:
            return " "
        }
    }*/
    
    func getCategory() -> String {
       switch Int(Singleton.sharedInstance.selectedCategory!) {
        case 1:
            return "HOTEL"
        case 2:
            return "OFFICE"
        case 3:
            return "RESORT"
        case 4:
            return "CAR"
        case 5:
            return "VAN"
        case 6:
            return "RESTAURANT"
        case 7:
            return "FLIGHT"
        default:
            return " "
        }
    }
}




