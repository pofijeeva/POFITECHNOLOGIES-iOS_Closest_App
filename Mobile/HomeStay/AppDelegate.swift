
//  AppDelegate.swift
//  HomeStay
//  Created by POFI TECHNOLOGIES on 11/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import UIKit
import FacebookCore
import FBSDKCoreKit
import GoogleSignIn
//import LinkedinSwift
import GooglePlaces
//import PayMayaSDK
import Braintree
import BraintreeDropIn
import IQKeyboardManagerSwift
import Firebase
import FirebaseCore
import FirebaseMessaging
//import FirebaseInstanceID
import UserNotifications
import GoogleMaps
import SWRevealViewController
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate  {
    
    var window: UIWindow?
    var strDeviceToken : String = ""
    var fcmRegToken : String = ""
    let gcmMessageIDKey = "gcm.message_id"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(UIFont.familyNames)
//        print(UIFont.fontNames(forFamilyName: "Sofia Pro"))
        FirebaseApp.configure()
//        Fabric.sharedSDK().debug = true
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
//        Messaging.messaging().shouldEstablishDirectChannel = true
        // [END set_messaging_delegate]
        if let token = Messaging.messaging().fcmToken {
            print("FCM token: \(token )")
            self.ConnectToFCM()
        }
        
        
        ConnectToFCM()
        
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        application.registerForRemoteNotifications()
        // [END register_for_notifications]
        
        // FirebaseApp.configure()
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotificaiton),
//                                               name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        
        //        PayMayaSDK.sharedInstance().setPaymentsAPIKey("pk-sHQWci2P410ppwFQvsi7IQCpHsIjafy74jrhYb8qfxu", for: PayMayaEnvironment.sandbox)
        //        PayMayaSDK.sharedInstance().setCheckoutAPIKey("pk-sHQWci2P410ppwFQvsi7IQCpHsIjafy74jrhYb8qfxu", for: PayMayaEnvironment.sandbox)
        
        //PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentSandbox: "AVomx52Gh-UDWy2BSntGqIVSwi5dnc9t6vCdMRyohM_C2Llk6xep2L22sRm9nLAVt-zG5i9zwF8NC1ft"])
        
        BTAppSwitch.setReturnURLScheme("com.closest.payments")
//        GIDSignIn.sharedInstance().clientID = googleClientID
        GMSPlacesClient.provideAPIKey("AIzaSyBPHvUw246-b8m--2jfzLdxoPy5-oBH7z8")
        GMSServices.provideAPIKey("AIzaSyDu8h4AFHn_dkKiNHYaXwZHz6YNemNI_aU")
        
        if login_session.value(forKey: "UserId") != nil {
            UserID = "\(login_session.value(forKey: "UserId")!)"
            UserEmail = login_session.value(forKey: "Email") as? String ?? ""
        }else{
            UserID = ""
            UserEmail = ""
            login_session.setValue("USD" , forKey: "APP_CURRENCY")
            login_session.setValue("$" , forKey: "APP_CURRENCY_SYMBOL")
        }
        print(UserID)
        languageUpdate1()
        VersionUpdateApi()
        return true
        
    }
    
    func checkRootView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func languageUpdate1()
        {
            if login_session.value(forKey: "Language") == nil
            {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                login_session.setValue("en", forKey: "Language")
                if let path = Bundle.main.path(forResource: "English", ofType: "json") {
                    do {
                        let fileUrl = URL(fileURLWithPath: path)
                        let myJSON = try String(contentsOf: fileUrl, encoding: .utf8)
                        let dict = convertToDictionary(text: myJSON)! as NSDictionary
                        print("JSONLoad : \(dict)")
                        GlobalLanguageDictionary.removeAllObjects()
                        GlobalLanguageDictionary.addEntries(from: dict as! [AnyHashable : Any])
                        
                    }
                    catch {print("Error")}
                }
            }
            else if login_session.value(forKey: "Language") as? String == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                login_session.setValue("ar", forKey: "Language")
                if let path = Bundle.main.path(forResource: "Arabic", ofType: "json") {
                    do {
                        let fileUrl = URL(fileURLWithPath: path)
                        let myJSON = try String(contentsOf: fileUrl, encoding: .utf8)
                        let dict = convertToDictionary(text: myJSON)! as NSDictionary
                        print("JSONLoad : \(dict)")
                        GlobalLanguageDictionary.removeAllObjects()
                        GlobalLanguageDictionary.addEntries(from: dict as! [AnyHashable : Any])
                        
                    }
                    catch {print("Error")}
                }
            }
            else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                if let path = Bundle.main.path(forResource: "English", ofType: "json") {
                    do {
                        let fileUrl = URL(fileURLWithPath: path)
                        let myJSON = try String(contentsOf: fileUrl, encoding: .utf8)
                        let dict = convertToDictionary(text: myJSON)! as NSDictionary
                        print("JSONLoad : \(dict)")
                        GlobalLanguageDictionary.removeAllObjects()
                        GlobalLanguageDictionary.addEntries(from: dict as! [AnyHashable : Any])
                        
                    }
                    catch {print("Error")}
                }
            }
        self.checkRootView()
        }
    func VersionUpdateApi(){
       //   showActivityIndicator(uiView: self.view)
        if (Reachability()?.isReachable ?? false)
        {
            let id = Singleton.sharedInstance.selectedCategory
          
            var params = NSMutableDictionary()
            params = ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en", "type":["android","ios"],"size":["L","M","S"]]
            print(params)
//            "currency_code":login_session.value(forKey: "APP_CURRENCY")as? String ?? ""
            
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(REQ_VERSION_UPDATE, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in

                DispatchQueue.main.async {
             //       self.hideActivityIndicator(uiView: self.view)
                }
                print(params)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
             //   self.hideActivityIndicator(uiView: self.view)
                if responseDict.value(forKey: "code") as? Int == 200 {
                    let mod = HomeModel(fromDictionary: responseDict as! [String : Any])
                    let dataDict = responseDict["data"] as! [String:Any]
                    let colorDict = dataDict["image_details"] as! [String:Any]
                    let color = colorDict["color_code"] as? String ?? ""
                    AppColor = self.hexStringToUIColor(hex: color)
                    Singleton.sharedInstance.homeModel = mod
                    self.LanguageUpdate()
                 //   self.tblViewHome.reloadData()
                    
                }
                    
                else {
                   // self.hideActivityIndicator(uiView: self.view)
               //     self.showInformation(title: "Closest", message: responseDict.value(forKey: "message") as? String ?? "")
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
             //   self.hideActivityIndicator(uiView: self.view)
                //self.showInformation(title: "Closest", message: error.localizedDescription)
            })
            
           
            //            showActivityIndicator(uiView: self.view)
            //            print(login_session.value(forKey: "UserId")!)
            //            let parameterStr = "lang_code=\(lanuguage_selection.value(forKey: "language") as? String ?? "en")&currency_code=\(login_session.value(forKey: "APP_CURRENCY")as? String ?? "")&base_id=\(id)&userid=\(login_session.value(forKey: "UserId")!)"
            //            Network.shared.GetRequest(withParameterString: parameterStr, serviceURL: REQ_HOMEPAGE, APIKEY: "HOME_API")
            //            print(parameterStr)
            
        } else {
            
            print("Failed")
             // hideActivityIndicator(uiView: self.view)
           // self.showInformation(title: "Info", message: GlobalLanguageDictionary.object(forKey: "Key_internetError") as? String ?? "")
        }
    }
    
    func LanguageUpdate(){
         if (Reachability()?.isReachable ?? false)
        {
 
            var params = NSMutableDictionary()
            params = ["lang_code":""]
            print(params)
 
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(LANGUAGELIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in

                DispatchQueue.main.async {
                 }
                print(params)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                 if responseDict.value(forKey: "code") as? Int == 200 {
                    lanuguage_selection.set("en", forKey: "language")
                    self.CurrencyUpdate()
                }
                else {
             
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
            })
  } else {
            print("Failed")
        }
    }
    
    func CurrencyUpdate(){
         if (Reachability()?.isReachable ?? false)
        {
 
            var params = NSMutableDictionary()
            params = ["lang_code":lanuguage_selection.value(forKey: "language") as? String ?? "en"]
            print(params)
 
            let manager = AFHTTPSessionManager()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/plain", "text/html", "application/json"]) as Set<NSObject> as? Set<String>
            
            manager.post(CURRENCYLIST, parameters: params, headers: ["Authorization":""], progress: nil, success: { (operation, responseObject) -> Void in

                DispatchQueue.main.async {
                 }
                print(params)
                let responseDict:NSDictionary = responseObject as! NSDictionary
                print(responseDict)
                 if responseDict.value(forKey: "code") as? Int == 200 {
                   
                }
                else {
             
                }
            }, failure: { (operation, error) -> Void in
                DispatchQueue.main.async {
                    
                }
                print(error)
            })
  } else {
            print("Failed")
        }
    }
    
    func LogOut(){
        if login_session.value(forKey: "UserId") != nil {
            UserID = "\(login_session.value(forKey: "UserId")!)"
            UserEmail = login_session.value(forKey: "Email") as? String ?? ""
        }else{
            UserID = ""
            UserEmail = ""
        }
        
        login_session.setValue("USD" , forKey: "APP_CURRENCY")
        login_session.setValue("$" , forKey: "APP_CURRENCY_SYMBOL")
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//                      let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "RevealRootView") as! SWRevealViewController
//
//                      self.window?.rootViewController = mainViewController
//                      self.window?.makeKeyAndVisible()
//s
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
       
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "InitialNavID") as! UINavigationController

        self.window?.rootViewController = mainViewController

        self.window?.makeKeyAndVisible()
    }
    func PropertyListing(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
       
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "HomeNavi") as! UINavigationController

        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    
    func RentalLstingCompleted(){
       
        
        self.window = UIWindow(frame: UIScreen.main.bounds) // PropertyListing
       
       // let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "PropertyListingViewController") as! PropertyListingViewController
        let mainViewController = storyBoardHome.instantiateViewController(withIdentifier: "PropertyListing") as! UINavigationController
        self.window?.rootViewController = mainViewController

        self.window?.makeKeyAndVisible()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        if UserDefaults.standard.value(forKey: "TranslationDocumentName") != nil {
            let checkLang:String = UserDefaults.standard.value(forKey: "TranslationDocumentName") as? String ?? ""
            if checkLang != "" {
                print(checkLang)
            }else{
                UserDefaults.standard.set("en", forKey: "TranslationDocumentName")
                let checkLang:String = UserDefaults.standard.value(forKey: "TranslationDocumentName") as? String ?? ""
                print(checkLang)
            }
        }
        UserDefaults.standard.synchronize()
        
        
        /*if LinkedinSwiftHelper.shouldHandle(url) {
            return LinkedinSwiftHelper.application(app, open: url, sourceApplication: nil, annotation: nil)
        }*/
        
        if url.scheme?.localizedCaseInsensitiveCompare("com.closest.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        else
        {
            return ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool
    {
        if (ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation))
        {
            return true
        }else if (GIDSignIn.sharedInstance.handle((url as URL?)!)){
            return true
        }
        else if url.scheme?.localizedCaseInsensitiveCompare("com.closest.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, sourceApplication: sourceApplication)
        }
        return false
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        ConnectToFCM()
        let badgeCount: Int = 0
        let application = UIApplication.shared
        application.applicationIconBadgeNumber = badgeCount
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print("Registration succeeded! Token: ", token)
        strDeviceToken = token
        
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instance ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                print("InstanceID token: \(result.token)")
//            }
//        }
        if let token = Messaging.messaging().fcmToken {
            print("FCM token: \(token )")
            UserDefaults.standard.set(token, forKey: "pushdevicetoken")
        }
        Messaging.messaging().apnsToken = deviceToken
        UserDefaults.standard.set(strDeviceToken, forKey: "pushdevicetoken")
        //InstanceID.instanceID().setAPNSToken(deviceToken, type: InstanceIDAPNSTokenType.sandbox)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Registration failed!,\(error.localizedDescription)")
    }
    
    func ConnectToFCM() {
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instance ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                let token = "\(result.token)"
//                print("DCS: " + token)
//                UserDefaults.standard.set(token, forKey: "fcmToken")
//            }
//        }
        if let token = Messaging.messaging().fcmToken {
            print("FCM token: \(token )")
            UserDefaults.standard.set(token, forKey: "pushdevicetoken")
        }
        Messaging.messaging().token { token, error in
 
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let resultToken = token {
                print("Remote instance ID token: \(resultToken)")
                let token = "\(resultToken)"
                print("DCS: " + token)
                UserDefaults.standard.set(token, forKey: "fcmToken")
                login_session.setValue(token, forKey: "fcmToken")
                login_session.synchronize()
            }
        }
//        Messaging.messaging().shouldEstablishDirectChannel = true
    }
//    @objc func tokenRefreshNotificaiton(_ notification: Foundation.Notification) {
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instance ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                let refreshedToken  = "\(result.token)"
//                UserDefaults.standard.set(refreshedToken, forKey: "fcmToken")
//            }
//        }
//        ConnectToFCM()
//    }
    
    //MARK: FCM Token Refreshed
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        // FCM token updated, update it on Backend Server
    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("remoteMessage: \(remoteMessage)")
//        print("remoteMessage: \(remoteMessage.appData)")
//        print("remoteMessage: \(remoteMessage)")
//
//        let pushDict:NSDictionary = remoteMessage.appData as NSDictionary
//        print(pushDict)
//        //let titleStr : String = pushDict.value(forKey: "title") as? String ?? ""
//        //let bodyStr : String = pushDict.value(forKey: "body") as? String ?? ""
//        let titleStr : String = (pushDict.value(forKey: "notification") as AnyObject).value(forKey: "title") as? String ?? ""
//        let bodyStr : String = (pushDict.value(forKey: "notification") as AnyObject).value(forKey: "body") as? String ?? ""
//        print(titleStr)
//        print(bodyStr)
//    }
//    func application(received remoteMessage: MessagingRemoteMessage) {
//        print("remoteMessage: \(remoteMessage)")
//        print("remoteMessage: \(remoteMessage.appData)")
//    }
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Firebase registration token: \(fcmToken)")
//        print(fcmToken)
//        let dataDict:[String: String] = ["token": fcmToken]
//        print(dataDict)
//        //NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//        // TODO: If necessary send token to application server.
//        // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
    //MARK: UNUserNotificationCenterDelegate Method
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        UIApplication.shared.applicationIconBadgeNumber += 1
        // custom code to handle push while app is in the foreground
        print("Handle push from foreground\(notification.request.content.userInfo)")
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        completionHandler([.alert, .badge, .sound])
    }
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = \(response.notification.request.content.userInfo)")
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        //        if let messageID = userInfo[gcmMessageIDKey] {
        //            print("Message ID: \(messageID)")
        //        }
        
        let state = UIApplication.shared.applicationState
        if state == .background {
            print("background")
        }
        else if state == .active {
            print("foreground")
        }
        else if state == .inactive {
            print("not active")
        }
        completionHandler()
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //        // If you are receiving a notification message while your app is in the background,
        //        // this callback will not be fired till the user taps on the notification launching the application.
        //        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        //        // Print full message.
        let state = UIApplication.shared.applicationState
        if state == .background {
            print("background")
        }
        else if state == .active {
            print("foreground")
        }
        else if state == .inactive {
            print("not active")
        }
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //        // If you are receiving a notification message while your app is in the background,
        //        // this callback will not be fired till the user taps on the notification launching the application.
        //        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        //        // Print full message.
        let state = UIApplication.shared.applicationState
        if state == .background {
            print("background")
        }
        else if state == .active {
            print("foreground")
        }
        else if state == .inactive {
            print("not active")
        }
        print(userInfo)
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
