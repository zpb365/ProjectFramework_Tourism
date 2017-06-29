//
//  TabParmterViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/6/26.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class TabParmterViewModel {
    var ListData = [TabModel]()
    func GetTabList(ChannelID:Int , tabClassID:Int , result:((_ result:Bool?) -> Void)?) {
        let parameters=["ChannelID":ChannelID , "tabClassID":tabClassID]
        
        CommonFunction.Global_Get(entity: TabModel(), IsListData: true, url: HttpsUrl+"api/Channels/GetTabList", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                
                self.ListData = resultModel?.Content   as!  [TabModel]
                result?(true)
            }else{
                result?(false)
            }
        }
    }

}
