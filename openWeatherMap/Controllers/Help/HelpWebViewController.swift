//
//  HelpWebViewController.swift
//  openWeatherMap
//
//  Created by GreenTech on 11/28/18.
//  Copyright © 2018 AhmedKhidr. All rights reserved.
//

import UIKit

class HelpWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.scrollView.minimumZoomScale = 1.0
        webView?.scrollView.maximumZoomScale = 5.0
        
        if let url = Bundle.main.path(forResource: "help", ofType: "html"){
            let requesturl = URL(string: url)
            let request = URLRequest(url: requesturl!)
            webView?.loadRequest(request)
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
