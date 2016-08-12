//
//  JWCHCollectionCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/8.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCHCollectionCell: UICollectionViewCell {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        self.addSubview(self.imageView)
        
        self.imageView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!).offset(UIEdgeInsetsZero)
        }
    }
    
    // MARK:- Lazy loading
    private lazy var imageView: UIImageView = {
        let tempImageView = UIImageView()
        tempImageView.layer.cornerRadius = 5
        tempImageView.clipsToBounds = true
        
        return tempImageView
    }()
    
    var category: JWClassifyCategoryModle? {
        
        didSet {
            self.imageView.sd_setImageWithURL(NSURL.init(string: category!.jwc_categoryBannerImageURL!),
                                              placeholderImage: UIImage.init(named: "placeholder_Image"))
        }
    }
}
