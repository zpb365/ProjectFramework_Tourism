//
//  ScenicSpotIntroduce.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/17.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class ScenicSpotIntroduce: UIViewController ,ScrollEnabledDelegate{

    lazy var WebView: PulickWebView = {
        let WebView = PulickWebView.init(frame: self.view.bounds)
        return WebView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView.tableHeaderView = self.WebView
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: CommonFunction.kScreenWidth, height: 0.0001))
        self.view.addSubview(tableView)
         self.WebView.loadHtmlString(html: "<p>香蕉是淀粉质丰富的有益水果。味甘性寒，可清热润肠</p><p>香蕉</p><p>香蕉</p><p>，促进肠胃蠕动，但脾虚泄泻者却不宜。根据“热者寒之”的原理，最适合燥热人士享用。痔疮出血者、因燥热而致胎动不安者，都可生吃蕉肉。</p><p>民间验方更有用香蕉炖冰糖，医治久咳；用香蕉煮酒，作为食疗。近代医学建议，用香蕉可治高血压，因它含钾量丰富，可平衡钠的不良作用，并促进细胞及组织生长。用香蕉可治疗便秘，因它能促进肠胃蠕动。</p><p>早餐午餐和晚餐分别吃一根香蕉，能够为人体提供丰富的钾，从而使得大脑血凝块几率降低约21%。</p><p>德国研究人员表示，用香蕉可治抑郁和情绪不安，因它能促进大脑分泌内啡化学物质。它能缓和紧张的情绪，提高工作效率，降低疲劳。</p><p>营养价值</p><p>香蕉属高热量水果，据分析每100克果肉的发热量达91大卡。在一些热带地区香蕉还作为主要粮食。香蕉果肉营</p><p>养价值颇高，每100克果肉含碳水化合物20克、蛋白质1.2克、脂肪0.6克；此外，还含多种微量元素和维生素。其中维生素A能促进生长，增强对疾病的抵抗力，是维持正常的生殖力和视力所必需；硫胺素能抗脚气病，促进食欲、助消化，保护神经系统；核黄素能促进人体正常生长和发育。　香蕉除了能平稳血清素和褪黑素外，它还含有可具有让肌肉松弛效果的镁元素，经常工作压力比较大的朋友可以多食用。</p>")
        WebView.FuncCallbackValue {[weak self] (height) in
            self?.WebView.frame = CGRect.init(x: 0, y: 0, width: (self?.view.frame.width)!, height: height)
            tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: SlidingDelegate
    func ScrollEnabledCan() {
//        print("实现代理")
//        self.WebView. = true
    }
    func ScrollEnabledNo() {
//        print("实现代理")
//        self.WebView.isScrollEnabled = false
    }
    deinit {    //销毁页面
        debugPrint("介绍 页面已经销毁")
    }

    

}
