//
//  SreetDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class SreetDetailViewModel {
    var ListData = StreetDetailModel()
    
    func GetChannelsCharacteristicStreetDetails(StreetID:Int,result:((_ result:Bool?) -> Void)?){
        
        let parameters=["StreetID":StreetID]
        
        CommonFunction.Global_Get(entity: StreetDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsCharacteristicStreetDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  StreetDetailModel
                
                result?(true)
            }
            else{
                result?(false)
            }
        }
    }
}
