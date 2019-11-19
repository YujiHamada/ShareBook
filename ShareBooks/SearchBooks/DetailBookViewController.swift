//
//  DetailBookViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/25.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import AlamofireImage
class DetailBookViewController: UIViewController {

    var bookItem: BookItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static func createWithStoryboard(bookItem: BookItem) -> DetailBookViewController {
        let storyboard = UIStoryboard(name: "DetailBook", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailBookViewController") as! DetailBookViewController
        vc.bookItem = bookItem
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.setImageWithPlaceholder(url: bookItem.imageUrl())
        titleLabel.text = bookItem.volumeInfo?.title
        descriptionLabel.text = bookItem.volumeInfo?.description
    }

    @IBAction func register(_ sender: Any) {
        
        let parameters: [String : Any] = [
            "name": bookItem.volumeInfo!.title!,
            "isbn": bookItem.volumeInfo!.isbn() ?? bookItem.id!,
            "description" : bookItem.volumeInfo?.description ?? "",
            "link" : bookItem.volumeInfo!.imageLinks!.smallThumbnail!
        ]
        RequestManager.shared.request(api: Api.registerBook, parameters: parameters) { (result) in
            let alert = UIAlertController(title: "", message: "本の登録が完了しました", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}
