//
//  GuideBookDetailsViewCell.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GuideBookDetailsViewCell: UITableViewCell,UIWebViewDelegate {

    typealias CallbackValue=(_ value:CGFloat)->Void //类似于OC中的typedef
    var myCallbackValue:CallbackValue?  //声明一个闭包 类似OC的Block属性
    func  FuncCallbackValue(value:CallbackValue?){
        myCallbackValue = value //返回值
    }
    lazy var costomWebView:UIWebView={
        let costomWebView = UIWebView.init(frame: CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: 10))
        costomWebView.scrollView.bounces = false
        costomWebView.scrollView.isScrollEnabled = false
        costomWebView.delegate = self
        costomWebView.backgroundColor = UIColor.white
        
        return costomWebView
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func InitConfig(_ cell: Any) {
        self.clipsToBounds = true
        self.contentView.addSubview(self.costomWebView)
    }
    //MARK: webViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView){
        print("开始加载")
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        print("加载完成")
        
        let str = "document.body.style.fontSize = '13px';"
        
        webView.stringByEvaluatingJavaScript(from: str)
        
        let height = webView.scrollView.contentSize.height
        costomWebView.frame = CommonFunction.CGRect_fram(0, y: 0, w: CommonFunction.kScreenWidth, h: height * 0.72)
        if (myCallbackValue != nil) {
            myCallbackValue!(height * 0.72)//改变字体大小以后会有多余的高度出来  乘以比例 13 px/18 px
        }
    }
    func loadHtmlString(html:String, isFirst:Bool) -> Void {
        if isFirst == false {
            costomWebView.loadHTMLString(html, baseURL: nil)
        }
    }
    


}
