//
//  AssetDetailVC.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/9.
//

import Foundation
import UIKit
import WebKit

class AssetDetailVC: UIViewController {
    var assetDetailVM: AssetDetailVM
    
    lazy var assetImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var assetName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var assetDescription: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        return textView
    }()
    
    lazy var webViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Permalink", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(openWebLink), for: .touchUpInside)
        return button
    }()
    
    let bottomView = UIView()
    var permalinkWebView: AssetPermaWebVC?
    
    init(vm: AssetDetailVM) {
        self.assetDetailVM = vm
        super.init(nibName: nil, bundle: nil)
        
        self.assetDetailVM.delegate = self
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = assetDetailVM.selectedAssetItem?.name ?? ""
        
        assetDetailVM.loadImage()
        assetName.text = assetDetailVM.selectedAssetItem?.name ?? ""
        assetDescription.text = assetDetailVM.selectedAssetItem?.assetDescription ?? ""
    }
    
    func setupLayout() {
        self.view.addSubview(assetImage)
        self.view.addSubview(assetName)
        self.view.addSubview(assetDescription)
        self.bottomView.addSubview(webViewButton)
        self.view.addSubview(bottomView)
        
        self.assetImage.translatesAutoresizingMaskIntoConstraints = false
        self.assetImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        self.assetImage.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.assetImage.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.assetImage.heightAnchor.constraint(lessThanOrEqualToConstant: min(self.view.bounds.width, self.assetImage.image?.size.height ?? 100)).isActive = true

        self.assetName.translatesAutoresizingMaskIntoConstraints = false
        self.assetName.topAnchor.constraint(equalTo: self.assetImage.bottomAnchor, constant: 10).isActive = true
        self.assetName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.assetName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.assetName.heightAnchor.constraint(equalToConstant: 30).isActive = true

        self.assetDescription.translatesAutoresizingMaskIntoConstraints = false
        self.assetDescription.topAnchor.constraint(equalTo: self.assetName.bottomAnchor, constant: 10).isActive = true
        self.assetDescription.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        self.assetDescription.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        self.assetDescription.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true

        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.topAnchor.constraint(equalTo: self.assetDescription.bottomAnchor).isActive = true
        self.bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        self.bottomView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.webViewButton.translatesAutoresizingMaskIntoConstraints = false
        self.webViewButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width / 2).isActive = true
        self.webViewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.webViewButton.centerXAnchor.constraint(equalTo: self.bottomView.centerXAnchor).isActive = true
        self.webViewButton.centerYAnchor.constraint(equalTo: self.bottomView.centerYAnchor).isActive = true
    }
    
    @objc func openWebLink() {
        if let permalink = self.assetDetailVM.selectedAssetItem?.permalink, let permalinkUrl = URL(string: permalink) {
            permalinkWebView = AssetPermaWebVC(permaUrl: permalinkUrl)
            self.present(permalinkWebView!, animated: true, completion: nil)
        }
    }
}

extension AssetDetailVC: AssetDetailVMDelegate {
    func imageLoaded(imageData: Data?) {
        if let data = imageData {
            DispatchQueue.main.async { [weak self] in
                self?.assetImage.image = UIImage(data: data)
                self?.setupLayout()
            }
        }
    }
}
