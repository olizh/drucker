//
//  ViewController.swift
//  德鲁克学徒
//
//  Created by ZhangOliver on 2017/1/29.
//  Copyright © 2017年 ZhangOliver. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation


class ViewController: UIViewController, UIWebViewDelegate, WKUIDelegate, WKScriptMessageHandler {
    private lazy var webView: WKWebView? = { return nil }()
    //private var webView = WKWebView()
    private var startUrl = "https://olizh.github.io/?isInSWIFT"
    
    override func loadView() {
        super.loadView()
        // receive notifications sent from javascript
        let contentController = WKUserContentController();
        //get page information if it follows opengraph
        /*
         let jsCode = "webkit.messageHandlers.callbackHandler.postMessage('testsound');"
         let userScript = WKUserScript(
         source: jsCode,
         injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
         forMainFrameOnly: true
         )
         contentController.addUserScript(userScript)
         */
        contentController.add(
            self,
            name: "callbackHandler"
        )
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: self.view.frame, configuration: config)
        self.view = self.webView
        //self.webView?.navigationDelegate = self
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
                if let webView = self.webView {
                    webView.loadHTMLString(s as String, baseURL:base)
                }
            } catch {
                //loadFromWeb()
            }
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            if let messageBody = message.body as? String {
                switch messageBody {
                case "testsound": AudioServicesPlaySystemSound(1106)
                case "correct": AudioServicesPlaySystemSound(4095)
                case "success":AudioServicesPlaySystemSound(4095)
                default: return
                }
            }
        }
    }
    
}

