//
//  ResultViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/25.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Alamofire
class ResultViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var code: String!
    var bookItem: BookItem?
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://www.googleapis.com/books/v1/volumes"
        let parameters: Parameters = ["q": "isbn:" + code]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let dict = response.result.value as? [String : Any] {
                let items = dict["items"] as! [[String : Any]]
                
                let jsonData = try! JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                let reqJSONStr = String(data: jsonData, encoding: .utf8)
                let data = reqJSONStr?.data(using: .utf8)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let bookItems = try! decoder.decode(Array<BookItem>.self, from: data!)
                self.bookItem = bookItems[0]
                self.imageView.setImageWithPlaceholder(url: self.bookItem?.imageUrl())
                self.titleLabel.text = self.bookItem?.volumeInfo?.title
                self.descriptionLabel.text = self.bookItem?.volumeInfo?.description
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        let parameters: [String : Any] = [
            "name": bookItem!.volumeInfo!.title!,
            "isbn": bookItem!.id!,
            "description" : bookItem!.volumeInfo!.description!,
            "link" : bookItem!.volumeInfo!.imageLinks!.smallThumbnail!
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
