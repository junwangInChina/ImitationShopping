//
//  JWCCollectionReusableView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/8.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWCCollectionReusableView: UICollectionReusableView {

}

/// Collection 页眉
class JWCCollectionHeaderView: UICollectionReusableView {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!).offset(JW_MARGIN)
            make.bottom.equalTo(self!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Lazy loading
    private lazy var titleLabel: UILabel = {
        
        let tempLabel = UILabel()
        tempLabel.textColor = UIColor.lightGrayColor()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textAlignment = NSTextAlignment.Left
        
        return tempLabel
    }()
    
    // MARK:- Public Method
    func configHeaderTitle(title: String) -> Void {
        self.titleLabel.text = title
    }
}

/// Collection 页脚
class JWCCollectionFooterView: UICollectionReusableView {
    
    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = JWColor(240, g: 240, b: 240, a: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
