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
    
    func closeAccount() {
        let alertController = UIAlertController(title: "退会", message: "退会しますか？アカウントを削除します", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "退会する", style: .default, handler: { action in
            self.requestCloseAccount()
        })
        alertController.addAction(UIAlertAction(title: "キャンセル", style: .default, handler: nil))
        alertController.addAction(okAction)
        UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
    }
    
    func requestCloseAccount() {
        RequestManager.shared.requestStatus(api: Api.closeAccount) { (result) in
            switch result {
            case .success(_):
                let alertController = UIAlertController(title: "退会完了", message: "退会処理が完了しました", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                    LoginManager().logOut()
                    self.logout()
                    UIApplication.shared.keyWindow?.rootViewController = LoginViewController.createWithStoryboard()
                })
                alertController.addAction(okAction)
                UIApplication.topViewController()!.present(alertController, animated: true, completion: nil)
            case .failure(_):
                let alertController = UIAlertController(title: "退会失敗", message: "退会処理に失敗しました。何度も失敗する場合はお問い合わせください。", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
