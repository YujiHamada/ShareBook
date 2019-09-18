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
    
    static func createWithStoryboard(bookItem: BookItem) -> DetailBookViewController {
        let storyboard = UIStoryboard(name: "DetailBook", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailBookViewController") as! DetailBookViewController
        vc.bookItem = bookItem
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.af_setImage(withURL: URL(string: (bookItem.imageUrl()))!)
        titleLabel.text = bookItem.volumeInfo?.title
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
