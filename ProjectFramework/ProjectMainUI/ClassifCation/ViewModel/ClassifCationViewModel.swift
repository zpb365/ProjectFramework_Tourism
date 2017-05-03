//
//  ClassifCationViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/4/21.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation

class ClassifCationViewModel {

    var ListData = [ClassifCationModel]()
    
    func GetChannelDta (result:((_ result:Bool?) -> Void)?){
        CommonFunction.Global_Get(entity: ClassifCationModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetChannelsInfo", isHUD: false, isHUDMake: false, parameters: nil) { (resultModel) in
            if(resultModel?.Success==true){
                self.ListData = resultModel?.Content   as!  [ClassifCationModel]
                result?(true)
            }else{
                result?(false)
            }
        }
    }
    
}
