//
//  GroupBookshelfViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/02.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class GroupBookshelfViewController: UIViewController {

    @IBOutlet weak var collectionView: BookshelfCollectionView!
    fileprivate let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView.delegate = collectionView
        collectionView.dataSource = collectionView
        collectionView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grain")!)
        navigationItem.title = "グループ本棚"
        
        requestBook()
    }
    
    func requestBook() {
        
        let tabbarController: TabBarController = self.tabBarController! as! TabBarController
        let parameter: [String: Any] = [
            "group_id" : tabbarController.groupId!
        ]
        RequestManager.shared.request(api: Api.groupBookList, parameters: parameter) { (result: Result<Array<Book>, Error>) in
            self.refreshControl.endRefreshing()
            switch result {
            case .success(let books):
                self.collectionView.books = books
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func refresh() {
        requestBook()
    }
    
}
