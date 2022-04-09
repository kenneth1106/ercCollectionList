//
//  APIService.swift
//  fontList
//
//  Created by Chen Yu-wen on 2021/5/6.
//  Copyright © 2021 Chen Yu-wen. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit

class APIService {
    
    class func getAssetsList(URLString: String, forPage page: String? = nil, completion: @escaping (_ list: AssetsList?, _ error: Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var urlComponents = URLComponents(string: URLString)!
        if let pageString = page {
            let queryItems = [URLQueryItem(name: "cursor", value: pageString)]
            urlComponents.queryItems = queryItems
        }
        let url = urlComponents.url
        var request = URLRequest(url: url!.absoluteURL)
        
        request.httpMethod = "GET"
        request.addValue("5b294e9193d240e39eefc5e6e551ce83", forHTTPHeaderField: "X-API-KEY")
        request.addValue("0x19818f44faf5a217f619aff0fd487cb2a55cca65", forHTTPHeaderField: "owner")
        request.addValue("0...N", forHTTPHeaderField: "offset")
        request.addValue("20", forHTTPHeaderField: "limit")
        
        let task = session.dataTask(with: request) { data, response, err in
            if (err == nil) {
                let decoder = JSONDecoder()
                if let data = data {
                    var fontList: AssetsList
                    do {
                        fontList = try decoder.decode(AssetsList.self, from: data)
                        completion(fontList, nil)
                    } catch {
                        print(error)
                        completion(nil, error)
                    }
                } else {
                    print("error")
                    completion(nil, err)
                }
            }
            else {
                // Failure
                completion(nil, err)
            }
        }
        task.resume()
    }
    
    class func loadFont(URLString: String, completion: @escaping (_ font: UIFont?, _ error: Error?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let url = NSURL(string: URLString)
        var request = URLRequest(url: url!.absoluteURL!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, err in
            if (err == nil) {
                if let data = data {
                    var uiFont : UIFont?
                    let fontData = data

                    if let dataProvider = CGDataProvider(data: fontData as CFData), let cgFont = CGFont(dataProvider) {
                        var error: Unmanaged<CFError>?
                        if !CTFontManagerRegisterGraphicsFont(cgFont, &error)
                        {
                            print("Error loading Font!")
                        } else {
                            let fontName = cgFont.postScriptName
                            uiFont = UIFont(name: String(fontName!) , size: 20)

                        }
                    }
                    
                    completion(uiFont, nil)
                } else {
                    print("error")
                    completion(nil, err)
                }
            }
            else {
                // Failure
                completion(nil, err)
            }
        }
        task.resume()
    }
    
    class func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
