//
//  OderComment.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift

class OderComment: UIViewController,UITextViewDelegate {

    lazy var bottomView: UIView = {
        let bottomView = UIView.init(frame: CommonFunction.CGRect_fram(0, y: self.contenView.frame.maxY + 7, w: CommonFunction.kScreenWidth, h: CommonFunction.kScreenHeight - self.contenView.frame.maxY - 7))
            bottomView.backgroundColor = UIColor.white

        return bottomView
    }()
    
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var promptLable: UILabel!
    fileprivate var submit:UIButton!
    
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    fileprivate let _OrderCommentViewModel = OrderCommentViewModel()   //数据处理 (VM)
    var _OrderNumber:String="" //订单号
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
        commentTextView.rx.text.orEmpty
            .bind(to: _OrderCommentViewModel.Description) //绑定
            .addDisposableTo(disposeBag)
        submit.rx.tap
            .bind(to: _OrderCommentViewModel.Event)  //绑定事件 (点击)
            .addDisposableTo(self.disposeBag)
        
        _OrderCommentViewModel.OrderNumber=_OrderNumber
        
        Result()   //点击按钮后接收的数据返回
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
   
    //MARK: initUI
    func initUI() -> Void {
        self.title = "评价"
        
        submit = UIButton.init(type: .system)
        submit.frame.size = CGSize.init(width: 60, height: 30)
        submit.setTitle("提交", for: .normal)
        submit.setTitleColor(UIColor.white, for: .normal)
        submit.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        submit.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -5, right: -30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: submit)
        
        contenView.frame = CGRect.init(x: 0, y: 64, width: contenView.frame.width, height: contenView.frame.height)
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        commentTextView.delegate = self
        //星星评分
        let starView = XHStarRateView.init(frame: CommonFunction.CGRect_fram(80, y: 180, w: 100, h: 15), numberOfStars: 5, rateStyle: .WholeStar, isAnination: true, delegate: self)
        self.contenView.addSubview(starView!)
        self.contenView.bringSubview(toFront: starView!)
        
        self.view.addSubview(self.bottomView)
        
        let picView = UpLoadPicManagerView.init(frame: self.bottomView.bounds, delegate: self, ShowRowsItem: 4, SelectedImgMaxCount: 9) { (imageArray: Array) in
            
        }
        self.bottomView.addSubview(picView)
    }
    //MARK: 提交
    func buttonClick(){
        
    }
    //MARK: 星星评分代理
    func starRateView(_ starRateView: XHStarRateView, currentScore: CGFloat) {
        _OrderCommentViewModel.Score=Int(currentScore)
    }
    //MARK: UITextViewDelegate
    //检测到textView为空时，隐藏键盘
    func textViewDidChange(_ textView: UITextView) {
        if (commentTextView.text == "") {
            commentTextView.resignFirstResponder()
            promptLable.isHidden = false
        }
        else{
            
        }
    }
    //开始编辑，隐藏lable
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        promptLable.isHidden = true
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location >= 500 {
            return false
        }
        else {
            return true
        }
    }
    //取消键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if (commentTextView.text.lengthOfBytes(using: String.Encoding(rawValue: String.Encoding.utf16.rawValue)) == 0) {
            promptLable.isHidden = false
        }
    }
    
    
    //返回数据
    func Result(){
        _ = self._OrderCommentViewModel.Result?.subscribe(onNext: {[weak self](result) in
            if(result==true){
                self?._OrderCommentViewModel.SetPendingEvaluation(result: { (isOK) in
                    if(isOK==true){
                        self?.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }).addDisposableTo(self.disposeBag)
    }
    
    deinit {
        debugPrint("释放了 ")
    }
}
