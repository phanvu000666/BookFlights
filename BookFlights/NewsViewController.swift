//
//  NewsViewController.swift
//  BookFlights
//
//  Created by Khả Như on 14/05/2022.
//  Copyright © 2022 hoangvu. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDislayoutSubView()
        view.addSubview(webView)
        guard let myURL = URL(string:"https://flightglobal.com/news") else {
            return
        }
        webView.load(URLRequest(url: myURL))
    }
    func viewDislayoutSubView() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}

