//
//  ViewController.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/8.
//

import UIKit

class ViewController: UIViewController {
    let assetCellWithReuseIdentifier = "assetCellWithReuseIdentifier"
    let endpoint = "https://api.opensea.io/api/v1/assets"
    let pageTitle = "My ERC Collections"
    
    lazy var assetCollectionListVM: AssetCollectionListVM = {
        let vm = AssetCollectionListVM(urlString: endpoint)
        return vm
    }()
    
    lazy var assetsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.minimumLineSpacing = 5
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 10, height: UIScreen.main.bounds.height / 3 - 15)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
        collectionView.alwaysBounceVertical = true
        collectionView.layer.borderWidth = 0.5
        collectionView.alwaysBounceVertical = false
        collectionView.register(AssetCollectionViewCell.self, forCellWithReuseIdentifier: assetCellWithReuseIdentifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = pageTitle
        
        assetsCollectionView.delegate = self
        assetsCollectionView.dataSource = self
        assetCollectionListVM.delegate = self
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(assetsCollectionView)
        
        self.assetsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.assetsCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.assetsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.assetsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.assetsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension ViewController: AssetCollectionListVMDelegate {
    func assetListLoaded() {
        DispatchQueue.main.async { [weak self] in
            
            self?.assetsCollectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentBottomPosition = scrollView.contentOffset.y + scrollView.bounds.height - self.view.safeAreaInsets.bottom
        if scrollView.contentSize.height - currentBottomPosition < 0 {
            assetCollectionListVM.fetchAssetList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetCollectionListVM.assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: assetCellWithReuseIdentifier, for: indexPath) as! AssetCollectionViewCell
        
        if self.assetCollectionListVM.assets.count >= indexPath.row {
            cell.config(self.assetCollectionListVM.assets[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AssetCollectionViewCell else { return }
        
        if let asset = cell.assetItem {
            let assetDetailVM = AssetDetailVM(selectedAsset: asset)
            let assetDetailVC = AssetDetailVC.init(vm: assetDetailVM)
            self.navigationController?.pushViewController(assetDetailVC, animated: true)
        }
    }
}

