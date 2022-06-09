//
//  SocialMedia.swift
//  HomeStay
//
//  Created by POFI TECHNOLOGIES on 13/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.

/*    Class theme:  Integrating app with the social media.
 
 Used SocialMedia: 1. Linkedin
                   2. Facebook
                   3. GooglePlus
 */

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
//import LinkedinSwift

//MARK:- Linkedin Integration

//Note: linkedin_Key & linkedin_Secret should not be edited with out the author permission.

//MARK:- Linkedin Keys
let linkedin_Key = "81v8cgvguurgeq"
let linkedin_Secret = "4UnCFxxsgcujgNmA"
let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"

// Start to Authorize the application.

//MARK:- Authorization

func startAuthorization() -> URL {
    // Specify the response type which should always be "code".
    let responseType = "code"
    // redirectURL can be modified in future.
    let  redirectURL = "https://www.laravelecommerce.com"
    // Create a random string based on the time interval (it will be in the form linkedin12345679).
    let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
    // Set preferred scope.
    let scope = "r_basicprofile"
    var authorizationURL = "\(authorizationEndPoint)?"
    authorizationURL += "response_type=\(responseType)&"
    authorizationURL += "client_id=\(linkedin_Key)&"
    authorizationURL += "redirect_uri=\(String(describing: redirectURL))&"
    authorizationURL += "state=\(state)&"
    authorizationURL += "scope=\(scope)"
    print(authorizationURL)
    return URL(string: authorizationURL)!
}
