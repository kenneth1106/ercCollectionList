//
//  AssetPermaWebVC.swift
//  ercCollectionList
//
//  Created by kenneth on 2022/4/9.
//

import Foundation
import WebKit

class AssetPermaWebVC: UIViewController {
    
    let permalinkWebView = WKWebView()
    
    init(permaUrl: URL) {
        super.init(nibName: nil, bundle: nil)
        
        let request = URLRequest(url: permaUrl)
        permalinkWebView.load(request)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "PermaDetail"
        setuplayout()
    }
    
    func setuplayout() {
        self.view.addSubview(self.permalinkWebView)
        
        self.permalinkWebView.translatesAutoresizingMaskIntoConstraints = false
        self.permalinkWebView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.permalinkWebView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.permalinkWebView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.permalinkWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
