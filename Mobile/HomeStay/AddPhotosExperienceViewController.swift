//
//  AddPhotosExperienceViewController.swift
//  HomeStay
//
//  Created by dineshkumarr on 30/01/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import UIKit
import AFNetworking

class AddPhotosExperienceViewController: UIViewController, UIImagePickerControllerDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
 
    

    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var viewcameraBackground: UIView!
    @IBOutlet weak var labelAddPhotos: UILabel!
    @IBOutlet weak var labelShortDescription: UILabel!
    @IBOutlet weak var collectionList: UICollectionView!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var viewAddPhoosExperience: UIView!
    @IBOutlet weak var heightCollectionList: NSLayoutConstraint!
    
    var imagePickerCont = UIImagePickerController()
    var arrayOfItems = [String]()
    var imageArray = NSMutableArray()
    var selectedImageID:String = ""
    var PropertyID = Int()
    var nCount:Int = 0
    var indexForTag = 0

//    var imageAR =

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelDescription.textColor = .darkGray
        
        self.buttonNext.titleLabel?.font = UIFont(name: RegularFont, size: 17.0)
        self.buttonNext.layer.cornerRadius = 5.0
        
        self.labelAddPhotos.font = UIFont(name: RegularFont, size: 15.0)
        self.labelAddPhotos.textColor = .darkGray
        
        self.labelShortDescription.font = UIFont(name: RegularFont, size: 15.0)
        self.labelShortDescription.textColor = .darkGray
        
        self.viewcameraBackground.layer.cornerRadius = 5
        
        
        self.viewAddPhoosExperience.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showPhotoMenu))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        self.viewAddPhoosExperience.addGestureRecognizer(tap)
       
        
        guard let text = self.labelAddPhotos.text else { return }
              let textRange = NSMakeRange(0, text.count)
              let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        self.labelAddPhotos.attributedText = attributedText
        
        if arrayOfResult.count > 0 {
            
            self.imageArray.removeAllObjects()
            self.imageArray.addObjects(from:(((arrayOfResult[0] as! NSDictionary).object(forKey: "Photos")as! NSDictionary).object(forKey: "exp_images")as! NSArray) as! [Any])
        }
        
        if imageArray.count == 0  {
            self.heightCollectionList.constant = 0
        }
        else {
            self.heightCollectionList.constant = 125
        }
        
        self.collectionList.reloadData()
        // Do any additional setup after loading the view.
    }
//    MARK: Functions and Obj-C functions:
    @objc func updateToPickImage() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePickerCont.delegate = self
            imagePickerCont.sourceType = .photoLibrary
            imagePickerCont.allowsEditing = true
            self.present(imagePickerCont, animated: true, completion: nil)
        }
    }
    @objc func updateToTakePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerCont.delegate = self
            imagePickerCont.sourceType = .camera
            imagePickerCont.allowsEditing = true
            self.present(imagePickerCont, animated: true, completion: nil)
        }
    }
    @objc func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil,
        preferredStyle: .actionSheet)

        let actCancel = UIAlertAction(title: "Cancel", style: .cancel,
        handler: nil)
        alert.addAction(actCancel)

        let actPhoto = UIAlertAction(title: "Take Photo",
        style: .default, handler: { _ in
            self.updateToTakePhoto()
        })

        alert.addAction(actPhoto)

        let actLibrary = UIAlertAction(title: "Choose From Library",
        style: .default, handler: { _ in
            self.updateToPickImage()
            })

        alert.addAction(actLibrary)

        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImage = selectedImage.resizeWithWidth(width: 700)!
        self.imageArray.add(selectedImage)
        print(self.imageArray)
        picker.dismiss(animated: true, completion: nil)
        if imageArray.count == 0 {
            self.heightCollectionList.constant = 0
        }
        else {
            self.heightCollectionList.constant = 125
        }
        self.collectionList.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    MARK: collection view delegate and datasource:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionList.dequeueReusableCell(withReuseIdentifier: "cellList", for: indexPath)
        let imageViewSource = cell.viewWithTag(10) as! UIImageView
        let buttonDelete = cell.viewWithTag(11) as! UIButton
        
        
        
        buttonDelete.layer.cornerRadius = buttonDelete.frame.width / 2
        ////buttonDelete.tag = indexPath.row;
        buttonDelete.accessibilityLabel = "\(indexPath.row)"
        indexForTag = indexPath.row
        buttonDelete.addTarget(self,action:#selector(deleteButtonClicked(sender:)), for: .touchUpInside)
        imageViewSource.contentMode = .scaleAspectFill
        let imageType = imageArray.object(at: indexPath.row)
        if let image = imageType as? UIImage
        {
            imageViewSource.image = image
        }
        else
        {
            let url = URL(string:(imageArray[indexPath.row] as! NSDictionary).object(forKey: "product_image") as! String)
            imageViewSource.kf.setImage(with: url)
        
        }
        if self.imageArray.count == 0
        {
            buttonDelete.isHidden = true
            imageViewSource.isHidden = true
        }
        else
        {
            buttonDelete.isHidden = false
            imageViewSource.isHidden = false

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 115.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    @objc func deleteButtonClicked(sender:UIButton) {
        
        Helper.sharedInstance.showActivity()
      //  let tag = Int(sender.accessibilityLabel!)
        let buttonPosition = sender.convert(CGPoint.zero, to: self.collectionList)
        let indexPath = self.collectionList.indexPathForItem(at: buttonPosition)
        print(indexPath!.row)
        let imageType = imageArray.object(at: indexPath!.row)
        if imageType is UIImage
        {
            imageArray.removeObject(at: indexPath!.row)
            if imageArray.count == 0 {
                self.heightCollectionList.constant = 0
            }
            else {
                self.heightCollectionList.constant = 125
            }
            self.collectionList.reloadData()
            Helper.sharedInstance.hideActivity()
        }
        else
        {
            let imageID:String = "\(((((arrayOfResult[0] as! NSDictionary).object(forKey: "Photos")as! NSDictionary).object(forKey: "exp_images")as! NSArray).object(at: indexPath!.row) as! NSDictionary).object(forKey: "image_id") as AnyObject)"
            //Singleton.sharedInstance.rentYourSpace.result[0].step5.productImage[indexPath!.row].productImageId!
            print("imageID is:",imageID)
            selectedImageID = imageID
            print("selectedImageID is:",selectedImageID)
            let url = URL(string: DELETE_PHOTO_EXPERIENCE)!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
          // let postString = "image_id=\(self.selectedImageID)"
            let postString = [
                "exp_id": "\(currentExpId)",
                "image_id": "\(self.selectedImageID)",
                "user_id": "\(login_session.value(forKey: "UserId")!)",
                "currency_code": "\(login_session.value(forKey: "APP_CURRENCY")!)",
                "device_type" : "IOS"
            ]
            
           // user_id=12, exp_id=204, device_type=android, image_id=54, currency_code=USD
            print("postString is : \(postString)")
          //  request.httpBody = postString.data(using: .utf8)
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(DELETE_PHOTO_EXPERIENCE, parameters: postString, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                
                
                if responseDict.value(forKey: "status") as! Int == 1 {
                    DispatchQueue.main.async {
                                                self.getBaseDetails()
                                            }
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
//            Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {                                                 // check for fundamental networking error
//                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
//                    print("error=\(error!)")
//                    self.showInformation(title: "Closest", message:(error?.localizedDescription)!)
//                    return
//                }
//
//                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
//                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                    print("response = \(response!)")
//                }
//                if let responseObject = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//                    print(responseObject)
//
//                    if responseObject.value(forKey: "status") as! Int == 1 {
//                        DispatchQueue.main.async {
//                            self.getBaseDetails()
//                        }
//
//                       // self.showInformation(title: "Closest", message:responseObject.value(forKey: "message") as! String)
//                    }
//                    else {
//                        self.showInformation(title: "Closest", message:responseObject.value(forKey: "message") as! String)
//                    }
//                } else {
//                    print("response was: \(String(describing: response))")
//                    let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                    print("responseString was: \(String(describing: responseString))")
//                    let responseString1 = String(data: data, encoding: .utf8)
//                    print("responseString1 = \(responseString1!)")
//                }
//            }
//            task.resume()
        }
    }

    
    func getBaseDetails() {
        if Helper.sharedInstance.isConnectedToInternet() {
            DispatchQueue.main.async {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            }
            var params = NSMutableDictionary()
            params = ["user_id":login_session.value(forKey: "UserId")!,"currency_code":login_session.value(forKey: "APP_CURRENCY") as! String,"device_type":"ios","exp_id": currentExpId]
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            print("params",params)
            print("Api",ExperienceBaseDetails)
            manager.post(ExperienceBaseDetails, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, resultData) in
                Helper.sharedInstance.hideActivityIndicator(view: self.view)
                let responseDict:NSDictionary = resultData as! NSDictionary
                print("Response:",responseDict)
                if responseDict.value(forKey: "status") as! Int == 1 {
                    dictOfExperience = responseDict
                    DispatchQueue.main.async {
                        Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    }
                    arrayOfResult = dictOfExperience["result"] as! NSArray
                    arrayOfBoolValues.removeAllObjects()
                    for i in 0..<arrayOfHeadings.count {
                        let str = ((arrayOfResult[0] as! NSDictionary).value(forKey:  arrayOfHeadings[i] as! String) as! NSDictionary).object(forKey: "step_completed") as AnyObject
                        arrayOfBoolValues.add("\(str)")
                    }
                 TimingsArray = (((dictOfExperience["result"] as! NSArray).object(at: 0) as! NSDictionary).object(forKey: "Timing") as! NSDictionary).object(forKey: "schedules") as! NSArray
                arrayOfResult = dictOfExperience["result"] as! NSArray
                    let result = responseDict.object(forKey: "result") as! NSArray
                    forAddPhotoDict.removeAllObjects()
                    forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                    print("CREATED_PROPERTY_STATUS forAddPhotoDict:::::",forAddPhotoDict)
                    self.imageArray.removeAllObjects()
                    self.imageArray.addObjects(from:((forAddPhotoDict.object(forKey: "Photos")as! NSDictionary).object(forKey: "exp_images")as! NSArray) as! [Any])
                    self.nCount = self.imageArray.count
                    if self.imageArray.count == 0 {
                        self.heightCollectionList.constant = 0
                    }
                    else {
                        self.heightCollectionList.constant = 125
                    }
                    self.collectionList.reloadData()
                }
                else {
                    DispatchQueue.main.async {
                        Helper.sharedInstance.hideActivityIndicator(view: self.view)
                    }
                  //  self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as! String)
                }
            }, failure: { (operation, error) in
                print(error)
                DispatchQueue.main.async {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                }
                self.showInformation(title: "Closest", message: error.localizedDescription)
            })

        }
        else {
            self.showInformation(title: "Closest", message: "Check your internet connection")
        }
        Helper.sharedInstance.hideActivityIndicator(view: self.view)
    }
    
    
    func baseExperienceApiCall() {
        if Helper.sharedInstance.isConnectedToInternet() {
            DispatchQueue.main.async {
                Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
            }
           
            var params = NSMutableDictionary()
              params = ["lang_code":lanuguage_selection.value(forKey: "language") ?? "en","property_id":self.PropertyID,"base_id":Singleton.sharedInstance.selectedCategory!]
          
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(CREATED_PROPERTY_STATUS, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in
                DispatchQueue.main.async {
                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
                }
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                
                
                if responseDict.value(forKey: "status") as! Int == 1 {
                    let mod = RentYourSpaceModel(fromDictionary: responseDict as! [String : Any])
                    Singleton.sharedInstance.rentYourSpace = mod
                    let result = responseDict.object(forKey: "result") as! NSArray
                    forAddPhotoDict.removeAllObjects()
                    forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
                    print("CREATED_PROPERTY_STATUS forAddPhotoDict:::::",forAddPhotoDict)
                    self.imageArray.removeAllObjects()
                    self.imageArray.addObjects(from:((forAddPhotoDict.object(forKey: "step5")as! NSDictionary).object(forKey: "product_image")as! NSArray) as! [Any])
                    self.nCount = self.imageArray.count
                    if self.imageArray.count == 0 {
                        self.heightCollectionList.constant = 0
                    }
                    else {
                        self.heightCollectionList.constant = 125
                    }
                    self.collectionList.reloadData()
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
        } else {
            showInformation(title: "Closest", message: "Please check your internet connection.")
        }
    }
    
    @IBAction func buttonNext(_ sender: Any) {
        
        if imageArray.count == 0
        {
            self.showInformation(title: "Message", message: "Please Select a photo")
            Helper.sharedInstance.hideActivityIndicator(view: self.view)

        }
        else
        {
            for image in imageArray
            {
                if ((image as? UIImage) != nil){
                    var params = NSMutableDictionary()
                    let id = Singleton.sharedInstance.selectedCategory!
                    params = [
                        "exp_id": "\(currentExpId)",
                        "lang_code": "\(lanuguage_selection.value(forKey: "language") ?? "en")",
                        "user_id": "\(login_session.value(forKey: "UserId")!)",
                        "currency_code": "\(login_session.value(forKey: "APP_CURRENCY")!)",
                        "device_type" : "IOS"
                    ]
                    print(params)
                    uploadImageInMultipart(parameters: params, sendImage: image as! UIImage)
                }else {
                    sharedInstanceExperience.gotoStepEight()
                }
            
                
            }
        }
    }
    
    func uploadImageInMultipart(parameters:NSMutableDictionary,sendImage:UIImage) {
        Helper.sharedInstance.showActivityIndicator(view: self.view, targetVC: self)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = Set(["text/plain", "text/html", "application/json"]) as Set<String>?
        print("API",AddExprencePhotos)
        print("Params",parameters)
        manager.post(AddExprencePhotos, parameters: parameters, headers: ["Authorization":""], constructingBodyWith: {
            (data: AFMultipartFormData!) in
            print(self.nCount)
            let imageData:Data = UIImageJPEGRepresentation(sendImage, 0.5)!
            data.appendPart(withFileData: imageData, name: "photos", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
        }, progress: nil, success: {
            (operation, responseObject) in
            let responseDictionary:NSDictionary = responseObject as! NSDictionary
            print("Profile Update Response Dictionary",responseDictionary)
//            let mod = RentYourSpaceModel(fromDictionary: responseDictionary as! [String : Any])
//            Singleton.sharedInstance.rentYourSpace = mod
            
            Helper.sharedInstance.hideActivityIndicator(view: self.view)
            let result = responseDictionary.object(forKey: "result") as! NSArray
            currentExpId = "\(responseDictionary.object(forKey: "experience_id") as AnyObject)"
            forAddPhotoDict.removeAllObjects()
            forAddPhotoDict.addEntries(from: result[0] as! [AnyHashable : Any])
            print("forAddPhotoDict:::::",forAddPhotoDict)
            self.imageArray.removeAllObjects()
            self.imageArray.addObjects(from:((forAddPhotoDict.object(forKey: "Photos")as! NSDictionary).object(forKey: "exp_images")as! NSArray) as! [Any])
            sharedInstanceExperience.gotoStepEight()

            if responseDictionary.object(forKey: "status") as! Int != 0
            {
                self.nCount = self.nCount + 1
            }
            else
            {
                self.showInformation(title: "Closest", message: responseDictionary.object(forKey: "message") as! String)
                
            }
            
            if self.nCount == self.imageArray.count
            {
                
//                let alert = UIAlertController(title: "Message", message: "Updated successfully", preferredStyle: UIAlertController.Style.alert)
//
//                // add the actions (buttons)
//                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:  { action in
//                    Helper.sharedInstance.hideActivityIndicator(view: self.view)
//                    self.collectionList.reloadData()
//                }))
//                self.present(alert, animated: true, completion: nil)
            }
        }, failure: {
            (operation, error) in
            Helper.sharedInstance.hideActivityIndicator(view: self.view)
            print(error.localizedDescription)
        })
         
        
    }
}
