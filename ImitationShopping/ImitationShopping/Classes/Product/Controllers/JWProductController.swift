//
//  JWProductController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWProductController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.addSubview(self.productCollectionView)
        self.productCollectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsZero)
        }
        self.queryProductListRequest()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Lazy loading
    lazy var productCollectionView: UICollectionView = {
        
        var tempLayout = UICollectionViewFlowLayout.init()
        tempLayout.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.width-30)/2,
                                         245)     // 每个item(Cell)的Size
        tempLayout.minimumLineSpacing = 10;       // 每个item的上下间隔
        tempLayout.minimumInteritemSpacing = 10;  // 每个item的左右间隔
        
        let tempCollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: tempLayout)
        tempCollectionView.delegate = self;
        tempCollectionView.dataSource = self;
        tempCollectionView.registerClass(JWProductCell.self, forCellWithReuseIdentifier: "ProductCollectionCellIdentifier")
        tempCollectionView.backgroundColor = self.view.backgroundColor
        
        return tempCollectionView
    }()

    var productList: NSMutableArray = NSMutableArray()
    
    // MARK:- Request
    func queryProductListRequest() -> Void {
        
        JWServiceManager.shareInstance().requestProductData { [weak self] (productList) in
            if productList.count > 0 {
            
                self?.productList.removeAllObjects()
                self?.productList.addObjectsFromArray(productList)
                self?.productCollectionView.reloadData()
            }
        }
    }
}

extension JWProductController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        return self.productList.count
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCollectionCellIdentifier", forIndexPath: indexPath) as! JWProductCell
        
        cell.product = self.productList[indexPath.row] as? JWProductModle
        
        return cell;
    }
    
    /**
     Collection Cell的点击事件
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = JWProductDetailController()
        detailController.product = self.productList[indexPath.row] as? JWProductModle
        navigationController?.pushViewController(detailController, animated: true)
    }
}
