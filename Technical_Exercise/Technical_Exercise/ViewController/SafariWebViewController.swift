//
//  SafariWebViewController.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import WebKit
import UIKit

class SafariWebViewController: UIViewController {
    var webView : WKWebView?
    var urlSTR: String?
    var titleText: String?
    override func viewDidLoad() {
        self.title = titleText
        webView = WKWebView(frame: CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        loadWebView()
    }
    
    func loadWebView() {
        if let str = urlSTR {
            if let url = URL(string: str) {
                let webView = WKWebView(frame: self.view.frame)
                let request = URLRequest(url: url)
                webView.load(request)
                self.view.addSubview(webView)
            }
        }
    }
    @objc func onBackButtonPress() {
        self.dismiss(animated: true, completion: nil)
    }
}
