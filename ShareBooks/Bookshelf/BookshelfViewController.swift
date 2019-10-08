//
//  BookshelfViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/23.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class BookshelfViewController: UIViewController {

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
        navigationItem.title = "本棚"
        
        requestBook()
    }
    
    func requestBook() {
        RequestManager.shared.request(api: Api.myBookList) { (result: Result<Array<Book>, Error>) in
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
