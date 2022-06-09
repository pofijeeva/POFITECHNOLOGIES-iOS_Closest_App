//
//  AddPhotoViewController.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 03/08/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import Kingfisher
import AFNetworking
import Alamofire

class AddPhotoViewController: BaseViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var collPhotos: UICollectionView!
    @IBOutlet weak var lblPhotoDisc: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblAddPhotos: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var conPhotoCollHeight: NSLayoutConstraint!
    
    //MARK:- Variables
    var imagePicker = UIImagePickerController()
    //var imageARR = [UIImage]()
    var imageARR = NSMutableArray()
    var imARR = NSMutableArray()
    

    var selectedImagesArray = NSMutableArray()
    var imageDataARR = NSData()
    var ListingActivityDelegate: listingActivityProtocol!
    var PropertyID = Int()
    var imageCount = Int()
    var imageUrlARR = [String]()
    var imageFromResponse = ""
    var camera = String()
    var Gallery = String()
    var decodedString = String()
    var addPhotoBool = Bool()
    var nCount:Int = 0
    var selectedImageID:Int = 0
    let id = Singleton.sharedInstance.selectedCategory!
    
    //MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.btnAdd.layer.cornerRadius = self.btnAdd.frame.size.width / 2
        
        setData()
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        self.collPhotos.reloadData()
        addPhotoBool = true
        
        
           //imageARR.addObjects(from: (Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage[i-1].productImage!))
        
        print(forAddPhotoDict)
//            imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "photo_list")as! NSArray) as! [Any])
        if let photos = Singleton.sharedInstance.rentYourSpace.result.first?.step5.photo_list {
            imageARR.addObjects(from: photos)
        }
        
        if imageARR.count == 0 {
            self.conPhotoCollHeight.constant = 6
        }else{
            self.conPhotoCollHeight.constant = 120
        }


        nCount = imageARR.count
        
        if Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage.count == 0 {
            imageFromResponse = "NO"
        } else {
            imageFromResponse = "YES"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.lblAddPhotos.font = UIFont(name: SemiBoldFont, size: 18)
          self.lblPhotoDisc.font = UIFont(name: RegularFont, size: 15)
        self.btnSave.titleLabel?.font =  UIFont(name: SemiBoldFont, size: 16)
              self.btnSave.backgroundColor = AppColor
         self.btnAdd.backgroundColor = AppColor
        
        let choose =  lanuguage_selection.value(forKey: "language") as? String ?? "en"
        if choose == "en"
        {
            self.lblAddPhotos.text = LocalizeHelper().localizedStringForKey("addphoto")
            self.lblPhotoDisc.text = LocalizeHelper().localizedStringForKey("addmorephoto")
            self.btnSave.setTitle(LocalizeHelper().localizedStringForKey("save"), for: .normal)
            //self.btnAdd.setTitle(LocalizeHelper().localizedStringForKey("add"), for: .normal)
            camera = LocalizeHelper().localizedStringForKey("camera")
            Gallery = LocalizeHelper().localizedStringForKey("gallery")
            
        }
        
    }
    
    func setData()
    {
        if let result = Singleton.sharedInstance.rentYourSpace.result.first,
           let step5 = result.step5 {
            
        }
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImage = selectedImage.resizeWithWidth(width: 700)!
        self.imageARR.add(selectedImage)
        self.imARR.add(selectedImage)
        self.conPhotoCollHeight.constant = self.imageARR.count > 0 ? 120 : 6
        
        picker.dismiss(animated: true, completion: nil)
        self.collPhotos.reloadData()

//        self.imageDataARR = UIImagePNGRepresentation(selectedImage)! as NSData
//        picker.dismiss(animated: true, completion: nil)
//        selectedImagesArray.add(selectedImage)
//        print(selectedImagesArray.count)
//        imageARR.append(selectedImage)
//        print(imageARR.count)
//        if imageARR.count > 1
//        {
//            self.imageFromResponse = "NO"
//
//        }
//        addPhotoBool = true
//        DispatchQueue.main.async {
//            self.collPhotos.reloadData()
//        }
    }
    
    //MARK:- Button Actions
    @IBAction func act_AddPhoto(_ sender: UIButton) {
        //nCount = 0
        let actionSheet = UIAlertController(title: "Closest", message: "Choose Image", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
            self.openGallary()
        }))
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            actionSheet.popoverPresentationController?.sourceView = sender
            actionSheet.popoverPresentationController?.sourceRect = sender.bounds
            actionSheet.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(actionSheet, animated: true, completion: nil)
        
        /*actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
         self.imagePicker.delegate = self
         self.imagePicker.sourceType = .camera;
         self.imagePicker.allowsEditing = true
         self.present(self.imagePicker, animated: true, completion: nil)
         }))
         actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
         self.imagePicker.delegate = self
         self.imagePicker.sourceType = .photoLibrary;
         self.imagePicker.allowsEditing = true
         self.present(self.imagePicker, animated: true, completion: nil)
         }))
         actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         self.present(actionSheet, animated: true, completion: nil)*/
    }
    
    //MARK: - Open the camera
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
//    func act_Saved() {
//        var params = NSMutableDictionary()
//
//        params = [
//            "property_id": "\(self.PropertyID)",
//            "lang_code": "\(lanuguage_selection.value(forKey: "language") ?? "en")",
//            "photos" : ""]
//
//        print(params)
//
//        APIManager.apiPostWithHeaders(serviceName: SAVE_PHOTO_LISTING, parameters: params as! [String : Any]) { response, error in
//            DispatchQueue.main.async {
//                self.ListingActivityDelegate.hideActivity()
//            }
//
//            if error != nil {
//                self.showInformation(title: "Closest", message: error!.localizedDescription)
//            } else {
//                let mod = RentYourSpaceModel(fromDictionary: response as! [String : Any])
//                Singleton.sharedInstance.rentYourSpace = mod
//
//                sharedInstanceListing.gotoStepfive()
//            }
//        }
//
//
//
//    }
    
    
    @IBAction func act_Save(_ sender: UIButton) {
        
//        act_Saved()
        
//        return
        
        if imageARR.count == 0
        {
            self.showInformation(title: "Message", message: "Please select images for the rental")
//            ListingActivityDelegate.hideActivity()

        }
        else
        {


                var params = NSMutableDictionary()
                let id = Singleton.sharedInstance.selectedCategory!
                

               
                params = [
                    "property_id": self.PropertyID,
                    "lang_code": lanuguage_selection.value(forKey: "language") ?? "en"
                    
//                        "base_id": id,
//                        "user_id": "\(login_session.value(forKey: "UserId")!)",
//                        "currency_code": "\(login_session.value(forKey: "APP_CURRENCY")!)",
//                        "device_type" : "IOS"
                ]
                print(params)
                
                
                
                ListingActivityDelegate.showActivity()

//                    uploadImageInMultipart(parameters: params, sendImage: image as! UIImage)
                uploadImageInMultipart1(images: imARR)

            sharedInstanceListing.gotoStepfive()

            
                
//        print("imageARR",imageARR)
//        print("imageARR",imageARR.count)
//        if imageARR.count > 0
//        {
//            if addPhotoBool == true
//            {
//            addPhotoBool = false
//            newApiCAll()
//            }else
//            {
//                ListingActivityDelegate.hideActivity()
//            }
//        }
//        else
//        {
//            self.ListingActivityDelegate.hideActivity()
//            let alert  = UIAlertController(title: "Warning", message: "Add atleast One photo", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//
//        }
    }
        
    }
    
    // MARK: newApiCAll API Call
//    func newApiCAll()  {
//        var params = NSMutableDictionary()
//        let id = Singleton.sharedInstance.selectedCategory!
//        params = [
//            "property_id": "\(self.PropertyID)",
//            "lang_code": "\(lanuguage_selection.value(forKey: "language") ?? "en")",
//            "base_id": id,
//            "user_id": "\(login_session.value(forKey: "UserId")!)",
//            "currency_code": "\(login_session.value(forKey: "APP_CURRENCY")!)",
//            "device_type" : "IOS"
//        ]
//        print(params)
//        uploadImageInMultipart(parameters: params)
//    }
    
    func uploadImageInMultipart(parameters:NSMutableDictionary,sendImage:UIImage) {
        ListingActivityDelegate.showActivity()
        print(parameters)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = Set(["text/plain", "text/html", "application/json"]) as Set<String>?
        manager.post(SAVE_PHOTO_LISTING, parameters: parameters, headers: HeaderManager.headers(), constructingBodyWith: {
            (data: AFMultipartFormData!) in
            print(self.nCount)
            let imageData:Data = UIImageJPEGRepresentation(sendImage, 0.5)!
            data.appendPart(withFileData: imageData, name: "item_img[0]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
        }, progress: nil, success: {
            (operation, responseObject) in
            let responseDictionary:NSDictionary = responseObject as! NSDictionary
            print("Profile Update Response Dictionary",responseDictionary)
            let mod = RentYourSpaceModel(fromDictionary: responseDictionary as! [String : Any])
            Singleton.sharedInstance.rentYourSpace = mod
            self.ListingActivityDelegate.hideActivity()
            let result = responseDictionary.object(forKey: "result") as! NSArray
            forAddPhotoDict.removeAllObjects()
            forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
            print("forAddPhotoDict:::::",forAddPhotoDict)
            self.imageARR.removeAllObjects()
            self.imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
           

            if mod.status! != 0
            {
                self.nCount = self.nCount + 1
            }
            else
            {
                self.showInformation(title: "Closest", message: mod.message)
                
            }
            
            if self.nCount == self.imageARR.count
            {
                sharedInstanceListing.gotoStepfive()
            }
            
            
        }
            , failure: {
            (operation, error) in
            self.ListingActivityDelegate.hideActivity()
            print(error.localizedDescription)
        })
         
        
    }
    
    
    func uploadImageInMultipart1(images:NSMutableArray) {
        
        //Parameter HERE
        let parameters = [
            "property_id": "\(self.PropertyID)",
            "lang_code": lanuguage_selection.value(forKey: "language") ?? "en",
            
        ]
        //Header HERE
        print(parameters)
        
        let postheaders : HTTPHeaders = HeaderManager.headers()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            let nameofFile:String = (UUID().uuidString)
            for (indexValue,image) in images.enumerated() {
                let imgData = UIImageJPEGRepresentation(image as! UIImage,0.7)!
                multipartFormData.append(imgData, withName: "item_img[\(indexValue)]", fileName: "\(nameofFile).jpeg", mimeType: "image/jpeg")
                
                
            }
            for (key, value) in parameters {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            
        }, usingThreshold:UInt64.init(),
                         to:SAVE_PHOTO_LISTING, //URL Here
                         method: .post,
                         headers: postheaders, //pass header dictionary here
                         encodingCompletion: { (result) in
            
            switch result {
            case .success(let upload, _, _):
                print("the status code is :")
                
                upload.uploadProgress(closure: { (progress) in
                    print("something")
                })
                
                upload.responseJSON { response in
                    print("the resopnse code is : \(response.response?.statusCode)")
                    print("the response is : \(response)")
                    switch(response.result) {
                    case .success(_):
                        if let data = response.value{
                            let json = data as? NSDictionary
                            let responseDict:NSDictionary = json!
                            print(responseDict)
                            if responseDict.value(forKey: "code") as! NSNumber == 200 {
                                //    self.Homepagedata.addEntries(from: responseDict as! [AnyHashable : Any])
                                
                                //                                                let resData = responseDict["data"] as! [String:Any]
                                //                                                let verifyDict = resData["verification_arr"] as! [String:Any]
                                //                                                self.idVerifyStatus = verifyDict["u_idproof_verified_status"] as! Int
                                //                                                self.idProofImgUrl = verifyDict["u_idproof"] as! String
                                //
                                //                                                self.viewPassportverify.isHidden = true
                                //                                                self.verificationListTV.isHidden = false
                                //                                                self.verificationListTV.delegate = self
                                //                                                self.verificationListTV.dataSource = self
                                //                                                self.verificationListTV.reloadData()
                                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                                Singleton.sharedInstance.rentYourSpace = mod
                                self.ListingActivityDelegate.hideActivity()
                                //                                                let result = responseDict.object(forKey: "result") as! NSArray
                                //                                                forAddPhotoDict.removeAllObjects()
                                //                                                forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                                //                                                print("forAddPhotoDict:::::",forAddPhotoDict)
                                //                                                self.imageARR.removeAllObjects()
                                //                                                self.imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
                                
                                
                                //                                                if mod.status! != 0
                                //                                                {
                                //                                                    self.nCount = self.nCount + 1
                                //                                                }
                                //                                                else
                                //                                                {
                                //                                                    self.showInformation(title: "Closest", message: mod.message)
                                //
                                //                                                }
                                
                                //                                                if self.nCount == self.imageARR.count
                                //                                                {
                                sharedInstanceListing.gotoStepfive()
                                //                                                }
                                
                                
                                
                            }
                            
                        }
                        break
                    case .failure(_):
                        // add your error alert message here
                        break
                    }
                    
                }
                break
            case .failure(let encodingError):
                print("the error is  : \(encodingError.localizedDescription)")
                break
            }
        })
        
    }
    
    //MARK: - Button call method
    @objc func deleteButtonClicked(sender:UIButton) {
        
        ListingActivityDelegate.showActivity()
        let imageType = imageARR.object(at: sender.tag)
        if imageType is UIImage
        {
            imageARR.removeObject(at: sender.tag)
            self.collPhotos.reloadData()
            ListingActivityDelegate.hideActivity()

        }
        else
        {
             ListingActivityDelegate.showActivity()
            let imageID:Int = Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage[sender.tag].productImageId!
            print("imageID is:",imageID)
            selectedImageID = imageID
            print("selectedImageID is:",selectedImageID)
            ListingActivityDelegate.showActivity()
            
//            "image_id":"21",
//            "lang_code":"en"
            
//            APIManager.apiPostWithHeaders(serviceName: DELETE_PHOTO_LISTING, parameters: params as? [String : Any]) { response, error in
//                DispatchQueue.main.async {
//                    self.ListingActivityDelegate?.hideActivity()
//                }
            
            
            
            let url = URL(string: DELETE_PHOTO_LISTING)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let postString = "image_id=\(self.selectedImageID)"
            print("postString is : \(postString)")
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                     self.ListingActivityDelegate.hideActivity()
                    print("error=\(error!)")
                    self.showInformation(title: "Closest", message:(error?.localizedDescription)!)
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response!)")
                }
                if let responseObject = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(responseObject)
                    self.ListingActivityDelegate.hideActivity()

                    if responseObject.value(forKey: "status") as! Int == 1 {
                       
                        self.createdPropertyStatusApiCall()
                        self.showInformation(title: "Closest", message:responseObject.value(forKey: "message") as! String)
                    }
                    else {
                        self.showInformation(title: "Closest", message:responseObject.value(forKey: "message") as! String)
                    }
                } else {
                    print("response was: \(String(describing: response))")
                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    print("responseString was: \(String(describing: responseString))")
                    let responseString1 = String(data: data, encoding: .utf8)
                    print("responseString1 = \(responseString1!)")
                }
            }
            task.resume()
            

        }

//        let deleteBtnRow = sender.tag
//        print("deleteBtnRow is:",deleteBtnRow)
//        let imageID:Int = Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage[deleteBtnRow].productImageId!
//        print("imageID is:",imageID)
//        selectedImageID = imageID
//        print("selectedImageID is:",selectedImageID)
//        if selectedImageID != 0 {
//            deleteImageApiCall(sender: deleteBtnRow)
//        }
//        else {
//            print("selectedImageID is:",selectedImageID)
//        }
    }
    
    // MARK: Delete Image Api Call
    func deleteImageApiCall(sender:UIButton)
    {
        let imageType = imageARR.object(at: sender.tag)

        if imageType is UIImage
        {
            imageARR.removeObject(at: sender.tag)
            self.collPhotos.reloadData()
        }
        else
        {
            
        }
        
        //let url = URL(string: "http://flight.mytaxisoft.com/json/property_image_delete")!
        let url = URL(string: DELETE_PHOTO_LISTING)!
        var request = URLRequest(url: url)
//        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(HeaderManager.headers())", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("my-secret-key", forHTTPHeaderField: "X-Mashape-Key"
        request.httpMethod = "POST"
//        let postString = "image_id=\(self.selectedImageID)"
        let parm = ["lang_code": lanuguage_selection.value(forKey: "language") ?? "en","image_id" : (self.selectedImageID)] as Dictionary
        print(" parm is : \(parm)")
        request.httpBody = try! JSONSerialization.data(withJSONObject: parm, options: [])
//        request.httpBody = parm.data(using: .utf8)
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error!)")
                self.showInformation(title: "Closest", message:(error?.localizedDescription)!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            if let responseObject = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                print(responseObject)
                if responseObject.value(forKey: "status") as! Int == 1 {
                    //self.showInformation(title: "Closest", message:responseDictionary.value(forKey: "message") as! String)
                    self.getImagesApiCall()
                }
                else {
                    self.showInformation(title: "Closest", message:responseObject.value(forKey: "message") as! String)
                }
            } else {
                print("response was: \(String(describing: response))")
                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("responseString was: \(String(describing: responseString))")
                let responseString1 = String(data: data, encoding: .utf8)
                print("responseString1 = \(responseString1!)")
            }
        }
        task.resume()
         ListingActivityDelegate.hideActivity()
    }
    
    
    func createdPropertyStatusApiCall()
    {
        Network.shared.HTTP_POST_STRING_REQUEST_DELEGATE = self
        if Reachability()!.isReachable
        {
            
            showActivityIndicator(uiView: self.view)
            var params = NSMutableDictionary()
              params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","property_id":self.PropertyID,"base_id":Singleton.sharedInstance.selectedCategory!]
          
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(CREATED_PROPERTY_STATUS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.rentYourSpace = mod
                    let result = responseDict.object(forKey: "result") as! NSArray
                    
                   
                    
                    forAddPhotoDict.removeAllObjects()
                    forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                    print("CREATED_PROPERTY_STATUS forAddPhotoDict:::::",forAddPhotoDict)
                    self.imageARR.removeAllObjects()
                    self.imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
                    self.nCount = self.imageARR.count
                    self.collPhotos.reloadData()

                    
                    
                    
                    
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
            
            
            
            
            
            
            
//            ListingActivityDelegate?.showActivity()
//            let  parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&property_id=\(self.PropertyID)&base_id=\(Singleton.sharedInstance.selectedCategory!)"
//            print(parameterStr)
//
//
//
//
//
//
//
//            Network.shared.POSTRequest(withParameterString:parameterStr, serviceURL: CREATED_PROPERTY_STATUS, APIKEY: "CREATED_PROPERTY_STATUS")
        } else {
            showInformation(title: "Closest", message: "Please check your internet connection.")
        }

    }
    
    // MARK: Get Images Api Call
    func getImagesApiCall() {
        
        
        
//        {
//        "lang_code":"en",
//        "photos":"",
//        "property_id":"41884"
//        }
        
        
//        APIManager.apiPostWithHeaders(serviceName: SAVE_PHOTO_LISTING, parameters: params as? [String : Any]) { response, error in
//            DispatchQueue.main.async {
//                self.ListingActivityDelegate?.hideActivity()
//            }

        let id = Singleton.sharedInstance.selectedCategory!
        //let url = URL(string: "http://flight.mytaxisoft.com/json/mobile_add_property_step5")!
        let url = URL(string: SAVE_PHOTO_LISTING)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "property_id=\(self.PropertyID)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(id)&user_id=\(login_session.value(forKey: "UserId")!)&currency_code=\(login_session.value(forKey: "APP_CURRENCY")!)"
        print("postString is : \(postString)")
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error!)")
                self.showInformation(title: "Closest", message:(error?.localizedDescription)!)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response!)")
            }
            if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            {
                print("getImagesApiCall.....", responseDictionary)
                let mod = RentYourSpaceModel(fromDictionary: responseDictionary as! [String : Any])
                if mod.status! != 0 {
                    Singleton.sharedInstance.rentYourSpace = mod
                    
                    DispatchQueue.main.async {
                        let result = responseDictionary.object(forKey: "result") as! NSArray
                        forAddPhotoDict.removeAllObjects()
                        forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                        print("forAddPhotoDict:::::",forAddPhotoDict)
                        self.imageARR.removeAllObjects()
                        self.imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
                      
                        self.collPhotos.reloadData()
                    }
                    if Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage.count == 0{
                        self.imageFromResponse = "NO"
                    } else {
                        self.imageFromResponse  = "YES"
                    }
                    self.showInformation(title: "Closest", message: "Successfully Removed!")
                }
                else {
                    self.showInformation(title: "Closest", message: mod.message)
                }
            } else {
                print("response was: \(String(describing: response))")
                let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print("responseString was: \(String(describing: responseString))")
                let responseString1 = String(data: data, encoding: .utf8)
                print("responseString1 = \(responseString1!)")
            }
        }
        task.resume()
    }
    
    func uploadPhotos(base64: String) {
        print("charCount",base64.count)
        if Reachability()!.isReachable {
            let id = Singleton.sharedInstance.selectedCategory!
            // user_id=\(login_session.value(forKey: "UserId")!)&
            let parameterStr = "property_id=\(self.PropertyID)&photos=\(base64)&lang_code=\(lanuguage_selection.value(forKey: "language") ?? "en")&base_id=\(id)&user_id=\(login_session.value(forKey: "UserId")!)"
            Network.shared.POSTRequest(withParameterString: parameterStr, serviceURL: SAVE_PHOTO_LISTING, APIKEY: "SAVE_PHOTO_LISTING")
            //print(parameterStr)
        } else {
            showInformation(title: "Network Error", message: "Please check your internet connection")
        }
    }
    
}

extension AddPhotoViewController: UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        
        return imageARR.count

        
//        if imageFromResponse == "NO"
//        {
//            return imageARR.count
//        }
//        else
//        {
//            return Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage.count
//        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddPhotoCell
        
        cell?.btnDeleteOne.layer.cornerRadius = (cell?.btnDeleteOne.frame.width)! / 2
        cell?.btnDeleteOne.tag = indexPath.row;
        cell?.btnDeleteOne.addTarget(self,action:#selector(deleteButtonClicked(sender:)), for: .touchUpInside)
        cell?.imgOne.contentMode = .scaleAspectFill
        let imageType = imageARR.object(at: indexPath.row)
        if let image = imageType as? UIImage
        {
            cell?.imgOne.image = image

        }
        else
        {
            let url = URL(string: Singleton.sharedInstance.rentYourSpace.result[0].step5.photo_list[indexPath.row].imagePath!)
            cell!.imgOne.kf.setImage(with: url)
        
        }
        
        if self.imageARR.count == 0
        {
           cell?.btnDeleteOne.isHidden = true
           cell?.imgOne.isHidden = true
        }
        else
        {
            cell?.btnDeleteOne.isHidden = false
            cell?.imgOne.isHidden = false

        }
        
        return cell!
    }
}
extension AddPhotoViewController: HTTP_POST_STRING_REQUEST_PROTOCOL {
    func httpPostRequest(APIKEY: String, requestURL: String, responseDict: NSDictionary, errorDict: String) {
        ListingActivityDelegate.hideActivity()
        if APIKEY == "SAVE_PHOTO_LISTING"{
             ListingActivityDelegate.hideActivity()
            if errorDict.count == 0 {
                print(responseDict)
                let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                mod.result.first?.step6
                UserDefaults.standard.set(responseDict.value(forKey: "attribute"), forKey: "AmenitiesArray")
                if mod.status! != 0 {
                    Singleton.sharedInstance.rentYourSpace = mod
                    if Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage.count == 0{
                        imageFromResponse = "NO"
                    } else {
                        imageFromResponse  = "YES"
                    }
                }
                self.showInformation(title: "Closest", message: mod.message)
            }
            else {
                
            }
        }
        else if APIKEY == "CREATED_PROPERTY_STATUS"
        {
            if errorDict.count == 0 {
                print(responseDict)

            let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
            Singleton.sharedInstance.rentYourSpace = mod
            let result = responseDict.object(forKey: "result") as! NSArray
            
//            commonMaintainListDataDict.removeAllObjects()
//            commonMaintainListDataDict.addEntries(from: responseDict as! [AnyHashable : Any])
//            print("commonMaintainListDataDict count:::",commonMaintainListDataDict.count)
//            let attributeArray:NSArray = responseDict.value(forKey: "attribute") as! NSArray
//            print("attribute array : ", attributeArray)
                
            forAddPhotoDict.removeAllObjects()
            forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
            print("CREATED_PROPERTY_STATUS forAddPhotoDict:::::",forAddPhotoDict)
                self.imageARR.removeAllObjects()
                self.imageARR.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
                  self.nCount = self.imageARR.count
                self.collPhotos.reloadData()

            }
        }
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, jpegQuality.rawValue)
    }
}
extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Int) -> UIImage? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = UIImageJPEGRepresentation(self, compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
