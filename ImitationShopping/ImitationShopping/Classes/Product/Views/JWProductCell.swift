//
//  JWProductCell.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWProductCell: UICollectionViewCell {

    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() -> Void {
        
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        self.addSubview(self.productImageView)
        self.addSubview(self.productNameLabel)
        self.addSubview(self.productPriceLabel)
        self.addSubview(self.productFavButton)
        
        self.productImageView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(164)
        }
        
        self.productNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.right.equalTo(self).offset(-5)
            make.width.equalTo(self).offset(-10)
            make.top.equalTo(self.productImageView.snp_bottom).offset(10)
        }
        
        self.productPriceLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-10)
        }
        
        self.productFavButton.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-5)
            make.bottom.equalTo(self).offset(-10)
        }
        self.productFavButton.addTarget(self, action: #selector(favButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK:- Public Method
    var product: JWProductModle? {
        
        didSet {
            
            self.productImageView.sd_setImageWithURL(NSURL(string:(product?.product_cover_image_url)!),
                                                     placeholderImage: UIImage.init(named: "placeholder_Image"))
            self.productNameLabel.text = product!.product_name
            self.productPriceLabel.text = "￥" + String(product!.product_price!)
            self.productFavButton.setTitle(String(product!.product_favCount!),
                                           forState: UIControlState.Normal)
            self.productFavButton.setImage(UIImage.init(named: product!.product_is_fav! ? "fav_yes" : "fav_no"),
                                           forState: UIControlState.Normal)
        }
    }
    
    // MARK:- Lazy loading
    var productImageView: UIImageView = {
        let tempImageView = UIImageView()
        
        return tempImageView
    }()
    
    var productNameLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(13)
        tempLabel.textColor = JWColor(0, g: 0, b: 0, a: 0.7)
        tempLabel.textAlignment = NSTextAlignment.Left
        tempLabel.numberOfLines = 0
        
        return tempLabel
    }()
    
    var productPriceLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.systemFontOfSize(12)
        tempLabel.textColor = JWColor(232, g: 84, b: 85, a: 1)
        tempLabel.textAlignment = NSTextAlignment.Left
        
        return tempLabel
    }()
    
    var productFavButton: UIButton = {
        let tempButton = UIButton.init()
        tempButton.setTitleColor(JWColor(0, g: 0, b: 0, a: 0.4), forState: UIControlState.Normal)
        tempButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        tempButton.titleEdgeInsets = UIEdgeInsetsMake(0, 1, 0, -1);
        tempButton.imageEdgeInsets = UIEdgeInsetsMake(0, -1, 0, 1)
        
        
        return tempButton
    }()
    
    // MARK:- Action Event
    func favButtonAction(sender: UIButton) -> Void {
        
    }
}
