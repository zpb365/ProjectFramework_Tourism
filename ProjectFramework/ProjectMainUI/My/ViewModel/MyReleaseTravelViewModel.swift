//
//  MyReleaseTravelViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/4.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class MyReleaseTravelViewModel     {
    
    var ListData = [TravelsModel]()
    
    func GetMyReleaseTravelsList (PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?)   {
        
        let parameters = ["UserID":Global_UserInfo.userid,"PageIndex":PageIndex,"PageSize":PageSize]
        CommonFunction.Global_Get(entity: TravelsModel(), IsListData: true, url: HttpsUrl+"api/My/GetMyReleaseTravelsList", isHUD: false, isHUDMake: false, parameters:parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                if(resultModel?.ret==6){
                    result?(true,true)
                    return
                }
                if(resultModel?.ret==5 && resultModel?.Content==nil){
                    result?(true,false)
                    return    //空数据
                }
                let model =  resultModel?.Content   as!  [TravelsModel]
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
    
    
    func DeleteMyTravels(TravelsID:Int,result:((_ result:Bool?) -> Void)?){
        let parameters = ["TravelsID":TravelsID]
        CommonFunction.Global_Post(entity: nil, IsListData: false, url: HttpsUrl+"api/My/DeleteMyTravels", isHUD: true, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                result?(true)
            }else{
                result?(false)
            }
        }
    }
    
    
    
    
}
