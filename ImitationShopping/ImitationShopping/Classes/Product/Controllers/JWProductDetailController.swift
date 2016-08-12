//
//  JWProductDetailController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWProductDetailController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "商品详情"
        
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
    func setupUI() -> Void {
        self.view.addSubview(self.pdScrollView)
        self.view.addSubview(self.pdToolView)
        
        self.pdScrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.pdToolView.snp_top)
        }
        
        self.pdToolView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        self.pdScrollView.contentSize = CGSizeMake(JW_SCREEN_WIDTH,
                                                   JW_SCREEN_Height - 64 - 50 + JW_MARGIN + 520)
    }
    
    var product: JWProductModle? {
        
        didSet {
            
            self.pdScrollView.product = product!
            self.pdToolView.product = product!
        }
    }
    
    // MARK:- Lazy loading
    lazy var pdScrollView: JWPDScrollView = {
        let tempScrollView = JWPDScrollView()
        tempScrollView.delegate = self
        tempScrollView.scrollEnabled = true
        
        return tempScrollView
    }()
    
    lazy var pdToolView: JWPDToolView = {
        let tempToolView = JWPDToolView()
        tempToolView.delegate = self
        
        return tempToolView
    }()
}

extension JWProductDetailController : UIScrollViewDelegate, JWPDToolViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = pdScrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            pdScrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }
    
    func toolViewDidSeletedLike() {
        
    }
    
    func toolViewDidSeletedBuy() {
        
        let buyController = JWProductBuyController()
        buyController.product = self.product
        navigationController?.pushViewController(buyController, animated: true)
    }
}
