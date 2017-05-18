//
//  TravelAcyDetailViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TravelAcyDetailViewModel: NSObject {
    var ListData = TravelAcyDetailModel()
    func GetChannelsTravelAgencyDetails(TravelAgencyID:Int ,PageIndex:Int ,PageSize:Int  ,result:((_ result:Bool?) -> Void)?) {
        let parameters=["TravelAgencyID":TravelAgencyID,"PageIndex":PageIndex,"PageSize":PageSize]
        
        CommonFunction.Global_Get(entity: TravelAcyDetailModel(), IsListData: false, url: HttpsUrl+"api/Channels/GetChannelsTravelAgencyDetails", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                self.ListData = resultModel?.Content   as!  TravelAcyDetailModel
                result?(true)
            }else{
                result?(false)
            }
            
        }
    }

}
