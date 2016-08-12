//
//  JWCGroupCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/11.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCGroupCell: UICollectionViewCell {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.groupImageView)
        self.addSubview(self.groupNameLabel)
        
        self.groupImageView.snp_makeConstraints { [weak self] (make) in
            make.centerY.equalTo(self!).offset(-JW_MARGIN)
            make.centerX.equalTo(self!)
            make.width.height.equalTo(self!.snp_width).multipliedBy(0.7)
        }
        
        self.groupNameLabel.snp_makeConstraints { [weak self] (make) in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!.groupImageView.snp_bottom).offset(JW_MARGIN/2)
        }
    }
    
    var channel: JWCGChannelModle? {
        
        didSet {
            
            self.groupImageView.sd_setImageWithURL(NSURL.init(string: channel!.jwcg_channelImageURL!), placeholderImage: UIImage.init(named: "placeholder_Image"))
            self.groupNameLabel.text = channel!.jwcg_channelName
        }
    }
    
    // MARK:- Lazy loading
    private lazy var groupImageView: UIImageView = {
        let tempImageView = UIImageView()
        
        return tempImageView;
    }()
    
    private lazy var groupNameLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textAlignment = NSTextAlignment.Center
        tempLabel.font = UIFont.systemFontOfSize(14)
        
        return tempLabel;
    }()
}
