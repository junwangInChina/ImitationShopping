//
//  JWPDSBSwitchPageView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

protocol JWPDSBSwitchPageViewDelegate: NSObjectProtocol {
    // 点击图文详情按钮，的委托方法
    func switchViewDidSeletedDetail()
    // 点击评论按钮，的委托方法
    func switchViewDidSeletedComment()
}

class JWPDSBSwitchPageView: UIView {

    weak var delegate: JWPDSBSwitchPageViewDelegate?
    
    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        addSubview(self.detailButton)
        addSubview(self.commentButton)
        addSubview(self.lineView)
        
        self.detailButton.snp_makeConstraints { [weak self] (make) in
            make.left.top.bottom.equalTo(self!)
            make.width.equalTo(self!).multipliedBy(0.5)
        }
        
        self.commentButton.snp_makeConstraints { [weak self] (make) in
            make.right.top.bottom.equalTo(self!)
            make.width.equalTo(self!).multipliedBy(0.5)
        }
        
        self.lineView.snp_makeConstraints { [weak self] (make) in
            make.left.bottom.equalTo(self!);
            make.width.equalTo(self!).multipliedBy(0.5)
            make.height.equalTo(2)
        }
        
        let topLine = UIView()
        topLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(topLine)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(bottomLine)
        
        let middleLine = UIView()
        middleLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(middleLine)
        
        topLine.snp_makeConstraints { [weak self] (make) in
            make.left.right.top.equalTo(self!)
            make.height.equalTo(0.5)
        }
        
        middleLine.snp_makeConstraints { [weak self] (make) in
            make.top.bottom.centerX.equalTo(self!);
            make.width.equalTo(0.5)
        }
        
        bottomLine.snp_makeConstraints { [weak self] (make) in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(0.5)
        }
    }
    
    // MARK:- Lazy loading
    private lazy var detailButton: UIButton = {
        
        let tempButton = UIButton()
        tempButton.setTitle("图文详情", forState: UIControlState.Normal)
        tempButton.setTitleColor(JWColor(0, g: 0, b: 0, a: 0.7), forState: UIControlState.Normal)
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        tempButton.addTarget(self, action: #selector(detailAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    
    lazy var commentButton: UIButton = {
        
        let tempButton = UIButton()
        tempButton.setTitle("评论", forState: UIControlState.Normal)
        tempButton.setTitleColor(JWColor(0, g: 0, b: 0, a: 0.7), forState: UIControlState.Normal)
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        tempButton.addTarget(self, action: #selector(commentAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    
    private lazy var lineView: UIView = {
        
        let tempLine = UIView()
        tempLine.backgroundColor = UIColor.redColor()
        
        return tempLine
    }()
    
    // MARK:- Private Action Event Method
    func detailAction(sender: UIButton) -> Void {
        
        UIView.animateWithDuration(0.3) { 
            self.lineView.frame.origin.x = 0
        }
        
        delegate?.switchViewDidSeletedDetail()
    }
    
    func commentAction(sender: UIButton) -> Void {
        UIView.animateWithDuration(0.3) {
            self.lineView.frame.origin.x = JW_SCREEN_WIDTH/2
        }
        delegate?.switchViewDidSeletedComment()
    }
}
