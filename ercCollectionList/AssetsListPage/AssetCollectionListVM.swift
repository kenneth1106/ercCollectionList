//
//  AssetCollectionListVM.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/9.
//

import Foundation

protocol AssetCollectionListVMDelegate: AnyObject {
    func assetListLoaded()
}

class AssetCollectionListVM {
    var fetchURL = ""
    var currentCursor: String?
    var pageCursor: String?
    var assets: [Asset] = []
    weak var delegate: AssetCollectionListVMDelegate? = nil
    
    init(urlString: String) {
        self.fetchURL = urlString
    }
    
    func fetchAssetList() {
        if currentCursor == nil || currentCursor != pageCursor {
            currentCursor = pageCursor
            APIService.getAssetsList(URLString: self.fetchURL, forPage: self.pageCursor, completion: { [weak self] result, err in
                if let list = result {
                    self?.assets.append(contentsOf: list.assets ?? [])
                    self?.pageCursor = list.next
                    self?.delegate?.assetListLoaded()
                }
            })
        }
    }
}
