//
//  AssetCollectionViewCell.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/8.
//

import Foundation
import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    
    var assetItem: Asset? = nil
    let assetImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.assetImageView.image = nil
        self.nameLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.assetImageView.contentMode = .scaleAspectFit
        self.setupLayout()
    }
    
    func setupLayout() {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.addSubview(self.assetImageView)
        self.addSubview(self.nameLabel)
        
        self.nameLabel.textAlignment = .center
        self.nameLabel.center = self.center
        self.nameLabel.minimumScaleFactor = 0.5
        self.nameLabel.adjustsFontSizeToFitWidth = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        self.nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.assetImageView.translatesAutoresizingMaskIntoConstraints = false
        self.assetImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.assetImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.assetImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        self.assetImageView.bottomAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: -8).isActive = true
    }
    
    func config(_ item: Asset) {
        if let imgUrlString = item.imageURL, let imgUrl = URL(string: imgUrlString) {
            APIService.getImageData(from: imgUrl, completion: { [weak self] imageData, response, err in
                if let data = imageData {
                    DispatchQueue.main.async { [weak self] in
                        self?.assetImageView.image = UIImage(data: data)
                    }
                }
            })
        }
        
        self.nameLabel.text = item.name
        self.assetItem = item
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
