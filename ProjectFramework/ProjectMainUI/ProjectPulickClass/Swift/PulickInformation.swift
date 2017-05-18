//
//  PulickInformation.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/15.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class PulickInformation: UIViewController,UIWebViewDelegate {
    lazy var lable: UILabel = {
        let lable = UILabel()
        lable.text = "购买须知"
        lable.font = UIFont.systemFont(ofSize: 12)
        return lable
    }()
    lazy var costomWebView: UIWebView = {
        let costomWebView = UIWebView.init()
        costomWebView.scrollView.bounces = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor().TransferStringToColor("#F0F0F2")
        return costomWebView
    }()
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton.init(type: .custom)
        deleteBtn.tag = 102
        deleteBtn.setImage(UIImage.init(named: "delete"), for: .normal)
        deleteBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return deleteBtn
    }()
    
    //MARK: buttonClick
    func buttonClick(button: UIButton) -> Void {
        self.dismiss(animated: true) { 
            
        }
    }
    
    var viewModel = GoumaiXuzhiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    override func viewDidLayoutSubviews() {
       self.GetHttpData()
    }
    func GetHttpData() -> Void {
        viewModel.GetChannelsVideo { (result, str) in
            if result == true{
                self.costomWebView.loadHTMLString(str!, baseURL: nil)
            }else{
                self.costomWebView.loadHTMLString("加载异常", baseURL: nil)
            }
            
        }
    }
    func initUI() -> Void {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(lable)
        self.view.addSubview(costomWebView)
        self.view.addSubview(deleteBtn)
        
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(10)//宽高相等
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(80)//底部相对父控件的约束条件
            make.height.equalTo(20)
        }
        deleteBtn.snp.makeConstraints { (make) in
            make.top.equalTo(10)//右边相对父控件的约束条件r
            make.width.equalTo(40)//底部相对父控件的约束条件
            make.height.equalTo(30)
            make.right.equalTo(0)
        }
        costomWebView.snp.makeConstraints { (make) in
            make.top.equalTo(40)//右边相对父控件的约束条件r
            make.left.equalTo(0)//底部相对父控件的约束条件
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }

    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        print("加载完成")
        
        let str = "document.body.style.fontSize = '11px';"
        
        webView.stringByEvaluatingJavaScript(from: str)
    }

}
