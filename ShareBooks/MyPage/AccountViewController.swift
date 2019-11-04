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
        navigationItem.title = "アカウント管理"
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "", message: "ログアウトしてよろしいでしょうか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.userManager.logout()
            UIApplication.shared.keyWindow?.rootViewController = LoginViewController.createWithStoryboard()
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func closeAccount(_ sender: Any) {
        userManager.closeAccount()
    }
    
}
