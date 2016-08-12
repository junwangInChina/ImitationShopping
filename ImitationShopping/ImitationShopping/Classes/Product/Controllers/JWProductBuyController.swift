//
//  JWProductBuyController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWProductBuyController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func setupUI() {
        self.view.addSubview(buyWebView)
        buyWebView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsZero)
        }
    }
    
    var product: JWProductModle? {
        
        didSet {
            let url = NSURL.init(string: product!.product_purchase_url!)
            let request = NSURLRequest.init(URL: url!)
            self.buyWebView.loadRequest(request)
        }
    }
    
    // MARK:- Lazy loading
    private lazy var buyWebView: UIWebView = {
        
        let tempWebView = UIWebView()
        tempWebView.scalesPageToFit = true
        tempWebView.dataDetectorTypes = .All
        tempWebView.delegate = self
        
        return tempWebView
    }()
}

extension JWProductBuyController: UIWebViewDelegate {
    
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