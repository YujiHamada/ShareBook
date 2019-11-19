//
//  MailLoginViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import FirebaseUI

class MailLoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    static let authEmail = "authEmail"

    static func createWithStoryboard() -> MailLoginViewController {
        let storyboard = UIStoryboard(name: "MailLogin", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MailLoginViewController") as! MailLoginViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "メールアドレスでログイン・新規作成"
    }
    
    @IBAction func mailLogin(_ sender: Any) {
        
        if emailTextField.text!.isEmpty {
            let alertController = UIAlertController.simpleOkAlert(title: "", message: "メールアドレスを入力してください")
            self.present(alertController, animated: true, completion: nil)
            return 
        }
        
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://sharebuk.page.link/sign_up")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        Auth.auth().sendSignInLink(toEmail: emailTextField.text!, actionCodeSettings: actionCodeSettings) { error in
            
            if let error = error {
                print(error)
                return
            }
            
            self.present(UIAlertController.simpleOkAlert(title: "確認メールを送信しました。", message: "メールを確認してメールのリンクをタップしてください"), animated: true)
            UserDefaults.standard.set(self.emailTextField.text, forKey: MailLoginViewController.authEmail)
        }
    }
    
}
