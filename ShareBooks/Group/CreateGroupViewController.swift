//
//  CreateGroupViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/18.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var groupTextField: UITextField!
    @IBOutlet weak var inviteCodeTextField: UITextField!
    
    static func createWithStoryboard() -> CreateGroupViewController {
        let storyboard = UIStoryboard(name: "CreateGroup", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createGroup(_ sender: Any) {
        guard let groupName = groupTextField.text else {
            print("グループ名を入力してください")
            return
        }
        guard let inviteCode = inviteCodeTextField.text else {
            print("招待コードを入力してください")
            return
        }
        
        let parameters: [String : Any] = [
            "group_name" : groupName,
            "invite_code" : inviteCode
        ]
        
        RequestManager.shared.request(api: Api.createGroup, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "グループを作成しました", handler: { action in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alertController, animated: true)
                
            case .failure(let _):
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "グループ作成に失敗しました", handler: { action in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alertController, animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
