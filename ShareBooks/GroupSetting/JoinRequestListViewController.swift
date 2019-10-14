//
//  JoinRequestListViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/12.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class JoinRequestListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var users: Array<User>? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var group: Group
    
    init(group: Group) {
        self.group = group
        super.init(nibName: String(describing: JoinRequestListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: JoinRequestTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JoinRequestTableViewCell.self))
        
        request()
    }
    
    private func request() {
        let parameters: [String : Any] = [
            "group_id" : group.id!
        ]
        RequestManager.shared.request(api: Api.joinRequestList, parameters: parameters) { (result: Result<Array<User>, Error>) in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension JoinRequestListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JoinRequestTableViewCell.self), for: indexPath) as! JoinRequestTableViewCell
        let user = users![indexPath.row]
        cell.titleLabel.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users![indexPath.row]
        let alertController = UIAlertController(title: "グループ参加申請", message: "参加許可しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "許可", style: .default, handler: { action in
            self.allowRequst(user: user)
        })
        
        let cancelAction = UIAlertAction(title: "却下", style: .cancel, handler: { action in
            self.denyRequst(user: user)
        })
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func allowRequst(user: User) {
        
        let parameters: [String : Any] = [
            "user_id" : user.id!,
            "group_id" : group.id!
        ]
        
        RequestManager.shared.requestStatus(api: Api.allowJoinRequest, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                self.request()
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "参加申請を許可しました！")
                self.present(alertController, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func denyRequst(user: User) {
        
        let parameters: [String : Any] = [
            "user_id" : user.id!,
            "group_id" : group.id!
        ]
        
        RequestManager.shared.requestStatus(api: Api.denyJoinRequest, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                self.request()
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "参加申請を拒否しました！")
                self.present(alertController, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
}
