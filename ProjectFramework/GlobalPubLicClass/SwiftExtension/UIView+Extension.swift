//
//  SwiftExtension.swift
//  CityParty
//
//  Created by hcy on 16/4/4.
//  Copyright © 2015年 hcy. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    func size(size:CGSize){
         var frame = self.frame
        frame.size = size
        self.frame = frame
    }
    func headView( width:CGFloat, height:CGFloat, leftViewColor:UIColor, title:String, titleColor:UIColor=UIColor.black) -> UIView {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        view.backgroundColor = UIColor.white
        
        let leftView = UIView()
        leftView.frame = CGRect.init(x: 10, y: 10, width: 4, height: 18)
        leftView.backgroundColor = leftViewColor
        view.addSubview(leftView)
        
        let lable = UILabel()
        lable.frame = CGRect.init(x: CGFloat(leftView.frame.maxX + 10), y: 0, width: 80, height: 15)
        lable.center.y = leftView.center.y
        lable.text = title
        lable.font = UIFont.systemFont(ofSize: 14)
        lable.textColor = titleColor
        view.addSubview(lable)
        
        return view
    }
    func initSectionView(text:String) -> UIView {
        let view = UIView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 50))
            view.backgroundColor = UIColor.white
        
        let lable = UILabel.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: 120, h: 30))
        lable.center.x = view.center.x
        lable.center.y = view.center.y
        lable.backgroundColor = UIColor().TransferStringToColor("#738FFE")
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 12)
        lable.textColor = UIColor.white
        lable.layer.cornerRadius = 5
        lable.clipsToBounds = true
        lable.text = text
        
        view.addSubview(lable)
        
        return view
    }
}

                                            
