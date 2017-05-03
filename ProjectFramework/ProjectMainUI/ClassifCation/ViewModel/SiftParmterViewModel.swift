//
//  SiftParmterViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/25.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class SiftParmterViewModel {
    var ListData = SfitParmterModel()
    func GetScreeningCondition(ChannelID:Int,result:((_ result:Bool?) -> Void)?){
        
        let parameters=["ChannelID":ChannelID]
        CommonFunction.Global_Get(entity: SfitParmterModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetScreeningCondition", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                self.ListData = resultModel?.Content   as!  SfitParmterModel
                result?(true)
            }else{
                result?(false)
            }
        }
    }
}
