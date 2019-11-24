//
//  AppDelegate.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDynamicLinks
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            window?.rootViewController = GroupTabViewController.createWithStoryboard()
        }
        
        return true
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//
//        if String(url.absoluteString.prefix(2)) == "fb" {
//            return  ApplicationDelegate.shared.application(app, open: url, options: options)
//        }
//
//        return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
//    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        guard let url = userActivity.webpageURL else { return true }
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { [weak self] (link, _) in
            guard let linkURL = link?.url else { return }
            self?.handlePasswordlessSignIn(withURL: linkURL)
        }
        return handled
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//        return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
//    }
    
    func handleOpenUrl(_ url: URL, sourceApplication: String?) -> Bool {
        // other URL handling goes here.
        return false
    }
    
    func handlePasswordlessSignIn(withURL url: URL) {
        let link = url.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            let email = UserDefaults.standard.string(forKey: MailLoginViewController.authEmail)!
            Auth.auth().signIn(withEmail: email, link: link) { (result, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let firebaseUser = Auth.auth().currentUser {
                    let split = email.components(separatedBy: "@")
                    let parameters: [String : Any] = [
                        "mail": email,
                        "name": split[0],
                    ]
                    RequestManager.shared.request(api: Api.signupin, parameters: parameters, completion: { (result) in
                        UIApplication.topViewController()!.present(GroupTabViewController.createWithStoryboard(), animated: true)
                    })
                    
                }
            }
        }
    }


}

