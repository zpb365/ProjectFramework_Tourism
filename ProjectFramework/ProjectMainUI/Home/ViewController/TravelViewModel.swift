//
//  TravelViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class TravelViewModel {
    
    var ListData = [TravelsModel]()
    
    func GetTravelsChannelsList (PageIndex:Int,PageSize:Int,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?)   {
    
        CommonFunction.Global_Get(entity: TravelsModel(), IsListData: true, url: HttpsUrl+"api/Travels/GetTravelsChannelsList", isHUD: false, isHUDMake: false, parameters:["PageIndex":PageIndex,"PageSize":PageSize]) { (resultModel) in
            if(resultModel?.Success==true){
                
                if(resultModel?.ret==6){
                    result?(true,true)
                    return
                }
                if(resultModel?.ret==5&&resultModel?.Content==nil){
                    result?(true,false)
                    return
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
    
}
