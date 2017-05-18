//
//  MyOrderDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/4.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation




class MyOrderDetailViewModel  {
    
    var ListData = MyOrderDetailModel()
    
    func GetMyOrderDetails (OrderNumber:String,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?)   {
        
        let parameters = ["OrderNumber":OrderNumber ]
        CommonFunction.Global_Get(entity: MyOrderDetailModel(), IsListData: false, url: HttpsUrl+"api/My/GetMyOrderDetails", isHUD: false, isHUDMake: false, parameters:parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret==5 && resultModel?.Content==nil){
                    result?(true,true)
                    return    //空数据
                }
                self.ListData = resultModel?.Content as! MyOrderDetailModel
                result?(true,false)
            }else{
                result?(false,false)
            }
            
        }
    }
    

    
    
}
