//
//  BaseWKWebController.swift
//  RxTest
//
//  Created by myxc on 2018/10/11.
//  Copyright © 2018 myxc. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

let handlerName = "name"
let webEstimatedProgress = "estimatedProgress"

class BaseWKWebController: UIViewController {

    var urlString:String? {
        didSet {
            if urlString != nil {
                webView.load(URLRequest.init(url: NSURL.init(string: urlString!)! as URL))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view.addSubview(progress)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        urlString = "http://localhost:63342/Demo/Text.html?_ijt=jo1ctphh77amjihipo29evpp0f"
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(self, forKeyPath: webEstimatedProgress, options: NSKeyValueObservingOptions.new, context: nil)
        webView.configuration.userContentController.add(self, name: handlerName)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.removeObserver(self, forKeyPath: webEstimatedProgress)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: handlerName)
    }
    
    //MARK: - KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progress.alpha = 1.0
            progress.setProgress(Float(webView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            print("webView.estimatedProgress--------->\(webView.estimatedProgress)")
            if(webView.estimatedProgress == 1.0) {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations: {[weak self] () -> Void in
                    self?.progress.alpha = 0.0
                    }, completion: {[weak self] (finished:Bool) -> Void in
                        self?.progress.progress = 0
                })
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progress.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 2)
    }
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.preferences.javaScriptEnabled = true//js可交互
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        let web = WKWebView.init(frame: self.view.bounds, configuration: config)
        return web
    }()
    
    lazy var progress: UIProgressView = {
        let progressView = UIProgressView()
        progressView.tintColor = UIColor.blue
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()

}

extension BaseWKWebController: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("body:\(message.body)")
        print("name : \(message.name)")

        let bodyDic = message.body as? [String:Any]
        let params = bodyDic!["params"] as? [String:Any]
        if let url = params!["url"] as? String,
           let title = params!["title"] as? String {
           let vc = BaseWKWebController()
            vc.urlString = url
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail")
    }
    
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        print("shouldPreviewElement")
        return true
    }
    
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        print("commitPreviewingViewController")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation")
    }
    
}
