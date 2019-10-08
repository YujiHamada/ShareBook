//
//  BookshelfCollectionView.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/10/01.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit

class BookshelfCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var books: Array<Book>? {
        didSet {
            reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return books?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let destinationViewController = DetailBookViewController.createWithStoryboard(bookItem: bookItems![indexPath.row])
    //        self.navigationController?.pushViewController(destinationViewController, animated: true)
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: BookshelfCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookshelfCollectionViewCell", for: indexPath) as! BookshelfCollectionViewCell
            cell.imageView.image = nil
            cell.book = books![indexPath.row]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
            let itemsPerRow: CGFloat = 2
            
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = superview!.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow - 20
            print(CGSize(width: widthPerItem, height: widthPerItem / 148 * 210 + 50))
            return CGSize(width: widthPerItem, height: widthPerItem / 148 * 210 + 50)
        }

}
