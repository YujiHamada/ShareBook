//
//  ProfileSettingViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/14.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class ProfileSettingViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProfile()
    }
    
    @IBAction func update(_ sender: Any) {
        requestUpdateProfile()
    }
    
    private func requestProfile() {
        RequestManager.shared.request(api: Api.userProfile) { (result: Result<User, Error>) in
            switch result {
            case .success(let user):
                self.user = user
                self.nameTextField.text = user.name
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestUpdateProfile() {
        let parameters: [String: Any] = [
            "user_name" : nameTextField.text!,
            "email" : user.email!
        ]
        
        RequestManager.shared.requestStatus(api: Api.updateProfile, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "ユーザー情報を更新しました")
                self.present(alertController, animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
