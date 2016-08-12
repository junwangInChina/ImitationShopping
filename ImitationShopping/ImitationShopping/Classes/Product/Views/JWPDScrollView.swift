//
//  JWPDScrollView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWPDScrollView: UIScrollView {

    /* 商品详情，页面的ScrollView，包含两个View
     * 顶部的商品信息          JWPDSTopView
     * 底部的商品详情&评论      JWPDSBottomView
     */
    
    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.userInteractionEnabled = true
        
        addSubview(self.topView)
        addSubview(self.bottomView)
        
        self.topView.snp_makeConstraints { [weak self] (make) in
            make.left.top.equalTo(self!)
            make.size.equalTo(CGSizeMake(JW_SCREEN_WIDTH, 520))
        }
        
        self.bottomView.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!)
            make.top.equalTo(self!.topView.snp_bottom).offset(JW_MARGIN)
            make.size.equalTo(CGSizeMake(JW_SCREEN_WIDTH, JW_SCREEN_Height - 64 - 45))
        }
    }
    
    var product: JWProductModle? {
        
        didSet {
            
            self.topView.product = product!
            self.bottomView.product = product!
        }
    }
    
    // MARK:- Lazy loading
    private lazy var topView: JWPDSTopView = {
        let tempTopView = JWPDSTopView()
        tempTopView.backgroundColor = UIColor.whiteColor()
        
        return tempTopView
    }()
    
    private lazy var bottomView: JWPDSBottomView = {
        let tempBottomView = JWPDSBottomView()
        tempBottomView.backgroundColor = UIColor.whiteColor()
        
        return tempBottomView
    }()
    
}
