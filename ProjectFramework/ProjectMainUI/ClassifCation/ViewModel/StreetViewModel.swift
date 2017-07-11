//
//  StreetViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class StreetViewModel {
    var ListData = [StreetModel]()
    
    func GetChannelsCharacteristicStreetList(PageIndex:Int,PageSize:Int,tabName:String,result:((_ result:Bool?,_ NoMore:Bool?) -> Void)?){
        let parameters=["PageIndex":PageIndex,"PageSize":PageSize,"tabName":tabName] as [String : Any]
        
        CommonFunction.Global_Get(entity: StreetModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsCharacteristicStreetList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret==5){
                    result?(true,false)
                    return
                }
                if(resultModel?.ret==6){
                    result?(true,true)
                    return
                }
                let model =  resultModel?.Content   as!  [StreetModel]
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
