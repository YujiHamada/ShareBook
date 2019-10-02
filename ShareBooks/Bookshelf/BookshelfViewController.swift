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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = collectionView
        collectionView.dataSource = collectionView
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grain")!)
        navigationItem.title = "本棚"
        
        RequestManager.shared.request(api: Api.myBookList) { (result: Result<Array<Book>, Error>) in
            print(result)
            switch result {
            case .success(let books):
                self.collectionView.books = books
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
