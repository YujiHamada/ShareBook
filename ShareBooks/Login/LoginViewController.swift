//
//  ViewController.swift
//  ShareBook
//
//  Created by 濱田裕史 on 2019/08/20.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var googleSignInView: GIDSignInButton!
    
    static func createWithStoryboard() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        googleSignInView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (googleSignUp))
        googleSignInView.addGestureRecognizer(gesture)
        
        navigationItem.title = "ログイン・新規作成"
    }
    
    @objc func googleSignUp(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func mailLogin(_ sender: Any) {
        navigationController?.pushViewController(MailLoginViewController.createWithStoryboard(), animated: true)
    }
    
}

extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let firebaseUser = Auth.auth().currentUser {
                let parameters: Parameters = [
                    "mail": firebaseUser.email ?? "",
                    "name": firebaseUser.displayName ?? "",
                ]
                RequestManager.shared.request(api: Api.signupin, parameters: parameters, completion: { (result) in
                    self.present(GroupTabViewController.createWithStoryboard(), animated: true)
                })
                
            }
            
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("didDisconnectWith")
    }
}

