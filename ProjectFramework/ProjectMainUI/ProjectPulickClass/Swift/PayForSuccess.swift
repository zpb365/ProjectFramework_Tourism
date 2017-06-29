//
//  PayForSuccess.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PayForSuccess: UIViewController {

    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    
    fileprivate lazy var backHome:UIButton = {
        let backHome = UIButton(type: .system)
        backHome.frame.size = CGSize.init(width: 200, height: 40)
        backHome.center = self.view.center
        backHome.backgroundColor = UIColor().TransferStringToColor("#29B6F6")
        backHome.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        backHome.setTitle("返回首页", for: .normal)
        backHome.setTitleColor(UIColor.white, for: .normal)
        backHome.rx.tap.subscribe(      //返回
            onNext: { [weak self] value in
                self?.dismiss(animated: true, completion: nil)
        }).addDisposableTo(self.disposeBag)
        return backHome
    }()
    fileprivate lazy var logiBtn:UIButton = {
        let logiBtn = UIButton(type: .system)
        logiBtn.frame.size = CGSize.init(width: 80, height: 40)
        logiBtn.center.x = self.view.center.x
        logiBtn.center.y = self.view.center.y - 100
        logiBtn.backgroundColor = UIColor().TransferStringToColor("#29B6F6")
        logiBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        logiBtn.setTitle("登录", for: .normal)
        logiBtn.setTitleColor(UIColor.white, for: .normal)
        logiBtn.rx.tap.subscribe(      //返回
            onNext: { [weak self] value in
             print("登录")
        }).addDisposableTo(self.disposeBag)
        return logiBtn
    }()
    fileprivate lazy var textFiled1:UITextField = {
        let textFiled1 = UITextField.init()
        textFiled1.frame = CGRect.init(x: 30, y: 50, width: 150, height: 30)
        textFiled1.placeholder = "我是输入框1"
        textFiled1.backgroundColor = UIColor.white
        return textFiled1
    }()
    fileprivate lazy var textFiled2:UITextField = {
        let textFiled2 = UITextField.init()
        textFiled2.frame = CGRect.init(x: 30, y: 100, width: 150, height: 30)
        textFiled2.placeholder = "我是输入框2"
        textFiled2.backgroundColor = UIColor.white
        return textFiled2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(backHome)
        self.view.addSubview(logiBtn)
        self.view.addSubview(textFiled1)
        self.view.addSubview(textFiled2)
        
        self.LoGin()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func LoGin() -> Void {
        let IsValid1: Observable = textFiled1.rx.text.orEmpty
            .map { newUsername in newUsername.characters.count > 5 }
        let IsValid2: Observable = textFiled2.rx.text.orEmpty
            .map { passWord in passWord.characters.count > 5
        }
        IsValid1
            .bind(to: backHome.rx.isUserInteractionEnabled)
            .addDisposableTo(self.disposeBag)
//        IsValid2
//            .bind(to: backHome.rx.isHidden)
//            .disposed(by: self.disposeBag)
        
        let isLoginEnable: Observable = Observable.combineLatest(IsValid1, IsValid2) {
            IsValid1, IsValid2 in IsValid1 && IsValid2
        }
        
        isLoginEnable
            .bind(to: logiBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        

    }
    
    
}


