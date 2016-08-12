//
//  JWCLItemCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCLItemCell: UITableViewCell {

    // MARK: - Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.addSubview(self.itemImageView)
        self.addSubview(self.titleLable)
        self.addSubview(self.likeButton)
        
        self.itemImageView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!).inset(UIEdgeInsetsMake(JW_MARGIN/2, JW_MARGIN, JW_MARGIN/2, JW_MARGIN))
        }
        
        self.titleLable.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!.itemImageView).offset(JW_MARGIN)
            make.bottom.equalTo(self!.itemImageView).offset(-JW_MARGIN)
        }
        
        self.likeButton.snp_makeConstraints { [weak self] (make) in
            make.right.equalTo(self!.itemImageView).offset(-JW_MARGIN)
            make.top.equalTo(self!.itemImageView).offset(JW_MARGIN)
            make.height.equalTo(26)
        }
    }
    
    var item: JWCLItemModle? {
        didSet {
            
            self.itemImageView.sd_setImageWithURL(NSURL.init(string: item!.itemCoverImageURL!),
                                                  placeholderImage: UIImage.init(named: "placeholder_Image"))
            self.titleLable.text = item!.itemTitle
            self.likeButton.setTitle(String(item!.itemLikeCount!),
                                     forState: UIControlState.Normal)
        }
    }
    
    // MARK: - Lazy loading
    private lazy var itemImageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.layer.cornerRadius = 5
        tempImageView.clipsToBounds = true
        
        return tempImageView
    }()
    
    private lazy var titleLable: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textAlignment = NSTextAlignment.Left
        
        return tempLabel
    }()
    
    private lazy var likeButton: UIButton = {
        let tempButton = UIButton()
        tempButton.backgroundColor = JWColor(0, g: 0, b: 0, a: 0.4)
        tempButton.layer.cornerRadius = 13
        tempButton.setImage(UIImage.init(named: "item_like"), forState: UIControlState.Normal)
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        tempButton.addTarget(self, action: #selector(likeButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    
    // MARK: - Action Event
    func likeButtonAction(sender: UIButton) -> Void {
        
    }
}
