//
//  JWPDSBottomView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWPDSBottomView: UIView {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
    
        self.addSubview(self.switchPage)
        self.addSubview(self.detailWebView)
        self.addSubview(self.commentTableView)
        
        self.switchPage.snp_makeConstraints { [weak self] (make) in
            make.left.top.right.equalTo(self!)
            make.height.equalTo(40)
        }
        self.detailWebView.snp_makeConstraints { [weak self] (make) in
            make.left.right.bottom.equalTo(self!)
            make.top.equalTo(self!.switchPage.snp_bottom)
        }
        self.commentTableView.snp_makeConstraints { [weak self] (make) in
            make.left.right.bottom.equalTo(self!)
            make.top.equalTo(self!.switchPage.snp_bottom)
        }
    }
    
    // MARK:- Lazy loading
    private lazy var switchPage: JWPDSBSwitchPageView = {
        
        let tempSwitch = JWPDSBSwitchPageView()
        tempSwitch.delegate = self
        
        return tempSwitch
    }()
    
    private lazy var detailWebView: UIWebView = {
        
        let tempWebView = UIWebView()
        tempWebView.scalesPageToFit = true
        tempWebView.dataDetectorTypes = .All
        tempWebView.delegate = self
        
        return tempWebView
    }()
    
    private lazy var commentTableView: UITableView = {
        
        let tempTableView = UITableView.init(frame: self.bounds,
                                             style: UITableViewStyle.Plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = .None
        tempTableView.registerClass(JWPDSBCommentCell.self, forCellReuseIdentifier: "JWProductDetailCommentCellIdentifier")
        tempTableView.rowHeight = 64
        tempTableView.hidden = true
        
        return tempTableView
    }()
    
    var comments = [JWCommentModle]()
    var product: JWProductModle? {
        
        didSet {
            
            JWServiceManager.shareInstance().requestProductDetail(product!.product_ID!) { [weak self](prodtctDetail) in
                
                self!.switchPage.commentButton.setTitle("评论" + String(prodtctDetail.product_comment_count!),
                                                        forState: UIControlState.Normal)
                self!.detailWebView.loadHTMLString(prodtctDetail.product_detail_url!, baseURL: nil)
            }
            
            JWServiceManager.shareInstance().requestProductComments(product!.product_ID!) { [weak self](commentList) in
                
                self!.comments = commentList
                self!.commentTableView.reloadData()
            }
        }
    }
}

extension JWPDSBottomView: UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, JWPDSBSwitchPageViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JWProductDetailCommentCellIdentifier", forIndexPath: indexPath) as? JWPDSBCommentCell
        
        cell?.comment = self.comments[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        print("WebView开始加载" + String(webView.request))
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("WebView加载成功" + String(webView.request))
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("WebView开始失败" + String(webView.request) + (error?.description)!)
    }
    
    func switchViewDidSeletedDetail() {
        self.detailWebView.hidden = false
        self.commentTableView.hidden = true
    }
    
    func switchViewDidSeletedComment() {
        self.detailWebView.hidden = true
        self.commentTableView.hidden = false
    }
}
