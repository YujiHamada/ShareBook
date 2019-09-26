//
//  BookshelfTableViewCell.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/23.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class BookshelfCollectionViewCell: UICollectionViewCell {
    var book: Book! {
        didSet {
            imageView.af_setImage(withURL: URL(string: (book.imageUrl()))!)
        }
    }
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
