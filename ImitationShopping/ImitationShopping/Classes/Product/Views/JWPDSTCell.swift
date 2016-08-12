//
//  JWPDSTCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWPDSTCell: UICollectionViewCell {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.imageView.snp_makeConstraints { [weak self] (make) in
            make.edges.equalTo(self!).inset(UIEdgeInsetsZero)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARk:- Lazy loading
    private lazy var imageView: UIImageView = {
        
        let tempImageView = UIImageView()
        
        return tempImageView
    }()
    
    // MARK:- Public Method
    func configImageName(imageName: String) -> Void {
        self.imageView.sd_setImageWithURL(NSURL.init(string: imageName),
                                          placeholderImage: UIImage.init(named: "placeholder_Image"))
    }
}
