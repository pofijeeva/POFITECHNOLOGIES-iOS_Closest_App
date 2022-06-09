//
//  ProfileViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 25/09/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AFNetworking

class ProfileViewController: BaseViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var btn_Camera: UIButton!
    @IBOutlet weak var txfFirstName: UITextField!
    @IBOutlet weak var txfLastname: UITextField!
    @IBOutlet weak var txfPhonenum: UITextField!
    @IBOutlet weak var txfAboutme: UITextField!
    @IBOutlet weak var txfWork: UITextField!
    @IBOutlet weak var titlebl: UILabel!

    var firstName = String()
    var lastName = String()
    var phoneNum = String()
    var abtMe = String()
    var work = String()
    var UserImg = String()
    var imagePicker = UIImagePickerController()
    var userpic = String()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.img_Profile.layer.masksToBounds = true
        self.img_Profile.layer.cornerRadius = 50
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        //self.img_Profile.imageFromURL(urlString: self.UserImg)
        self.userpic = UserDefaults.standard.value(forKey: "USER_IMAGE") as! String
        print(userpic)
        let url = URL(string: UserDefaults.standard.value(forKey: "USER_IMAGE") as! String)
        self.img_Profile.kf.setImage(with: url, placeholder:UIImage(named:"user"))
       // self.img_Profile.imageFromURL(urlString:  UserDefaults.standard.value(forKey: "USER_IMAGE") as! String)
        // Do any additional setup after loading the view.
    }
        override func viewWillAppear(_ animated: Bool)
        {
            
            self.titlebl.font = UIFont(name: SemiBoldFont, size: 20)
            self.txfFirstName.font = UIFont(name: RegularFont, size: 15)
             self.txfLastname.font = UIFont(name: RegularFont, size: 15)
             self.txfPhonenum.font = UIFont(name: RegularFont, size: 15)
             self.txfWork.font = UIFont(name: RegularFont, size: 15)
             self.txfAboutme.font = UIFont(name: RegularFont, size: 15)
            
            
            
        self.txfFirstName.text  = login_session.string(forKey: "Firstname")
        self.txfLastname.text = login_session.string(forKey: "Lastname")
        self.txfPhonenum.text = self.phoneNum
        self.txfWork.text = self.work
        self.txfAboutme.text = self.abtMe
       }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func act_Backbtn(_ sender: UIButton)
    {
    self.navigationController?.popViewController(animated: true)
    }
    @IBAction func act_BtnSave(_ sender: UIButton)
    {
         uploadImageInMultipart()
    }
  
    @IBAction func act_SelectPhoto(_ sender: UIButton)
    {
        let actionSheet = UIAlertController(title: "Closest", message: "Choose Image", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
            self.openGallary()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
   
        switch UIDevice.current.userInterfaceIdiom
        {
        case .pad:
            actionSheet.popoverPresentationController?.sourceView = sender
            actionSheet.popoverPresentationController?.sourceRect = sender.bounds
            actionSheet.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(actionSheet, animated: true, completion: nil)
      
    }
    
    func openCamera()
    {
    if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadImageInMultipart() {
        showActivityIndicator(uiView: self.view)
        var params = NSMutableDictionary()
        params = [
            "u_first_name": "\(self.txfFirstName.text!)",
            "u_last_name": "\(self.txfLastname.text!)",
            "userid": "\(login_session.value(forKey: "UserId")!)",
            "u_phone": "\(self.txfPhonenum.text!)",
            "u_about": "\(self.txfAboutme.text!)",
            "work": "\(self.txfWork.text!)",
            "device_type" : "IOS"
        ]
        print(params)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = Set(["text/plain", "text/html", "application/json"]) as Set<String>?
        let urlString:NSString = NSString(format: "%@",UPDATE_USER_DETAILS_API)
        print(urlString)
        manager.post(urlString as String, parameters: params, headers: ["Authorization":""], constructingBodyWith: {
            (data: AFMultipartFormData!) in
            let imageData:Data = UIImageJPEGRepresentation(self.img_Profile.image!, 0.5)!
            data.appendPart(withFileData: imageData, name: "photos", fileName: "profile.jpeg", mimeType: "image/jpeg")
        }, progress: nil, success: {
            (operation, responseObject) in
            self.hideActivityIndicator(uiView: self.view)
            //UserDefaults.standard.set(user_image, forKey: "ProfileImage")
            let responseDictionary:NSDictionary = responseObject as! NSDictionary
            if responseDictionary.value(forKey: "status") as! Int == 1 {
                self.showInformation(title: "Closest", message: "Successfully Updated")
                let ProfInfo = responseDictionary.value(forKey: "profileinfo") as? NSArray
                for num in 0..<ProfInfo!.count {
                    let profDict = ProfInfo![num] as! NSDictionary
                    let imgStr:String = profDict.value(forKey: "user_image") as! String
                    print(imgStr)
                    login_session.setValue(imgStr, forKey: "ProfilePic")
                    UserDefaults.standard.set(imgStr, forKey: "ProfileImage")
                }
                let str = ProfInfo?.value(forKey: "accno")
                print(str!)
                print("Profile Update Response Dictionary",responseDictionary)
                //self.showAlertWithDistructiveButton()
            }
            else {
                self.showInformation(title: "Warning", message: responseDictionary.value(forKey: "message") as! String)
            }
        }, failure: {
            (operation, error) in
            self.hideActivityIndicator(uiView: self.view)
            print(error.localizedDescription)
            self.showInformation(title: "Warning", message:error.localizedDescription)
        })
    }
    
//    func showAlertWithDistructiveButton() {
//        let alert = UIAlertController(title: "Closest", message: "You can always access your content by signing back in", preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title: "Updated Successfully!", style: UIAlertActionStyle.default, handler: { _ in
//            self.navigationController?.popViewController(animated: true)
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
}
extension ProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imagepicked = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.img_Profile.image = imagepicked
        print(imagepicked)
        picker.dismiss(animated: true, completion: nil)
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension ProfileViewController : HTTP_POST_STRING_REQUEST_PROTOCOL
{
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String)
    {
        if APIKEY == "UPDATE_USER_DETAILS_API"
        {
            if errorDict.count == 0
            {
                hideActivityIndicator(uiView: self.view)
                print(responseDict)
                let alert = UIAlertController.init(title: "Closest", message: "Successfully Updated", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in

                }))
                //                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                print("Not Updated")
            }
            
        }
        else
        {
            print("Not Updated")
        }
    }
}
