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
                let bookItem = bookItems[0]
                self.imageView.af_setImage(withURL: URL(string: bookItem.imageUrl())!)
                self.titleLabel.text = bookItem.volumeInfo?.title
                self.descriptionLabel.text = bookItem.volumeInfo?.description
            }
        }
    }
}
