//
//  GroupSettingViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/09.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class GroupSettingViewController: UIViewController {

    var group: Group
    @IBOutlet weak var tableView: UITableView!
    
    private enum TableRow: Int, CaseIterable {
        case manageAccount = 0
        case joinRequest = 1
        
        func title() -> String{
            switch self {
            case .manageAccount:
                return "グループ設定確認"
            case .joinRequest:
                return "承認待ちユーザー一覧"
            }
        }
    }
    
    init(group: Group) {
        self.group = group
        super.init(nibName: String(describing: GroupSettingViewController.self), bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: GroupSettingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GroupSettingTableViewCell.self))

    }
}

extension GroupSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableRow.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupSettingTableViewCell.self), for: indexPath) as! GroupSettingTableViewCell
        let row: TableRow = TableRow(rawValue: indexPath.row)!
        cell.titleLabel.text = row.title()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row: TableRow = TableRow(rawValue: indexPath.row)!
        
        switch row {
        case .manageAccount:
            let vc = BrowseGroupSettingViewController(group: group)
            navigationController?.pushViewController(vc, animated: true)
        case .joinRequest:
            let vc = JoinRequestListViewController(group: group)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
