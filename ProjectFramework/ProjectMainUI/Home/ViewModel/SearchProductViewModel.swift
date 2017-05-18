//
//  SearchProductViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/12.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class SearchProductViewModel: NSObject {

    var ListData = [SearchProductModel]()
    func GetHomeSearchRecordInfo(SearchTitle:String,result:((_ result:Bool?) -> Void)?){
         let parameters=["SearchTitle":SearchTitle]
        
        CommonFunction.Global_Get(entity: SearchProductModel(), IsListData: true, url: HttpsUrl+"api/Home/GetHomeSearchRecordInfo", isHUD: false, isHUDMake: false, parameters: parameters as NSDictionary) { (resultModel) in
            if(resultModel?.Success==true){
                if(resultModel?.ret == 5){
                    result?(true)
                    return
                }
                self.ListData = resultModel?.Content   as!  [SearchProductModel]
                result?(true)
            }else{
                result?(false)
            }
        }
    }
}
