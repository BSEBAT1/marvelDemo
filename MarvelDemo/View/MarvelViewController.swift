//
//  ViewController.swift
//  MarvelDemo
//
//  Created by Berkay Sebat on 3/18/20.
//  Copyright © 2020 marvel. All rights reserved.
//

import UIKit


class MarvelViewController: UIViewController {
    
    private let progressHUD = ProgressHUD(text: "Fetching Data")
    
    @IBOutlet var coverImage: CustomImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(progressHUD)
        let webservice = WebServices.init()
        webservice.fetchApiData {[weak self] (data, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    self?.progressHUD.hide()
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                if let comicBookData = data {
                    
                    DispatchQueue.main.async {
                        self?.progressHUD.hide()
                        self?.titleLabel.text = comicBookData.results[0].title
                        self?.descBox.text = comicBookData.results[0].textObjects?[0].text
                        if var url = comicBookData.results[0].thumbnail?.path {
                            url = url+"/detail.jpg"
                            self?.coverImage.loadImageUsingCacheWithUrlString(urlString:url)
                        }
                    }
                }
            }
        }
    }
}


