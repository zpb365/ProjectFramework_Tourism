//
//  MarketDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/7/6.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class MarketDetailViewModel {
    var ListData = MarketDetailModel()
    
    func GetChannelsMarketDetails(MarketID:Int,result:((_ result:Bool?) -> Void)?){
        
        let parameters=["MarketID":MarketID]
        
        CommonFunction.Global_Get(entity: MarketDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsMarketDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                //没有数据
                if(resultModel?.ret==5){
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  MarketDetailModel
                
                result?(true)
            }
            else{
                result?(false)
            }
        }
    }

}
