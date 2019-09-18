//
//  User.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/28.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import FirebaseUI

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    
    func isGoogleLogin() -> Bool{
        if let user = Auth.auth().currentUser {
            let providerDataArray = user.providerData
            for provider in providerDataArray {
                if (provider.providerID == GoogleAuthProviderID) {
                    return true;
                }
            }
        }
        return false
    }
    
    func isFacebookLogin() -> Bool{
        if let user = Auth.auth().currentUser {
            let providerDataArray = user.providerData
            for provider in providerDataArray {
                if (provider.providerID == FacebookAuthProviderID) {
                    return true
                }
            }
        }
        return false
    }
    
    func isMailLogin() -> Bool{
        if let user = Auth.auth().currentUser {
            let providerDataArray = user.providerData
            for provider in providerDataArray {
                if (provider.providerID == EmailAuthProviderID) {
                    return true
                }
            }
        }
        return false
    }
    
    func logout(){
        let firebaseAuth = Auth.auth()
        do {
            let authUI = FUIAuth.defaultAuthUI()
            try authUI!.signOut()
            try firebaseAuth.signOut()
            LoginManager().logOut()
            GIDSignIn.sharedInstance()?.signOut()
        } catch {
        }
    }
}
