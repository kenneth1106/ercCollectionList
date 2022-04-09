//
//  AssetDetailVM.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/9.
//

import Foundation
import UIKit

protocol AssetDetailVMDelegate: AnyObject {
    func imageLoaded(imageData: Data?)
}

class AssetDetailVM {
    var selectedAssetItem: Asset? = nil
    weak var delegate: AssetDetailVMDelegate? = nil
    
    init(selectedAsset asset: Asset) {
        self.selectedAssetItem = asset
    }
    
    func loadImage() {
        if let imgUrlString = self.selectedAssetItem?.imageURL, let imgUrl = URL(string: imgUrlString) {
            APIService.getImageData(from: imgUrl, completion: { [weak self] imageData, response, err in
                self?.delegate?.imageLoaded(imageData: imageData)
            })
        }
    }
    
}
