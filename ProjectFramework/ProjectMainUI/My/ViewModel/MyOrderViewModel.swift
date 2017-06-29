//
//  MyOrderViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/4.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation


class MyOrderViewModel     {
    
    var ListData = [MyOrderModel]()
    
    func GetMyOrderList (OrderType:Int,PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?)   {
        
        let parameters = ["UserID":Global_UserInfo.userid,"PageIndex":PageIndex,"PageSize":PageSize,"OrderType":OrderType]
        CommonFunction.Global_Get(entity: MyOrderModel(), IsListData: true, url: HttpsUrl+"api/My/GetMyOrderList", isHUD: false, isHUDMake: false, parameters:parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                if(resultModel?.ret==6){
                    result?(true,true)
                    return
                }
                if(resultModel?.ret==5 && resultModel?.Content==nil){
                    self.ListData.removeAll()
                    result?(true,false)
                    return    //空数据
                }
                let model =  resultModel?.Content   as!  [MyOrderModel]
                
                if(PageIndex>=2){
                    for item in model {
                        self.ListData.append(item)
                    }
                }else{
                    self.ListData = model
                }
                result?(true,false)
            }else{
                result?(false,false)
            }
            
        }
    }
    
 
    
}
