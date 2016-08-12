//
//  JWPDSTopView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/5.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWPDSTopView: UIView {

    /*
     * 商品详情，页面上部View
     * 包含商品的基本信息（图片、名称、价格、描述）
     */
    
    // MARK:- Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.addSubview(self.topCollectionView)
        self.addSubview(self.pageControl)
        self.addSubview(self.titleLabel)
        self.addSubview(self.priceLabel)
        self.addSubview(self.descLabel);
        
        self.topCollectionView.snp_makeConstraints { [weak self] (make) in
            make.left.top.right.equalTo(self!)
            make.height.equalTo(375)
        }
        
        self.pageControl.snp_makeConstraints { [weak self] (make) in
            make.centerX.equalTo(self!)
            make.bottom.equalTo(self!.topCollectionView).offset(-JW_MARGIN)
        }
        
        self.titleLabel.snp_makeConstraints { [weak self] (make) in
            make.left.equalTo(self!).offset(JW_MARGIN/2)
            make.right.equalTo(self!).offset(-JW_MARGIN/2)
            make.top.equalTo(self!.topCollectionView.snp_bottom).offset(JW_MARGIN/2)
            make.width.equalTo(self!).offset(-JW_MARGIN)
        }
        
        self.descLabel.snp_makeConstraints { [weak self] (make) in
            make.left.right.width.equalTo(self!.titleLabel)
            make.bottom.equalTo(self!).offset(-JW_MARGIN/2)
        }
        
        self.priceLabel.snp_makeConstraints { [weak self] (make) in
            make.left.right.width.equalTo(self!.titleLabel)
            make.top.equalTo(self!.titleLabel.snp_bottom).offset(JW_MARGIN/2)
            make.bottom.lessThanOrEqualTo(self!.descLabel.snp_top).offset(-JW_MARGIN/2)
        }
    }
    
    var images = [String]()
    var product: JWProductModle? {
        
        didSet {
            self.images = product!.product_image_URLS!
            self.pageControl.numberOfPages = self.images.count
            self.titleLabel.text = product!.product_name
            self.priceLabel.text = "￥ " + String(product!.product_price!)
            self.descLabel.text = product!.product_describe
            self.topCollectionView.reloadData()
        }
    }
    
    // MARK:- Lazy loading
    private lazy var topCollectionView: UICollectionView = {
        
        var tempLayout = UICollectionViewFlowLayout.init()
        tempLayout.itemSize = CGSizeMake(JW_SCREEN_WIDTH, 375)
        tempLayout.minimumLineSpacing = 0
        tempLayout.minimumInteritemSpacing = 0
        tempLayout.scrollDirection = .Horizontal
        
        let tempCollectionView = UICollectionView.init(frame: self.bounds,
                                                       collectionViewLayout: tempLayout)
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.registerClass(JWPDSTCell.self, forCellWithReuseIdentifier: "ProductDetailTopViewCollectionCellIdentifier")
        tempCollectionView.backgroundColor = self.backgroundColor
        tempCollectionView.bounces = false
        tempCollectionView.pagingEnabled = true
        tempCollectionView.showsHorizontalScrollIndicator = false
        
        return tempCollectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        
        let tempPageControl = UIPageControl.init()
        tempPageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        tempPageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        
        return tempPageControl
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.numberOfLines = 0
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.font = UIFont.systemFontOfSize(16)
        
        return tempLabel
    }()
    
    private lazy var priceLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.numberOfLines = 0
        tempLabel.textColor = UIColor.redColor()
        tempLabel.font = UIFont.systemFontOfSize(14)
        
        return tempLabel
    }()
    
    private lazy var descLabel: UILabel = {
        
        let tempLabel = UILabel.init()
        tempLabel.numberOfLines = 0
        tempLabel.textColor = UIColor.lightGrayColor()
        tempLabel.font = UIFont.systemFontOfSize(14)
        
        return tempLabel
    }()
}

extension JWPDSTopView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK:- UICollectionViewDelegate & UICollectionViewDataSource
    /**
     返回一共有多少个Section
     
     - parameter collectionView: UICollectionView
     
     - returns: 返回一共有多少个Section
     */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /**
     返回每一个Section有多少个Cell
     
     - parameter collectionView: UICollectionView
     - parameter section:        section
     
     - returns: 返回每一个Section有多少个Cell
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    /**
     返回当前CollectionView相对应父View的Insets
     
     - parameter collectionView:       UICollectionView
     - parameter collectionViewLayout: UICollectionViewLayout
     - parameter section:              section
     
     - returns: 返回当前CollectionView相对于父View的UIEdgeInsets
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    /**
     返回每个Cell
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     
     - returns: 返回每个Cell
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductDetailTopViewCollectionCellIdentifier", forIndexPath: indexPath) as! JWPDSTCell
        
        cell.configImageName(self.images[indexPath.row])
        
        return cell;
    }
    
    /**
     Collection Cell的点击事件
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = offsetX / JW_SCREEN_WIDTH
        pageControl.currentPage = Int(page + 0.5)
    }
}
