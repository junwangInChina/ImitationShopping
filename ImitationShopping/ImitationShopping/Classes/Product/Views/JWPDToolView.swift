//
//  JWPDToolView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

protocol JWPDToolViewDelegate: NSObjectProtocol {
    // 点击like按钮，的委托方法
    func toolViewDidSeletedLike()
    // 点击buy按钮，的委托方法
    func toolViewDidSeletedBuy()
}

class JWPDToolView: UIView {

    /* 商品详情，页面底部的工具栏
     * 包含两个按钮，喜欢&去天猫购买
     */
    
    weak var delegate: JWPDToolViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.likeButton)
        self.addSubview(self.buyButton)
        
        self.likeButton.snp_makeConstraints { [weak self] (make) in
            make.centerY.equalTo(self!)
            make.height.equalTo(self!).multipliedBy(0.8)
            make.left.equalTo(self!).offset(JW_MARGIN)
            make.width.equalTo(80)
        }
        
        self.buyButton.snp_makeConstraints { [weak self] (make) in
            make.centerY.equalTo(self!)
            make.left.equalTo(self!.likeButton.snp_right).offset(JW_MARGIN)
            make.right.equalTo(self!).offset(-JW_MARGIN)
            make.height.equalTo(self!).multipliedBy(0.8)
        }
    }
    
    var product: JWProductModle? {
        
        didSet {
            
            self.likeButton.setImage(UIImage.init(named: product!.product_is_fav! ? "fav_yes" : "fav_no"),
                                     forState: UIControlState.Normal)
            self.likeButton.setTitle(product!.product_is_fav! ? "不喜欢" : "喜欢",
                                     forState: UIControlState.Normal)
        }
    }
    
    // MARK:- Lazy loading
    lazy var likeButton: UIButton = {
        let tempButton = UIButton.init()
        tempButton.backgroundColor = UIColor.whiteColor()
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        tempButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        tempButton.layer.cornerRadius = 10;
        tempButton.layer.borderWidth = 1;
        tempButton.layer.borderColor = UIColor.redColor().CGColor
        tempButton.addTarget(self, action: #selector(likeAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    lazy var buyButton: UIButton = {
        let tempButton = UIButton.init()
        tempButton.backgroundColor = UIColor.redColor()
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        tempButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        tempButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        tempButton.setTitle("去天猫购买", forState: UIControlState.Normal)
        tempButton.layer.cornerRadius = 10;
        tempButton.layer.borderWidth = 1;
        tempButton.layer.borderColor = UIColor.redColor().CGColor
        tempButton.addTarget(self, action: #selector(buyAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    
    // MARK:- Action Event
    func likeAction(sender: UIButton) -> Void {
        delegate?.toolViewDidSeletedLike()
    }
    
    func buyAction(sender: UIButton) -> Void {
        delegate?.toolViewDidSeletedBuy()
    }
}
