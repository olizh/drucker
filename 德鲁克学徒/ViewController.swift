//
//  ViewController.swift
//  德鲁克学徒
//
//  Created by ZhangOliver on 2017/1/29.
//  Copyright © 2017年 ZhangOliver. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    private var webView = WKWebView()
    private var startUrl = "https://olizh.github.io/?isInSWIFT"
    
    override func loadView() {
        super.loadView()
        self.view = self.webView
        self.webView.navigationDelegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadFromLocal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadFromLocal() {
        if let templatePath = Bundle.main.path(forResource: "index", ofType: "html"){
            let base = URL(string: startUrl)
            do {
                let s = try NSString(contentsOfFile:templatePath, encoding:String.Encoding.utf8.rawValue)
                self.webView.loadHTMLString(s as String, baseURL:base)
            } catch {
                //loadFromWeb()
            }
        }
    }
    
}

