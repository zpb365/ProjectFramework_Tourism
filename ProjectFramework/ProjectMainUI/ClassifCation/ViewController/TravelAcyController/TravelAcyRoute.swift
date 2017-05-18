//
//  TravelAcyRoute.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyRoute: UIViewController ,UIWebViewDelegate{
    
    lazy var goumaixuzhiBtn: UIButton = {
        let goumaixuzhiBtn = UIButton.init(type: .system)
        goumaixuzhiBtn.backgroundColor = UIColor.white
        goumaixuzhiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        goumaixuzhiBtn.setTitle("购买须知", for: .normal)
        goumaixuzhiBtn.setTitleColor(UIColor().TransferStringToColor("#5E7D8A"), for: .normal)
        goumaixuzhiBtn.tag = 100
        goumaixuzhiBtn.layer.borderWidth = 0.8
        goumaixuzhiBtn.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        goumaixuzhiBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return goumaixuzhiBtn
    }()
    lazy var payforBtn: UIButton = {
        let payforBtn = UIButton.init(type: .system)
        payforBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        payforBtn.backgroundColor = UIColor().TransferStringToColor("#FF5722")
        payforBtn.setTitle("立即订购", for: .normal)
        payforBtn.setTitleColor(UIColor.white, for: .normal)
        payforBtn.tag = 101
        payforBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return payforBtn
    }()
    
    lazy var lable: UILabel = {
        let lable = UILabel.init()
        lable.backgroundColor = UIColor().TransferStringToColor("#03A9F4")
        return lable
    }()
    lazy var webView: UIWebView = {
        let webView = UIWebView.init(frame: CGRect.init(x: 0, y: 96, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 96 - 40))
        webView.delegate = self
        webView.scrollView.bounces = false
        return webView
    }()
    var travelProduct:TravelAgencyProduct_List!
    var currenBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "路线介绍"
        self.initUI()
    }
    
    override func viewDidLayoutSubviews() {
        webView.loadHTMLString(travelProduct.LineIntroduce, baseURL: nil)
    }
    //MARK: initUI
    func initUI() -> Void {
        let textArray = ["行程介绍","费用说明"]
        for i in 0..<textArray.count {
            let button = UIButton.init(type: .system)
            button.frame = CGRect.init(x: CommonFunction.kScreenWidth/2 - 100 + CGFloat(100*i), y: 64, width: 100, height: 30)
            button.tag = 1+i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitle(textArray[i], for: .normal)
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            if i == 0 {
                lable.frame = CGRect.init(x: 0, y: button.frame.maxY, width: 70, height: 2)
                lable.center.x = button.center.x
                self.view.addSubview(lable)
                currenBtn = button
                button.isUserInteractionEnabled = false
            }
            self.view.addSubview(button)
        }
        self.view.addSubview(webView)
        self.view.addSubview(goumaixuzhiBtn)
        self.view.addSubview(payforBtn)
        goumaixuzhiBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)//宽高相等
            make.left.equalTo(0)//右边相对父控件的约束条件r
            make.bottom.equalTo(0)//底部相对父控件的约束条件
            make.height.equalTo(40)
        }
        payforBtn.snp.makeConstraints { (make) in
            make.left.equalTo(goumaixuzhiBtn.snp.right).offset(0)
            make.right.equalTo(0)//右边相对父控件的约束条件
            make.bottom.equalTo(0)//底部相对父控件的约束条件
            make.height.equalTo(40)
        }
    }
    //MARK: buttonClick
    func buttonClick(button: UIButton) -> Void{
        switch button.tag {
        case 1,2:
            lable.center.x = button.center.x
            if button.tag == 1 {
                if currenBtn != button {
                    webView.loadHTMLString(travelProduct.LineIntroduce, baseURL: nil)
                    
                }

            }else{
                if currenBtn != button {
                    webView.loadHTMLString(travelProduct.BookInformation, baseURL: nil)
                }
                
            }
            currenBtn.isUserInteractionEnabled = true
            button.isUserInteractionEnabled = false
            currenBtn = button
            break
        case 100:
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 101:
            let vc = TravelAcyDateChoose()
            vc.travelProduct = self.travelProduct
            self.navigationController?.show(vc, sender: self)
            break
        default:
            break
        }
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        let str = "document.body.style.fontSize = '13px';"
        webView.stringByEvaluatingJavaScript(from: str)

    }
    

}
