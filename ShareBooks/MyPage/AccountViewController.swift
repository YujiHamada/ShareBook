//
//  AccountViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/28.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    let userManager: UserManager = UserManager.shared
    static func createWithStoryboard() -> AccountViewController {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logout(_ sender: Any) {
        userManager.logout()
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController.createWithStoryboard()
    }
    
    @IBAction func closeAccount(_ sender: Any) {
        userManager.closeAccount()
    }
    
}
