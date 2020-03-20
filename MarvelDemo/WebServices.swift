//
//  WebServices.swift
//  MarvelDemo
//
//  Created by Berkay Sebat on 3/18/20.
//  Copyright © 2020 marvel. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

class WebServices {
    
    // MARK: - Private Properties -
    
    private let session = URLSession.shared
    
    // MARK: - API Calls -
    
    func fetchApiData(completion: @escaping (_ data:MarvelObj?, _ failure:String?) -> ()) {
        let apiKey = "effb80dc84b84faad35bc2aae6d301bf"
        let privateKey = "471a9d5978e4083d11629f3ef22bec8b660480bb"
        let timeStamp = String(Date().timeIntervalSince1970)
        guard let hash = MD5(timeStamp+privateKey+apiKey) else {
            completion(nil,"failed to generate hash check if keys are valid")
            return
            
        }
        let urlString = "http://gateway.marvel.com/v1/public/comics/1003?ts=\(timeStamp)&apikey=\(apiKey)&hash=\(hash)"
        guard let url = URL.init(string:urlString) else {
            completion(nil,"failed to generate correct url check if keys are valid")
            return
        }
        var task = URLSessionDownloadTask.init()
        task = session.downloadTask(with: url, completionHandler: { (tempUrl, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil,"unable to connect to server")
                return
                
            }
            if let error = error {
                completion(nil,"error connecting to server:\(error.localizedDescription)")
                return
            }
            guard let fileLocation = tempUrl else {
                completion(nil,"error parsing json data")
                return
            }
            guard let data = try? Data.init(contentsOf: fileLocation) else {
                completion(nil,"error parsing json data")
                return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    guard let jsonData = json["data"] as? [String:Any] else {
                        completion(nil,"error parsing json data")
                        return}
                    let jsonObj = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                    let marvelObj = try JSONDecoder().decode(MarvelObj.self, from: jsonObj)
                    completion(marvelObj,nil)
                } else {
                    completion(nil,"error parsing json data")
                }
            } catch let error as NSError {
                completion(nil,error.localizedDescription)
            }
        })
        
        task.resume()
        
    }
    
    // MARK: - Hash Function -
    
    private func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let d = string.data(using: .utf8) { _ = d.withUnsafeBytes { body -> String in CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
            return ""
            }
        }
        return (0..<length).reduce("") { $0 + String(format: "%02x", digest[$1]) } }
}

