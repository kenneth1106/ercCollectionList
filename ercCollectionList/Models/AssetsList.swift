//
//  Asset.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/8.
//

import Foundation

// MARK: - AssetsList
struct AssetsList: Codable {
    let next, previous: String?
    let assets: [Asset]?
}
