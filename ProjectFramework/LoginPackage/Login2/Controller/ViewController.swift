//
//  ViewController.swift
//  Cloudin
//
//  Created by 住朋购友 on 2017/3/27.
//  Copyright © 2017年 子轩. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    fileprivate let disposeBag   = DisposeBag() //创建一个处理包（通道）
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        
        let btn = UIButton(frame: CGRect(x: 5, y: 22, width: 50, height: 43))
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle(  "X",   for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.rx.tap.subscribe(      //返回
            onNext:{ [weak self] value in
               print(value)
                  self?.dismiss(animated: true, completion: nil)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposed")
            
            
        }).addDisposableTo(self.disposeBag)
        //btn.addTarget(self, action: #selector(a), for: .touchUpInside)
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func a(){
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    deinit {
        print("shifangle")
    }
}
