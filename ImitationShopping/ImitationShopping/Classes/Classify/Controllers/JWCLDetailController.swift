//
//  JWCLDetailController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCLDetailController: JWBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "攻略详情"
                self.view.addSubview(webView)
        webView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsZero)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    // MARK:- Lazy loading
    private lazy var webView: UIWebView = {
        let tempWebView = UIWebView()
        tempWebView.scalesPageToFit = true
        tempWebView.dataDetectorTypes = .All
        tempWebView.delegate = self
        
        return tempWebView
    }()
    
    var item: JWCLItemModle? {
        didSet {
            let url = NSURL.init(string: item!.itemContentURL!)
            let request = NSURLRequest.init(URL: url!)
            webView.loadRequest(request)
        }
    }
    
    var homeItem: JWHomeItemModle? {
        didSet {
            let url = NSURL.init(string: homeItem!.itemContentURL!)
            let request = NSURLRequest.init(URL: url!)
            webView.loadRequest(request)
        }
    }
}

extension JWCLDetailController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("WebView开始加载" + String(webView.request))
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("WebView加载成功" + String(webView.request))
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("WebView开始失败" + String(webView.request) + (error?.description)!)
    }
}