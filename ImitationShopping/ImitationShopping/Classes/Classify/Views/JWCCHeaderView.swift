//
//  JWCCHeaderView.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/8.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

protocol JWCCHeaderViewDelegate:NSObjectProtocol {
    
    func jwcc_headViewDidSeletedSeeAll()
    func jwcc_headViewDidSeletedCategory(category: JWClassifyCategoryModle)
}

class JWCCHeaderView: UIView {

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
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.seeAllButton)
        self.addSubview(self.headerCollectionView)
        
        let tempBottomLine = UIView()
        tempBottomLine.backgroundColor = JWColor(240, g: 240, b: 240, a: 1)
        self.addSubview(tempBottomLine)
        tempBottomLine.snp_makeConstraints { [weak self] (make) in
            make.left.right.bottom.equalTo(self!)
            make.height.equalTo(JW_MARGIN)
        }
        
        self.titleLabel.snp_makeConstraints { [weak self] (make) in
            make.left.top.equalTo(self!).offset(JW_MARGIN)
        }
        
        self.seeAllButton.snp_makeConstraints { [weak self] (make) in
            make.right.equalTo(self!).offset(-JW_MARGIN)
            make.centerY.equalTo(self!.titleLabel)
        }
        
        self.headerCollectionView.snp_makeConstraints { [weak self] (make) in
            make.left.right.equalTo(self!);
            make.top.equalTo(self!.titleLabel.snp_bottom)
            make.bottom.equalTo(tempBottomLine.snp_top)
        }
        
    }
    
    // MARK:- Lazy loading
    private lazy var headerCollectionView: UICollectionView = {
        
        var tempLayout = UICollectionViewFlowLayout.init()
        tempLayout.itemSize = CGSizeMake(150,
                                         75)     // 每个item(Cell)的Size
        tempLayout.minimumLineSpacing = 10;       // 每个item的上下间隔
        tempLayout.minimumInteritemSpacing = 10;  // 每个item的左右间隔
        tempLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        let tempCollection = UICollectionView.init(frame: self.bounds,
                                                   collectionViewLayout: tempLayout)
        tempCollection.delegate = self
        tempCollection.dataSource = self
        tempCollection.backgroundColor = self.backgroundColor
        tempCollection.showsHorizontalScrollIndicator = false
        tempCollection.registerClass(JWCHCollectionCell.self,
                                     forCellWithReuseIdentifier: "ClassifyHeaderCollectionCellIdentifier")
        return tempCollection
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let tempLabel = UILabel()
        tempLabel.textColor = UIColor.lightGrayColor()
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textAlignment = NSTextAlignment.Left
        tempLabel.text = "专题合集"
        
        return tempLabel
    }()
    
    private lazy var seeAllButton: UIButton = {
        
        let tempButton = UIButton.init()
        tempButton.setTitleColor(JWColor(0, g: 0, b: 0, a: 0.4), forState: UIControlState.Normal)
        tempButton.setImage(UIImage.init(named: "arrow"), forState: UIControlState.Normal)
        tempButton.setTitle("查看全部", forState: UIControlState.Normal)
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        tempButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        tempButton.titleEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 10);
        tempButton.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, -10)
        tempButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right

        tempButton.addTarget(self, action: #selector(seeAllAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
    }()
    
    private var categorys = [JWClassifyCategoryModle]()
    
    weak var delegate: JWCCHeaderViewDelegate?
    
    // MARK:- Action Event
    func seeAllAction(sender: UIButton) -> Void {
        delegate?.jwcc_headViewDidSeletedSeeAll()
    }
    
    func reloadHeadView(list: [JWClassifyCategoryModle]) -> Void {
        self.categorys = list;
        self.headerCollectionView.reloadData()
    }
}

extension JWCCHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        return categorys.count ?? 0
    }
    
    /**
     返回当前CollectionView相对应父View的Insets
     
     - parameter collectionView:       UICollectionView
     - parameter collectionViewLayout: UICollectionViewLayout
     - parameter section:              section
     
     - returns: 返回当前CollectionView相对于父View的UIEdgeInsets
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    /**
     返回每个Cell
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     
     - returns: 返回每个Cell
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClassifyHeaderCollectionCellIdentifier", forIndexPath: indexPath) as! JWCHCollectionCell
        
        cell.category = categorys[indexPath.row]

        return cell;
    }
    
    /**
     Collection Cell的点击事件
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.jwcc_headViewDidSeletedCategory(self.categorys[indexPath.row])
    }
}
