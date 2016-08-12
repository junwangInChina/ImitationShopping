//
//  JWPDSBCommentCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWPDSBCommentCell: UITableViewCell {

    // MARK:- Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.addSubview(self.userImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.timeLabel)
        self.addSubview(self.contentLabel)
        
        self.userImageView.snp_makeConstraints { [weak self] (make) in
            make.left.top.equalTo(self!).offset(JW_MARGIN)
            make.size.equalTo(CGSizeMake(30, 30))
        }
        
        self.titleLabel.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!.userImageView.snp_right).offset(JW_MARGIN)
            make.centerY.equalTo(self!.userImageView)
        }
        
        self.timeLabel.snp_makeConstraints { [weak self] (make) in
            make.right.equalTo(self!).offset(-JW_MARGIN)
            make.centerY.equalTo(self!.userImageView)
        }
        
        self.contentLabel.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!.titleLabel)
            make.right.equalTo(self!).offset(-JW_MARGIN)
            make.width.equalTo(self!).offset(-JW_MARGIN*6)
            make.top.equalTo(self!.titleLabel.snp_bottom).offset(JW_MARGIN)
            make.bottom.lessThanOrEqualTo(self!).offset(-JW_MARGIN)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(bottomLine)
        bottomLine.snp_makeConstraints { [weak self] (make) in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(0.5)
        }
    }
    
    var comment: JWCommentModle? {
        
        didSet{
            
            self.userImageView.sd_setImageWithURL(NSURL.init(string: (comment!.comment_user?.user_avatr_url)!), placeholderImage: UIImage.init(named: "placeholder_Image"))
            self.titleLabel.text = comment!.comment_user!.user_nickname
            self.contentLabel.text = comment!.comment_content
            self.timeLabel.text = String(comment!.comment_create_at!)
        }
    }
    
    // MARK:- Lazy loading
    private lazy var userImageView: UIImageView = {
        
        let tempImageView = UIImageView()
        tempImageView.layer.cornerRadius = 15
        
        return tempImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.textAlignment = NSTextAlignment.Left
        tempLabel.textColor = JWColor(0, g: 0, b: 0, a: 0.8)
        tempLabel.font = UIFont.systemFontOfSize(14)
        
        return tempLabel
    }()
    
    private lazy var timeLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.textAlignment = NSTextAlignment.Right
        tempLabel.textColor = JWColor(0, g: 0, b: 0, a: 0.6)
        tempLabel.font = UIFont.systemFontOfSize(12)
        
        return tempLabel
    }()
    
    private lazy var contentLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.textAlignment = NSTextAlignment.Left
        tempLabel.textColor = JWColor(0, g: 0, b: 0, a: 0.6)
        tempLabel.font = UIFont.systemFontOfSize(12)
        
        return tempLabel
    }()
}
