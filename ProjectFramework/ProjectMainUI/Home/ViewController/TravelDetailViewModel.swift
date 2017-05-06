//
//  TravelDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/3.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation


class TravelDetailViewModel {
    
    var ListData = TravelsDetailModel()
    
    func GetTravelsDetails (TravelsId:Int,PageIndex:Int,PageSize:Int,result:((_ result:Bool?) -> Void)?)   {
        
        CommonFunction.Global_Get(entity: TravelsDetailModel(), IsListData: false, url: HttpsUrl+"api/Travels/GetTravelsDetails", isHUD: false, isHUDMake: false, parameters:["TravelsId":TravelsId,"PageIndex":PageIndex,"PageSize":PageSize]) { (resultModel) in
            if(resultModel?.Success==true){
                let model =  resultModel?.Content   as!  TravelsDetailModel
                self.ListData = model
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }
    
}
