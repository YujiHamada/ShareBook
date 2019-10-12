//
//  BrowseGroupSettingViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/10.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Toast_Swift

class BrowseGroupSettingViewController: UIViewController {

    @IBOutlet weak var inviteCodeLabel: UILabel!
    var group: Group
    
    init(group: Group) {
        self.group = group
        super.init(nibName: String(describing: BrowseGroupSettingViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inviteCodeLabel.text = group.inviteCode
        inviteCodeLabel.isUserInteractionEnabled = true

        let tg = UITapGestureRecognizer(target: self, action: #selector(copyInviteCode(_:)))
        inviteCodeLabel.addGestureRecognizer(tg)
    }
    
    @objc func copyInviteCode(_ sender:UITapGestureRecognizer) {
        UIPasteboard.general.string = inviteCodeLabel.text
        var style = ToastStyle()
        style.backgroundColor = .cyan
        self.view.makeToast("招待コードをコピーしました！", style: style)
    }
}
