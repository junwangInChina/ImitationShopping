//
//  JWCSeeAllCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/12.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCSeeAllCell: UITableViewCell {

    // MARK: - Life cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.addSubview(self.categoryImageView)
        self.addSubview(self.titleLable)
        self.addSubview(self.subTitleLable)
        
        self.categoryImageView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!).inset(UIEdgeInsetsMake(JW_MARGIN/2, JW_MARGIN, JW_MARGIN/2, JW_MARGIN))
        }
        
        self.titleLable.snp_makeConstraints { [weak self] (make) in
            make.centerX.equalTo(self!)
            make.bottom.equalTo(self!.categoryImageView.snp_centerY).offset(-JW_MARGIN/2)
        }
        
        self.subTitleLable.snp_makeConstraints { [weak self] (make) in
            make.centerX.equalTo(self!)
            make.top.equalTo(self!.categoryImageView.snp_centerY).offset(JW_MARGIN/2)
        }
    }
    
    var category: JWClassifyCategoryModle? {
        didSet {
            
            self.categoryImageView.sd_setImageWithURL(NSURL.init(string: category!.jwc_categoryCoverImageURL!),
                                                      placeholderImage: UIImage.init(named: ""))
            self.titleLable.text = category!.jwc_categoryTitle
            self.subTitleLable.text = category!.jwc_categorySubtitle
        }
    }
    
    // MARK: - Lazy loading
    private lazy var categoryImageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.layer.cornerRadius = 5
        tempImageView.clipsToBounds = true
        
        return tempImageView
    }()
    
    private lazy var titleLable: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.font = UIFont.systemFontOfSize(18)
        tempLabel.textAlignment = NSTextAlignment.Center
        
        return tempLabel
    }()
    
    private lazy var subTitleLable: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.font = UIFont.systemFontOfSize(16)
        tempLabel.textAlignment = NSTextAlignment.Center
        
        return tempLabel
    }()

}
