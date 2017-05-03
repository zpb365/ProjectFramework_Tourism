//
//  WaterCollectionViewLayout.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/13.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class WaterCollectionViewLayout: UICollectionViewLayout {
//    //来控制cell的大小
//    var setSize:()->(Array<UIImage>) = {_ in return []}
    var queueNum: Int = 2 //列数，默认为两列
    let margin: CGFloat = 3//左右距离
    var hs: Array<CGFloat>!
    private var totalNum: Int!
    private var layoutAttributes: Array<UICollectionViewLayoutAttributes>!
    private let gap:CGFloat = 5//间隔，缝隙大小
    private var width:CGFloat!
    override func prepare() {
        super.prepare()
        hs = []
        for _ in 0..<queueNum {
            hs.append(5)
        }
        
        totalNum = collectionView?.numberOfItems(inSection: 0)
        layoutAttributes = []
        var indexpath: NSIndexPath!
        for index in 0..<totalNum {
            indexpath = NSIndexPath(row: index, section: 0)
            let attributes = layoutAttributesForItem(at: indexpath as IndexPath)
            layoutAttributes.append(attributes!)
        }
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        width = (collectionView!.bounds.size.width-gap*(CGFloat(queueNum)-1)-margin*2)/CGFloat(queueNum)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//        let sizes = setSize()
        //随机给个高度
//        let num1 = CGFloat(arc4random() % 100)
//        let num2 = CGFloat(arc4random() % 100)
//        if num1 >= num2{
//            attributes.size = CGSize(width: width , height: 200 + CGFloat(arc4random() % 30))
//        }
//        else{
//            attributes.size = CGSize(width: width , height: 200 - CGFloat(arc4random() % 50))
//        }
//        if indexPath.item % 2 == 0 {
//            attributes.size = CGSize(width: width , height: 200 + 30)
//        }else{
            attributes.size = CGSize(width: width , height: 200)
//        }
        var nub:CGFloat = 0
        var h:CGFloat = 0
        (nub,h) = minH(hhs: hs)
        attributes.center = CGPoint(x:(nub+0.5)*(gap+width), y:h+(width/attributes.size.width*attributes.size.height+gap)/2)
        hs[Int(nub)] = h+width/attributes.size.width*attributes.size.height+gap
        return attributes
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: (collectionView?.bounds.width)!, height: maxH(hhs: hs))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
    private func minH(hhs:Array<CGFloat>)->(CGFloat,CGFloat){
        var num = 0
        var min = hhs[0]
        for i in 1..<hhs.count{
            if min>hhs[i] {
                min = hhs[i]
                num = i
            }
        }
        return (CGFloat(num),min)
    }
    func maxH(hhs:Array<CGFloat>)->CGFloat{
        var max = hhs[0]
        for i in 1..<hhs.count{
            if max<hhs[i] {
                max = hhs[i]
            }
        }
        
        return max
    } 
}

