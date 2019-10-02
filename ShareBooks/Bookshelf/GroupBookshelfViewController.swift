//
//  GroupBookshelfViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/02.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class GroupBookshelfViewController: UIViewController {

    @IBOutlet weak var collectionView: GroupBookshelfCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.identifier = "GroupBookshelfViewController"
        collectionView.delegate = collectionView
        collectionView.dataSource = collectionView
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grain")!)
        navigationItem.title = "本棚"
        
        RequestManager.shared.request(api: Api.myBookList) { (result: Result<Array<Book>, Error>) in
            switch result {
            case .success(let books):
                self.collectionView.books = books
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
