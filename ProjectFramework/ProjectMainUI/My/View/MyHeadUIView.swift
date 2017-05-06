//
//  MyHeadUIView.swift
//  ProjectFramework
//
//  Created by 购友住朋 on 2017/2/28.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyHeadUIView: UIView {
    
    fileprivate  var displayLink:CADisplayLink?=nil
    fileprivate  var shapeLayer:CAShapeLayer?=nil
    fileprivate  var shapeLayer1:CAShapeLayer?=nil
    fileprivate  var dong:CGFloat = 0.0
    
    var Imgbtn:UIButton!
    var LabName:UILabel!
    
    //用代码创建的时候会进入这个init函数体
    override init(frame: CGRect) {
        super.init(frame: frame )
        load()
        
    }
    
    //用Storyboard/xib继承这个类的时候会进入这个init函数体
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    fileprivate  func load(){
        displayLink = CADisplayLink(target: self, selector:#selector(funcdisPlayLink))
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    func funcdisPlayLink(){
        self.dong=self.dong+0.05
        self.shapeLayer?.path=getWavePath(8, w: 0.04, d: 25+60, dong: 0).cgPath
        self.shapeLayer1?.path=getWavePath(8, w: 0.04, d: 29+60, dong: 10).cgPath
    }
    
    func _layer(tableHeaderView:UITableView,target:UIViewController,selector:Selector) -> UIView{
        self.frame=CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(UIScreen.main.bounds.size.width), height: CGFloat(160))
        self.backgroundColor = UIColor.white
        tableHeaderView.tableHeaderView = self
        let layer2 = CAShapeLayer()
        layer2.fillColor = UIColor.orange.cgColor
        layer2.frame = self.bounds
        layer2.shouldRasterize = true
        layer2.path = self.getLayerBezierPath().cgPath
        self.layer.addSublayer(layer2)  //添加半椭圆
        
        let imgWh:CGFloat=70
        Imgbtn = UIButton(frame: CGRect(x: self.bounds.width/2-imgWh/2, y: 40, width:imgWh, height: imgWh))
        Imgbtn.setImage(UIImage.init(named: "userIcon_defualt"), for: .normal)
        Imgbtn.layer.borderColor=UIColor.white.cgColor
        Imgbtn.layer.borderWidth=2
        Imgbtn.layer.cornerRadius=imgWh/2
        Imgbtn.layer.masksToBounds=true
        Imgbtn.addTarget(target, action: selector, for: .touchUpInside)
        self.addSubview(Imgbtn)    //添加图片
        
        LabName=UILabel(frame: CGRect(x: 0, y: Imgbtn.frame.maxY+5, width: CommonFunction.kScreenWidth, height: 20))
        LabName.text="Hi,给我取个名字吧"
        LabName.contentMode = .center
        LabName.textColor=UIColor.white
        LabName.textAlignment = .center
        LabName.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(LabName)    //添加文字
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.frame = self.bounds
        layer.opacity = 0.3
        layer.shouldRasterize = true
        layer.path = self.getWavePath(8, w: 0.04, d: 25 + 60, dong: 0).cgPath
        self.shapeLayer = layer
        self.layer.addSublayer(layer)   //添加水波
        
        let layer1 = CAShapeLayer()
        layer1.fillColor = UIColor.white.cgColor
        layer1.frame = self.bounds
        layer1.opacity = 0.3
        layer1.shouldRasterize = true
        layer1.path = self.getWavePath(8, w: 0.04, d: 29 + 60, dong: 10).cgPath
        self.shapeLayer1 = layer1
        self.layer.addSublayer(layer1)   //添加水波
        return self
    }
    
    
    
    func getLayerBezierPath() -> UIBezierPath {
        let width: CGFloat = UIScreen.main.bounds.size.width
        let R: CGFloat = 25 + pow(width, 2) / 400.0
        let centerArc = CGPoint(x: CGFloat(width / 2.0), y: CGFloat(160 - R))
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: CGFloat(0), y: CGFloat(0)))
        bezierPath.addLine(to: CGPoint(x: CGFloat(0), y: CGFloat(110)))
        
        bezierPath.addArc(withCenter: centerArc, radius: R, startAngle: acos(width / (2 * R)), endAngle: (.pi - acos(width / (2 * R))), clockwise: true)
        bezierPath.addLine(to: CGPoint(x: width, y: CGFloat(110)))
        bezierPath.addLine(to: CGPoint(x: width, y: CGFloat(0)))
        bezierPath.close()
        return bezierPath
    }
    
    
    
    func getWavePath(_ A: CGFloat, w: CGFloat, d: CGFloat, dong: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: CGFloat(0), y: CGFloat(0)))
        path.addLine(to: CGPoint(x: CGFloat(0), y: CGFloat(50)))
        for i in 0..<Int(UIScreen.main.bounds.size.width) {
            
            let c = CGFloat(i) * w + dong + self.dong + d
            let y: CGFloat = A * CGFloat(sinf(c.ToFloat()))
            path.addLine(to: CGPoint(x: CGFloat(i), y: y))
        }
        path.addLine(to: CGPoint(x: CGFloat(UIScreen.main.bounds.size.width), y: CGFloat(0)))
        path.close()
        return path
    }
    
    deinit {
        debugPrint("释放")
    }
    
}
