//
//  SearchBooksViewController.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/08/22.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import UIKit
import Alamofire

class SearchBooksViewController: UIViewController {

    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var index = 0
    var offset = 10
    var searchWord: String!
    var isReloading = false
    var bookItems: [BookItem]? {
        didSet {
            if index == 0  || index == 10 {
                collectionView.reloadData()
            } else {
                var indexPaths: [IndexPath] = []
                for i in index - offset...index - 1 {
                    indexPaths.append(IndexPath(row: i, section: 0))
                }
                collectionView.insertItems(at: indexPaths)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grain")!)
        navigationItem.title = "マイページ"
        collectionView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
    }

    @IBAction func search(_ sender: Any) {
        searchWordTextField.endEditing(true)
        guard let word = searchWordTextField.text else { return }
        self.collectionView.contentOffset = CGPoint(x: 0, y: -self.collectionView.contentInset.top);
        searchWord = word
        index = 0
        offset = 10
        bookItems = nil
        requestBook()
    }
    
    private func requestBook() {
        if isReloading {
            return
        }
        isReloading = true
        let url = "https://www.googleapis.com/books/v1/volumes"
        let parameters: Parameters = [
            "q": "intitle:" + searchWord,
            "startIndex" : index,
            "maxResults" : offset
        ]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            self.isReloading = false
            self.index = self.index + self.offset
            if let dict = response.result.value as? [String : Any] {
                guard let items: [[String : Any]] = dict["items"] as? [[String : Any]]   else {
                    let okAlert = UIAlertController.simpleOkAlert(title: "該当なし", message: "検索結果が0件でした")
                    self.present(okAlert, animated: true)
                    return
                }
                
                let jsonData = try! JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                let reqJSONStr = String(data: jsonData, encoding: .utf8)
                let data = reqJSONStr?.data(using: .utf8)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let newBookItems = try! decoder.decode(Array<BookItem>.self, from: data!)
                if self.bookItems == nil {
                    self.bookItems = newBookItems
                } else {
                    self.bookItems = self.bookItems! + newBookItems
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.collectionView.reloadData()
            requestBook()
        }
    }
}

extension SearchBooksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationViewController = DetailBookViewController.createWithStoryboard(bookItem: bookItems![indexPath.row])
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchBookCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchBookCollectionViewCell", for: indexPath) as! SearchBookCollectionViewCell
        cell.imageView.image = nil
        cell.bookItem = bookItems![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
        let itemsPerRow: CGFloat = 2
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem / 148 * 210 + 50)
    }


}