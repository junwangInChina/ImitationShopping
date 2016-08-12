//
//  JWClassifyController.swift
//  ImitationShopping
//
//  Created by wangjun on 16/8/4.
//  Copyright © 2016年 wangjun. All rights reserved.
//

import UIKit

class JWClassifyController: JWBaseViewController {

    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
        self.queryClassifyCategorys()
        self.queryClassifyGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() -> Void {
        
        self.view.addSubview(self.classifyCollectionView)
        self.classifyCollectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsZero)
        }
        
        self.classifyCollectionView.addSubview(self.headerView)
        self.classifyCollectionView.contentInset = UIEdgeInsetsMake(135, 0, 0, 0)
    }
    
    // MARK:- Lazy loading
    private lazy var classifyCollectionView: UICollectionView = {
        
        var tempLayout = UICollectionViewFlowLayout.init()
        tempLayout.itemSize = CGSizeMake((UIScreen.mainScreen().bounds.width-50)/4,
                                         100)     // 每个item(Cell)的Size
        tempLayout.minimumLineSpacing = 10;       // 每个item的上下间隔
        tempLayout.minimumInteritemSpacing = 10;  // 每个item的左右间隔
        
        let tempCollection = UICollectionView.init(frame: self.view.bounds,
                                                   collectionViewLayout: tempLayout)
        tempCollection.delegate = self
        tempCollection.dataSource = self
        tempCollection.backgroundColor = UIColor.whiteColor()//JWColor(240, g: 240, b: 240, a: 1)

        tempCollection.registerClass(JWCGroupCell.self,
                                     forCellWithReuseIdentifier: "ClassifyCollectionGroupCellIdentifier")
        tempCollection.registerClass(JWCCollectionHeaderView.self,
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                     withReuseIdentifier: "ClassifyCollectionHeaderIdentifier")
        tempCollection.registerClass(JWCCollectionFooterView.self,
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                     withReuseIdentifier: "ClassifyCollectionFooterIdentifier")
        return tempCollection
    }()
    
    private lazy var headerView: JWCCHeaderView = {
        let tempHeaderView = JWCCHeaderView.init(frame: CGRectMake(0, -135, JW_SCREEN_WIDTH, 135))
        tempHeaderView.delegate = self;
        
        return tempHeaderView;
    }()
    
    var categorys = [JWClassifyCategoryModle]()
    var groups = [JWClassifyGroupModle]()

    // MARK:- Request
    func queryClassifyCategorys() -> Void {
        
        JWServiceManager.shareInstance().requestClassifyCategorys(6) { (categoryList) in
            self.categorys = categoryList
            self.headerView.reloadHeadView(categoryList)
        }
    }
    
    func queryClassifyGroups() -> Void {
        
        JWServiceManager.shareInstance().requestClassifyGroups { (groupList) in
            self.groups = groupList
            self.classifyCollectionView.reloadData()
        }
    }

}

extension JWClassifyController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JWCCHeaderViewDelegate{
    
    // MARK:- UICollectionViewDelegate & UICollectionViewDataSource
    /**
     返回一共有多少个Section
     
     - parameter collectionView: UICollectionView
     
     - returns: 返回一共有多少个Section
     */
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.groups.count
    }
    
    /**
     返回每一个Section有多少个Cell
     
     - parameter collectionView: UICollectionView
     - parameter section:        section
     
     - returns: 返回每一个Section有多少个Cell
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups[section].jwc_groupChannels!.count
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header: JWCCollectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ClassifyCollectionHeaderIdentifier", forIndexPath: indexPath) as! JWCCollectionHeaderView
            
            header.configHeaderTitle(self.groups[indexPath.section].jwc_groupName!)
            
            return header
        case UICollectionElementKindSectionFooter:
            let footer: JWCCollectionFooterView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ClassifyCollectionFooterIdentifier", forIndexPath: indexPath) as! JWCCollectionFooterView
            
            return footer
        default:
            return UICollectionReusableView()
        }
    }
    /**
     返回CollectionView的每一个Section的页眉(headerView)Size
     
     - parameter collectionView:       UICollectionView
     - parameter collectionViewLayout: UICollectionViewLayout
     - parameter section:              section
     
     - returns: 返回页眉Size
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(JW_SCREEN_WIDTH, 30)
    }
    
    /**
     返回CollectionView的每一个Section的页脚(footerView)Size
     
     - parameter collectionView:       UICollectionView
     - parameter collectionViewLayout: UICollectionViewLayout
     - parameter section:              section
     
     - returns: 返回页脚Size
     */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(JW_SCREEN_WIDTH, 10)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClassifyCollectionGroupCellIdentifier", forIndexPath: indexPath) as! JWCGroupCell
        
        cell.channel = self.groups[indexPath.section].jwc_groupChannels![indexPath.row]
        
        return cell;
    }
    
    /**
     Collection Cell的点击事件
     
     - parameter collectionView: UICollectionView
     - parameter indexPath:      NSIndexPath
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        let channel = self.groups[indexPath.section].jwc_groupChannels![indexPath.row]
        let listController = JWCListController()
        listController.channel = channel
        navigationController?.pushViewController(listController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK:- JWCCHeaderViewDelegate
    func jwcc_headViewDidSeletedSeeAll() {
        
        let allController = JWCSeeAllController()
        navigationController?.pushViewController(allController, animated: true)
    }
    
    func jwcc_headViewDidSeletedCategory(category: JWClassifyCategoryModle) {
        
        let listController = JWCListController()
        listController.category = category
        navigationController?.pushViewController(listController, animated: true)
    }
}
