//
//  ScenicIntroduceCell.swift
//  ProjectFramework
//
//  Created by 住朋购友 on 2017/3/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import WebKit

class ScenicIntroduceCell: UITableViewCell,WKNavigationDelegate {

    typealias CallbackValue=(_ value:CGFloat)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    lazy var costomWebView:WKWebView={
        let costomWebView = WKWebView.init(frame: self.contentView.bounds) 
        costomWebView.navigationDelegate = self
        return costomWebView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func InitConfig(_ cell: Any) {
        costomWebView.loadHTMLString(cell as! String, baseURL: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(costomWebView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: WKWebViewdelegate
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        print("开始加载")
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation) {
        print("内容返回")
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation){
        print("加载完成")
        print(webView.scrollView.contentSize)
        print(webView.frame)
        let height = webView.scrollView.contentSize
//        costomWebView.frame = CommonFunction.CGRect_fram(0, y: 0, w: self.contentView.frame.width, h: height)
//        if (myCallbackValue != nil){
////            myCallbackValue!(height)//回调。
//        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }

}
