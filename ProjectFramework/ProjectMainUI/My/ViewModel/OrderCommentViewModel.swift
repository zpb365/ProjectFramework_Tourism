//
//  OrderCommentViewmodel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/4.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation


import RxSwift

class OrderCommentViewModel    {
    
    let Description = Variable<String>("")     //描述内容
    let QQPhone  = Variable<String>("")    //联系方式数据
    
    var Score  = 0    //评分 
    var OrderNumber  = ""    //订单号
    
    // 按钮点击 绑定的 事件
    let  Event = PublishSubject<Void>()
    // 保存返回数据
    var Result: Observable<Bool>? = nil
    
    init( ) {
        
        
        let parameter = Observable.combineLatest(Description.asObservable(),QQPhone.asObservable()){($0,$1)}
        
        Result =  Event.asObserver()
            .withLatestFrom(parameter)
            .flatMapLatest({ (Description,QQPhone) -> Observable<Bool> in
                //业务处理逻辑处理
                
                if(Description==""){
                    CommonFunction.HUD("内容不可为空", type: .error)
                    return Observable.just(false)
                }
                if(self.OrderNumber==""){
                    CommonFunction.HUD("订单号不可为空", type: .error)
                    return Observable.just(false)
                }
                if(self.Score==0){
                    CommonFunction.HUD("请给商家一个评分吧", type: .error)
                    return Observable.just(false)
                }
                
                return Observable.just(true)
                
            }).shareReplay(1)
    }
    
    func SetPendingEvaluation(result:((_ result:Bool?) -> Void)?){
        let parameters = [ "Description":Description,"Score":self.Score,"OrderNumber":self.OrderNumber] as [String : Any]
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl+"api/My/SetPendingEvaluation",isHUD: true,HUDMsg: "数据提交中...", isHUDMake: false, parameters: parameters as NSDictionary, Model: { (resultData) in
            
            if(resultData?.Success==true){
                CommonFunction.HUD("提交成功", type: .success)
                  result?(true)
            }else{
                CommonFunction.HUD("提交失败", type: .error)
                  result?(false)
            }
            
        })
    }
    
}
