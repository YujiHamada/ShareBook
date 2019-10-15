//
//  BookDetailViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/14.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var book: Book
    
    init(book: Book) {
        self.book = book
        super.init(nibName: String(describing: BookDetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: SimpleLabelTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SimpleLabelTableViewCell.self))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imageView.af_setImage(withURL: URL(string: (book.imageUrl()))!)
        
        navigationItem.title = book.name
    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SimpleLabelTableViewCell.self), for: indexPath) as! SimpleLabelTableViewCell
        let user = book.users![indexPath.row]
        cell.titleLabel.text = user.name
        
        return cell
    }
    
    
}
