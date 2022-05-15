//
//  NewsViewController.swift
//  BookFlights
//
//  Created by Khả Như on 14/05/2022.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController,WKUIDelegate {
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let myURL = URL(string:"https://flightglobal.com/news") else {
            return
        }
        webView.load(URLRequest(url: myURL))
    }
}

