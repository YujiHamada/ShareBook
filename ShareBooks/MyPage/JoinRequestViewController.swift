//
//  JoinRequestViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/10.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class JoinRequestViewController: UIViewController {

    @IBOutlet weak var inviteCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func joinRequest(_ sender: Any) {
        
        guard let inviteCode = inviteCodeTextField.text else {
            let alertController = UIAlertController.simpleOkAlert(title: "", message: "招待コードを入力してください！")
            self.present(alertController, animated: true)
            return
        }
        
        let parameters: [String : Any] = [
            "invite_code" : inviteCode
        ]
        
        RequestManager.shared.requestStatus(api: Api.joinRequest, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                print("")
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "参加申請を送りました！")
                self.present(alertController, animated: true)
                                
            case .failure(let error):
                print(error)
            }
        }
    }
}
