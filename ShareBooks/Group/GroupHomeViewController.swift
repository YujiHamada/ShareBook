//
//  GroupHomeViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/18.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class GroupHomeViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    private var groups: [Group]?
    fileprivate let refreshControl = UIRefreshControl()
    
    static func createWithStoryboard() -> GroupHomeViewController {
        let storyboard = UIStoryboard(name: "GroupHome", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GroupHomeViewController") as! GroupHomeViewController
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        navigationItem.title = "グループ一覧"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "グループ作成", style: .plain, target: self, action: #selector(pushToCreateGroup(_:)))
        
        request()
    }
    
    @objc func refresh() {
        request()
    }
    
    private func request() {
        RequestManager.shared.request(api: Api.groupList) { (result: Result<Array<Group>, Error>) in
            print(result)
            switch result {
            case .success(let groups):
                self.groups = groups
                self.tableview.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func pushToCreateGroup(_ sender: Any) {
        let createGroupViewController = CreateGroupViewController.createWithStoryboard()
        navigationController?.pushViewController(createGroupViewController, animated: true)
    }
}

extension GroupHomeViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupHomeTableViewCell", for: indexPath) as! GroupHomeTableViewCell
        cell.group = groups![indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupBookshelfViewController = GroupBookshelfViewController.createWithStoryboard(group: groups![indexPath.row])
        self.navigationController?.pushViewController(groupBookshelfViewController, animated: true)
    }
}
