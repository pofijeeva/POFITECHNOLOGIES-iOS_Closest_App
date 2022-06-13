//
//  Helper.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 13/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.

import Foundation
import UIKit

// Protocols

protocol DropDownProtocol {
    func getValueFromDropDown(value: String , Key: Any)
}

protocol listingActivityProtocol {
    func showActivity()
    func hideActivity()
}

protocol CalenderProtocol {
    func showCalender()
    func hideCalender()
}


// Information
extension UIViewController {
    
    //MARK:- Variables
    var activityIndicatorTag: Int { return 999999 }
    
    //MARK:- Alert
    // Alert with single Button
    func showInformation(title: String,message: String)
    {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Alert with two Button
    func showAlert(title: String,message: String,yesButton: String,noButton: String,yes_Action: @escaping ((_: UIAlertAction) -> Void) ,no_Action: @escaping ((_: UIAlertAction) -> Void))
    {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: yesButton, style: .default, handler: yes_Action))
        alert.addAction(UIAlertAction(title: noButton, style: .cancel, handler: no_Action))
        self.present(alert, animated: true, completion: nil)
    }
}
//MARK: - Email validation

// To check the email format
func isValidEmail(email:String?) -> Bool {
    guard email != nil else { return false }
    let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
    return pred.evaluate(with: email)
}
func validateUrl (urlString: NSString) -> Bool {
    let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
}
//MARK:- To clear the session details

func clearUserSession(){
    let domain = Bundle.main.bundleIdentifier!
   login_session.removePersistentDomain(forName: domain)
   login_session.synchronize()
     UserDefaults.standard.removeObject(forKey: "ProfileImage")
    UserDefaults.standard.synchronize()
}

func clearAppSession(){
    let domain = Bundle.main.bundleIdentifier!
    app_session.removePersistentDomain(forName: domain)
    app_session.synchronize()
}


//MARK:- DropDown Height

func setDropDownHeight(items: Int) -> CGFloat{
    if items == 0 {
        return 150.0
    } else if items <= 7 {
        return  50.0 * CGFloat(items) + 100.0
    } else {
        return 500.0
    }
}

//MARK: - View Extensions

extension UIView {
    
    // To set Shaddow of particular view
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.75
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 5.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // To set shake effect of particular view
    // Usage: Wrong validations
    func shakeEffect(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func setBorder(withColor: UIColor,width: CGFloat,cornerRadius: CGFloat){
            self.layer.cornerRadius = cornerRadius
            self.layer.borderColor = withColor.cgColor
            self.layer.borderWidth = width
    }
    
    
}

//MARK: - Button extension

extension UIButton {
    
    // To set corner radius of the particular button
    // Usage: Rounded corners
    
    func roundedCorner(){
        self.layer.cornerRadius = 5.0
    }
    
    func startAnimating() {
        self.isEnabled = false
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        let buttonHeight = self.bounds.size.height
        let buttonWidth = self.bounds.size.width
        indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
        let scale = max(min((self.frame.size.height - 4) / 21, 2.0), 0.0)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        indicator.transform = transform
        self.addSubview(indicator)
        indicator.startAnimating()
    }

    
    func stopAnimating() {
        self.isEnabled = true
        if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}

//MARK:- Image Extension

extension UIImageView {
    
        public func imageFromURL(urlString: String) {
            
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            activityIndicator.startAnimating()
            if self.image == nil {
                self.addSubview(activityIndicator)
            }
            
            var urlString1 = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)

            URLSession.shared.dataTask(with: NSURL(string: urlString1!)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    activityIndicator.removeFromSuperview()
                    self.image = image
                })
                
            }).resume()
        }
    }
    
public enum ImageFormat {
    case PNG
    case JPEG(CGFloat)
}

extension UIImage {
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    public func base64(format: ImageFormat) -> String {
        var imageData: Data
        switch format {
        case .PNG: imageData = self.pngData()!
        case .JPEG(let compression): imageData = self.jpegData(compressionQuality: compression)!
        }
        return imageData.base64EncodedString()
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIImageView {
    func circleImageView() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
extension UITextView {
    
    func set(placeHolder: String) {
        self.text = placeHolder
        self.textColor = UIColor.lightGray
    }
    
    func removePlaceholder() {
        self.text = ""
        self.textColor = UIColor.black
    }
    
}

class Helper: NSObject {
    static let sharedInstance = Helper()
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    let VC = UIViewController()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func isConnectedToInternet() -> Bool {
        let reach = Reachability()
        if reach!.isReachable {
            return true
        }
        else {
            return false
        }
    }
    
    func showActivity() {
        container.frame = VC.view.frame
        container.center = VC.view.center
        container.backgroundColor = UIColor(hex: 0xffffff)
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = VC.view.center
        loadingView.backgroundColor = UIColor(hex: 0x444444)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2);
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        VC.view.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    func getObjectForKey(_ key:String) -> Dictionary<String,AnyObject> {
        if UserDefaults.standard.object(forKey: key) != nil {
            let newData: Data = UserDefaults.standard.object(forKey: key) as! Data
            if let dicDetails = NSKeyedUnarchiver.unarchiveObject(with: newData) as? Dictionary<String,AnyObject> {
                return dicDetails
            }
        }
        return [:]
    }
    func setObjectForKey(_ key:String, object:Dictionary<String,AnyObject>) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        UserDefaults.standard.set(data, forKey: key)
    }

  
     func showActivityIndicator(view: UIView, targetVC: UIViewController) {

        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        activityIndicator.backgroundColor = UIColor(hex: 0xBFBFC2)//UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        let height = CGPoint(x: targetVC.view.center.x, y: targetVC.view.center.y - 100.0)
        activityIndicator.center = height
        activityIndicator.hidesWhenStopped = true
         activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.tag = 1
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

     func hideActivityIndicator(view: UIView) {
        let activityIndicator = view.viewWithTag(1) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func UpdateTextfield(_ textField: UITextField) {
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = BorderColor.cgColor
//        textField.layer.shadowColor = UIColor(hex: 0xBFBFC2).cgColor
//        textField.layer.shadowOffset = CGSize.zero
//        textField.layer.shadowOpacity = 0.6
        textField.layer.cornerRadius = 5
//        textField.isEnabled = true
//        textField.isUserInteractionEnabled = false
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 44))
        textField.leftView = spaceView
        textField.leftViewMode = .always
        textField.backgroundColor = UIColor.white
    }
   
    
}

