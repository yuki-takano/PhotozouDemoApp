//
//  GridViewController.swift
//  PhotozouDemoApp
//
//  Created by TakanoYuki on 2017/08/26.
//  Copyright © 2017年 TakanoYuki. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let indicator = UIActivityIndicatorView()
    var collectionDatas = [PhotoImageModel]()
    let kCellName = "PhotoZouCell"
    let kGridNum = 2
    let kGridSpace: CGFloat = 5.0
    let kEdgeInsetValue: CGFloat = 0.0
    let kNoKeyword = "検索ワードを設定して下さい"
    let kNoData = "データが取得できませんでした。ネットワーク環境に接続している事をご確認下さい。"
    var offset = 0
    var keyword = ""
    var isSearching = false
    var isEndData = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        collectionView.register(UINib(nibName: kCellName, bundle: nil), forCellWithReuseIdentifier: kCellName)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        let inset = UIEdgeInsets(top: kEdgeInsetValue, left: kEdgeInsetValue, bottom: kEdgeInsetValue, right: kEdgeInsetValue)
        collectionView.adaptGrid(kGridNum, gridLineSpace: kGridSpace, sectionInset: inset)
    }
    
    func showIndicator() {
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        indicator.color = UIColor.gray
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    fileprivate func fetchAPI() {
        self.isSearching = true
        dispatch_async_global({
            PhotoZouManager.shared.getPhotoZouModels(keyword: self.keyword, offset: self.offset, loadComplete: { (photoModels: [PhotoImageModel]) -> Void in
                self.indicator.stopAnimating()
                self.isSearching = false
                self.collectionDatas += photoModels
                self.offset += photoModels.count
                self.collectionView.reloadData()
                if photoModels.count == 0 {
                    self.isEndData = true
                    let title = self.keyword == "" ? self.kNoKeyword : self.kNoData
                    let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.isEndData = false
                }
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellName, for: indexPath) as! PhotoZouCell
        let photoModel = collectionDatas[indexPath.row]
        cell.setImage(url: photoModel.imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellFooter", for: indexPath) as! CollectionViewFooter
            
            // 検索してデータがもう無い時、または検索キーワードが設定されていない
            if isEndData && !isSearching {
                let isSearched = searchBar.text != "" ? true : false
                header.showLabel(isSearched: isSearched)
                header.stopIndicator()
            } else if !isEndData && !isSearching {
                // 追加読み込みしたい時
                fetchAPI()
                header.startIndicator()
            }
            return header
        }
        return UICollectionReusableView()
    }
}


extension GridViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let word = searchBar.text {
            if keyword != word {
                collectionDatas.removeAll()
            }
            keyword = word
            offset = collectionDatas.count
            fetchAPI()
        } else {
            collectionDatas.removeAll()
            keyword = ""
            offset = 0
            collectionView.reloadData()
        }
    }
}

extension GridViewController {
    func dispatch_async_main(_ block: @escaping () -> ()) {
        DispatchQueue.main.async(execute: block)
    }
    
    func dispatch_async_global(_ block: @escaping () -> ()) {
        DispatchQueue.global(qos: .`default`).async(execute: block)
    }
}
