//
//  MyinfoViewModel.swift
//  ProjectFramework_Tourism
//
//  Created by 住朋购友 on 2017/5/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import Foundation
import SwiftyJSON

class  MyinfoHttps {
    
    //更新用户信息
    func UpUserInfo(data:Data,parameters:NSDictionary,Model:((_ model:AppResultModel?) -> Void)?)->Void{
        
        AFNHelper.upload(HttpsUrl+"api/Home/UpUserInfo", parameters: parameters, constructingBodyWithBlock: { (formData) in
            
            formData.appendPart(withFileData: data, name: "upuserinfo", fileName: ".jpg", mimeType: "image/jpge")
            
        }, uploadProgress: { (progress) in
            debugPrint(progress.fractionCompleted)
        }, success: { (obj) in
            
            let valuemodel = AppResultModel.mj_object(withKeyValues: JSON(obj).description)
            Model?(valuemodel)
        }, failure: { (error) in
            let valuemodel=AppResultModel()
            valuemodel.ret=2
            valuemodel.Result=error.description
            Model?(valuemodel)
        })
        
    }
    
 
}
