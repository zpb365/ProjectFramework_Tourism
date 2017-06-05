//
//  SpecialtyProductDetail.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/11.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SpecialtyProductDetail: UIViewController ,UIWebViewDelegate{

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
    lazy var webView: UIWebView = {
        let webView = UIWebView.init(frame: CGRect.init(x: 0, y: 64, width: CommonFunction.kScreenWidth, height: CommonFunction.kScreenHeight - 64 - 40))
        webView.delegate = self
        webView.scrollView.bounces = false
        return webView
    }()
    
    var spePoduct: SpecialitiesProduct_List?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "特产详情"
        self.initUI()
    }
    override func viewDidLayoutSubviews() {
        webView.loadHTMLString(spePoduct!.Introduce, baseURL: nil)
    }
    //MARK: initUI
    func initUI() -> Void{
        self.view.addSubview(goumaixuzhiBtn)
        self.view.addSubview(payforBtn)
        self.view.addSubview(webView)
        
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
        case 100:
            let vc = PulickInformation()
            self.present(vc, animated: true, completion:nil)
            break
        case 101:
            if spePoduct?.DefaultInventor != 0 {
                let vc = CommonFunction.ViewControllerWithStoryboardName("SpecialtyOderWrite", Identifier: "SpecialtyOderWrite") as! SpecialtyOderWrite
                vc.spePoduct =  self.spePoduct
                self.navigationController?.show(vc, sender: self)
            }else{
                CommonFunction.HUD("该特产已没有库存，请重新选择！", type: .error)
            }
            break
        default:
            break
        }
    }
    func webViewDidFinishLoad(_ webView: UIWebView){
        let str = "document.body.style.fontSize = '13px';"
        webView.stringByEvaluatingJavaScript(from: str)
        var  imageauto = "var script = document.createElement('script');"
        imageauto+="script.type = 'text/javascript';"
        imageauto+="script.text = \"function ResizeImages() { "
        imageauto+="var myimg,oldwidth;"
        imageauto+="var maxwidth = %f;"
        imageauto+="for(i=0;i <document.images.length;i++){"
        imageauto+="myimg = document.images[i];"
        imageauto+="if(myimg.width > maxwidth){"
        imageauto+="oldwidth = myimg.width;"
        imageauto+="myimg.width = %f;"
        imageauto+="}"
        imageauto+="}"
        imageauto+="}\";"
        imageauto+="document.getElementsByTagName('head')[0].appendChild(script);"
        imageauto = String(format: imageauto, UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.width - 15)
        webView.stringByEvaluatingJavaScript(from: imageauto)
        webView.stringByEvaluatingJavaScript(from: "ResizeImages();")
    }
    

}
