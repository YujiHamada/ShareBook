//
//  SearchBookCollectionViewCell.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var bookItem: BookItem! {
        didSet{
            imageView.af_setImage(withURL: URL(string: (bookItem.imageUrl()))!)
            titleLabel.text = bookItem.volumeInfo?.title
        }
    }
}
