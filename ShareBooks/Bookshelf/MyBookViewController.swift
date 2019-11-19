//
//  MyBookViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/11/18.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class MyBookViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let book: Book
    
    init(book: Book) {
        self.book = book
        super.init(nibName: String(describing: MyBookViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImageView.af_setImage(withURL: URL(string: book.imageUrl())!)
        titleLabel.text = book.name
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "削除", style: .plain, target: self, action: #selector(remove))
    }
    
    func removeRequest() {
        let parameters: [String : Any] = [
            "book_id" : book.id!
        ]
        
        RequestManager.shared.requestStatus(api: .removeMybook, parameters: parameters) { (result) in
            switch result {
            case .success(_):
                let alertController = UIAlertController.simpleOkAlert(title: "", message: "本を削除しました")
                self.present(alertController, animated: true, completion: {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        NotificationCenter.default.post(name: .reloadMyBookShelf, object: nil)
                    }
                })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func remove() {
        
        let alertController = UIAlertController(title: "", message: "この本を自分の本棚から削除してよろしいでしょうか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "削除", style: .default, handler: { action in
            self.removeRequest()
        })
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

}
