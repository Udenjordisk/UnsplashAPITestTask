//
//  PhotoViewController.swift
//  BelashovTestTask
//
//  Created by Кирилл on 04.09.2022.
//

import UIKit
import CHTCollectionViewWaterfallLayout
class PhotoViewController: UIViewController {
    
    var modelsArray: [MainModel] = []
    var timer: Timer?
    
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "For example: Cute puppies"
        searchController.searchBar.searchBarStyle = .default
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    
    let photoCollection: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        
        let photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        photoCollection.register(CollectionViewPhotoCell.self, forCellWithReuseIdentifier: CollectionViewPhotoCell.identifier)
        return photoCollection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let network = NetworkService()
        network.fetch(dataType: [MainModel].self, from: nil) { result in
            switch result {
            case .success(let models):
                self.modelsArray = models
                self.photoCollection.reloadData()
                return
            case .failure(let error):
                print(error)
            }
        }
        view.addSubview(photoCollection)
        self.photoCollection.dataSource = self
        self.photoCollection.delegate = self
        self.searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollection.frame = view.bounds
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
    
    
}


// extension //
extension PhotoViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            
            let network = NetworkService()
            network.fetch(dataType: [MainModel].self, from: searchText) { result in
                switch result {
                case .success(let models):
                    self.modelsArray = models
                    self.photoCollection.contentOffset = CGPoint(x: 0, y: 0)
                    self.photoCollection.reloadData()
                    return
                case .failure(let error):
                    print(error)
                        }
                    }
                })
            }
    
}
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: CGFloat.random(in: 250...400))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        modelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewPhotoCell", for: indexPath) as! CollectionViewPhotoCell
        
        
        let model = modelsArray[indexPath.row]
        cell.configur(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func actionSheet(){
            var myActionSheet =  UIAlertController(title: "Show detail", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            myActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            myActionSheet.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ACTION :UIAlertAction!) in
                
                self.navigationController?.pushViewController(DetailsViewController(with: self.modelsArray[indexPath.row]), animated: true)
            }))
            
            self.present(myActionSheet, animated: true, completion: nil)
        }
        actionSheet()
    }
}
